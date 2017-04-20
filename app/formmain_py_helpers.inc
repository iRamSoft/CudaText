{$ifdef nn}begin end;{$endif}


procedure TfmMain.DoPyCommand(const AModule, AMethod: string;
  const AParams: array of string);
var
  Frame: TEditorFrame;
  Ed: TATSynEdit;
begin
  if not PythonOK then exit;
  PyLastCommandModule:= AModule;
  PyLastCommandMethod:= AMethod;
  PyLastCommandParam:= '';
  if Length(AParams)>0 then
    PyLastCommandParam:= AParams[0];
  PyEditorMaybeDeleted:= false;

  Frame:= CurrentFrame;
  if Frame=nil then exit;
  Ed:= CurrentEditor;
  if Ed=nil then exit;

  if Frame.MacroRecord then
    Frame.MacroString:= Frame.MacroString+ ('py:'+AModule+','+AMethod+','+PyLastCommandParam+#10);

  Ed.Strings.BeginUndoGroup;
  PyCommandRunning:= true;
  try
    Py_RunPlugin_Command(AModule, AMethod, AParams);
  finally
    PyCommandRunning:= false;
    if not PyEditorMaybeDeleted then
      Ed.Strings.EndUndoGroup;
  end;
end;


procedure TfmMain.DoPyCommand_ByPluginIndex(AIndex: integer);
begin
  if not ((AIndex>=Low(FPluginsCmd)) and (AIndex<=High(FPluginsCmd))) then exit;

  if not IsLexerMatches(FPluginsCmd[AIndex].ItemLexers) then
  begin
    MsgStatus(msgStatusCommandOnlyForLexers+' '+FPluginsCmd[AIndex].ItemLexers);
    Exit
  end;

  DoPyCommand(
    FPluginsCmd[AIndex].ItemModule,
    FPluginsCmd[AIndex].ItemProc,
    FPluginsCmd[AIndex].ItemProcParam
    );
end;


function TfmMain.DoPyEvent(AEd: TATSynEdit; AEvent: TAppPyEvent;
  const AParams: array of string): string;
const
  cTheseEventsStoppedByTrue = [cEventOnComplete];
  cTheseEventsNeedGroupingUndo = [cEventOnComplete, cEventOnSnippet];
var
  SCurLexer: string;
  bNeedGroup: boolean;
  Frame: TEditorFrame;
  MaxPrior, i_plugin, i_prior: integer;
begin
  //empty string result means "no handlers for event"
  Result:= '';
  if not PythonOK then exit;
  Frame:= CurrentFrame;
  if Frame=nil then exit;
  SCurLexer:= Frame.LexerName;
  bNeedGroup:= AEvent in cTheseEventsNeedGroupingUndo;

  //get max prior for AEvent
  MaxPrior:= 0;
  for i_plugin in TAppPluginEventArray do
    with FPluginsEvents[i_plugin] do
    begin
      if (ItemModule='') then Break;
      if (AEvent in ItemEvents) then
        MaxPrior:= Max(MaxPrior, ItemEventsPrior[AEvent]);
    end;

  //see all items for prior=MaxPrior..0
  for i_prior:= MaxPrior downto 0 do
    for i_plugin in TAppPluginEventArray do
      with FPluginsEvents[i_plugin] do
      begin
        if (ItemModule='') then Break;
        if not (AEvent in ItemEvents) then Continue;
        if (i_prior<>ItemEventsPrior[AEvent]) then Continue;
        if not ((ItemLexers='') or IsLexerListed(SCurLexer, ItemLexers)) then Continue;

        //check that OnKey event is called for supported keys
        if (AEvent=cEventOnKey) then
          if Length(AParams)>0 then
            if (ItemKeys<>'') and not IsLexerListed(AParams[0], ItemKeys) then
              Continue;

        //call Python
        if bNeedGroup then
          AEd.Strings.BeginUndoGroup;
        PyCommandRunning:= true;
        try
          Result:= Py_RunPlugin_Event(ItemModule, cAppPyEvent[AEvent], AEd, AParams);
        finally
          PyCommandRunning:= false;
          if bNeedGroup then
            AEd.Strings.EndUndoGroup;
        end;

        //True for some events means "stop"
        if Result=cPyTrue then
          if AEvent in cTheseEventsStoppedByTrue then Exit;

        //False means "stop", other results ignored
        if Result=cPyFalse then Exit;
      end;
end;


procedure TfmMain.DoPyCallbackFromAPI(const ACallback: string;
  const AParams: array of string);
const
  cRegex_DotCommand = '([a-z_]\w*)\.([a-z_]\w*)$';
  cRegex_SignCommand = 'module=(.+);cmd=(.+);$';
  cRegex_SignFunc = 'module=(.+);func=(.+);$';
var
  Parts: TRegexParts;
  SModule, SFunc: string;
begin
  if SRegexFindParts(cRegex_DotCommand, ACallback, Parts) or
     SRegexFindParts(cRegex_SignCommand, ACallback, Parts) then
  begin
    SModule:= Parts[1];
    SFunc:= Parts[2];
    Py_RunPlugin_Command(SModule, SFunc, AParams);
    exit;
  end;

  if SRegexFindParts(cRegex_SignFunc, ACallback, Parts) then
  begin
    SModule:= Parts[1];
    SFunc:= Parts[2];
    Py_RunModuleFunction(SModule, SFunc, AParams);
    exit;
  end;

  fmConsole.DoLogConsoleLine(Format(msgBadApiCall, [ACallback]));
end;


procedure TfmMain.DoPyUpdateEvents(const AModuleName, AEventStr, ALexerStr, AKeyStr: string);
var
  i, N: integer;
begin
  //find index of plugin (get first empty index if not listed)
  N:= -1;
  for i:= Low(FPluginsEvents) to High(FPluginsEvents) do
    with FPluginsEvents[i] do
      if (ItemModule=AModuleName) or (ItemModule='') then
        begin N:= i; Break end;
  if N<0 then Exit;

  //update record
  with FPluginsEvents[N] do
  begin
    if ItemModule='' then
      ItemModule:= AModuleName;
    DoPyStringToEvents(AEventStr, ItemEvents, ItemEventsPrior);
    ItemLexers:= ALexerStr;
    ItemKeys:= AKeyStr;
  end;
end;


procedure TfmMain.DoPyResetPlugins;
var
  fn, Cmd: string;
  L: TStringList;
begin
  fn:= GetAppPath(cDirPy)+DirectorySeparator+'cudatext_reset_plugins.py';
  if not FileExists(fn) then
  begin
    MsgBox(msgCannotFindFile+#13+fn, MB_OK or MB_ICONERROR);
    Exit
  end;

  L:= TStringList.Create;
  try
    L.LoadFromFile(fn);
    GetPythonEngine.ExecStrings(L);
    Cmd:= Format('_reset_plugins(r"%s")', [GetAppPath(cDirPy)]);
    GetPythonEngine.ExecString(Cmd);
  finally
    FreeAndNil(L)
  end;
end;

procedure TfmMain.DoPyRescanPlugins;
begin
  DoOps_LoadPlugins;
  UpdateMenuPlugins;
  DoOps_LoadKeymap;
  MsgStatus('Rescanned plugins');
end;

procedure TfmMain.DoPyRunLastPlugin;
begin
  if PyLastCommandModule<>'' then
    DoPyCommand(PyLastCommandModule, PyLastCommandMethod, PyLastCommandParam);
end;


procedure TfmMain.DoPanel_Event(AControl: TObject; const AEvent: string);
begin
  DoPyEvent(CurrentEditor, cEventOnPanel,
    [
      IntToStr(PtrInt(AControl)),
      '"'+AEvent+'"'
    ]);
end;

procedure TfmMain.DoPanel_OnContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  DoPanel_Event(Sender, 'on_menu');
end;

procedure TfmMain.DoPanel_OnClick(Sender: TObject);
begin
  DoPanel_Event(Sender, 'on_click');
end;

procedure TfmMain.DoPanel_OnDblClick(Sender: TObject);
begin
  DoPanel_Event(Sender, 'on_dbl_click');
end;

procedure TfmMain.DoPanel_OnSelChanged(Sender: TObject);
begin
  DoPanel_Event(Sender, 'on_sel');
end;


procedure TfmMain.DoPyTimerTick(Sender: TObject);
var
  Timer: TTimer;
  SAll, SCallback, STag: string;
  N: integer;
begin
  Timer:= Sender as TTimer;
  N:= FListTimers.IndexOfObject(Timer);
  if N<0 then exit;

  //if timer_start_one
  if Timer.Tag=1 then
    Timer.Enabled:= false;

  SAll:= FListTimers[N];
  SCallback:= SGetItem(SAll, '|');
  STag:= SAll;

  DoPyCallbackFromAPI(SCallback, STag);
end;

