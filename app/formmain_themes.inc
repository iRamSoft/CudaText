{$ifdef nnnn}begin end;{$endif}

procedure DoApplyThemeToCustomDialog(F: TFormDummy);
var
  C: TComponent;
  i: integer;
begin
  for i:= 0 to F.ComponentCount-1 do
  begin
    C:= F.Components[i];

    if C is TATListbox then
      if (C as TATListbox).ThemedColors then
        DoApplyThemeToListbox(C as ATListbox.TATListbox);

    if C is TAppTreeContainer then
      if (C as TAppTreeContainer).Themed then
        DoApplyThemeToTreeview((C as TAppTreeContainer).Tree, true, false);

    if C is TATFlatToolbar then
      if (C as TATFlatToolbar).Themed then
        DoApplyThemeToToolbar(C as TATFlatToolbar);
  end;
end;


procedure TfmMain.DoApplyThemeToGroups(G: TATGroups);
begin
  G.SetTabOption(tabColorText, GetAppColor('TabFont'));
  G.SetTabOption(tabColorTextModified, GetAppColor('TabFontMod'));
  G.SetTabOption(tabColorBg, GetAppColor('TabBg'));
  G.SetTabOption(tabColorBgActive, GetAppColor('TabActive'));
  G.SetTabOption(tabColorBgPassive, GetAppColor('TabPassive'));
  G.SetTabOption(tabColorBgPassiveOver, GetAppColor('TabOver'));
  G.SetTabOption(tabColorBorderActive, GetAppColor('TabBorderActive'));
  G.SetTabOption(tabColorBorderPassive, GetAppColor('TabBorderPassive'));
  G.SetTabOption(tabColorArrow, GetAppColor('TabArrow'));
  G.SetTabOption(tabColorArrowOver, GetAppColor('TabArrowOver'));
  G.SetTabOption(tabColorCloseBg, GetAppColor('TabCloseBg'));
  G.SetTabOption(tabColorCloseBgOver, GetAppColor('TabCloseBgOver'));
  G.SetTabOption(tabColorCloseBorderOver, GetAppColor('TabCloseBorderOver'));
  G.SetTabOption(tabColorCloseX, GetAppColor('TabCloseX'));
  G.SetTabOption(tabColorCloseXOver, GetAppColor('TabCloseXOver'));
  G.SetTabOption(tabColorActiveMark, GetAppColor('TabActiveMark'));
  G.SetTabOption(tabColorSpecMarks, GetAppColor('TabMarks'));
  G.Invalidate;
end;

procedure TfmMain.DoApplyTheme;
var
  F: TEditorFrame;
  //PropObject: TAppPanelPropsClass;
  i: integer;
begin
  UpdateMenuThemes(true);
  UpdateMenuThemes(false);

  //we have 2 copies of ATScrollbar unit, need to update same 2 records
  //unit#1:
  with ATSynEdit_ScrollBar.ATScrollbarTheme do
  begin
    ColorBG:= GetAppColor('ScrollBack');
    ColorThumbBorder:= GetAppColor('ScrollRect');
    ColorThumbFill:= GetAppColor('ScrollFill');
    ColorArrowBorder:= ATScrollbarTheme.ColorBG;
    ColorArrowFill:= ATScrollbarTheme.ColorBG;
    ColorArrowSign:= GetAppColor('ScrollArrow');
    ColorScrolled:= GetAppColor('ScrollScrolled');
  end;

  //unit#2:
  Assert(
    SizeOf(ATSynEdit_Scrollbar.ATScrollbarTheme) =
    SizeOf(ATScrollbar.ATScrollbarTheme), 'Not equal ATScrollbarTheme vars in 2 units');
  Move(
    ATSynEdit_Scrollbar.ATScrollbarTheme,
    ATScrollbar.ATScrollbarTheme,
    SizeOf(ATScrollbar.ATScrollbarTheme));

  ListboxOut.Color:= GetAppColor('ListBg');
  ListboxOut.Invalidate;
  ListboxVal.Color:= ListboxOut.Color;
  ListboxVal.Invalidate;

  for i:= Low(AppBookmarkSetup) to High(AppBookmarkSetup) do
    AppBookmarkSetup[i].Color:= GetAppColor('EdBookmarkBg');

  EditorApplyTheme(CodeTreeFilterInput);
  EditorApplyTheme(fmConsole.ed);
  EditorApplyTheme(fmConsole.memo);
  if fmConsole.ShowError then
  begin
    fmConsole.memo.Colors.TextFont:= clRed;
    fmConsole.memo.Update;
  end;

  ToolbarMain.Color:= GetAppColor('TabBg');
  Self.Color:= ToolbarMain.Color;

  PanelCodeTreeTop.Color:= ToolbarMain.Color;
  PanelLeftTitle.Color:= ToolbarMain.Color;
  ToolbarSideTop.Color:= GetAppColor('SideBg');
  ToolbarSideLow.Color:= ToolbarSideTop.Color;
  ToolbarSideMid.Color:= ToolbarSideTop.Color;

  Status.Font.Color:= GetAppColor('StatusFont');
  Status.Color:= GetAppColor('StatusBg');
  Status.ColorBorderTop:= GetAppColor('StatusLines');
  Status.ColorBorderR:= GetAppColor('StatusLines');

  StatusAlt.Font.Color:= GetAppColor('StatusAltFont');
  StatusAlt.Color:= GetAppColor('StatusAltBg');
  StatusAlt.ColorBorderTop:= Status.ColorBorderTop;
  StatusAlt.ColorBorderR:= Status.ColorBorderR;

  StatusProgress.Font.Color:= Status.Font.Color;
  StatusProgress.ForeColor:= GetAppColor('GaugeFill');
  StatusProgress.BackColor:= GetAppColor('GaugeBg');
  StatusProgress.BorderColor:= GetAppColor('ButtonBorderPassive');

  ATButtonTheme.ColorFont:= GetAppColor('ButtonFont');
  ATButtonTheme.ColorFontDisabled:= GetAppColor('ButtonFontDisabled');
  ATButtonTheme.ColorBgPassive:= GetAppColor('ButtonBgPassive');
  ATButtonTheme.ColorBgOver:= GetAppColor('ButtonBgOver');
  ATButtonTheme.ColorBgChecked:= GetAppColor('ButtonBgChecked');
  ATButtonTheme.ColorBgDisabled:= GetAppColor('ButtonBgDisabled');
  ATButtonTheme.ColorBorderPassive:= GetAppColor('ButtonBorderPassive');
  ATButtonTheme.ColorArrows:= GetAppColor('TabArrow');
  ATButtonTheme.ColorBorderOver:= GetAppColor('ButtonBorderOver');
  ATButtonTheme.ColorBorderFocused:= GetAppColor('ButtonBorderFocused');

  DoApplyThemeToGroups(Groups);
  if FloatGroups then
  begin
    DoApplyThemeToGroups(GroupsF1);
    DoApplyThemeToGroups(GroupsF2);
    DoApplyThemeToGroups(GroupsF3);
  end;

  PanelLeftTitle.Font.Color:= GetAppColor('TabFont');

  if assigned(fmFind) then
  begin
    fmFind.Color:= GetAppColor('TabBg');
    fmFind.LabelFind.Font.Color:= GetAppColor('ListFont');
    EditorApplyTheme(fmFind.edFind);
    EditorApplyTheme(fmFind.edRep);
    fmFind.Invalidate;
  end;

  DoApplyThemeToTreeview(CodeTree.Tree, true, true);

  //proc_sidepanel_add_dialog
  for i:= 0 to CustomDialogs.Count-1 do
    DoApplyThemeToCustomDialog(TFormDummy(CustomDialogs[i]));

  //apply AppTheme to all frames
  for i:= 0 to FrameCount-1 do
  begin
    F:= Frames[i];
    F.Lexer:= F.Lexer; //apply lexer style map
    F.ApplyTheme;
  end;

  SplitterVert.Color:= GetAppColor('SplitMain');
  SplitterHorz.Color:= SplitterVert.Color;
  SplitterHorz.Invalidate;
  SplitterVert.Invalidate;

  Groups.Splitter1.Color:= GetAppColor('SplitGroups');
  Groups.Splitter2.Color:= Groups.Splitter1.Color;
  Groups.Splitter3.Color:= Groups.Splitter1.Color;
  Groups.Splitter4.Color:= Groups.Splitter1.Color;
  Groups.Splitter5.Color:= Groups.Splitter1.Color;
  Groups.Splitter1.Invalidate;
  Groups.Splitter2.Invalidate;
  Groups.Splitter3.Invalidate;
  Groups.Splitter4.Invalidate;
  Groups.Splitter5.Invalidate;

  CompletionOps.ColorBg:= GetAppColor('ListBg');
  CompletionOps.ColorSelBg:= GetAppColor('ListSelBg');
  CompletionOps.ColorFont[0]:= GetAppColor('ListCompletePrefix');
  CompletionOps.ColorFont[1]:= GetAppColor('ListFont');
  CompletionOps.ColorFont[2]:= GetAppColor('ListCompleteParams');
end;


procedure TfmMain.UpdateMenuThemes(AThemeUI: boolean);
var
  mi: TMenuItem;
  cap, FileMask: string;
  ListThemes: TStringList;
  sub: TMenuItem;
  i: integer;
begin
  if AThemeUI then
    sub:= mnuThemesUI
  else
    sub:= mnuThemesSyntax;

  if sub=nil then exit;
  sub.Clear;

  mi:= TMenuItem.Create(Self);
  mi.Caption:= msgThemeDefault;
  mi.RadioItem:= true;

  if AThemeUI then
  begin
    mi.OnClick:= @MenuThemeDefaultUiClick;
    mi.Checked:= FThemeUi='';
    ListThemes:= FListThemesUI;
    FileMask:= '*'+AppExtensionThemeUi;
  end
  else
  begin
    mi.OnClick:= @MenuThemeDefaultSyntaxClick;
    mi.Checked:= FThemeSyntax='';
    ListThemes:= FListThemesSyntax;
    FileMask:= '*'+AppExtensionThemeSyntax;
  end;
  sub.Add(mi);

  FFindFilesInDir(GetAppPath(cDirDataThemes), FileMask, ListThemes);
  if ListThemes.Count=0 then exit;
  ListThemes.Sort;

  for i:= 0 to ListThemes.Count-1 do
  begin
    cap:= LowerCase(ExtractFileNameOnly(ListThemes[i]));
    if sub.IndexOfCaption(cap)>=0 then Continue; //for Qt

    mi:= TMenuItem.Create(Self);
    mi.RadioItem:= true;
    mi.Caption:= cap;
    mi.Tag:= i;

    if AThemeUI then
    begin
      mi.OnClick:= @MenuThemesUiClick;
      mi.Checked:= LowerCase(FThemeUi)=LowerCase(mi.Caption);
    end
    else
    begin
      mi.OnClick:= @MenuThemesSyntaxClick;
      mi.Checked:= LowerCase(FThemeSyntax)=LowerCase(mi.Caption);
    end;

    sub.Add(mi);
  end;
end;

procedure TfmMain.SetThemeUi(const AValue: string);
var
  SName: string;
begin
  FThemeUi:= AValue;

  if FThemeUi='' then
  begin
    SName:= FThemeSyntax;
    DoInitTheme(AppTheme); //resets UI+Syntax
    if SName<>'' then
      SetThemeSyntax(SName);
  end
  else
    DoLoadTheme(GetAppPath(cDirDataThemes)+DirectorySeparator+FThemeUi+AppExtensionThemeUi, AppTheme, true);

  DoClearLexersAskedList;
  DoApplyTheme;

  DoPyEvent(CurrentEditor, cEventOnState, [IntToStr(APPSTATE_THEME_UI)]);
end;

procedure TfmMain.SetThemeSyntax(const AValue: string);
var
  SName: string;
begin
  FThemeSyntax:= AValue;

  if FThemeSyntax='' then
  begin
    SName:= FThemeUi;
    DoInitTheme(AppTheme); //resets UI+Syntax
    if SName<>'' then
      SetThemeUi(SName);
  end
  else
    DoLoadTheme(GetAppPath(cDirDataThemes)+DirectorySeparator+FThemeSyntax+AppExtensionThemeSyntax, AppTheme, false);

  DoClearLexersAskedList;
  DoApplyTheme;

  DoPyEvent(CurrentEditor, cEventOnState, [IntToStr(APPSTATE_THEME_SYNTAX)]);
end;

procedure TfmMain.MenuThemeDefaultUiClick(Sender: TObject);
begin
  ThemeUi:= '';

  if MsgBox(msgConfirmSyntaxThemeSameName, MB_OKCANCEL+MB_ICONQUESTION)=ID_OK then
    ThemeSyntax:= '';
end;

procedure TfmMain.MenuThemeDefaultSyntaxClick(Sender: TObject);
begin
  ThemeSyntax:= '';
end;


function TfmMain.IsThemeNameExist(const AName: string; AThemeUI: boolean): boolean;
var
  List: TStringList;
  StrName: string;
  i: integer;
begin
  Result:= false;

  if AThemeUI then
    List:= FListThemesUI
  else
    List:= FListThemesSyntax;

  for i:= 0 to List.Count-1 do
  begin
    StrName:= ExtractFileNameOnly(List[i]);
    if StrName=AName then exit(true);
  end;
end;

procedure TfmMain.MenuThemesUiClick(Sender: TObject);
var
  fn: string;
begin
  fn:= FListThemesUI[(Sender as TComponent).Tag];
  ThemeUi:= ExtractFileNameOnly(fn);

  //find syntax-theme with the same name
  if IsThemeNameExist(ThemeUi, false) then
    if MsgBox(msgConfirmSyntaxThemeSameName, MB_OKCANCEL+MB_ICONQUESTION)=ID_OK then
      ThemeSyntax:= ThemeUi;
end;

procedure TfmMain.MenuThemesSyntaxClick(Sender: TObject);
var
  fn: string;
begin
  fn:= FListThemesSyntax[(Sender as TComponent).Tag];
  ThemeSyntax:= ExtractFileNameOnly(fn);
end;


procedure TfmMain.DoDialogTheme(AThemeUI: boolean);
var
  Str, StrName, StrExt: string;
begin
  if AThemeUI then
  begin
    StrName:= ThemeUi;
    StrExt:= AppExtensionThemeUi;
  end
  else
  begin
    StrName:= ThemeSyntax;
    StrExt:= AppExtensionThemeSyntax;
  end;

  if DoDialogConfigTheme(AppTheme, AThemeUI) then
  begin
    DoApplyTheme;
    if Msgbox(msgConfirmSaveColorsToFile, MB_OKCANCEL or MB_ICONQUESTION)=ID_OK then
    begin
      Str:= Trim(InputBox(msgTitle, msgThemeName, StrName));
      if Str='' then exit;
      Str:= GetAppPath(cDirDataThemes)+DirectorySeparator+Str+StrExt;

      DoSaveTheme(Str, AppTheme, AThemeUI);
      UpdateMenuThemes(AThemeUI);
    end;
  end;
end;

function TfmMain.DoDialogConfigTheme(var AData: TAppTheme; AThemeUI: boolean
  ): boolean;
var
  Form: TfmColorSetup;
  i: integer;
begin
  Form:= TfmColorSetup.Create(nil);
  try
    Form.PanelUi.Visible:= AThemeUI;
    Form.PanelSyntax.Visible:= not AThemeUI;

    DoLocalize_FormColorSetup(Form);
    Form.OnApply:= @FormColorsApply;
    Form.Data:= AData;
    Result:= Form.ShowModal=mrOk;

    if Result then
    begin
      AData:= Form.Data;
      for i:= 0 to FrameCount-1 do
        with Frames[i] do Lexer:= Lexer;
      UpdateFrame;
    end;
  finally
    FreeAndNil(Form);
  end;
end;


