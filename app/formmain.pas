(*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.

Copyright (c) Alexey Torgashin
*)
unit FormMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus,
  Clipbrd, StrUtils, Variants, IniFiles,
  LclType, LclProc, LclIntf,
  LazFileUtils, LazUTF8, FileUtil,
  TreeFilterEdit,
  {$ifdef LCLGTK2}
  fix_gtk_clipboard,
  {$endif}
  fix_focus_window,
  at__jsonconf,
  PythonEngine,
  UniqueInstance,
  ec_LexerList,
  ec_SyntAnal,
  ATButtons,
  ATFlatToolbar,
  ATListbox,
  ATScrollbar,
  ATPanelSimple,
  ATSynEdit,
  ATSynEdit_Keymap,
  ATSynEdit_Keymap_Init,
  ATSynEdit_Commands,
  ATSynEdit_Finder,
  ATSynEdit_Carets,
  ATSynEdit_Bookmarks,
  ATSynEdit_Markers,
  ATSynEdit_WrapInfo,
  ATSynEdit_Ranges,
  ATSynEdit_DimRanges,
  ATSynEdit_Gaps,
  ATSynEdit_Hotspots,
  ATSynEdit_CanvasProc,
  ATSynEdit_Adapter_EControl,
  ATSynEdit_Adapter_LiteLexer,
  ATSynEdit_ScrollBar,
  ATSynEdit_CharSizer,
  ATSynEdit_Export_HTML,
  ATSynEdit_Edits,
  ATTabs,
  ATGroups,
  ATStatusBar,
  ATStrings,
  ATStringProc,
  ATGauge,
  ATBinHex,
  atsynedit_form_complete,
  atsynedit_form_complete_synwrite,
  atsynedit_form_complete_css,
  atsynedit_form_complete_html,
  proc_str,
  proc_py,
  proc_py_const,
  proc_files,
  proc_globdata,
  proc_colors,
  proc_cmd,
  proc_editor,
  proc_miscutils,
  proc_msg,
  proc_install_zip,
  proc_lexer_styles,
  proc_keysdialog,
  proc_customdialog,
  proc_customdialog_dummy,
  proc_scrollbars,
  proc_keymap_undolist,
  formconsole,
  formframe,
  form_menu_commands,
  form_menu_list,
  form_menu_py,
  formgoto,
  formfind,
  formsavetabs,
  formconfirmrep,
  formlexerprop,
  formlexerlib,
  formlexerstylesload,
  formlexerstylemap,
  formcolorsetup,
  formabout,
  formcharmaps,
  formkeyinput,
  form_addon_report,
  formconfirmbinary,
  math;

type
  TATFindMarkingMode = (
    markingNone,
    markingSelections,
    markingMarkers,
    markingBookmarks
    );

  TATMenuItemsAlt = record
    item0: TMenuItem;
    item1: TMenuItem;
    active0: boolean;
  end;

type
  { TfmMain }
  TfmMain = class(TForm)
    AppProps: TApplicationProperties;
    ButtonCancel: TATButton;
    mnuTabMoveF2: TMenuItem;
    mnuTabMoveF3: TMenuItem;
    mnuSepT2: TMenuItem;
    mnuViewFloatSide: TMenuItem;
    mnuViewFloatBottom: TMenuItem;
    mnuOpDefaultUser: TMenuItem;
    TimerStatusBusy: TTimer;
    TimerAppIdle: TIdleTimer;
    ImageListTabs: TImageList;
    ImageListToolbar: TImageList;
    MenuItem5: TMenuItem;
    mnuSelExtWord: TMenuItem;
    mnuViewOnTop: TMenuItem;
    mnuOpPlugins: TMenuItem;
    mnuTreeSep1: TMenuItem;
    mnuTreeSorted: TMenuItem;
    mnuViewUnpriSpacesTail: TMenuItem;
    mnuViewMicromap: TMenuItem;
    mnuHelpCheckUpd: TMenuItem;
    PopupPicScale: TPopupMenu;
    StatusProgress: TGauge;
    LabelSideTitle: TLabel;
    MenuItem4: TMenuItem;
    mnuViewDistFree: TMenuItem;
    SepV4: TMenuItem;
    mnuBmPlaceOnCarets: TMenuItem;
    mnuFileNewMenu: TMenuItem;
    mnuPluginsEmpty: TMenuItem;
    ImageListSide: TImageList;
    FontDlg: TFontDialog;
    ImageListBm: TImageList;
    ImageListTree: TImageList;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    mnuBmDeleteLines: TMenuItem;
    mnuBmCopyLines: TMenuItem;
    mnuOpThemeSyntax: TMenuItem;
    mnuThemesSyntax: TMenuItem;
    mnuBmPlaceCarets: TMenuItem;
    PaintTest: TPaintBox;
    PanelAll: TATPanelSimple;
    PanelBottom: TATPanelSimple;
    PanelLeft: TATPanelSimple;
    PanelLeftTitle: TATPanelSimple;
    PanelMain: TATPanelSimple;
    PanelSide: TATPanelSimple;
    SepV3: TMenuItem;
    mnuLexers: TMenuItem;
    mnuHelpIssues: TMenuItem;
    mnuOpLexMap: TMenuItem;
    mnuTst2: TMenuItem;
    mnuLang: TMenuItem;
    mnuTextOpenUrl: TMenuItem;
    mnuFontOutput: TMenuItem;
    mnuGr1p2H: TMenuItem;
    mnuEditSpToTab: TMenuItem;
    SepEd7: TMenuItem;
    mnuEditTabToSp: TMenuItem;
    mnuEditCharmap: TMenuItem;
    SepV2: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem14: TMenuItem;
    SepHelp1: TMenuItem;
    SepHelp2: TMenuItem;
    SepFile1: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    mnuThemesUI: TMenuItem;
    SepEd6: TMenuItem;
    mnuFileEndUn: TMenuItem;
    mnuFileEndMac: TMenuItem;
    mnuFileEnds: TMenuItem;
    SepFile4: TMenuItem;
    mnuFileEndWin: TMenuItem;
    mnuFileEnc: TMenuItem;
    mnuTextUndo: TMenuItem;
    mnuTextRedo: TMenuItem;
    MenuItem32: TMenuItem;
    mnuTextCut: TMenuItem;
    mnuTextCopy: TMenuItem;
    mnuTextPaste: TMenuItem;
    mnuTextDelete: TMenuItem;
    MenuItem37: TMenuItem;
    mnuTextSel: TMenuItem;
    mnuTextGotoDef: TMenuItem;
    mnuPlugins: TMenuItem;
    mnuFileHtml: TMenuItem;
    mnuTreeFold9: TMenuItem;
    mnuTreeFold7: TMenuItem;
    mnuTreeFold8: TMenuItem;
    mnuTreeFold2: TMenuItem;
    mnuTreeFold5: TMenuItem;
    mnuTreeFold6: TMenuItem;
    mnuTreeFold3: TMenuItem;
    mnuTreeFold4: TMenuItem;
    mnuTreeUnfoldAll: TMenuItem;
    mnuTreeFoldAll: TMenuItem;
    mnuTreeFoldLevel: TMenuItem;
    mnuViewSide: TMenuItem;
    mnuOpKeys: TMenuItem;
    mnuHelpWiki: TMenuItem;
    mnuOpThemeUi: TMenuItem;
    mnuEditTrimL: TMenuItem;
    mnuEditTrimR: TMenuItem;
    mnuEditTrim: TMenuItem;
    mnuHelpLexers: TMenuItem;
    mnuTabColor: TMenuItem;
    mnuThemes: TMenuItem;
    MenuItem29: TMenuItem;
    mnuTabsizeSpace: TMenuItem;
    mnuFind2Prev: TMenuItem;
    mnuTabSaveAs: TMenuItem;
    mnuTabSave: TMenuItem;
    mnuOpFileTypes: TMenuItem;
    mnuFindPrev: TMenuItem;
    mnuOpLexLib: TMenuItem;
    mnuOpLexSub: TMenuItem;
    mnuOpLexProp: TMenuItem;
    mnuFileCloseDel: TMenuItem;
    mnuOpLexer: TMenuItem;
    mnuOpMore: TMenuItem;
    mnuViewStatus: TMenuItem;
    mnuViewFullscr: TMenuItem;
    mnuFindWordNext: TMenuItem;
    mnuFindWordPrev: TMenuItem;
    SepSr2: TMenuItem;
    mnuFind2Next: TMenuItem;
    MenuItem20: TMenuItem;
    mnuFind2WordNext: TMenuItem;
    mnuFind2WordPrev: TMenuItem;
    mnuHelpChangelog: TMenuItem;
    mnuHelpMouse: TMenuItem;
    mnuHelpForum: TMenuItem;
    mnuViewToolbar: TMenuItem;
    mnuFontText: TMenuItem;
    mnuFontUi: TMenuItem;
    mnuFontSub: TMenuItem;
    mnuFileReopen: TMenuItem;
    mnuOpUser: TMenuItem;
    SepOp1: TMenuItem;
    mnuOp: TMenuItem;
    mnuOpDefault: TMenuItem;
    mnuHelpAbout: TMenuItem;
    mnuBmSub: TMenuItem;
    mnuFindRepDialog: TMenuItem;
    mnuFindNext: TMenuItem;
    mnuFindDlg: TMenuItem;
    SepSr1: TMenuItem;
    mnuBmPrev: TMenuItem;
    mnuBmNext: TMenuItem;
    mnuGotoBm: TMenuItem;
    mnuBmToggle: TMenuItem;
    mnuBmInvert: TMenuItem;
    mnuBmClear: TMenuItem;
    mnuCaseSent: TMenuItem;
    mnuCaseLow: TMenuItem;
    mnuCaseUp: TMenuItem;
    mnuCaseTitle: TMenuItem;
    mnuCaseInvert: TMenuItem;
    mnuCaseSub: TMenuItem;
    mnuSelExtLine: TMenuItem;
    mnuSelInvert: TMenuItem;
    mnuSelSplit: TMenuItem;
    SepSel1: TMenuItem;
    mnuSel: TMenuItem;
    mnuFileSaveAll: TMenuItem;
    mnuEditCopyLine: TMenuItem;
    mnuEditCopyAppend: TMenuItem;
    SepEd4: TMenuItem;
    mnuEditCopyFFull: TMenuItem;
    mnuEditCopyFName: TMenuItem;
    mnuEditCopyFDir: TMenuItem;
    mnuEditCopySub: TMenuItem;
    mnuGotoLine: TMenuItem;
    mnuSr: TMenuItem;
    mnuTabMove1: TMenuItem;
    mnuTabMove2: TMenuItem;
    mnuTabMove3: TMenuItem;
    mnuTabMove4: TMenuItem;
    mnuTabMove5: TMenuItem;
    mnuTabMove6: TMenuItem;
    mnuTabMoveF1: TMenuItem;
    mnuSepT1: TMenuItem;
    mnuTabMoveNext: TMenuItem;
    mnuTabMovePrev: TMenuItem;
    mnuTabMoveSub: TMenuItem;
    mnuTabCloseSub: TMenuItem;
    MenuItem9: TMenuItem;
    mnuTabCloseOtherAll: TMenuItem;
    mnuTabCloseAllAll: TMenuItem;
    mnuTabCloseAllSame: TMenuItem;
    mnuTabCloseLeft: TMenuItem;
    mnuTabCloseRight: TMenuItem;
    mnuTabCloseThis: TMenuItem;
    mnuTabCloseOtherSame: TMenuItem;
    mnuCaretsUp1Page: TMenuItem;
    mnuCaretsUpBegin: TMenuItem;
    mnuCaretsDown1Line: TMenuItem;
    mnuCaretsDown1Page: TMenuItem;
    mnuCaretsDownEnd: TMenuItem;
    SepEd5: TMenuItem;
    mnuCaretsCancel: TMenuItem;
    mnuCaretsUp1Line: TMenuItem;
    mnuCaretsExtSub: TMenuItem;
    mnuEditLineMoveUp: TMenuItem;
    mnuEditLineMoveDown: TMenuItem;
    mnuEditLineDel: TMenuItem;
    mnuEditLineDup: TMenuItem;
    mnuEditIndent: TMenuItem;
    mnuEditUnindent: TMenuItem;
    mnuEditIndentSub: TMenuItem;
    mnuEditLineOp: TMenuItem;
    mnuHelpCmd: TMenuItem;
    mnuEditUndo: TMenuItem;
    mnuEditDel: TMenuItem;
    mnuSelAll: TMenuItem;
    SepEd2: TMenuItem;
    mnuEditRedo: TMenuItem;
    SepEd1: TMenuItem;
    mnuEditCut: TMenuItem;
    mnuEditCopy: TMenuItem;
    mnuEditPaste: TMenuItem;
    mnuViewNums: TMenuItem;
    mnuViewRuler: TMenuItem;
    mnuViewFold: TMenuItem;
    mnuViewWrap: TMenuItem;
    mnuViewMinimap: TMenuItem;
    mnuViewSplitSub: TMenuItem;
    MenuItem10: TMenuItem;
    SepV1: TMenuItem;
    mnuViewUnpriShow: TMenuItem;
    mnuViewUnpriSpaces: TMenuItem;
    mnuViewUnpriEnds: TMenuItem;
    mnuViewUnpriEndsDet: TMenuItem;
    mnuViewUnpri: TMenuItem;
    mnuEndsWin: TMenuItem;
    mnuEndsUnix: TMenuItem;
    mnuEndsMac: TMenuItem;
    mnuViewSplitDo: TMenuItem;
    mnuViewSplitHorz: TMenuItem;
    mnuHelp: TMenuItem;
    mnuView: TMenuItem;
    mnuViewBottom: TMenuItem;
    mnuFileCloseAll: TMenuItem;
    mnuFileCloseOther: TMenuItem;
    SepFile2: TMenuItem;
    mnuFileNew: TMenuItem;
    mnuGr1p2V: TMenuItem;
    mnuGr6: TMenuItem;
    mnuGr4G: TMenuItem;
    mnuGr4V: TMenuItem;
    mnuGr4H: TMenuItem;
    mnuGroups: TMenuItem;
    mnuGr1: TMenuItem;
    mnuGr3V: TMenuItem;
    mnuGr3H: TMenuItem;
    mnuGr2V: TMenuItem;
    mnuGr2H: TMenuItem;
    mnuFile: TMenuItem;
    SepFile3: TMenuItem;
    mnuFileExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuFileOpenDir: TMenuItem;
    mnuFileOpenSub: TMenuItem;
    mnuFileOpen: TMenuItem;
    mnuFileSave: TMenuItem;
    mnuFileSaveAs: TMenuItem;
    mnuFileClose: TMenuItem;
    OpenDlg: TOpenDialog;
    PopupEnc: TPopupMenu;
    PopupEnds: TPopupMenu;
    PopupLex: TPopupMenu;
    PopupFind: TPopupMenu;
    PopupText: TPopupMenu;
    PopupTree: TPopupMenu;
    PopupTabSize: TPopupMenu;
    PopupRecents: TPopupMenu;
    PopupTab: TPopupMenu;
    PythonEngine: TPythonEngine;
    PythonIO: TPythonInputOutput;
    PythonMod: TPythonModule;
    SaveDlg: TSaveDialog;
    SplitterHorz: TSplitter;
    SplitterVert: TSplitter;
    TimerStatusAlt: TTimer;
    TimerTreeFill: TTimer;
    TimerCmd: TTimer;
    TimerStatus: TTimer;
    TimerTreeFocus: TTimer;
    ToolbarMain: TATFlatToolbar;
    ToolbarSideMid: TATFlatToolbar;
    ToolbarSideLow: TATFlatToolbar;
    ToolbarSideTop: TATFlatToolbar;
    UniqInstance: TUniqueInstance;
    procedure AppPropsActivate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure DoOnTabOver(Sender: TObject; ATabIndex: Integer);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var ACanClose: boolean);
    procedure FormColorsApply(const AColors: TAppTheme);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FrameStopTreeUpdate;
    procedure FrameAddRecent(Sender: TObject);
    procedure FrameOnMsgStatus(Sender: TObject; const AStr: string);
    procedure FrameOnChangeCaretPos(Sender: TObject);
    procedure FrameParseDone(Sender: TObject);
    procedure ListboxOutClick(Sender: TObject);
    procedure ListboxOutDrawItem(Sender: TObject; C: TCanvas; AIndex: integer;
      const ARect: TRect);
    procedure ListboxOutKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuThemesSyntaxClick(Sender: TObject);
    procedure mnuTabColorClick(Sender: TObject);
    procedure mnuTabMoveF2Click(Sender: TObject);
    procedure mnuTabMoveF3Click(Sender: TObject);
    procedure mnuTabsize1Click(Sender: TObject);
    procedure mnuTabsize2Click(Sender: TObject);
    procedure mnuTabsize3Click(Sender: TObject);
    procedure mnuTabsize4Click(Sender: TObject);
    procedure mnuTabsize5Click(Sender: TObject);
    procedure mnuTabsize6Click(Sender: TObject);
    procedure mnuTabsize7Click(Sender: TObject);
    procedure mnuTabsize8Click(Sender: TObject);
    procedure MenuRecentsClear(Sender: TObject);
    procedure mnuFind2NextClick(Sender: TObject);
    procedure mnuFind2PrevClick(Sender: TObject);
    procedure mnuFind2WordNextClick(Sender: TObject);
    procedure mnuFind2WordPrevClick(Sender: TObject);
    procedure DoHelpAbout;
    procedure DoHelpForum;
    procedure DoHelpChangelog;
    procedure DoHelpMouse;
    procedure DoHelpWiki;
    procedure DoHelpLexers;
    procedure DoHelpIssues;
    procedure DoHelpHotkeys;

    procedure MenuWindowClick(Sender: TObject);
    procedure mnuTabCloseAllAllClick(Sender: TObject);
    procedure mnuTabCloseAllSameClick(Sender: TObject);
    procedure mnuTabCloseLeftClick(Sender: TObject);
    procedure mnuTabCloseOtherAllClick(Sender: TObject);
    procedure mnuTabCloseOtherSameClick(Sender: TObject);
    procedure mnuTabCloseRightClick(Sender: TObject);
    procedure mnuTabCloseThisClick(Sender: TObject);
    procedure mnuTabMove1Click(Sender: TObject);
    procedure mnuTabMove2Click(Sender: TObject);
    procedure mnuTabMove3Click(Sender: TObject);
    procedure mnuTabMove4Click(Sender: TObject);
    procedure mnuTabMove5Click(Sender: TObject);
    procedure mnuTabMove6Click(Sender: TObject);
    procedure mnuTabMoveF1Click(Sender: TObject);
    procedure mnuTabMoveNextClick(Sender: TObject);
    procedure mnuTabMovePrevClick(Sender: TObject);
    procedure mnuTabSaveAsClick(Sender: TObject);
    procedure mnuTabSaveClick(Sender: TObject);
    procedure mnuTabsizeSpaceClick(Sender: TObject);
    procedure mnuTreeFold2Click(Sender: TObject);
    procedure mnuTreeFold3Click(Sender: TObject);
    procedure mnuTreeFold4Click(Sender: TObject);
    procedure mnuTreeFold5Click(Sender: TObject);
    procedure mnuTreeFold6Click(Sender: TObject);
    procedure mnuTreeFold7Click(Sender: TObject);
    procedure mnuTreeFold8Click(Sender: TObject);
    procedure mnuTreeFold9Click(Sender: TObject);
    procedure mnuTreeFoldAllClick(Sender: TObject);
    procedure mnuTreeSortedClick(Sender: TObject);
    procedure mnuTreeUnfoldAllClick(Sender: TObject);
    procedure PopupTabPopup(Sender: TObject);
    procedure PopupTextPopup(Sender: TObject);
    procedure PythonEngineAfterInit(Sender: TObject);
    procedure PythonIOSendUniData(Sender: TObject; const Data: UnicodeString);
    procedure PythonModInitialization(Sender: TObject);
    procedure StatusPanelClick(Sender: TObject; AIndex: Integer);
    procedure TimerAppIdleTimer(Sender: TObject);
    procedure TimerCmdTimer(Sender: TObject);
    procedure TimerStatusAltTimer(Sender: TObject);
    procedure TimerStatusBusyTimer(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure TimerTreeFillTimer(Sender: TObject);
    procedure TimerTreeFocusTimer(Sender: TObject);
    procedure UniqInstanceOtherInstance(Sender: TObject; ParamCount: Integer;
      Parameters: array of String);
    {$ifdef windows}
    procedure SecondInstance(const Msg: TBytes);
    {$endif}
  private
    { private declarations }
    FFormFloatSide: TForm;
    FFormFloatBottom: TForm;
    FFormFloatGroups1: TForm;
    FFormFloatGroups2: TForm;
    FFormFloatGroups3: TForm;
    FBoundsFloatSide: TRect;
    FBoundsFloatBottom: TRect;
    FBoundsFloatGroups1: TRect;
    FBoundsFloatGroups2: TRect;
    FBoundsFloatGroups3: TRect;
    FListRecents: TStringList;
    FListThemesUI: TStringList;
    FListThemesSyntax: TStringList;
    FListLangs: TStringList;
    FListTimers: TStringList;
    FListConsole: TStringList;
    FKeymapUndoList: TATKeymapUndoList;
    FKeymapLastLexer: string;
    FConsoleMustShow: boolean;
    FThemeUi: string;
    FThemeSyntax: string;
    FSessionName: string;
    FColorDialog: TColorDialog;
    Status: TATStatus;
    StatusAlt: TATStatus;
    Groups: TATGroups;
    GroupsCtx: TATGroups;
    GroupsF1: TATGroups;
    GroupsF2: TATGroups;
    GroupsF3: TATGroups;

    mnuApple: TMenuItem;
    mnuApple_About: TMenuItem;
    mnuApple_CheckUpd: TMenuItem;
    //mnuApple_Quit: TMenuItem;

    mnuViewWrap_Alt,
    mnuViewNums_Alt,
    mnuViewFold_Alt,
    mnuViewRuler_Alt,
    mnuViewMinimap_Alt,
    mnuViewMicromap_Alt,
    mnuViewSplitDo_Alt,
    mnuViewSplitHorz_Alt,
    mnuViewUnpriShow_Alt,
    mnuViewUnpriSpaces_Alt,
    mnuViewUnpriSpacesTail_Alt,
    mnuViewUnpriEnds_Alt,
    mnuViewUnpriEndsDet_Alt,
    mnuViewToolbar_Alt,
    mnuViewStatus_Alt,
    mnuViewFullscr_Alt,
    mnuViewDistFree_Alt,
    mnuViewSide_Alt,
    mnuViewBottom_Alt,
    mnuViewFloatSide_Alt,
    mnuViewFloatBottom_Alt,
    mnuViewOnTop_Alt,
    mnuGr1_Alt,
    mnuGr2H_Alt,
    mnuGr2V_Alt,
    mnuGr3H_Alt,
    mnuGr3V_Alt,
    mnuGr1p2V_Alt,
    mnuGr1p2H_Alt,
    mnuGr4H_Alt,
    mnuGr4V_Alt,
    mnuGr4G_Alt,
    mnuGr6_Alt: TATMenuItemsAlt;

    FFinder: TATEditorFinder;
    FFindStop: boolean;
    FFindConfirmAll: TModalResult;
    FFindMarkingMode: TATFindMarkingMode;
    FFindMarkingCaret1st: boolean;
    FShowFullScreen: boolean;
    FOrigBounds: TRect;
    FOrigWndState: TWindowState;
    FOrigShowToolbar: boolean;
    FOrigShowBottom: boolean;
    FOrigShowStatusbar: boolean;
    FOrigShowSidePanel: boolean;
    FOrigShowSideBar: boolean;
    FOrigShowTabs: boolean;
    FAllowLoadKeymap: boolean;
    FAllowOnFocus: boolean;
    FHandledOnShow: boolean;
    FFileNamesDroppedInitially: array of string;
    FFileNameLogDebug: string;
    FFileNameLogConsole: string;
    FTreeClick: boolean;
    FMenuCopy: TPopupMenu;
    FNewClickedEditor: TATSynEdit;
    FPyComplete_Editor: TATSynEdit;
    FPyComplete_Text: string;
    FPyComplete_CharsLeft: integer;
    FPyComplete_CharsRight: integer;
    FPyComplete_CaretPos: TPoint;
    FLastDirOfOpenDlg: string;
    FLastLexerForPluginsMenu: string;
    FLastSidebarPanel: string;
    FLastBottomPanel: string;
    FLastSelectedCommand: integer;
    FLastMousePos: TPoint;
    FOption_OpenReadOnly: boolean;
    FOption_OpenNewWindow: boolean;
    FOption_WindowPos: string;
    FOption_Encoding: string;
    FOption_FileOpenOptions: string;

    procedure CodeTreeFilterInputOnChange(Sender: TObject);
    procedure CodeTreeFilterResetClick(Sender: TObject);
    procedure DoApplyCenteringOption;
    procedure DoClearSingleFirstTab;
    procedure DoCloseAllTabs;
    procedure DoFileDialog_PrepareDir(Dlg: TFileDialog);
    procedure DoFileDialog_SaveDir(Dlg: TFileDialog);
    procedure DoCommandsMsgStatus(Sender: TObject; const ARes: string);
    procedure DoFindMarkingInit(AMode: TATFindMarkingMode);
    procedure DoFindOptions_OnChange(Sender: TObject);
    procedure DoFindOptions_ApplyDict(AText: string);
    procedure DoFindOptions_ResetInSelection;
    procedure DoFindOptions_GetStrings(out AFind, AReplace: string);
    function DoFindOptions_GetDict: PPyObject;
    procedure DoFolderOpen(const ADirName: string; ANewProject: boolean);
    procedure DoGroupsChangeMode(Sender: TObject);
    procedure DoOps_AddPluginMenuItem(ACaption: string; ASubMenu: TMenuItem; ATag: integer);
    procedure DoOps_LexersDisableInFrames(ListNames: TStringList);
    procedure DoOps_LexersRestoreInFrames(ListNames: TStringList);
    procedure DoShowBottomPanel(const ATabCaption: string);
    function DoSidebar_FilenameToImageIndex(ATabCaption, AFilename: string): integer;
    procedure DoSidebar_InitPanelForm(var AItem: TAppSidePanel;
      const ACaption: string; AForm: TCustomForm; AParent: TWinControl);
    procedure DoSidebar_ListboxDrawItem(Sender: TObject; C: TCanvas;
      AIndex: integer; const ARect: TRect);
    procedure DoSidebar_MainMenuClick(Sender: TObject);
    function DoSidebar_TranslatedCaption(const ACaption: string): string;
    procedure FormFloatBottomOnClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormFloatGroups1_OnEmpty(Sender: TObject);
    procedure FormFloatGroups2_OnEmpty(Sender: TObject);
    procedure FormFloatGroups3_OnEmpty(Sender: TObject);
    procedure FormFloatSideOnClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormFloatGroups1_OnClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormFloatGroups2_OnClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormFloatGroups3_OnClose(Sender: TObject; var CloseAction: TCloseAction);
    function GetSessionFilename: string;
    procedure CharmapOnInsert(const AStr: string);
    procedure DoLocalize;
    procedure DoLocalize_FormFind;
    procedure DoLocalize_FormGoto;
    function DoCheckFilenameOpened(const AName: string): boolean;
    procedure DoInvalidateEditors;
    function DoMenuAdd_Params(
      const AMenuId, AMenuCmd, AMenuCaption, AMenuHotkey, AMenuTagString: string;
      AIndex: integer): string;
    procedure DoMenuClear(const AMenuId: string);
    function DoMenu_GetPyProps(mi: TMenuItem): PPyObject;
    function DoMenu_PyEnum(const AMenuId: string): PPyObject;
    procedure DoOnTabMove(Sender: TObject; NFrom, NTo: Integer);
    procedure DoCodetree_OnDblClick(Sender: TObject);
    procedure DoCodetree_OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DoCodetree_OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoCodetree_GotoBlockForCurrentNode(AndSelect: boolean);
    procedure DoSidebar_OnTabClick(Sender: TObject);
    function DoSidebar_ActivateTab(const ACaption: string; AndFocus: boolean): boolean;
    function DoSidebar_AddTab(const ACaption: string;
      AImageIndex: integer; AHandle: PtrInt): boolean;
    function DoSidebar_AddTab_Empty(const ACaption: string;
      AImageIndex: integer; const AModule, AMethod: string): boolean;
    function DoSidebar_RemoveTab(const ACaption: string): boolean;
    function DoSidebar_CaptionToPanelsIndex(const Str: string): integer;
    function DoSidebar_CaptionToTabIndex(const Str: string): integer;
    function DoSidebar_CaptionToControlHandle(const ACaption: string): PtrInt;
    procedure DoBottom_OnTabClick(Sender: TObject);
    procedure DoBottom_AddonsClick(Sender: TObject);
    procedure DoBottom_FindClick(Sender: TObject);
    function DoBottom_CaptionToControlHandle(const ACaption: string): PtrInt;
    function DoBottom_AddTab(const ACaption: string;
      AImageIndex: integer; AHandle: PtrInt): boolean;
    function DoBottom_CaptionToPanelsIndex(const Str: string): integer;
    function DoBottom_ActivateTab(const ACaption: string): boolean;
    function DoBottom_CaptionToTabIndex(const ACaption: string): integer;
    function DoBottom_RemoveTab(const ACaption: string): boolean;
    procedure DoAutoComplete;
    procedure DoCudaLibAction(const AMethod: string);
    procedure DoDialogCharMap;
    procedure DoFindActionFromString(AStr: string);
    procedure DoFindOptionsFromString(const S: string);
    function DoFindOptionsToString: string;
    procedure DoGotoFromInput(const AInput: string);
    procedure DoGotoDefinition;
    procedure DoShowFuncHint;
    procedure DoApplyGutterVisible(AValue: boolean);
    procedure DoApplyFrameOps(F: TEditorFrame; const Op: TEditorOps; AForceApply: boolean);
    procedure DoApplyFont_Text;
    procedure DoApplyFont_Ui;
    procedure DoApplyFont_Output;
    procedure DoApplyAllOps;
    procedure DoApplyTheme;
    procedure DoApplyThemeToGroups(G: TATGroups);
    procedure DoClearRecentFileHistory;
    function DoOnConsoleInput(const Str: string): boolean;
    function DoOnConsolePrint(const Str: string): boolean;
    function DoOnConsoleClear: boolean;
    function DoOnConsoleNav(const Str: string): boolean;
    function DoOnMacro(const Str: string): boolean;
    function DoDialogConfigTheme(var AData: TAppTheme; AThemeUI: boolean): boolean;
    function DoDialogMenuApi(const AText, ACaption: string; AMultiline: boolean;
      AInitIndex: integer; ANoFuzzy: boolean; ANoFullFilter: boolean): integer;
    procedure DoFileExportHtml;
    function DoFileInstallZip(const fn: string; out DirTarget: string; ASilent: boolean): boolean;
    procedure DoFileCloseAndDelete;
    procedure DoFileNewMenu(Sender: TObject);
    procedure DoFileNewFrom(const fn: string);
    procedure DoFileSave;
    procedure DoFileSaveAs;
    procedure DoFocusEditor;
    procedure DoSwitchActiveTab(ANext: boolean);
    procedure DoPyTimerTick(Sender: TObject);
    procedure DoPyRunLastPlugin;
    procedure DoPyResetPlugins;
    procedure DoPyRescanPlugins;
    procedure DoPyStringToEvents(const AEventStr: string;
      out AEvents: TAppPyEvents;
      out AEventsPrior: TAppPyEventsPrior;
      out AEventsLazy: TAppPyEventsLazy);
    procedure DoPyUpdateEvents(const AModuleName, AEventStr, ALexerStr, AKeyStr: string);
    function DoSplitter_StringToId(const AStr: string): integer;
    procedure DoSplitter_GetInfo(const Id: integer;
      out BoolVert, BoolVisible: boolean; out NPos, NTotal: integer);
    procedure DoSplitter_SetInfo(const Id: integer; NPos: integer);
    procedure DoToolbarClick(Sender: TObject);
    procedure FrameLexerChange(Sender: TObject);
    procedure FrameOnEditorClickEndSelect(Sender: TObject; APrevPnt, ANewPnt: TPoint);
    procedure FrameOnEditorClickMoveCaret(Sender: TObject; APrevPnt, ANewPnt: TPoint);
    function GetFloatBottom: boolean;
    function GetFloatSide: boolean;
    function GetFloatGroups: boolean;
    function GetShowFloatGroup1: boolean;
    function GetShowFloatGroup2: boolean;
    function GetShowFloatGroup3: boolean;
    function GetShowMenu: boolean;
    function GetShowOnTop: boolean;
    function GetShowSidebarOnRight: boolean;
    procedure InitAppleMenu;
    procedure InitFloatGroup(var F: TForm; var G: TATGroups; ATag: integer;
      const ARect: TRect; AOnClose: TCloseEvent; AOnGroupEmpty: TNotifyEvent);
    procedure InitFloatGroups;
    procedure InitSidebar;
    procedure InitToolbar;
    function IsAllowedToOpenFileNow: boolean;
    function IsThemeNameExist(const AName: string; AThemeUI: boolean): boolean;
    procedure LiteLexer_ApplyStyle(Sender: TObject; AStyleHash: integer; var APart: TATLinePart);
    function LiteLexer_GetStyleHash(Sender: TObject; const AStyleName: string): integer;
    procedure MenuEncWithReloadClick(Sender: TObject);
    procedure MenuLangClick(Sender: TObject);
    procedure MenuPicScaleClick(Sender: TObject);
    procedure MenuPluginClick(Sender: TObject);
    procedure MenuTabsizeClick(Sender: TObject);
    procedure MenuThemeDefaultUiClick(Sender: TObject);
    procedure MenuThemeDefaultSyntaxClick(Sender: TObject);
    procedure MenuThemesUiClick(Sender: TObject);
    procedure MsgLogConsole(const AText: string);
    procedure MsgLogDebug(const AText: string);
    procedure MsgLogToFilename(const AText, AFilename: string; AWithTime: boolean);
    procedure MsgStatusAlt(const AText: string; ASeconds: integer);
    procedure SetFloatBottom(AValue: boolean);
    procedure SetFloatSide(AValue: boolean);
    procedure SetShowFloatGroup1(AValue: boolean);
    procedure SetShowFloatGroup2(AValue: boolean);
    procedure SetShowFloatGroup3(AValue: boolean);
    procedure SetShowMenu(AValue: boolean);
    procedure SetShowOnTop(AValue: boolean);
    procedure SetShowSidebarOnRight(AValue: boolean);
    procedure SetSidebarPanel(const ACaption: string);
    procedure SetShowDistractionFree(AValue: boolean);
    procedure SetShowFullScreen(AValue: boolean);
    procedure SetFullScreen_Ex(AValue: boolean; AHideAll: boolean);
    procedure SetFullScreen_Universal(AValue: boolean);
    procedure SetFullScreen_Win32(AValue: boolean);
    procedure SetThemeSyntax(const AValue: string);
    procedure SetThemeUi(const AValue: string);
    function SFindOptionsToTextHint: string;
    procedure DoTreeGetSyntaxRange(ANode: TTreeNode; out APosBegin, APosEnd: TPoint);
    procedure DoTreeSetSyntaxRange(ANode: TTreeNode; const APosBegin, APosEnd: TPoint);
    procedure DoOps_ShowEventPlugins;
    procedure DoOps_ResetLexerSpecificOptions;
    procedure DoOps_LoadPluginFromInf(const fn_inf: string);
    procedure DoOps_LoadSidebarIcons;
    procedure DoOps_LoadTreeIcons;
    procedure DoOps_LoadToolBarIcons;
    procedure DoOps_LoadCommandLineOptions;
    procedure DoOps_LoadLexerLib;
    procedure DoOps_SaveHistory;
    procedure DoOps_SaveHistory_GroupView(c: TJsonConfig);
    procedure DoOps_LoadHistory;
    procedure DoOps_LoadHistory_GroupView(c: TJsonConfig);
    procedure DoOps_LoadHistory_AfterOnStart;
    function DoOps_SaveSession(fn_session: string): boolean;
    function DoOps_LoadSession(fn_session: string): boolean;
    procedure DoOps_LoadOptionsAndApplyAll;
    procedure DoOps_LoadOptionsLexerSpecific(F: TEditorFrame);
    procedure DoOps_OpenFile_FileTypes;
    procedure DoOps_OpenFile_LexerSpecific;
    procedure DoOps_LoadPlugins;
    procedure DoOps_DialogFont(var OpName: string; var OpSize: integer;
      const AConfigStrName, AConfigStrSize: string);
    procedure DoOps_DialogFont_Text;
    procedure DoOps_DialogFont_Ui;
    procedure DoOps_DialogFont_Output;
    procedure DoOps_OpenFile_Default;
    procedure DoOps_OpenFile_User;
    procedure DoOps_OpenFile_DefaultAndUser;
    procedure DoOps_LoadOptions(const fn: string; var Op: TEditorOps);
    procedure DoOps_LoadKeymap;
    procedure DoOps_LoadKeymapFrom(const AFilenameKeymap: string; AUndoList: TATKeymapUndoList);
    procedure DoEditorsLock(ALock: boolean);
    procedure DoFindCurrentWordOrSel(ANext: boolean; AWordOrSel: boolean);
    procedure DoFind_ExpandSelectionToWord;
    procedure DoCopyFilenameDir;
    procedure DoCopyFilenameFull;
    procedure DoCopyFilenameName;
    procedure DoCopyLine;
    procedure DoDialogCommands;
    function DoDialogCommands_Custom(AShowUsual, AShowPlugins, AShowLexers,
      AAllowConfig: boolean; AFocusedCommand: integer): integer;
    function DoDialogCommands_Py(AShowUsual, AShowPlugins, AShowLexers, AAllowConfig: boolean): string;
    procedure DoDialogGoto;
    procedure DoDialogGotoBookmark;
    function DoDialogSaveTabs: boolean;
    procedure DoDialogLexerProp(an: TecSyntAnalyzer);
    procedure DoDialogLexerLib;
    procedure DoDialogLexerMap;
    procedure DoDialogRestoreLexerStyles;
    procedure DoDialogTheme(AThemeUI: boolean);
    procedure DoShowConsole(AFocusEdit: boolean);
    procedure DoShowOutput;
    procedure DoShowValidate;
    procedure DoShowSidePanel(const ATabCaption: string; AndFocus: boolean);
    function FrameOfPopup: TEditorFrame;
    procedure FrameOnCommand(Sender: TObject; ACommand: integer; const AText: string;
      var AHandled: boolean);
    function DoFileCloseAll: boolean;
    procedure DoDialogFind(AReplaceMode: boolean);
    procedure DoDialogFind_Hide;
    procedure DoFindResult(ok: boolean);
    procedure DoFindFirst;
    procedure DoFindNext(ANext: boolean);
    procedure DoFindMarkAll(AMode: TATFindMarkingMode);
    procedure DoMoveTabToGroup(AGroupIndex: Integer);
    procedure DoOnTabPopup(Sender: TObject; APages: TATPages; ATabIndex: integer);
    function DoFileOpen(AFilename: string; APages: TATPages=nil; const AOptions: string=''): TEditorFrame;
    procedure DoFileOpenDialog(AOptions: string= '');
    procedure DoFileOpenDialog_NoPlugins;
    procedure DoFileSaveAll;
    procedure DoFileReopen;
    procedure DoLoadCommandLine;
    procedure DoToggleMenu;
    procedure DoToggleFloatSide;
    procedure DoToggleFloatBottom;
    procedure DoToggleOnTop;
    procedure DoToggleFullScreen;
    procedure DoToggleDistractionFree;
    procedure DoToggleSidePanel;
    procedure DoToggleBottomPanel;
    procedure DoToggleFindDialog;
    procedure DoToggleToolbar;
    procedure DoToggleStatusbar;
    procedure FindDialogDone(Sender: TObject; const Res: string);
    procedure FinderOnFound(Sender: TObject; APos1, APos2: TPoint);
    procedure FinderOnBadRegex(Sender: TObject);
    procedure FinderOnConfirmReplace(Sender: TObject; APos1, APos2: TPoint;
      AForMany: boolean; var AConfirm, AContinue: boolean);
    procedure FinderOnProgress(Sender: TObject; const ACurPos, AMaxPos: Int64; var AContinue: boolean);
    procedure FinderUpdateEditor(AUpdateText: boolean);
    procedure FrameOnSaveFile(Sender: TObject);
    procedure GetEditorIndexes(Ed: TATSynEdit; out AGroupIndex, ATabIndex: Integer);
    function GetModifiedCount: integer;
    function GetShowSideBar: boolean;
    function GetShowSidePanel: boolean;
    function GetShowStatus: boolean;
    function GetShowToolbar: boolean;
    function GetShowBottom: boolean;
    function GetShowTabsMain: boolean;
    procedure InitFormFind;
    function IsFocusedBottom: boolean;
    function IsFocusedFind: boolean;
    function IsLexerMatches(const ANameList: string): boolean;
    procedure PyCompletionOnGetProp(Sender: TObject; out AText: string;
      out ACharsLeft, ACharsRight: integer);
    procedure PyCompletionOnResult(Sender: TObject;
      const ASnippetId: string; ASnippetIndex: integer);
    procedure DoPyCommand_ByPluginIndex(AIndex: integer);
    procedure SetFrameEncoding(Frame: TEditorFrame; const AEnc: string;
      AAlsoReloadFile: boolean);
    procedure SetLexerIndex(N: integer);
    procedure SetShowStatus(AValue: boolean);
    procedure SetShowToolbar(AValue: boolean);
    procedure SetShowBottom(AValue: boolean);
    procedure SetShowSideBar(AValue: boolean);
    procedure SetShowSidePanel(AValue: boolean);
    procedure SetShowTabsMain(AValue: boolean);
    procedure SplitterOnPaint_Gr(Sender: TObject);
    procedure SplitterOnPaint_Main(Sender: TObject);
    procedure UpdateBottomPanels(const ACaption: string);
    procedure UpdateEditorTabsize(N: integer);
    procedure UpdateKeymapDynamicItems;
    procedure UpdateMenuItemAltObject(mi: TMenuItem; cmd: integer);
    procedure UpdateMenuItemChecked(mi: TMenuItem; saved: TATMenuItemsAlt; AValue: boolean);
    procedure UpdateMenuItemHint(mi: TMenuItem; const AHint: string);
    procedure UpdateMenuItemHotkey(mi: TMenuItem; cmd: integer);
    procedure UpdateMenuLangs(sub: TMenuItem);
    procedure UpdateMenuPicScale;
    procedure UpdateMenuTabsize;
    procedure UpdateMenuThemes(AThemeUI: boolean);
    procedure UpdateMenuLexersTo(AMenu: TMenuItem);
    procedure UpdateMenuRecent(F: TEditorFrame);
    procedure UpdateMenuHotkeys;
    procedure UpdateMenuLexers;
    procedure UpdateMenuPlugins;
    procedure UpdateMenuPlugins_Shortcuts(AForceUpdate: boolean=false);
    procedure UpdateMenuChecks;
    procedure UpdateMenuEnc(AMenu: TMenuItem);
    procedure DoApplyUiOps;
    procedure DoApplyUiOpsToGroups(G: TATGroups);
    procedure InitPyEngine;
    procedure FrameOnChangeCaption(Sender: TObject);
    procedure FrameOnUpdateStatus(Sender: TObject);
    function DoTabAdd(APages: TATPages; const ACaption: string;
      AndActivate: boolean=true;
      AAllowNearCurrent: boolean=true): TATTabData;
    procedure DoOnTabFocus(Sender: TObject);
    procedure DoOnTabAdd(Sender: TObject);
    procedure DoOnTabClose(Sender: TObject; ATabIndex: Integer;
      var ACanClose, ACanContinue: boolean);
    procedure FrameOnFocus(Sender: TObject);
    function GetFrame(AIndex: integer): TEditorFrame;
    procedure MenuEncNoReloadClick(Sender: TObject);
    procedure MenuLexerClick(Sender: TObject);
    procedure MenuMainClick(Sender: TObject);
    procedure MenuRecentsClick(Sender: TObject);
    procedure SetFrame(Frame: TEditorFrame);
    procedure UpdateFrameLineEnds(Frame: TEditorFrame; AValue: TATLineEnds);
    procedure MsgStatus(const AText: string);
    procedure UpdateSidebarButtons;
    procedure UpdateSidebarPanels(const ACaption: string; AndFocus: boolean);
    procedure UpdateStatusbarPanelsFromString(AStr: string);
    procedure UpdateBottomButtons;
    procedure UpdateStatus_ForFrame(AStatus: TATStatus; F: TEditorFrame);
    procedure UpdateStatus_RealWork;
    procedure UpdateStatus_ToolButton(AToolbar: TATFlatToolbar; ACmd: integer; AChecked: boolean);
    procedure UpdateTabCaptionsFromFolders;
    procedure UpdateTabsActiveColor(F: TEditorFrame);
    procedure UpdateTree(AFill: boolean; AConsiderTreeVisible: boolean=true; AForceUpdateAll: boolean=false);
    procedure UpdateTreeContents;
    procedure UpdateTreeSelection;
    procedure UpdateCaption;
    procedure UpdateEnabledAll(b: boolean);
    procedure InitFrameEvents(F: TEditorFrame);
    procedure UpdateInputForm(Form: TForm; AndHeight: boolean= true);
    procedure UpdateFrame(AUpdatedText: boolean= false);
    procedure UpdateAppForSearch(AStart, AEdLock, AFindMode: boolean);
    procedure UpdateStatus;
    procedure InitStatusButton;
    procedure DoOnDeleteLexer(Sender: TObject; const ALexerName: string);
    procedure UpdateTreeFilter;
  public
    { public declarations }
    CodeTree: TAppTreeContainer;
    CodeTreeFilter: TTreeFilterEdit;
    CodeTreeFilterInput: TATEdit;
    CodeTreeFilterReset: TATButton;
    PanelCodeTreeTop: TATPanelSimple;
    ListboxOut: TATListbox;
    ListboxVal: TATListbox;
    function FrameCount: integer;
    property Frames[N: integer]: TEditorFrame read GetFrame;
    function CurrentFrame: TEditorFrame;
    function CurrentEditor: TATSynEdit;
    property FloatSide: boolean read GetFloatSide write SetFloatSide;
    property FloatBottom: boolean read GetFloatBottom write SetFloatBottom;
    property FloatGroups: boolean read GetFloatGroups;
    property ShowFloatGroup1: boolean read GetShowFloatGroup1 write SetShowFloatGroup1;
    property ShowFloatGroup2: boolean read GetShowFloatGroup2 write SetShowFloatGroup2;
    property ShowFloatGroup3: boolean read GetShowFloatGroup3 write SetShowFloatGroup3;
    property ShowMenu: boolean read GetShowMenu write SetShowMenu;
    property ShowOnTop: boolean read GetShowOnTop write SetShowOnTop;
    property ShowFullscreen: boolean read FShowFullScreen write SetShowFullScreen;
    property ShowDistractionFree: boolean read FShowFullScreen write SetShowDistractionFree;
    property ShowSideBar: boolean read GetShowSideBar write SetShowSideBar;
    property ShowSideBarOnRight: boolean read GetShowSidebarOnRight write SetShowSidebarOnRight;
    property ShowSidePanel: boolean read GetShowSidePanel write SetShowSidePanel;
    property ShowToolbar: boolean read GetShowToolbar write SetShowToolbar;
    property ShowStatus: boolean read GetShowStatus write SetShowStatus;
    property ShowBottom: boolean read GetShowBottom write SetShowBottom;
    property ShowTabsMain: boolean read GetShowTabsMain write SetShowTabsMain;
    property ThemeUi: string read FThemeUi write SetThemeUi;
    property ThemeSyntax: string read FThemeSyntax write SetThemeSyntax;
    property SidebarPanel: string read FLastSidebarPanel write SetSidebarPanel;
    function DoPyEvent(AEd: TATSynEdit; AEvent: TAppPyEvent; const AParams: array of string): string;
    procedure DoPyCommand(const AModule, AMethod: string; const AParams: array of string);
    //function DoPyCallbackFromAPI(const ACallback: string; const AParams: array of string): string;
  end;

var
  fmMain: TfmMain;

var
  NTickInitial: QWord = 0;


implementation

const
  StatusbarTag_Caret = 10;
  StatusbarTag_Enc = 11;
  StatusbarTag_LineEnds = 12;
  StatusbarTag_Lexer = 13;
  StatusbarTag_TabSize = 14;
  StatusbarTag_InsOvr = 15;
  StatusbarTag_SelMode = 16;
  StatusbarTag_WrapMode = 17;
  StatusbarTag_Msg = 20;

{$R *.lfm}

function GetEditorFrame(Ed: TATSynEdit): TEditorFrame;
begin
  if Ed.Parent is TEditorFrame then
    Result:= Ed.Parent as TEditorFrame
  else
    Result:= nil;
end;

function GetEditorBrother(Ed: TATSynEdit): TATSynEdit;
var
  F: TEditorFrame;
begin
  F:= GetEditorFrame(Ed);
  if F=nil then exit(nil);
  if Ed=F.Editor then
    Result:= F.Editor2
  else
    Result:= F.Editor;
end;

function GetEditorActiveInGroup(AIndex: integer): TATSynEdit;
var
  Pages: TATPages;
  Data: TATTabData;
begin
  Result:= nil;
  case AIndex of
    0..5:
      Pages:= fmMain.Groups.Pages[AIndex];
    6:
      Pages:= fmMain.GroupsF1.Pages[0];
    7:
      Pages:= fmMain.GroupsF2.Pages[0];
    8:
      Pages:= fmMain.GroupsF3.Pages[0];
    else
      exit;
  end;

  Data:= Pages.Tabs.GetTabData(Pages.Tabs.TabIndex);
  if Assigned(Data) then
    Result:= (Data.TabObject as TEditorFrame).Editor;
end;


{ TfmMain }

{$I formmain_py_toolbars.inc}
{$I formmain_py_statusbars.inc}
{$I formmain_py_api.inc}
{$I formmain_py_helpers.inc}
{$I formmain_py_pluginwork.inc}


procedure TfmMain.StatusPanelClick(Sender: TObject; AIndex: Integer);
var
  Frame: TEditorFrame;
  Data: TATStatusData;
begin
  Frame:= CurrentFrame;
  Data:= Status.GetPanelData(AIndex);
  if Data=nil then exit;

  if Frame.IsPicture then
  begin
    case Data.Tag of
      StatusbarTag_TabSize:
        begin
          PopupPicScale.Popup;
        end;
    end;
    exit;
  end;

  if Frame.IsBinary then
  begin
    case Data.Tag of
      StatusbarTag_Enc:
        with Mouse.CursorPos do
          Frame.Binary.TextEncodingsMenu(X, Y);
    end;
    exit;
  end;

  case Data.Tag of
    StatusbarTag_Enc:
      begin
        if not Frame.ReadOnly then
          PopupEnc.PopUp;
      end;
    StatusbarTag_LineEnds:
      begin
        if not Frame.ReadOnly then
          PopupEnds.PopUp;
      end;
    StatusbarTag_Lexer:
      begin
        PopupLex.PopUp;
      end;
    StatusbarTag_TabSize:
      begin
        PopupTabSize.Popup;
      end;
    StatusbarTag_SelMode:
      begin
        with CurrentEditor do
        begin
          OptMouseColumnSelectionWithoutKey:= not OptMouseColumnSelectionWithoutKey;
          UpdateStatus;
        end;
      end;
    StatusbarTag_WrapMode:
      begin
        //loop: no wrap - wrap at window - wrap at margin
        with CurrentEditor do
        begin
          if OptWrapMode=High(OptWrapMode) then
            OptWrapMode:= Low(OptWrapMode)
          else
            OptWrapMode:= Succ(OptWrapMode);
          UpdateStatus;
        end;
      end;
  end;
end;

procedure TfmMain.TimerAppIdleTimer(Sender: TObject);
var
  PntScreen, PntLocal: TPoint;
  Ed: TATSynEdit;
  S: string;
  i: integer;
begin
  while FListConsole.Count>0 do
  begin
    S:= FListConsole[0];
    FListConsole.Delete(0);
    MsgLogConsole(S);
  end;

  PntScreen:= Mouse.CursorPos;
  if PntScreen<>FLastMousePos then
  begin
    FLastMousePos:= PntScreen;
    for i:= Low(TATGroupsNums) to High(TATGroupsNums) do
    begin
      Ed:= GetEditorActiveInGroup(i);
      if Ed=nil then Break;
      PntLocal:= Ed.ScreenToClient(PntScreen);
      if PtInRect(Ed.ClientRect, PntLocal) then
      begin
        DoPyEvent(Ed, cEventOnMouseStop, [
          IntToStr(PntLocal.X),
          IntToStr(PntLocal.Y)
          ]);
        Break;
      end;
    end;
  end;
end;

procedure TfmMain.TimerStatusTimer(Sender: TObject);
begin
  MsgStatus('');
  TimerStatus.Enabled:= false;
end;

procedure TfmMain.TimerStatusAltTimer(Sender: TObject);
begin
  TimerStatusAlt.Enabled:= false;
  StatusAlt.Hide;
end;

procedure TfmMain.TimerStatusBusyTimer(Sender: TObject);
begin
  TimerStatusBusy.Enabled:= false;
  UpdateStatus_RealWork;
end;

procedure TfmMain.TimerTreeFillTimer(Sender: TObject);
begin
  TimerTreeFill.Enabled:= false;
  UpdateTree(true);
end;

procedure TfmMain.TimerTreeFocusTimer(Sender: TObject);
begin
  TimerTreeFocus.Enabled:= false;
  UpdateTree(false);
end;

procedure TfmMain.DoCodetree_OnDblClick(Sender: TObject);
var
  PntBegin, PntEnd: TPoint;
begin
  DoTreeGetSyntaxRange(CodeTree.Tree.Selected, PntBegin, PntEnd);

  FTreeClick:= true;
  CurrentEditor.DoGotoPos(
    PntBegin,
    Point(-1, -1),
    UiOps.FindIndentHorz,
    UiOps.FindIndentVert,
    true,
    true
    );
  DoFocusEditor;
  FTreeClick:= false;
end;

procedure TfmMain.DoTreeGetSyntaxRange(ANode: TTreeNode; out APosBegin, APosEnd: TPoint);
var
  DataObj: TObject;
  Range: TATRangeInCodeTree;
begin
  APosBegin:= Point(-1, -1);
  APosEnd:= Point(-1, -1);
  if ANode=nil then exit;
  if ANode.Data=nil then exit;

  DataObj:= TObject(ANode.Data);
  if not (DataObj is TATRangeInCodeTree) then exit;
  Range:= DataObj as TATRangeInCodeTree;
  APosBegin:= Range.PosBegin;
  APosEnd:= Range.PosEnd;
end;

procedure TfmMain.DoTreeSetSyntaxRange(ANode: TTreeNode; const APosBegin, APosEnd: TPoint);
var
  DataObj: TObject;
  Range: TATRangeInCodeTree;
begin
  if ANode=nil then exit;
  if ANode.Data=nil then
  begin
    DataObj:= TATRangeInCodeTree.Create;
    ANode.Data:= Pointer(DataObj);
  end
  else
    DataObj:= TObject(ANode.Data);

  if DataObj is TATRangeInCodeTree then
  begin
    Range:= DataObj as TATRangeInCodeTree;
    Range.PosBegin:= APosBegin;
    Range.PosEnd:= APosEnd;
  end;
end;


procedure TfmMain.DoCodetree_OnMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //fix to hide parts on Tree's hints on editor canvas (Win32, moving mouse from
  //long hint to shorter)
  DoInvalidateEditors;
end;


function TfmMain.IsAllowedToOpenFileNow: boolean;
begin
  Result:= true;
  if IsDialogCustomShown then exit(false);
  if Assigned(fmCommands) and fmCommands.Visible then fmCommands.Close;
end;

procedure TfmMain.UniqInstanceOtherInstance(Sender: TObject;
  ParamCount: Integer; Parameters: array of String);
var
  SFilename: string;
  Frame: TEditorFrame;
  NLine, NColumn, i: integer;
begin
  if not IsAllowedToOpenFileNow then exit;

  for i:= 0 to ParamCount-1 do
  begin
    SFilename:= Parameters[i];
    SParseFilenameWithTwoNumbers(SFilename, NLine, NColumn);
    if DirectoryExistsUTF8(SFilename) then
    begin
      DoFolderOpen(SFilename, True);
    end
    else
    if FileExistsUTF8(SFilename) then
    begin
      Frame:= DoFileOpen(SFilename);
      if Assigned(Frame) and (NLine>0) then
        Frame.DoGotoPos(NColumn-1, NLine-1);
    end;
  end;

  if WindowState=wsMinimized then
  begin
    WindowState:= wsNormal;
    Application.ProcessMessages;
  end;

  {$ifdef windows}
  // Those two calls below conflicts with Windows SwitchToThisWindow API call
  // so they are left for other platforms
  {$else}
  Application.BringToFront;
  DoFocusWindow(Handle);
  {$ifend}
end;

{$ifdef windows}
procedure TfmMain.SecondInstance(const Msg: TBytes);
var
  SFilename: String;
  params: TStringList;
  Frame: TEditorFrame;
  NLine, NColumn, i: integer;
begin
  if not IsAllowedToOpenFileNow then Exit;

  params := TStringList.Create;
  try
    params.StrictDelimiter := True;
    params.Delimiter := '|';
    params.DelimitedText := UTF8Encode(StringOf(Msg));
    for i := 0 to params.Count - 1 do
    begin
      SFilename := params[i];
      SParseFilenameWithTwoNumbers(SFilename, NLine, NColumn);
      //if dir, open in ProjManager
      if DirectoryExistsUTF8(SFilename) then
      begin
        DoFolderOpen(SFilename, False);
      end
      else
      if FileExistsUTF8(SFilename) then
      begin
        Frame:= DoFileOpen(SFilename);
        if Assigned(Frame) and (NLine>0) then
          Frame.DoGotoPos(NColumn-1, NLine-1);
      end;
    end;
  finally
    params.Free;
  end;

  if WindowState = wsMinimized then
  begin
    WindowState := wsNormal;
    Application.ProcessMessages;
  end;
end;
{$endif}

function TfmMain.GetSessionFilename: string;
begin
  Result:= FSessionName;
  if Result='' then
    Result:= 'history session.json';
  if ExtractFileDir(Result)='' then
    Result:= GetAppPath(cDirSettings)+DirectorySeparator+Result;
end;


procedure TfmMain.InitAppleMenu;
var
  cAppleString: string;
begin
  {$ifndef darwin}
  exit;
  {$endif}
  cAppleString:= UTF8Encode(WideChar($F8FF));

  mnuApple:= TMenuItem.Create(Self);
  mnuApple.Caption:= cAppleString;
  Menu.Items.Insert(0, mnuApple);

  mnuApple_About:= TMenuItem.Create(Self);
  mnuApple_About.Caption:= 'About CudaText';
  mnuApple.Add(mnuApple_About);
  mnuHelpAbout.Visible:= false;

  mnuApple_CheckUpd:= TMenuItem.Create(Self);
  mnuApple_CheckUpd.Caption:= 'Check for updates';
  mnuApple.Add(mnuApple_CheckUpd);
  mnuHelpCheckUpd.Visible:= false;

  //macOS adds Quit item in apple menu
  mnuFileExit.Visible:= false;
end;


procedure TfmMain.FormCreate(Sender: TObject);
var
  i: integer;
begin
  CustomDialog_DoPyCallback:= @DoPyCallbackFromAPI;
  FFileNameLogDebug:= GetAppPath(cDirSettings)+DirectorySeparator+'app.log';
  FFileNameLogConsole:= GetAppPath(cDirSettings)+DirectorySeparator+'console.log';

  {$ifdef windows}
  UiOps.ScreenScale:= MulDiv(100, Screen.PixelsPerInch, 96);
  
  if IsSetToOneInstance then
  begin
    FInstanceManage := TInstanceManage.Create(AppUniqueUID);
    FInstanceManage.Check;
    case FInstanceManage.Status of
      isFirst:
        begin
          FInstanceManage.SetFormHandleForActivate(Self.Handle);
          FInstanceManage.OnSecondInstanceStarted := @SecondInstance;
        end;
    end;
  end;
  {$endif}
  //UiOps.ScreenScale:= 200; ////test
  //UiOps_ScreenScale:= UiOps.ScreenScale;

  FBoundsFloatSide:= Rect(650, 50, 900, 700);
  FBoundsFloatBottom:= Rect(50, 480, 900, 700);
  FBoundsFloatGroups1:= Rect(300, 100, 800, 700);
  FBoundsFloatGroups2:= Rect(320, 120, 820, 720);
  FBoundsFloatGroups3:= Rect(340, 140, 840, 740);

  ToolbarMain.ScalePercents:= UiOps.ScreenScale;
  ToolbarSideTop.ScalePercents:= UiOps.ScreenScale;
  ToolbarSideLow.ScalePercents:= UiOps.ScreenScale;
  ToolbarSideMid.ScalePercents:= UiOps.ScreenScale;

  InitAppleMenu;
  InitToolbar;
  InitSidebar;

  CodeTree:= TAppTreeContainer.Create(Self);
  CodeTree.Parent:= PanelLeft;
  CodeTree.Align:= alClient;
  CodeTree.Tree.Images:= ImageListTree;
  CodeTree.Themed:= true;
  CodeTree.Tree.OnDblClick:= @DoCodetree_OnDblClick;
  CodeTree.Tree.OnMouseMove:= @DoCodetree_OnMouseMove;
  CodeTree.Tree.OnKeyDown:= @DoCodetree_OnKeyDown;
  CodeTree.Tree.PopupMenu:= PopupTree;

  PanelCodeTreeTop:= TATPanelSimple.Create(Self);
  PanelCodeTreeTop.Parent:= CodeTree;
  PanelCodeTreeTop.Align:= alTop;
  PanelCodeTreeTop.Height:= 28;

  CodeTreeFilter:= TTreeFilterEdit.Create(Self);
  CodeTreeFilter.Hide;
  CodeTreeFilter.FilteredTreeview:= CodeTree.Tree;

  CodeTreeFilterReset:= TATButton.Create(Self);
  CodeTreeFilterReset.Parent:= PanelCodeTreeTop;
  CodeTreeFilterReset.Align:= alRight;
  CodeTreeFilterReset.Width:= UiOps_ScrollbarWidth;
  CodeTreeFilterReset.Caption:= msgButtonX;
  CodeTreeFilterReset.Focusable:= false;
  CodeTreeFilterReset.Flat:= true;
  CodeTreeFilterReset.OnClick:= @CodeTreeFilterResetClick;

  CodeTreeFilterInput:= TATEdit.Create(Self);
  CodeTreeFilterInput.Parent:= PanelCodeTreeTop;
  CodeTreeFilterInput.Align:= alClient;
  CodeTreeFilterInput.OnChange:= @CodeTreeFilterInputOnChange;

  ListboxOut:= TATListbox.Create(Self);
  ListboxOut.VirtualMode:= false;
  ListboxOut.Parent:= PanelBottom;
  ListboxOut.Align:= alClient;
  ListboxOut.CanGetFocus:= true;
  ListboxOut.OwnerDrawn:= true;
  ListboxOut.OnDblClick:= @ListboxOutClick;
  ListboxOut.OnDrawItem:= @ListboxOutDrawItem;
  ListboxOut.OnKeyDown:= @ListboxOutKeyDown;

  ListboxVal:= TATListbox.Create(Self);
  ListboxVal.VirtualMode:= false;
  ListboxVal.Parent:= PanelBottom;
  ListboxVal.Align:= alClient;
  ListboxVal.CanGetFocus:= true;
  ListboxVal.OwnerDrawn:= true;
  ListboxVal.OnDblClick:= @ListboxOutClick;
  ListboxVal.OnDrawItem:= @ListboxOutDrawItem;
  ListboxVal.OnKeyDown:= @ListboxOutKeyDown;

  CodeTree.DoScaleScrollbar;
  ListboxOut.DoScaleScrollbar;
  ListboxVal.DoScaleScrollbar;

  AppBookmarkImagelist.AddImages(ImageListBm);
  for i:= 2 to 9 do
  begin
    AppBookmarkSetup[i].Color:= clMoneyGreen;
    AppBookmarkSetup[i].ImageIndex:= i-1;
  end;

  PanelAll.Align:= alClient;
  PaintTest.Height:= 150;
  AppManager:= TecLexerList.Create(Self);
  AppManagerLite:= TATLiteLexers.Create(Self);
  AppManagerLite.OnGetStyleHash:= @LiteLexer_GetStyleHash;
  AppManagerLite.OnApplyStyle:= @LiteLexer_ApplyStyle;

  FSessionName:= '';
  FListRecents:= TStringList.Create;
  FListThemesUI:= TStringList.Create;
  FListThemesSyntax:= TStringList.Create;
  FListLangs:= TStringList.Create;
  FListTimers:= TStringList.Create;
  FListConsole:= TStringList.Create;

  FKeymapUndoList:= TATKeymapUndoList.Create;
  FKeymapLastLexer:= '??'; //not ''
  FAllowLoadKeymap:= false;
  FAllowOnFocus:= false;

  FillChar(AppPanelProp_Out, SizeOf(AppPanelProp_Out), 0);
  FillChar(AppPanelProp_Val, SizeOf(AppPanelProp_Val), 0);
  AppPanelProp_Out.Listbox:= ListboxOut;
  AppPanelProp_Val.Listbox:= ListboxVal;

  Status:= TATStatus.Create(Self);
  Status.Parent:= Self;
  Status.ScalePercents:= UiOps.ScreenScale;
  Status.Align:= alBottom;
  Status.Top:= Height;
  Status.Height:= 23;
  Status.Padding:= 2;
  Status.OnPanelClick:= @StatusPanelClick;

  StatusAlt:= TATStatus.Create(Self);
  StatusAlt.Parent:= Self;
  StatusAlt.ScalePercents:= UiOps.ScreenScale;
  StatusAlt.Align:= alBottom;
  StatusAlt.Height:= Status.Height;
  StatusAlt.Padding:= 0;
  StatusAlt.AddPanel(-1, 5000, taLeftJustify, '?');
  StatusAlt.Hide;

  fmConsole:= TfmConsole.Create(Self);
  fmConsole.Parent:= PanelBottom;
  fmConsole.Align:= alClient;
  fmConsole.OnConsoleInput:= @DoOnConsoleInput;
  fmConsole.OnConsolePrint:= @MsgLogConsole;
  fmConsole.OnConsoleNav:= @DoOnConsoleNav;

  fmGoto:= TfmGoto.Create(Self);

  ListboxOut.Align:= alClient;
  ListboxVal.Align:= alClient;

  Groups:= TATGroups.Create(Self);
  Groups.Parent:= PanelMain;
  Groups.Align:= alClient;
  Groups.Mode:= gmOne;
  Groups.Images:= ImageListTabs;
  Groups.OnChangeMode:=@DoGroupsChangeMode;
  Groups.OnTabFocus:= @DoOnTabFocus;
  Groups.OnTabAdd:= @DoOnTabAdd;
  Groups.OnTabClose:= @DoOnTabClose;
  Groups.OnTabMove:= @DoOnTabMove;
  Groups.OnTabPopup:= @DoOnTabPopup;
  Groups.OnTabOver:= @DoOnTabOver;

  with AppSidePanels[0] do
  begin
    ItemCaption:= msgPanelTree_Init;
    ItemControl:= CodeTree;
  end;

  FFinder:= TATEditorFinder.Create;
  FFinder.OptRegex:= true;
  FFinder.OnConfirmReplace:= @FinderOnConfirmReplace;
  FFinder.OnProgress:= @FinderOnProgress;
  FFinder.OnBadRegex:= @FinderOnBadRegex;
  FFinder.OnFound:=@FinderOnFound;

  UpdateMenuEnc(PopupEnc.Items);
  UpdateMenuEnc(mnuFileEnc);
  InitStatusButton;

  FFindStop:= false;
  FFindConfirmAll:= mrNone;

  Groups.Splitter1.OnPaint:= @SplitterOnPaint_Gr;
  Groups.Splitter2.OnPaint:= @SplitterOnPaint_Gr;
  Groups.Splitter3.OnPaint:= @SplitterOnPaint_Gr;
  Groups.Splitter4.OnPaint:= @SplitterOnPaint_Gr;
  Groups.Splitter5.OnPaint:= @SplitterOnPaint_Gr;
  SplitterVert.OnPaint:= @SplitterOnPaint_Main;
  SplitterHorz.OnPaint:= @SplitterOnPaint_Main;

  FLastDirOfOpenDlg:= '';
  FLastLexerForPluginsMenu:= '-';
  FLastSidebarPanel:= '';
  FLastBottomPanel:= '';

  UpdateMenuItemHint(mnuFile, 'top-file');
  UpdateMenuItemHint(mnuEdit, 'top-edit');
  UpdateMenuItemHint(mnuSel, 'top-sel');
  UpdateMenuItemHint(mnuSr, 'top-sr');
  UpdateMenuItemHint(mnuView, 'top-view');
  UpdateMenuItemHint(mnuOp, 'top-op');
  UpdateMenuItemHint(mnuHelp, 'top-help');
  UpdateMenuItemHint(mnuGroups, 'top-groups');
  UpdateMenuItemHint(mnuPlugins, 'plugins');
  UpdateMenuItemHint(mnuFileOpenSub, '_recents');
  UpdateMenuItemHint(mnuFileEnc, '_enc');
  UpdateMenuItemHint(mnuFileEnds, '_ends');
  UpdateMenuItemHint(mnuLexers, '_lexers');
  UpdateMenuItemHint(mnuThemesUI, '_themes-ui');
  UpdateMenuItemHint(mnuThemesSyntax, '_themes-syntax');
  UpdateMenuItemHint(mnuOpPlugins, '_oplugins');
  UpdateMenuItemHint(mnuLang, '_langs');
end;

procedure TfmMain.DoCloseAllTabs;
var
  Tabs: TATTabs;
  nGroup, nTab: integer;
begin
  for nGroup:= High(TATGroupsNums) to Low(TATGroupsNums) do
  begin
    Tabs:= Groups.Pages[nGroup].Tabs;
    for nTab:= Tabs.TabCount-1 downto 0 do
      Tabs.DeleteTab(nTab, true{AllowEvent}, false{AWithCancelBtn});
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  F: TEditorFrame;
  i: integer;
begin
  //maybe no need too? done in DoCloseAllTabs
  for i:= 0 to FrameCount-1 do
  begin
    F:= Frames[i];
    UpdateMenuRecent(F);
  end;

  //after UpdateMenuRecent
  DoOps_SaveHistory;

  (*
  //no need, done via DoCloseAllTabs
  for i:= FrameCount-1 downto 0 do
  begin
    F:= Frames[i];
    //make sure adapters don't block closing
    F.Editor.AdapterForHilite:= nil;
    F.Editor2.AdapterForHilite:= nil;
    F.Adapter.Stop;
  end;
  *)

  DoCloseAllTabs;
  DoPyEvent(CurrentEditor, cEventOnExit, []);
end;

procedure TfmMain.ButtonCancelClick(Sender: TObject);
begin
  FFindStop:= true;
end;

procedure TfmMain.AppPropsActivate(Sender: TObject);
begin
  if EditorOps.OpShowCurLineOnlyFocused then
    CurrentEditor.Update;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var ACanClose: boolean);
var
  F: TEditorFrame;
  i: integer;
begin
  //call on_close_pre for all tabs, it's needed to save all
  //tabs by AutoSave plugin
  for i:= 0 to FrameCount-1 do
  begin
    F:= Frames[i];
    DoPyEvent(F.Editor, cEventOnCloseBefore, []);
  end;

  if GetModifiedCount>0 then
    ACanClose:= DoDialogSaveTabs
  else
    ACanClose:= true;
end;

procedure TfmMain.FormColorsApply(const AColors: TAppTheme);
begin
  AppTheme:= AColors;
  DoClearLexersAskedList;
  DoApplyTheme;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  //seems gtk2 leaks memory for imagelists, tryin to fix it
  //ImageListBm.Clear;
  //ImageListSide.Clear;
  //ImageListTabs.Clear;
  //ImageListTree.Clear;
  //ImageListToolbar.Clear;

  {$ifdef windows}
  if Assigned(FInstanceManage) then
    FInstanceManage.Free;
  {$ifend}

  for i:= 0 to FListTimers.Count-1 do
    TTimer(FListTimers.Objects[i]).Enabled:= false;
  FreeAndNil(FListTimers);

  FreeAndNil(FListRecents);
  FreeAndNil(FListThemesUI);
  FreeAndNil(FListThemesSyntax);
  FreeAndNil(FListLangs);
  FreeAndNil(FListConsole);
  FreeAndNil(FKeymapUndoList);
end;

procedure TfmMain.FormDropFiles(Sender: TObject;
  const FileNames: array of String);
var
  SName: string;
  Pages: TATPages;
  i: integer;
begin
  //support mac: it drops file too early
  //(dbl-click on file in Finder)
  if not FHandledOnShow then
  begin
    SetLength(FFileNamesDroppedInitially, Length(FileNames));
    for i:= 0 to Length(FileNames)-1 do
      FFileNamesDroppedInitially[i]:= FileNames[i];
    exit;
  end;

  if not IsAllowedToOpenFileNow then exit;

  //set group according to mouse cursor
  Pages:= nil;
  for i in [Low(TATGroupsNums)..High(TATGroupsNums)] do
    if fmMain.Groups.Pages[i].Visible then
      if PtInControl(fmMain.Groups.Pages[i], Mouse.CursorPos) then
      begin
        Pages:= fmMain.Groups.Pages[i];
        Break;
      end;

  for i:= 0 to Length(Filenames)-1 do
  begin
    SName:= FileNames[i];
    if DirectoryExistsUTF8(SName) then
      DoFolderOpen(SName, False)
    else
    if FileExistsUTF8(SName) then
      DoFileOpen(SName, Pages);
  end;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_ESCAPE) and (Shift=[]) then
  begin
    PyEscapeFlag:= true;
    if PyCommandRunning then
    begin
      Key:= 0;
      exit
    end;

    if fmConsole.ed.Focused or fmConsole.memo.Focused then
    begin
      if UiOps.EscapeCloseConsole then
        ShowBottom:= false
      else
        CurrentFrame.SetFocus;
      Key:= 0;
      exit
    end;

    if UiOps.EscapeClose then
    begin
      Close;
      Key:= 0;
      exit
    end;

    exit
  end;
end;

procedure TfmMain.FormShow(Sender: TObject);
var
  NTickShowEnd,
  NTickPluginBegin, NTickPluginEnd: QWord;
  Frame: TEditorFrame;
begin
  if FHandledOnShow then exit;

  DoOps_LoadCommandLineOptions;
  DoOps_LoadOptions(GetAppPath(cFileOptionsUser), EditorOps);
  DoApplyFont_Text;
  DoApplyFont_Ui;
  DoApplyFont_Output;
  DoApplyUiOps;

  InitPyEngine;

  DoOps_LoadSidebarIcons;
  DoOps_LoadTreeIcons;
  DoOps_LoadToolBarIcons;

  DoOps_LoadLexerLib;
  DoFileOpen('');
  FHandledOnShow:= true;

  DoOps_LoadPlugins;
  DoOps_LoadHistory;
  FAllowLoadKeymap:= true;
  DoOps_LoadKeymap;

  NTickPluginBegin:= GetTickCount64;
  DoPyEvent(CurrentEditor, cEventOnStart, []);
  NTickPluginEnd:= GetTickCount64;

  DoOps_LoadHistory_AfterOnStart;

  UpdateMenuPlugins;
  UpdateMenuPlugins_Shortcuts(true);
  UpdateMenuThemes(true);
  UpdateMenuThemes(false);
  UpdateMenuLangs(mnuLang);
  UpdateMenuHotkeys;
  UpdateMenuTabsize;
  UpdateMenuPicScale;

  UpdateSidebarButtons;
  UpdateBottomButtons;
  UpdateStatus;
  DoLoadCommandLine;

  if FOption_WindowPos<>'' then
  begin
    Left:= StrToIntDef(SGetItem(FOption_WindowPos), Left);
    Top:= StrToIntDef(SGetItem(FOption_WindowPos), Top);
    Width:= StrToIntDef(SGetItem(FOption_WindowPos), Width);
    Height:= StrToIntDef(SGetItem(FOption_WindowPos), Height);
  end;

  FAllowOnFocus:= true;
  Frame:= CurrentFrame;
  if Assigned(Frame) then Frame.SetFocus;

  NTickShowEnd:= GetTickCount64;
  MsgLogConsole(Format(
    'Startup: total: %dms, including plugins: %dms', [
    (NTickShowEnd-NTickInitial) div 10 * 10,
    NTickPluginEnd-NTickPluginBegin
    ]));

  MsgLogDebug('start');
end;

procedure TfmMain.FrameAddRecent(Sender: TObject);
begin
  UpdateMenuRecent(Sender as TEditorFrame);
end;

procedure TfmMain.FrameOnChangeCaretPos(Sender: TObject);
begin
  if FTreeClick then exit;
  TimerTreeFocus.Enabled:= false;
  TimerTreeFocus.Enabled:= true;
end;

procedure TfmMain.FrameOnMsgStatus(Sender: TObject; const AStr: string);
begin
  MsgStatus(AStr);
end;

procedure TfmMain.MenuRecentsClear(Sender: TObject);
begin
  DoClearRecentFileHistory;
end;

procedure TfmMain.mnuFind2NextClick(Sender: TObject);
begin
  CurrentEditor.DoCommand(cmd_FindNext);
end;

procedure TfmMain.mnuFind2PrevClick(Sender: TObject);
begin
  CurrentEditor.DoCommand(cmd_FindPrev);
end;

procedure TfmMain.mnuFind2WordNextClick(Sender: TObject);
begin
  CurrentEditor.DoCommand(cmd_FindCurWordNext);
end;

procedure TfmMain.mnuFind2WordPrevClick(Sender: TObject);
begin
  CurrentEditor.DoCommand(cmd_FindCurWordPrev);
end;

procedure TfmMain.DoClearRecentFileHistory;
begin
  FListRecents.Clear;
  UpdateMenuRecent(nil);
  //
  DeleteFileUTF8(GetAppPath(cFileOptionsHistoryFiles));
end;

function TfmMain.DoFileInstallZip(const fn: string; out DirTarget: string;
  ASilent: boolean): boolean;
var
  msg, msg2: string;
  AddonType: TAppAddonType;
begin
  DoInstallAddonFromZip(fn, GetAppPath(cDirDataAutocomplete), msg, msg2,
    Result, AddonType, DirTarget, ASilent);

  if Result then
  begin
    if AddonType in [cAddonTypeLexer, cAddonTypeLexerLite] then
    begin
      DoOps_LoadLexerLib;
    end;

    if AddonType=cAddonTypeData then
    begin
      UpdateMenuLangs(mnuLang);
      UpdateMenuThemes(true);
      UpdateMenuThemes(false);
    end;

    if AddonType=cAddonTypePlugin then
    begin
      DoOps_LoadPlugins;
      DoOps_LoadKeymap;
      UpdateMenuPlugins;
      UpdateMenuPlugins_Shortcuts(true);
    end;

    if not ASilent then
      DoDialogAddonInstalledReport(msg, msg2);
  end;
end;


function TfmMain.GetModifiedCount: integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to FrameCount-1 do
    if Frames[i].Modified then
      Inc(Result);
end;

function TfmMain.GetShowStatus: boolean;
begin
  Result:= Status.Visible;
end;

function TfmMain.GetShowToolbar: boolean;
begin
  Result:= ToolbarMain.Visible;
end;

function TfmMain.GetShowSidePanel: boolean;
begin
  if FloatSide then
    Result:= FFormFloatSide.Visible
  else
    Result:= PanelLeft.Visible;
end;

function TfmMain.GetShowBottom: boolean;
begin
  if FloatBottom then
    Result:= FFormFloatBottom.Visible
  else
    Result:= PanelBottom.Visible;
end;

function TfmMain.GetShowSideBar: boolean;
begin
  Result:= PanelSide.Visible;
end;

function TfmMain.DoDialogSaveTabs: boolean;
var
  F: TEditorFrame;
  Form: TfmSaveTabs;
  SCaption: string;
  res: TModalResult;
  i: integer;
begin
  Result:= false;
  Form:= TfmSaveTabs.Create(nil);
  try
    DoLocalize_FormSaveTabs(Form);
    Form.List.Clear;
    for i:= 0 to FrameCount-1 do
    begin
      F:= Frames[i];
      if not F.Modified then Continue;
      SCaption:= F.TabCaption+IfThen(F.Filename<>'', '  ('+ExtractFileDir(F.Filename)+')');
      Form.List.Items.AddObject(SCaption, F);
      Form.List.Checked[Form.List.Count-1]:= true;
    end;

    res:= Form.ShowModal;
    case res of
      mrClose:
        Result:= true;
      mrCancel:
        Result:= false;
      mrNoToAll:
        begin
          Result:= true; //like for mrClose
          UiOps.ShowLastFiles:= false; //dont save tabs to session
        end;
      mrOk:
        begin
          Result:= true;
          for i:= 0 to Form.List.Count-1 do
            if Form.List.Checked[i] then
            begin
              F:= Form.List.Items.Objects[i] as TEditorFrame;
              F.DoFileSave(false);
            end;
        end;
    end;
  finally
    Form.Free
  end;
end;

procedure TfmMain.DoDialogLexerProp(an: TecSyntAnalyzer);
begin
  if DoShowDialogLexerProp(an,
    EditorOps.OpFontName,
    EditorOps.OpFontSize,
    GetAppPath(cFileLexerStylesBackup)) then
  begin
    DoLexerExportFromLibToFile(an);
    UpdateMenuLexers;
    UpdateStatus;
    UpdateFrame;
  end;
end;

procedure TfmMain.DoDialogLexerLib;
begin
  if DoShowDialogLexerLib(
    GetAppPath(cDirDataAutocomplete),
    EditorOps.OpFontName,
    EditorOps.OpFontSize,
    GetAppPath(cFileLexerStylesBackup),
    @DoOnDeleteLexer
    ) then
  begin
    UpdateMenuLexers;
    UpdateStatus;
    UpdateFrame;
  end;
end;

procedure TfmMain.DoDialogLexerMap;
var
  i: integer;
begin
  if DoDialogLexerStylesMap(CurrentFrame.Lexer) then
    for i:= 0 to FrameCount-1 do
      with Frames[i] do
        Lexer:= Lexer;
end;

procedure TfmMain.DoCopyFilenameFull;
begin
  SClipboardCopy(CurrentFrame.FileName);
end;

procedure TfmMain.DoCopyFilenameDir;
begin
  SClipboardCopy(ExtractFileDir(CurrentFrame.FileName));
end;

procedure TfmMain.DoCopyFilenameName;
begin
  SClipboardCopy(ExtractFileName(CurrentFrame.FileName));
end;


procedure TfmMain.DoCopyLine;
var
  Str: atString;
  Ed: TATSynEdit;
  N: integer;
begin
  Ed:= CurrentEditor;
  N:= Ed.Carets[0].PosY;
  if not Ed.Strings.IsIndexValid(N) then exit;
  Str:= Ed.Strings.Lines[N];
  SClipboardCopy(UTF8Encode(Str));
end;

procedure TfmMain.DoHelpAbout;
var
  Form: TfmAbout;
begin
  Form:= TfmAbout.Create(Self);
  with Form do
  try
    DoLocalize_FormAbout(Form);
    labelVer.Caption:= cAppExeVersion;
    ShowModal;
  finally
    Free
  end;
end;

procedure TfmMain.DoHelpForum;
begin
  OpenURL('http://synwrite.sourceforge.net/forums/viewforum.php?f=20');
end;

procedure TfmMain.DoHelpChangelog;
begin
  DoFileOpen(GetAppPath(cFileReadmeHistory));
end;

procedure TfmMain.DoHelpMouse;
begin
  DoFileOpen(GetAppPath(cFileReadmeHelpMouse));
end;

procedure TfmMain.MenuWindowClick(Sender: TObject);
begin
  SetFrame(Frames[(Sender as TMenuItem).Tag]);
end;


procedure TfmMain.UpdateFrameLineEnds(Frame: TEditorFrame; AValue: TATLineEnds);
begin
  if Assigned(Frame) then
    Frame.LineEnds:= AValue;
  UpdateStatus;
  MsgStatus(msgStatusEndsChanged);
end;

type
  TUniqInstanceHack = class(TUniqueInstance);


procedure TfmMain.DoApplyUiOpsToGroups(G: TATGroups);
begin
  G.SetTabFont(Self.Font);
  G.ScalePercents:= UiOps.ScreenScale;
  G.SetTabOption(tabOptionMultiline, Ord(UiOps.TabMultiline));
  G.SetTabOption(tabOptionAngled, Ord(UiOps.TabAngled));
  G.SetTabOption(tabOptionSpaceInitial, IfThen(UiOps.TabAngled, 10, 4));
  G.SetTabOption(tabOptionSpaceBetweenTabs, IfThen(UiOps.TabAngled, 4, 0));
  G.SetTabOption(tabOptionShowFlat, Ord(UiOps.TabFlat));
  G.SetTabOption(tabOptionPosition, UiOps.TabPosition);
  G.SetTabOption(tabOptionShowXButtons, UiOps.TabShowX);
  G.SetTabOption(tabOptionShowPlus, Ord(UiOps.TabShowPlus));
  G.SetTabOption(tabOptionShowEntireColor, Ord(UiOps.TabColorFull));
  G.SetTabOption(tabOptionDoubleClickClose, Ord(UiOps.TabDblClickClose));
  G.SetTabOption(tabOptionWidthMin, UiOps.TabWidthMin);
  G.SetTabOption(tabOptionWidthMax, UiOps.TabWidth);
  G.SetTabOption(tabOptionHeight, UiOps.TabHeight+UiOps.TabSpacer);
  G.SetTabOption(tabOptionHeightInner, UiOps.TabHeightInner);
  G.SetTabOption(tabOptionSpacer, IfThen(UiOps.TabPosition=0, UiOps.TabSpacer));
  G.SetTabOption(tabOptionSpacer2, 1); //for multiline mode
  G.SetTabOption(tabOptionColoredBandSize, _InitOptColoredBandSize);
  G.SetTabOption(tabOptionActiveMarkSize, _InitOptActiveMarkSize);
  G.SetTabOption(tabOptionScrollMarkSizeX, _InitOptScrollMarkSizeX);
  G.SetTabOption(tabOptionScrollMarkSizeY, _InitOptScrollMarkSizeY);
  G.SetTabOption(tabOptionShowNums, Ord(UiOps.TabNumbers));
  G.SetTabOption(tabOptionSpaceXRight, 10);
  G.SetTabOption(tabOptionSpaceXSize, 12);
  G.SetTabOption(tabOptionArrowSize, 4);
  G.SetTabOption(tabOptionButtonSize, 16);
  G.SetTabOption(tabOptionShowArrowsNear, Ord(Pos('<>', UiOps.TabButtonLayout)>0));
  G.SetTabOptionString(tabOptionButtonLayout, UiOps.TabButtonLayout);
  G.SetTabOptionString(tabOptionModifiedText, '*');
end;

procedure TfmMain.DoApplyUiOps;
var
  i: integer;
begin
  cAdapterIdleInterval:= UiOps.LexerDelayedParsingPause;
  cAdapterIdleTextSize:= UiOps.LexerDelayedParsingSize;
  CompletionOps.AppendOpeningBracket:= UiOps.AutocompleteAddOpeningBracket;
  CompletionOps.UpDownAtEdge:= TATCompletionUpDownAtEdge(UiOps.AutocompleteUpDownAtEdge);

  //apply DoubleBuffered
  //no need for ToolbarMain and buttons
  for i:= Low(TATGroupsNums) to High(TATGroupsNums) do
    Groups.Pages[i].Tabs.DoubleBuffered:= UiOps.DoubleBuffered;
  for i:= 0 to FrameCount-1 do
    with Frames[i] do
    begin
      Editor.DoubleBuffered:= UiOps.DoubleBuffered;
      Editor2.DoubleBuffered:= UiOps.DoubleBuffered;
    end;
  Status.DoubleBuffered:= UiOps.DoubleBuffered;
  StatusAlt.DoubleBuffered:= UiOps.DoubleBuffered;
  ButtonCancel.DoubleBuffered:= UiOps.DoubleBuffered;
  StatusProgress.DoubleBuffered:= UiOps.DoubleBuffered;
  ListboxOut.DoubleBuffered:= UiOps.DoubleBuffered;
  ListboxVal.DoubleBuffered:= UiOps.DoubleBuffered;
  if Assigned(fmConsole) then
    fmConsole.IsDoubleBuffered:= UiOps.DoubleBuffered;
  if Assigned(fmFind) then
    fmFind.IsDoubleBuffered:= UiOps.DoubleBuffered;
  if Assigned(fmGoto) then
    fmGoto.IsDoubleBuffered:= UiOps.DoubleBuffered;
  //end apply DoubleBuffered

  UpdateStatusbarPanelsFromString(UiOps.StatusPanels);

  TimerTreeFill.Interval:= UiOps.TreeTimeFill;
  TimerTreeFocus.Interval:= UiOps.TreeTimeFocus;
  CodeTree.Tree.ToolTips:= UiOps.TreeShowTooltips;

  fmConsole.memo.OptCaretShapeRO:= TATSynCaretShape(EditorOps.OpCaretShapeRO);
  fmConsole.memo.OptBorderFocusedActive:= UiOps.ShowActiveBorder;
  fmConsole.ed.OptBorderFocusedActive:= UiOps.ShowActiveBorder;
  fmConsole.Wordwrap:= UiOps.ConsoleWordWrap;

  DoApplyUiOpsToGroups(Groups);
  if FloatGroups then
  begin
    DoApplyUiOpsToGroups(GroupsF1);
    DoApplyUiOpsToGroups(GroupsF2);
    DoApplyUiOpsToGroups(GroupsF3);
  end;

  PanelSide.Visible:= UiOps.SidebarShow;
  ShowSideBarOnRight:= UiOps.SidebarOnRight;
  PanelLeftTitle.Height:= Groups.Pages1.Tabs.Height;

  if UiOps.TabPosition=1 then
    PanelLeftTitle.Align:= alBottom
  else
    PanelLeftTitle.Align:= alTop;

  case UiOps.TreeFilterLayout of
    0:
      PanelCodeTreeTop.Hide;
    1:
      begin
        PanelCodeTreeTop.Show;
        PanelCodeTreeTop.Align:= alTop;
      end;
    2:
      begin
        PanelCodeTreeTop.Show;
        PanelCodeTreeTop.Align:= alBottom;
        PanelCodeTreeTop.Top:= PanelLeft.Height; //fix pos relative to horz scrollbar
      end;
  end;

  Status.Height:= MulDiv(UiOps.StatusHeight, UiOps.ScreenScale, 100);
  TimerStatus.Interval:= UiOps.StatusTime*1000;

  ATButtonTheme.FontName:= UiOps.VarFontName;
  ATButtonTheme.FontSize:= UiOps.VarFontSize;

  CompletionOps.FormSizeX:= UiOps.ListboxCompleteSizeX;
  CompletionOps.FormSizeY:= UiOps.ListboxCompleteSizeY;

  if UiOps.OneInstance and not FOption_OpenNewWindow then
    if not UniqInstance.Enabled then
    begin
      UniqInstance.Enabled:= true;
      TUniqInstanceHack(UniqInstance).Loaded;

      if UniqInstance.PriorInstanceRunning then
        Application.Terminate;
        //note: app still works and will get DoFileOpen calls (e.g. on session opening)
        //so later need to check Application.Terminated
    end;

  DoApplyTheme;
end;


procedure TfmMain.DoFolderOpen(const ADirName: string; ANewProject: boolean);
const
  cBool: array[boolean] of string = (cPyFalse, cPyTrue);
begin
  DoPyCommand('cuda_project_man', 'open_dir', [
    'r"'+ADirName+'"',
    cBool[ANewProject]
    ]);
end;

procedure TfmMain.DoGroupsChangeMode(Sender: TObject);
begin
  DoPyEvent(CurrentEditor, cEventOnState, [IntToStr(APPSTATE_GROUPS)]);
  DoApplyCenteringOption;
end;

procedure TfmMain.DoApplyCenteringOption;
var
  F: TEditorFrame;
  NCentering, i: integer;
begin
  if EditorOps.OpCenteringWidth>0 then
  begin
    if Groups.Mode<>gmOne then
      NCentering:= 0
    else
      NCentering:= EditorOps.OpCenteringWidth;

    for i:= 0 to FrameCount-1 do
    begin
      F:= Frames[i];
      F.Editor.OptTextCenteringCharWidth:= NCentering;
      F.Editor2.OptTextCenteringCharWidth:= NCentering;
      F.Editor.Update;
      F.Editor2.Update;
    end;
  end;
end;

procedure TfmMain.CodeTreeFilterInputOnChange(Sender: TObject);
begin
  CodeTreeFilter.Text:= CodeTreeFilterInput.Text;
end;

procedure TfmMain.CodeTreeFilterResetClick(Sender: TObject);
begin
  CodeTreeFilterInput.Text:= '';
  CodeTreeFilterInput.OnChange(nil);
end;

function TfmMain.DoFileOpen(AFilename: string; APages: TATPages;
  const AOptions: string): TEditorFrame;
var
  D: TATTabData;
  F: TEditorFrame;
  isOem: boolean;
  bSilent, bPreviewTab, bEnableHistory, bEnableEvent,
  bAndActivate, bAllowNear: boolean;
  OpenMode: TAppOpenMode;
  tick: QWord;
  msg: string;
  i: integer;
begin
  Result:= nil;
  AppFolderOfLastInstalledAddon:= '';
  if Application.Terminated then exit;

  bSilent:= Pos('/silent', AOptions)>0;
  bPreviewTab:= Pos('/preview', AOptions)>0;
  bEnableHistory:= Pos('/nohistory', AOptions)=0;
  bEnableEvent:= Pos('/noevent', AOptions)=0;
  bAndActivate:= Pos('/passive', AOptions)=0;
  bAllowNear:= Pos('/nonear', AOptions)=0;

  if Pos('/view-text', AOptions)>0 then
    OpenMode:= cOpenModeViewText
  else
  if Pos('/view-binary', AOptions)>0 then
    OpenMode:= cOpenModeViewBinary
  else
  if Pos('/view-hex', AOptions)>0 then
    OpenMode:= cOpenModeViewHex
  else
  if Pos('/view-unicode', AOptions)>0 then
    OpenMode:= cOpenModeViewUnicode
  else
    OpenMode:= cOpenModeEditor;

  if APages=nil then
    APages:= Groups.PagesCurrent;

  if AFilename='' then
  begin
    D:= DoTabAdd(APages, GetUntitledCaption, bAndActivate, bAllowNear);
    if not Assigned(D) then
    begin
      D:= Groups.Pages1.Tabs.GetTabData(0);
      DoClearSingleFirstTab;
    end;
    Result:= D.TabObject as TEditorFrame;
    Result.SetFocus;
    Exit
  end;

  //expand "./name"
  //note: ExpandFileNameUTF8 has bug in Laz 1.9-
  AFilename:= ExpandFileName(AFilename);

  if not FileExistsUTF8(AFilename) then
  begin
    MsgBox(msgCannotFindFile+#13+AFilename, mb_ok or mb_iconerror);
    Exit
  end;

  if OpenMode=cOpenModeEditor then
  begin
    //zip files
    if ExtractFileExt(AFilename)='.zip' then
    begin
      if DoFileInstallZip(AFilename, AppFolderOfLastInstalledAddon, bSilent) then
        Result:= CurrentFrame;
      exit
    end;

    //py event
    if bEnableEvent then
      if DoPyEvent(CurrentEditor, cEventOnOpenBefore,
        [SStringToPythonString(AFilename)]) = cPyFalse then exit;

    //non-text option
    if not IsFilenameListedInExtensionList(AFilename, UiOps.PictureTypes) then
    if UiOps.NonTextFiles<>1 then
      if not IsFileContentText(AFilename, UiOps.NonTextFilesBufferKb, false, IsOem) then
        case UiOps.NonTextFiles of
          0:
            case DoDialogConfirmBinaryFile(AFileName, false) of
              ConfirmBinaryViewText: OpenMode:= cOpenModeViewText;
              ConfirmBinaryViewBinary: OpenMode:= cOpenModeViewBinary;
              ConfirmBinaryViewHex: OpenMode:= cOpenModeViewHex;
              ConfirmBinaryViewUnicode: OpenMode:= cOpenModeViewUnicode;
              ConfirmBinaryCancel: Exit;
            end;
          2:
            Exit;
          3:
            OpenMode:= cOpenModeViewBinary;
          4:
            OpenMode:= cOpenModeViewHex;
          else
            Exit;
        end;

    //too big size?
    if (OpenMode=cOpenModeEditor) and IsFileTooBigForOpening(AFilename) then
    begin
      case DoDialogConfirmBinaryFile(AFileName, true) of
        ConfirmBinaryViewText: OpenMode:= cOpenModeViewText;
        ConfirmBinaryViewBinary: OpenMode:= cOpenModeViewBinary;
        ConfirmBinaryViewHex: OpenMode:= cOpenModeViewHex;
        ConfirmBinaryViewUnicode: OpenMode:= cOpenModeViewUnicode;
        ConfirmBinaryCancel: Exit;
      end;
    end;
  end; //not binary

  //is file already opened? activate frame
  for i:= 0 to FrameCount-1 do
  begin
    F:= Frames[i];
    if SameFileName(F.FileName, AFilename) then
    begin
      SetFrame(F);
      Result:= F;
      Result.SetFocus;
      UpdateStatus;
      UpdateTreeContents;
      Exit
    end;
  end;

  //preview-tab
  if bPreviewTab then
  begin
    APages:= Groups.Pages1; //open preview tab in 1st group
    for i:= 0 to APages.Tabs.TabCount-1 do
    begin
      D:= APages.Tabs.GetTabData(i);
      if D.TabSpecial then
      begin
        Result:= D.TabObject as TEditorFrame;
        SetFrame(Result);
        Break
      end;
    end;

    if Result=nil then
    begin
      D:= DoTabAdd(APages, 'pre', true, false);
      if not Assigned(D) then exit;
      D.TabSpecial:= true;
      D.TabFontStyle:= StringToFontStyles(UiOps.TabPreviewFontStyle);
      Result:= D.TabObject as TEditorFrame;
    end;

    Result.Adapter.Stop;
    Result.DoFileOpen(AFilename, bEnableHistory, true, OpenMode);
    msg:= msgStatusOpened+' '+ExtractFileName(AFilename);
    MsgStatus(msg);

    DoPyEvent(Result.Editor, cEventOnOpen, []);
    Result.SetFocus;
    exit;
  end;

  //is current frame empty? use it
  if APages=Groups.PagesCurrent then
  begin
    F:= CurrentFrame;
    if Assigned(F) then
    if F.IsEmpty then
    begin
      tick:= GetTickCount64;
      F.DoFileOpen(AFilename, bEnableHistory, true, OpenMode);
      Result:= F;
      tick:= (GetTickCount64-tick) div 1000;

      UpdateStatus;
      msg:= msgStatusOpened+' '+ExtractFileName(AFilename);
      if tick>2 then
        msg:= msg+' ('+IntToStr(tick)+'s)';
      MsgStatus(msg);

      DoPyEvent(F.Editor, cEventOnOpen, []);
      if F.IsText and (F.LexerName='') then
        DoPyEvent(F.Editor, cEventOnOpenNone, []);
      Exit
    end;
  end;

  D:= DoTabAdd(APages, ExtractFileName(AFilename), bAndActivate, bAllowNear);
  if not Assigned(D) then
  begin
    D:= Groups.Pages1.Tabs.GetTabData(0);
    DoClearSingleFirstTab;
  end;
  F:= D.TabObject as TEditorFrame;

  tick:= GetTickCount64;
  F.DoFileOpen(AFilename, bEnableHistory, true, OpenMode);
  Result:= F;
  tick:= (GetTickCount64-tick) div 1000;

  UpdateStatus;
  msg:= msgStatusOpened+' '+ExtractFileName(AFilename);
  if tick>2 then
    msg:= msg+' ('+IntToStr(tick)+'s)';
  MsgStatus(msg);

  DoPyEvent(F.Editor, cEventOnOpen, []);
  if F.IsText and (F.LexerName='') then
    DoPyEvent(F.Editor, cEventOnOpenNone, []);
  Result.SetFocus;
end;


procedure TfmMain.DoFileOpenDialog_NoPlugins;
begin
  DoFileOpenDialog('/noevent');
end;

procedure TfmMain.DoFileDialog_PrepareDir(Dlg: TFileDialog);
begin
  if CurrentFrame.FileName<>'' then
    Dlg.InitialDir:= ExtractFileDir(CurrentFrame.FileName)
  else
  begin
    if UiOps.InitialDir<>'' then
      Dlg.InitialDir:= UiOps.InitialDir
    else
      Dlg.InitialDir:= FLastDirOfOpenDlg;
  end;
end;

procedure TfmMain.DoFileDialog_SaveDir(Dlg: TFileDialog);
begin
  FLastDirOfOpenDlg:= ExtractFileDir(Dlg.FileName);
end;


procedure TfmMain.DoFileOpenDialog(AOptions: string='');
const
  //passive option used only for many files
  SOptionPassive = '/passive /nonear';
var
  i: integer;
begin
  with OpenDlg do
  begin
    FileName:= '';
    DoFileDialog_PrepareDir(OpenDlg);
    if not Execute then exit;
    DoFileDialog_SaveDir(OpenDlg);

    if Files.Count>1 then
    begin
      for i:= 0 to Files.Count-1 do
        DoFileOpen(Files[i], nil, AOptions+SOptionPassive);
    end
    else
    begin
      if FileExistsUTF8(FileName) then
        DoFileOpen(FileName, nil, AOptions)
      else
      if MsgBox(
        Format(msgConfirmCreateNewFile, [FileName]),
        MB_OKCANCEL or MB_ICONQUESTION)=ID_OK then
      begin
        FCreateFile(FileName);
        DoFileOpen(FileName, nil, AOptions);
      end;
    end;
  end;
end;

procedure TfmMain.DoDialogCommands;
var
  NCmd: integer;
begin
  MsgStatus(msgStatusHelpOnShowCommands);
  NCmd:= DoDialogCommands_Custom(true, true, true, true, FLastSelectedCommand);
  if NCmd>0 then
  begin
    FLastSelectedCommand:= NCmd;
    CurrentEditor.DoCommand(NCmd);
    UpdateFrame;
  end;
end;


function TfmMain.DoDialogCommands_Py(AShowUsual, AShowPlugins, AShowLexers, AAllowConfig: boolean): string;
var
  NCmd: integer;
begin
  Result:= '';
  NCmd:= DoDialogCommands_Custom(AShowUsual, AShowPlugins, AShowLexers, AAllowConfig, 0);
  if NCmd<=0 then exit;

  if (NCmd>=cmdFirstPluginCommand) and (NCmd<=cmdLastPluginCommand) then
  begin
    with AppPluginsCommand[NCmd-cmdFirstPluginCommand] do
      if ItemProcParam<>'' then
        Result:= Format('p:module=%s;cmd=%s;info=%s;', [ItemModule, ItemProc, ItemProcParam])
      else
        Result:= Format('p:%s.%s', [ItemModule, ItemProc]);
  end
  else
  if (NCmd>=cmdFirstLexerCommand) and (NCmd<cmdFirstLexerCommand+AppManager.LexerCount) then
  begin
    Result:= 'l:'+AppManager.Lexers[NCmd-cmdFirstLexerCommand].LexerName
  end
  else
    Result:= 'c:'+IntToStr(NCmd);
end;


function TfmMain.DoDialogCommands_Custom(
  AShowUsual, AShowPlugins, AShowLexers, AAllowConfig: boolean;
  AFocusedCommand: integer): integer;
var
  bKeysChanged: boolean;
begin
  Result:= 0;
  fmCommands:= TfmCommands.Create(Self);
  try
    UpdateInputForm(fmCommands);
    fmCommands.OptShowUsual:= AShowUsual;
    fmCommands.OptShowPlugins:= AShowPlugins;
    fmCommands.OptShowLexers:= AShowLexers;
    fmCommands.OptAllowConfig:= AAllowConfig;
    fmCommands.OptFocusedCommand:= AFocusedCommand;
    fmCommands.OnMsg:= @DoCommandsMsgStatus;
    fmCommands.CurrentLexerName:= CurrentFrame.LexerName;
    fmCommands.Keymap:= CurrentEditor.Keymap;
    fmCommands.ShowModal;
    Result:= fmCommands.ResultCommand;
    bKeysChanged:= fmCommands.ResultHotkeysChanged;
  finally
    FreeAndNil(fmCommands);
  end;

  if bKeysChanged then
    UpdateMenuPlugins_Shortcuts(true);
end;


procedure TfmMain.DoDialogGoto;
begin
  DoLocalize_FormGoto;
  fmGoto.Width:= MulDiv(UiOps.ListboxSizeX, UiOps.ScreenScale, 100);
  UpdateInputForm(fmGoto, false);

  if fmGoto.ShowModal=mrOk then
    DoGotoFromInput(UTF8Encode(fmGoto.edInput.Text));
end;

procedure TfmMain.DoGotoFromInput(const AInput: string);
var
  Frame: TEditorFrame;
  Ed: TATSynEdit;
begin
  Frame:= CurrentFrame;
  Ed:= Frame.Editor;

    if Frame.IsBinary then
    begin
      if not ViewerGotoFromString(Frame.Binary, AInput) then
        MsgStatus(msgStatusBadLineNum);
    end
    else
    if Frame.IsText then
    begin
      if not EditorGotoFromString(Ed, AInput) then
        MsgStatus(msgStatusBadLineNum);
    end;

  Frame.SetFocus;
end;

procedure TfmMain.DoDialogGotoBookmark;
const
  cMaxLen = 150;
var
  Ed: TATSynEdit;
  Form: TfmGotoList;
  Num, NumMax: integer;
  items: TStringList;
  bm: TATBookmarkItem;
  str, strKind: atString;
  NLine, NKind, i: integer;
begin
  Ed:= CurrentEditor;
  NumMax:= Ed.Strings.Count-1;
  items:= TStringlist.Create;

  try
    for i:= 0 to ed.Strings.Bookmarks.Count-1 do
    begin
      bm:= ed.Strings.Bookmarks[i];
      if not bm.ShowInBookmarkList then Continue;

      NLine:= bm.LineNum;

      //paint prefix [N] for numbered bookmarks (kind=2..10)
      NKind:= bm.Kind;
      if (NKind>=2) and (NKind<=10) then
        strKind:= '['+IntToStr(NKind-1)+'] '
      else
        strKind:= '';

      str:= ed.Strings.LineSub(NLine, 1, cMaxLen) + #9 + strKind + IntToStr(NLine+1);
      items.AddObject(Utf8Encode(str), TObject(PtrInt(NLine)));
    end;

    if items.Count=0 then
    begin
      MsgStatus(msgCannotFindBookmarks);
      Exit;
    end;

    Num:= -1;
    Form:= TfmGotoList.Create(Self);
    try
      UpdateInputForm(Form);
      Form.Items:= items;
      Form.ShowModal;
      if Form.ResultIndex>=0 then
        Num:= PtrInt(items.Objects[Form.ResultIndex]);
    finally
      FreeAndNil(Form);
    end;
  finally
    FreeAndNil(items);
  end;

  if Num<0 then
    begin MsgStatus(msgStatusCancelled); Exit end;
  if Num>NumMax then
    Num:= NumMax;

  Ed.DoGotoPos(
    Point(0, Num),
    Point(-1, -1),
    UiOps.FindIndentHorz,
    UiOps.FindIndentVert,
    true,
    true
    );

  MsgStatus(Format(msgStatusGotoLine, [Num+1]));
end;


function TfmMain.IsFocusedFind: boolean;
begin
  Result:= Assigned(fmFind) and
    (
    fmFind.Focused or
    fmFind.edFind.Focused or
    fmFind.edRep.Focused
    );
end;


procedure TfmMain.SetShowBottom(AValue: boolean);
var
  bBottom: boolean;
begin
  if GetShowBottom<>AValue then
  begin
    bBottom:= IsFocusedBottom;

    PanelBottom.Visible:= AValue;
    if FloatBottom then
    begin
      FFormFloatBottom.Visible:= AValue;
    end
    else
    begin
      SplitterHorz.Visible:= AValue;
      SplitterHorz.Top:= PanelBottom.Top-8;
    end;

    if not AValue then
      if bBottom then
        CurrentFrame.SetFocus;
  end;

  UpdateBottomButtons;
  UpdateStatus;
end;

procedure TfmMain.SetShowSidePanel(AValue: boolean);
begin
  if GetShowSidePanel<>AValue then
  begin
    PanelLeft.Visible:= AValue;
    if FloatSide then
    begin
      FFormFloatSide.Visible:= AValue;
    end
    else
    begin
      SplitterVert.Visible:= AValue;
      SplitterVert.Left:= PanelLeft.Width;
    end;

    if AValue then
    begin
      if SidebarPanel='' then
        DoShowSidePanel(msgPanelTree_Init, false);
      UpdateTreeContents;
    end;
  end;
  UpdateSidebarButtons;
end;


procedure TfmMain.PopupTabPopup(Sender: TObject);
var
  CurForm: TForm;
  NVis, NCur: Integer;
begin
  CurForm:= Screen.ActiveForm;
  GroupsCtx:= nil;
  NCur:= -1;

  if CurForm=Self then
  begin
    GroupsCtx:= Groups;
    NCur:= GroupsCtx.PagesIndexOf(GroupsCtx.PopupPages);
  end
  else
  if FloatGroups then
  begin
    if CurForm=FFormFloatGroups1 then
    begin
      GroupsCtx:= GroupsF1;
      NCur:= 6;
    end
    else
    if CurForm=FFormFloatGroups2 then
    begin
      GroupsCtx:= GroupsF2;
      NCur:= 7;
    end
    else
    if CurForm=FFormFloatGroups3 then
    begin
      GroupsCtx:= GroupsF3;
      NCur:= 8;
    end;
  end;

  NVis:= Groups.PagesVisibleCount; //visible groups

  mnuTabMove1.Enabled:= ((NVis>=2) and (NCur<>0)) or (NCur>5);
  mnuTabMove2.Enabled:= {(NVis>=2) and} (NCur<>1);
  mnuTabMove3.Enabled:= (NVis>=3) and (NCur<>2);
  mnuTabMove4.Enabled:= (NVis>=4) and (NCur<>3);
  mnuTabMove5.Enabled:= (NVis>=5) and (NCur<>4);
  mnuTabMove6.Enabled:= (NVis>=6) and (NCur<>5);
  mnuTabMoveF1.Enabled:= (NCur<>6);
  mnuTabMoveF2.Enabled:= (NCur<>7);
  mnuTabMoveF3.Enabled:= (NCur<>8);
  mnuTabMoveNext.Enabled:= (NVis>=2) and (NCur<6);
  mnuTabMovePrev.Enabled:= mnuTabMoveNext.Enabled;
end;

procedure TfmMain.PythonEngineAfterInit(Sender: TObject);
var
  Str: array of string;
  dir: string;
  PathAppend: boolean;
  InitList: TStringList;
  InitPy: string;
begin
  if not PythonOK then exit;

  PathAppend:= true;
  SetLength(Str, 0);

  {$ifdef windows}
  PathAppend:= false;
  dir:= ExtractFileDir(Application.ExeName)+DirectorySeparator;
  SetLength(Str, 2);
  Str[0]:= dir+'dlls';
  Str[1]:= dir+ChangeFileExt(UiOps.PyLibrary, '.zip');
  {$endif}

  SetLength(Str, Length(Str)+1);
  Str[Length(Str)-1]:= GetAppPath(cDirPy);

  Py_SetSysPath(Str, PathAppend);

  InitPy:= GetAppPath(cDirPy)+DirectorySeparator+'cudatext_init.py';
  if not FileExists(InitPy) then exit;

  InitList:= TStringList.Create;
  try
    InitList.LoadFromFile(InitPy);
    try
      GetPythonEngine.ExecStrings(InitList);
    except
    end;
  finally
    FreeAndNil(InitList);
  end;
end;

procedure TfmMain.InitPyEngine;
begin
  PythonEngine.DllPath:= ExtractFileDir(UiOps.PyLibrary);
  PythonEngine.DllName:= ExtractFileName(UiOps.PyLibrary);
  PythonEngine.LoadDll;

  if PythonOK then
    GetPythonEngine.ExecString('import sys')
  else
  begin
    FConsoleMustShow:= true;
    MsgLogConsole(msgCannotInitPython1);
    MsgLogConsole(msgCannotInitPython2);
    fmConsole.ShowError:= true;
    //disable Plugins menu
    mnuPlugins.Enabled:= false;
  end;
end;

procedure TfmMain.MenuEncNoReloadClick(Sender: TObject);
begin
  SetFrameEncoding(CurrentFrame, (Sender as TMenuItem).Caption, false);
end;

procedure TfmMain.MenuEncWithReloadClick(Sender: TObject);
begin
  SetFrameEncoding(CurrentFrame, (Sender as TMenuItem).Caption, true);
end;


procedure TfmMain.SetFrameEncoding(Frame: TEditorFrame; const AEnc: string; AAlsoReloadFile: boolean);
begin
  if SameText(Frame.EncodingName, AEnc) then exit;
  Frame.EncodingName:= AEnc;

  if AAlsoReloadFile then
  begin
    if Frame.FileName<>'' then
      Frame.DoFileReload_DisableDetectEncoding
    else
      MsgBox(msgCannotReloadUntitledTab, MB_OK or MB_ICONWARNING);
  end
  else
  begin
    //set modified to allow save
    Frame.Editor.Modified:= true;
  end;

  Frame.Editor.DoEventChange; //reanalyze all file
  UpdateFrame;
  UpdateStatus;
  MsgStatus(msgStatusEncChanged);
end;

procedure TfmMain.MenuLexerClick(Sender: TObject);
var
  obj: TObject;
begin
  obj:= TObject((Sender as TComponent).Tag);
  if obj is TecSyntAnalyzer then
    CurrentFrame.Lexer:= obj as TecSyntAnalyzer
  else
  if obj is TATLiteLexer then
    CurrentFrame.LexerLite:= obj as TATLiteLexer
  else
  begin
    CurrentFrame.LexerLite:= nil;
    CurrentFrame.Lexer:= nil;
  end;

  UpdateFrame;
  UpdateStatus;
end;


procedure TfmMain.DoOps_LexersDisableInFrames(ListNames: TStringList);
var
  Frame: TEditorFrame;
  i: integer;
begin
  ListNames.Clear;
  for i:= 0 to FrameCount-1 do
  begin
    Frame:= Frames[i];
    ListNames.Add(Frame.LexerName);
    Frame.Lexer:= nil;
  end;
end;

procedure TfmMain.DoOps_LexersRestoreInFrames(ListNames: TStringList);
var
  Frame: TEditorFrame;
  i: integer;
begin
  for i:= 0 to FrameCount-1 do
  begin
    Frame:= Frames[i];
    if i<ListNames.Count then
      Frame.LexerName:= ListNames[i];
  end;
end;


procedure TfmMain.DoOps_LoadLexerLib;
var
  fn, DirLexers, LexName: string;
  ListFiles, ListBackup: TStringlist;
  an: TecSyntAnalyzer;
  ini: TIniFile;
  i, j: integer;
begin
  ListFiles:= TStringList.Create;
  ListBackup:= TStringList.Create;
  try
    DoOps_LexersDisableInFrames(ListBackup);

    AppManager.Clear;
    AppManagerLite.Clear;

    //load lite lexers
    DirLexers:= GetAppPath(cDirDataLexersLite);
    AppManagerLite.LoadFromDir(DirLexers);

    //load EControl lexers
    DirLexers:= GetAppPath(cDirDataLexers);
    FindAllFiles(ListFiles, DirLexers, '*.lcf', false);
    ListFiles.Sort;

    if ListFiles.Count=0 then
      MsgStatusAlt(msgCannotFindLexersAll, 3);

    for i:= 0 to ListFiles.Count-1 do
    begin
      an:= AppManager.AddLexer;
      //an.Name:= '_lx_'+LexerFilenameToComponentName(ListFiles[i]);
      an.LoadFromFile(ListFiles[i]);
    end;

    //correct sublexer links
    for i:= 0 to AppManager.LexerCount-1 do
    begin
      an:= AppManager.Lexers[i];
      fn:= GetAppLexerMapFilename(an.LexerName);
      if FileExists(fn) then
      begin
        ini:= TIniFile.Create(fn);
        try
          for j:= 0 to an.SubAnalyzers.Count-1 do
          begin
            LexName:= ini.ReadString('ref', IntToStr(j), '');
            if LexName<>'' then
              an.SubAnalyzers[j].SyntAnalyzer:= AppManager.FindLexerByName(LexName);
          end;
        finally
          FreeAndNil(ini);
        end;
      end;
    end;

    UpdateMenuLexers;

    DoOps_LexersRestoreInFrames(ListBackup);
  finally
    FreeAndNil(ListFiles);
    FreeAndNil(ListBackup);
  end;
end;


procedure TfmMain.UpdateMenuLexers;
begin
  UpdateKeymapDynamicItems;
  DoOps_LoadKeymap;
  UpdateMenuLexersTo(PopupLex.Items);
  UpdateMenuLexersTo(mnuLexers);
end;

procedure TfmMain.UpdateMenuLexersTo(AMenu: TMenuItem);
var
  sl: TStringList;
  an: TecSyntAnalyzer;
  an_lite: TATLiteLexer;
  mi, mi0: TMenuItem;
  ch, ch0: char;
  i: integer;
begin
  if AMenu=nil then exit;
  AMenu.Clear;

  ch0:= '?';
  mi0:= nil;

  mi:= TMenuItem.Create(self);
  mi.Caption:= msgNoLexer;
  mi.OnClick:= @MenuLexerClick;
  AMenu.Add(mi);

  sl:= TStringList.Create;
  try
    //make stringlist of all lexers
    for i:= 0 to AppManager.LexerCount-1 do
    begin
      an:= AppManager.Lexers[i];
      if not an.Internal then
        sl.AddObject(an.LexerName, an);
    end;

    for i:= 0 to AppManagerLite.LexerCount-1 do
    begin
      an_lite:= AppManagerLite.Lexers[i];
      sl.AddObject(an_lite.LexerName+msgLiteLexerSuffix, an_lite);
    end;
    sl.Sort;

    //put stringlist to menu
    if not UiOps.LexerMenuGrouped then
    begin
      for i:= 0 to sl.Count-1 do
      begin
        if sl[i]='' then Continue;
        mi:= TMenuItem.Create(self);
        mi.Caption:= sl[i];
        mi.Tag:= PtrInt(sl.Objects[i]);
        mi.OnClick:= @MenuLexerClick;
        AMenu.Add(mi);
      end;
    end
    else
    //grouped view
    for i:= 0 to sl.Count-1 do
    begin
      if sl[i]='' then Continue;
      ch:= UpCase(sl[i][1]);
      if ch<>ch0 then
      begin
        ch0:= ch;
        mi0:= TMenuItem.Create(self);
        mi0.Caption:= ch;
        AMenu.Add(mi0);
      end;

      mi:= TMenuItem.Create(self);
      mi.Caption:= sl[i];
      mi.Tag:= PtrInt(sl.Objects[i]);
      mi.OnClick:= @MenuLexerClick;
      if Assigned(mi0) then
        mi0.Add(mi)
      else
        AMenu.Add(mi);
    end;
  finally
    sl.Free;
  end;
end;

procedure TfmMain.MsgStatus(const AText: string);
var
  Frame: TEditorFrame;
  S: string;
begin
  Frame:= CurrentFrame;
  S:= AText;
  SReplaceAll(S, #10, ' ');
  SReplaceAll(S, #13, ' ');

  if Frame.IsText then
  begin
    if Frame.ReadOnly then
      S:= msgStatusReadonly+' '+S;
    if Frame.MacroRecord then
      S:= msgStatusMacroRec+' '+S;
  end;

  DoStatusbarTextByTag(Status, StatusbarTag_Msg, S);

  if S='' then exit;
  TimerStatus.Enabled:= false;
  TimerStatus.Enabled:= true;
end;

procedure TfmMain.MsgStatusAlt(const AText: string; ASeconds: integer);
const
  cMax=30;
begin
  if ASeconds<=0 then
  begin
    TimerStatusAlt.Enabled:= false;
    StatusAlt.Hide;
    Exit
  end;

  if ASeconds>cMax then
    ASeconds:= cMax;

  //StatusAlt.Parent:= Status; //place hint on statusbar
  //StatusAlt.Align:= alClient;
  StatusAlt.Top:= Status.Top-4;

  StatusAlt.Captions[0]:= AText;
  StatusAlt.Show;

  TimerStatusAlt.Interval:= ASeconds*1000;
  TimerStatusAlt.Enabled:= false;
  TimerStatusAlt.Enabled:= true;
end;

procedure TfmMain.SetShowMenu(AValue: boolean);
begin
  if AValue then
    Menu:= MainMenu
  else
    Menu:= nil;
end;

function TfmMain.GetShowOnTop: boolean;
begin
  Result:= UiOps.ShowFormsOnTop;
end;

function TfmMain.GetShowMenu: boolean;
begin
  Result:= Menu<>nil;
end;

procedure TfmMain.SetShowOnTop(AValue: boolean);
begin
  UiOps.ShowFormsOnTop:= AValue;
  UpdateFormOnTop(Self);
  UpdateStatus;
end;

procedure TfmMain.SetSidebarPanel(const ACaption: string);
begin
  if (ACaption<>'-') and (ACaption<>'') then
    if ShowSidePanel then
      DoShowSidePanel(ACaption, true);
end;

procedure TfmMain.SetShowSideBar(AValue: boolean);
begin
  PanelSide.Visible:= AValue;
end;

function TfmMain.GetShowSidebarOnRight: boolean;
begin
  Result:= PanelSide.Align=alRight;
end;

procedure TfmMain.SetShowSidebarOnRight(AValue: boolean);
const
  cVal: array[boolean] of TAlign = (alLeft, alRight);
begin
  if AValue=GetShowSidebarOnRight then exit;
  PanelSide.Align:= cVal[AValue];
  PanelLeft.Align:= cVal[AValue];
  SplitterVert.Align:= cVal[AValue];

  if AValue then
    SplitterVert.Left:= PanelSide.Width
  else
    SplitterVert.Left:= ClientWidth-PanelSide.Width;
end;

procedure TfmMain.SetShowStatus(AValue: boolean);
begin
  Status.Visible:= AValue;
end;

procedure TfmMain.SetShowToolbar(AValue: boolean);
begin
  ToolbarMain.Visible:= AValue;
end;

procedure TfmMain.DoFileSaveAll;
var
  F: TEditorFrame;
  i: integer;
begin
  for i:= 0 to FrameCount-1 do
  begin
    F:= Frames[i];
    if F.Modified then
      F.DoFileSave(false);
  end;
end;

procedure TfmMain.DoFileReopen;
var
  F: TEditorFrame;
  PrevRO: boolean;
  PrevLexer: string;
begin
  F:= CurrentFrame;
  if F.FileName='' then exit;

  if F.Modified and UiOps.ReloadUnsavedConfirm then
    if MsgBox(
      Format(msgConfirmReopenModifiedTab, [F.FileName]),
      MB_OKCANCEL or MB_ICONQUESTION
      ) <> ID_OK then exit;

  PrevRO:= F.ReadOnly;
  PrevLexer:= F.LexerName;
  F.ReadOnly:= false;
  F.DoFileReload;
  F.Lexer:= AppManager.FindLexerByName(PrevLexer);
  F.ReadOnly:= PrevRO;

  UpdateStatus;
  MsgStatus(msgStatusReopened+' '+ExtractFileName(F.Filename));
end;

function TfmMain.DoFileCloseAll: boolean;
var
  i: integer;
begin
  Result:= Groups.CloseTabs(tabCloseAll, false);
  if not Result then exit;

  for i:= 0 to FrameCount-1 do
    if Frames[i].Modified then exit(false);
end;

procedure TfmMain.DoFileCloseAndDelete;
var
  fn: string;
begin
  if not CurrentFrame.IsText then exit;
  fn:= CurrentFrame.FileName;
  if fn='' then exit;

  if MsgBox(msgConfirmCloseDelFile+#13+fn, MB_OKCANCEL or MB_ICONWARNING)=id_ok then
    if Groups.CloseTabs(tabCloseCurrent, false) then
      DeleteFileUTF8(fn);
end;


procedure TfmMain.MenuRecentsClick(Sender: TObject);
var
  fn: string;
  n: integer;
begin
  n:= (Sender as TComponent).Tag;
  fn:= FListRecents[n];
  if FileExistsUTF8(fn) then
    DoFileOpen(fn)
  else
  begin
    MsgBox(msgCannotFindFile+#13+fn, MB_OK or MB_ICONERROR);
    FListRecents.Delete(n);
    UpdateMenuRecent(nil);
  end;
end;

procedure TfmMain.DoToggleMenu;
begin
  ShowMenu:= not ShowMenu;
end;

procedure TfmMain.DoToggleFloatSide;
begin
  FloatSide:= not FloatSide;
end;

procedure TfmMain.DoToggleFloatBottom;
begin
  FloatBottom:= not FloatBottom;
end;

procedure TfmMain.DoToggleOnTop;
begin
  ShowOnTop:= not ShowOnTop;
end;

procedure TfmMain.DoToggleFullScreen;
begin
  ShowFullscreen:= not ShowFullscreen;
end;

procedure TfmMain.DoToggleDistractionFree;
begin
  ShowDistractionFree:= not ShowDistractionFree;
end;

procedure TfmMain.DoToggleSidePanel;
begin
  ShowSidePanel:= not ShowSidePanel;
end;

procedure TfmMain.DoToggleBottomPanel;
begin
  ShowBottom:= not ShowBottom;
end;

procedure TfmMain.DoToggleFindDialog;
var
  bBottom: boolean;
begin
  bBottom:= IsFocusedFind;

  InitFormFind;
  fmFind.Visible:= not fmFind.Visible;

  if not fmFind.Visible then
    if bBottom then
      CurrentFrame.SetFocus;
end;

procedure TfmMain.DoToggleToolbar;
begin
  ShowToolbar:= not ShowToolbar;
end;

procedure TfmMain.DoToggleStatusbar;
begin
  ShowStatus:= not ShowStatus;
end;

procedure TfmMain.DoCudaLibAction(const AMethod: string);
var
  Ed: TATSynEdit;
begin
  Ed:= CurrentEditor;
  Ed.Strings.BeginUndoGroup;
  try
    DoPyCommand('cudax_lib', AMethod, []);
  finally
    Ed.Strings.EndUndoGroup;
  end;
end;


procedure TfmMain.DoShowConsole(AFocusEdit: boolean);
begin
  DoShowBottomPanel(msgPanelConsole_Init);
  if AFocusEdit then
    fmConsole.ed.SetFocus;
end;

procedure TfmMain.DoShowOutput;
begin
  DoShowBottomPanel(msgPanelOutput_Init);
end;

procedure TfmMain.DoShowValidate;
begin
  DoShowBottomPanel(msgPanelValidate_Init);
end;

procedure TfmMain.DoShowSidePanel(const ATabCaption: string; AndFocus: boolean);
begin
  if ATabCaption='-' then
  begin
    ShowSidePanel:= false;
  end
  else
  begin
    ShowSidePanel:= true;
    if ATabCaption<>'' then
      DoSidebar_ActivateTab(ATabCaption, AndFocus);
  end;

  UpdateSidebarButtons;
end;


procedure TfmMain.DoShowBottomPanel(const ATabCaption: string);
begin
  if ATabCaption='-' then
  begin
    ShowBottom:= false;
  end
  else
  begin
    ShowBottom:= true;
    if ATabCaption<>'' then
      DoBottom_ActivateTab(ATabCaption);
  end;

  UpdateBottomButtons;
end;

procedure TfmMain.SetShowFullScreen(AValue: boolean);
begin
  if FShowFullScreen=AValue then Exit;
  FShowFullScreen:= AValue;
  SetFullScreen_Ex(AValue, false);
end;

procedure TfmMain.SetShowDistractionFree(AValue: boolean);
begin
  if FShowFullScreen=AValue then Exit;
  FShowFullScreen:= AValue;
  SetFullScreen_Ex(AValue, true);
end;


procedure TfmMain.DoApplyGutterVisible(AValue: boolean);
var
  i: integer;
begin
  for i:= 0 to FrameCount-1 do
    with Frames[i] do
    begin
      Editor.OptGutterVisible:= AValue;
      Editor2.OptGutterVisible:= AValue;
    end;
end;

procedure TfmMain.SetFullScreen_Ex(AValue: boolean; AHideAll: boolean);
var
  Ed: TATSynEdit;
begin
  Ed:= CurrentEditor;
  if AValue then
  begin
    FOrigShowToolbar:= ShowToolbar;
    FOrigShowStatusbar:= ShowStatus;
    FOrigShowBottom:= ShowBottom;
    FOrigShowSidePanel:= ShowSidePanel;
    FOrigShowSideBar:= ShowSideBar;
    FOrigShowTabs:= ShowTabsMain;

    if AHideAll then
    begin
      Ed.OptMinimapVisible:= false;
      Ed.OptMicromapVisible:= false;
      Ed.OptTextCenteringCharWidth:= EditorOps.OpCenteringForDistractionFree;
      Ed.Update;
    end;

    if AHideAll or (Pos('t', UiOps.FullScreen)>0) then ShowToolbar:= false;
    if AHideAll or (Pos('b', UiOps.FullScreen)>0) then ShowBottom:= false;
    if AHideAll or (Pos('i', UiOps.FullScreen)>0) then ShowStatus:= false;
    if AHideAll or (Pos('p', UiOps.FullScreen)>0) then ShowSidePanel:= false;
    if AHideAll or (Pos('a', UiOps.FullScreen)>0) then ShowSideBar:= false;
    if AHideAll or (Pos('u', UiOps.FullScreen)>0) then ShowTabsMain:= false;
    if AHideAll or (Pos('g', UiOps.FullScreen)>0) then DoApplyGutterVisible(false);
  end
  else
  begin
    ShowToolbar:= FOrigShowToolbar;
    ShowStatus:= FOrigShowStatusbar;
    ShowBottom:= FOrigShowBottom;
    ShowSidePanel:= FOrigShowSidePanel;
    ShowSideBar:= FOrigShowSideBar;
    ShowTabsMain:= FOrigShowTabs;
    Ed.OptMinimapVisible:= EditorOps.OpMinimapShow;
    Ed.OptMicromapVisible:= EditorOps.OpMicromapShow;
    Ed.OptTextCenteringCharWidth:= IfThen(Groups.Mode=gmOne, EditorOps.OpCenteringWidth, 0);
    DoApplyGutterVisible(EditorOps.OpGutterShow);
  end;

  {$ifdef windows}
  SetFullScreen_Win32(AValue);
  {$else}
  SetFullScreen_Universal(AValue);
  {$endif}
end;

procedure TfmMain.SetFullScreen_Universal(AValue: boolean);
begin
  {$ifdef darwin}
  if AValue then
    BorderStyle:= bsNone
  else
    BorderStyle:= bsSizeable;
  {$endif}

  if AValue then
    ShowWindow(Handle, SW_SHOWFULLSCREEN)
  else
    ShowWindow(Handle, SW_SHOWNORMAL);
end;

procedure TfmMain.SetFullScreen_Win32(AValue: boolean);
begin
  if AValue then
  begin
    FOrigWndState:= WindowState;
    FOrigBounds:= BoundsRect;
    BorderStyle:= bsNone;
    BoundsRect:= Monitor.BoundsRect;
  end
  else
  begin
    WindowState:= FOrigWndState;
    BoundsRect:= FOrigBounds;
    BorderStyle:= bsSizeable;
    BoundsRect:= FOrigBounds; //again
  end;
end;

function TfmMain.GetShowTabsMain: boolean;
begin
  Result:= Groups.Pages1.Tabs.Visible;
end;

procedure TfmMain.SetShowTabsMain(AValue: boolean);
begin
  Groups.SetTabOption(tabOptionShowTabs, Ord(AValue));
end;


procedure TfmMain.DoEditorsLock(ALock: boolean);
var
  i: integer;
begin
  for i:= 0 to FrameCount-1 do
    Frames[i].Locked:= ALock;
end;

procedure TfmMain.DoFileNewFrom(const fn: string);
var
  F: TEditorFrame;
begin
  F:= DoFileOpen('');
  if F=nil then exit;
  F.Editor.Strings.LoadFromFile(fn);
  F.DoLexerFromFilename(fn);
  UpdateFrame(true);
  UpdateStatus;
end;

procedure TfmMain.DoFileSave;
var
  F: TEditorFrame;
begin
  F:= CurrentFrame;
  DoFileDialog_PrepareDir(SaveDlg);
  if F.Modified or (F.FileName='') then
    if F.DoFileSave(false) then
      DoFileDialog_SaveDir(SaveDlg);
end;

procedure TfmMain.DoFileSaveAs;
var
  F: TEditorFrame;
begin
  F:= CurrentFrame;
  DoFileDialog_PrepareDir(SaveDlg);
  if F.DoFileSave(true) then
    DoFileDialog_SaveDir(SaveDlg);
end;

procedure TfmMain.DoFocusEditor;
var
  Ed: TATSynEdit;
begin
  Ed:= CurrentEditor;
  if Ed=nil then exit;
  if Ed.Visible and Ed.Enabled then
    Ed.SetFocus;
end;

procedure TfmMain.DoSwitchActiveTab(ANext: boolean);
begin
  Groups.PagesCurrent.Tabs.SwitchTab(ANext);
end;

function TfmMain.DoCheckFilenameOpened(const AName: string): boolean;
var
  SName: string;
  i: integer;
begin
  Result:= false;
  if AName='' then exit;
  for i:= 0 to FrameCount-1 do
  begin
    SName:= Frames[i].FileName;
    if SameFileName(SName, AName) then exit(true);
  end;
end;

procedure TfmMain.DoOps_OpenFile_Default;
var
  fn: string;
  F: TEditorFrame;
begin
  fn:= GetAppPath(cFileOptionsDefault);
  F:= DoFileOpen(fn);
  if Assigned(F) then
    F.ReadOnly:= true;
end;

procedure TfmMain.DoOps_OpenFile_User;
var
  fn: string;
begin
  fn:= GetAppPath(cFileOptionsUser);
  if not FileExistsUTF8(fn) then
  begin
    FCreateFile(fn, true);
    if not FileExistsUTF8(fn) then Exit;
  end;

  DoFileOpen(fn);
end;

procedure TfmMain.DoOps_OpenFile_DefaultAndUser;
var
  fn: string;
  F: TEditorFrame;
begin
  if Groups.Mode=gmOne then
    Groups.Mode:= gm2v;

  fn:= GetAppPath(cFileOptionsDefault);
  F:= DoFileOpen(fn, Groups.Pages[0]);
  if Assigned(F) then
    F.ReadOnly:= true;

  fn:= GetAppPath(cFileOptionsUser);
  if not FileExistsUTF8(fn) then
  begin
    FCreateFile(fn, true);
    if not FileExistsUTF8(fn) then Exit;
  end;
  DoFileOpen(fn, Groups.Pages[1]);
end;

procedure TfmMain.DoOps_OpenFile_FileTypes;
var
  fn: string;
begin
  fn:= GetAppPath(cFileOptionsFiletypes);
  if not FileExistsUTF8(fn) then
  begin
    FCreateFile(fn, true);
    if not FileExistsUTF8(fn) then Exit;
  end;

  DoFileOpen(fn);
end;

procedure TfmMain.DoOps_OpenFile_LexerSpecific;
var
  fn: string;
begin
  fn:= GetAppLexerSpecificConfig(CurrentFrame.LexerName);
  if not FileExistsUTF8(fn) then
  begin
    FCreateFile(fn, true);
    if not FileExistsUTF8(fn) then exit;
  end;

  DoFileOpen(fn);
end;

procedure TfmMain.MenuMainClick(Sender: TObject);
var
  F: TEditorFrame;
  bFindFocused: boolean;
  NTag: PtrInt;
  NCommand: integer;
  SCallback: string;
begin
  NTag:= (Sender as TComponent).Tag;
  if NTag=0 then exit;

  NCommand:= TAppMenuProps(NTag).CommandCode;
  SCallback:= TAppMenuProps(NTag).CommandString;
  F:= CurrentFrame;

  //dont do editor commands here if ed not focused
  bFindFocused:= Assigned(fmFind) and
    (fmFind.edFind.Focused or fmFind.edRep.Focused);
  if bFindFocused then
    if (NCommand>0) and (NCommand<cmdFirstAppCommand) then exit;

  //-1 means run callback
  if NCommand=-1 then
  begin
    if SCallback<>'' then
      DoPyCallbackFromAPI(SCallback, []);
  end
  else
    F.Editor.DoCommand(NCommand);

  UpdateFrame;
  UpdateStatus;
end;

procedure TfmMain.SetLexerIndex(N: integer);
begin
  if (N>=0) and (N<AppManager.LexerCount) then
    CurrentFrame.Lexer:= AppManager.Lexers[N]
  else
    CurrentFrame.Lexer:= nil;

  UpdateFrame;
  UpdateStatus;
end;


procedure TfmMain.DoAutoComplete;
var
  F: TEditorFrame;
  Ed: TATSynEdit;
  LexName: string;
  IsPascal, IsCss, IsHtml, IsCaseSens: boolean;
  FileHtml, FileCss, FileAcp: string;
  Caret: TATCaretItem;
begin
  F:= CurrentFrame;
  Ed:= CurrentEditor;

  if DoPyEvent(Ed, cEventOnComplete, [])=cPyTrue then exit;

  if F.Lexer=nil then exit;

  Caret:= Ed.Carets[0];
  LexName:= F.LexerNameAtPos(Point(Caret.PosX, Caret.PosY));
  if LexName='' then exit;

  IsPascal:= Pos('Pascal', LexName)>0;
  IsHtml:= UiOps.AutocompleteHtml and SRegexMatchesString(LexName, UiOps.AutocompleteHtml_Lexers, false);
  IsCss:= UiOps.AutocompleteCss and SRegexMatchesString(LexName, UiOps.AutocompleteCss_Lexers, false);
  IsCaseSens:= false; //cannot detect it yet
  FileCss:= GetAppPath(cDirDataAutocompleteSpec)+DirectorySeparator+'css_list.ini';
  FileHtml:= GetAppPath(cDirDataAutocompleteSpec)+DirectorySeparator+'html_list.ini';
  FileAcp:= GetAppLexerAcpFilename(LexName);

  //allow autocompletion with carets, only in HTML
  if Ed.Carets.Count>1 then
    if not IsHtml then
    begin
      MsgStatus(msgCannotAutocompleteMultiCarets);
      exit;
    end;
  MsgStatus(msgStatusTryingAutocomplete+' '+LexName);

  if IsHtml then
  begin
    if EditorHasCssAtCaret(Ed) then
      DoEditorCompletionCss(Ed, FileCss)
    else
      DoEditorCompletionHtml(Ed, FileHtml);
  end
  else
  if IsCss then
    DoEditorCompletionCss(Ed, FileCss)
  else
    DoEditorCompletionAcp(Ed, FileAcp, IsCaseSens, IsPascal);
end;

procedure TfmMain.mnuTreeFold2Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 2);
end;

procedure TfmMain.mnuTreeFold3Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 3);
end;

procedure TfmMain.mnuTreeFold4Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 4);
end;

procedure TfmMain.mnuTreeFold5Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 5);
end;

procedure TfmMain.mnuTreeFold6Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 6);
end;

procedure TfmMain.mnuTreeFold7Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 7);
end;

procedure TfmMain.mnuTreeFold8Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 8);
end;

procedure TfmMain.mnuTreeFold9Click(Sender: TObject);
begin
  DoTreeviewFoldLevel(CodeTree.Tree, 9);
end;

procedure TfmMain.mnuTreeFoldAllClick(Sender: TObject);
begin
  CodeTree.Tree.FullCollapse;
end;

procedure TfmMain.mnuTreeSortedClick(Sender: TObject);
begin
  if CodeTree.Tree.SortType=stNone then
    CodeTree.Tree.SortType:= stText
  else
    CodeTree.Tree.SortType:= stNone;

  mnuTreeSorted.Checked:= CodeTree.Tree.SortType<>stNone;
end;

procedure TfmMain.mnuTreeUnfoldAllClick(Sender: TObject);
begin
  CodeTree.Tree.FullExpand;
end;


procedure TfmMain.DoFileExportHtml;
var
  Ed: TATSynEdit;
  STitle: string;
  Opt: TOpenOptions;
begin
  STitle:= ExtractFileName(CurrentFrame.FileName);
  if STitle='' then STitle:= 'untitled';
  SaveDlg.Filename:= STitle+'.html';
  SaveDlg.InitialDir:= GetTempDir(false);

  Opt:= SaveDlg.Options;
  try
    SaveDlg.Options:= SaveDlg.Options-[ofOverwritePrompt];
    SaveDlg.Filter:= 'HTML files|*.htm;*.html';
    if not SaveDlg.Execute then exit;
  finally
    SaveDlg.Options:= Opt;
  end;

  CurrentFrame.Adapter.DynamicHiliteEnabled:= false; //turn off for html

  Ed:= CurrentEditor;
  Ed.DoCommand(cCommand_SelectNone);

  DoEditorExportToHTML(Ed, SaveDlg.FileName, STitle,
    UiOps.ExportHtmlFontName,
    UiOps.ExportHtmlFontSize,
    UiOps.ExportHtmlNumbers,
    GetAppColor('ExportHtmlBg'),
    GetAppColor('ExportHtmlNumbers')
    );

  CurrentFrame.Adapter.DynamicHiliteEnabled:= EditorOps.OpLexerDynamicHiliteEnabled; //turn back
  UpdateFrame(true);

  if MsgBox(msgConfirmOpenCreatedDoc, MB_OKCANCEL or MB_ICONQUESTION)=id_ok then
    OpenDocument(SaveDlg.FileName);
end;


function TfmMain.DoDialogMenuApi(const AText, ACaption: string;
  AMultiline: boolean;
  AInitIndex: integer;
  ANoFuzzy: boolean;
  ANoFullFilter: boolean): integer;
var
  Form: TfmMenuApi;
  S, SItem: string;
begin
  Form:= TfmMenuApi.Create(nil);
  try
    S:= AText;
    repeat
      SItem:= SGetItem(S, #10);
      if SItem='' then Break;
      Form.listItems.Add(SItem);
    until false;

    UpdateInputForm(Form);
    Form.ListCaption:= ACaption;
    Form.Multiline:= AMultiline;
    Form.InitItemIndex:= AInitIndex;
    Form.DisableFuzzy:= ANoFuzzy;
    Form.DisableFullFilter:= ANoFullFilter;

    Form.ShowModal;
    Result:= Form.ResultCode;
  finally
    Form.Free;
  end;
end;

procedure TfmMain.SplitterOnPaint_Gr(Sender: TObject);
begin
  //empty, to disable themed paint
end;

procedure TfmMain.SplitterOnPaint_Main(Sender: TObject);
begin
  //empty, to disable themed paint
end;


procedure TfmMain.GetEditorIndexes(Ed: TATSynEdit; out AGroupIndex, ATabIndex: Integer);
var
  Gr: TATGroups;
  Pages: TATPages;
  Frame: TEditorFrame;
  NLocalGroup: integer;
begin
  Frame:= GetEditorFrame(Ed);
  if Assigned(Frame) then
    GetFrameLocation(Frame, Gr, Pages, NLocalGroup, AGroupIndex, ATabIndex)
  else
  begin
    AGroupIndex:= -1;
    ATabIndex:= -1;
  end;
end;

procedure TfmMain.DoHelpWiki;
begin
  OpenURL('http://wiki.freepascal.org/CudaText');
end;

procedure TfmMain.DoCodetree_OnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_ESCAPE) then
  begin
    CurrentFrame.SetFocus;
    Key:= 0;
    exit
  end;

  if (Key=VK_RETURN) then
  begin
    (Sender as TTreeView).OnDblClick(Sender);
    Key:= 0;
    exit
  end;
end;

procedure TfmMain.DoCodetree_GotoBlockForCurrentNode(AndSelect: boolean);
var
  Ed: TATSynEdit;
  Node: TTreeNode;
  P1, P2: TPoint;
begin
  Node:= CodeTree.Tree.Selected;
  if Node=nil then exit;

  DoTreeGetSyntaxRange(Node, P1, P2);
  if (P1.Y<0) or (P2.Y<0) then exit;

  if not AndSelect then
    P2:= Point(-1, -1);

  Ed:= CurrentEditor;
  Ed.DoGotoPos(P1, P2,
    UiOps.FindIndentHorz,
    UiOps.FindIndentVert,
    true,
    true
    );
end;

procedure TfmMain.ListboxOutKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Prop: ^TAppPanelProps;
  List: TATListbox;
begin
  //Esc
  if (Key=VK_ESCAPE) then
  begin
    CurrentFrame.SetFocus;
    Key:= 0;
    exit
  end;

  List:= Sender as TATListbox;
  if Sender=ListboxOut then
    Prop:= @AppPanelProp_Out
  else
    Prop:= @AppPanelProp_Val;

  if not ((List.ItemIndex>=0) and
          (List.ItemIndex<Prop^.Listbox.Items.Count)) then exit;

  //Ctrl+C
  if (Key=Ord('C')) and (Shift=[ssCtrl]) then
  begin
    SClipboardCopy(Prop^.Listbox.Items.Text);
    Key:= 0;
    exit
  end;

  //Ctrl+D
  if (Key=Ord('D')) and (Shift=[ssCtrl]) then
  begin
    SClipboardCopy(Prop^.Listbox.Items[List.ItemIndex]);
    Key:= 0;
    exit
  end;

  //Ctrl+Del
  if Key=VK_DELETE then
  begin
    ////don't enable Del for Output panel
    //if Shift=[] then
    //  Prop^.Items.Delete(List.ItemIndex);

    if Shift=[ssCtrl] then
      Prop^.Listbox.Items.Clear;

    if List.ItemCount=0 then
      List.ItemIndex:= -1
    else
    if List.ItemIndex>=List.ItemCount then
      List.ItemIndex:= List.ItemCount-1;

    List.Invalidate;
  end;
end;


procedure TfmMain.MenuLangClick(Sender: TObject);
var
  NTag: integer;
begin
  NTag:= (Sender as TComponent).Tag;
  if NTag>=0 then
  begin
    AppLangName:= ExtractFileNameOnly(FListLangs[NTag]);
    UpdateMenuLangs(mnuLang);
    DoLocalize;
  end
  else
  begin
    AppLangName:= '';
    MsgBox('Built-in translation will be used after app restart', mb_ok or MB_ICONINFORMATION);
  end;

  DoPyEvent(CurrentEditor, cEventOnState, [IntToStr(APPSTATE_LANG)]);
end;

procedure TfmMain.MenuPicScaleClick(Sender: TObject);
var
  F: TEditorFrame;
begin
  F:= CurrentFrame;
  if F.IsPicture then
  begin
    F.PictureScale:= (Sender as TComponent).Tag;
  end;
end;


procedure TfmMain.DoHelpLexers;
begin
  DoFileOpen(GetAppPath(cFileReadmeHelpLexers));
end;

procedure TfmMain.DoHelpIssues;
begin
  OpenURL('https://github.com/Alexey-T/CudaText/issues');
end;

procedure TfmMain.DoHelpHotkeys;
begin
  MsgBox(msgStatusHelpOnKeysConfig, MB_OK or MB_ICONINFORMATION);
end;


procedure TfmMain.mnuTabColorClick(Sender: TObject);
var
  F: TEditorFrame;
  NColor: TColor;
begin
  F:= FrameOfPopup;
  if F=nil then exit;

  NColor:= Py_DialogColorPicker(F.TabColor);
  if NColor<0 then exit;

  if NColor=clNone then
    F.TabColor:= clNone
  else
    F.TabColor:= NColor;
end;

procedure TfmMain.mnuTabsize1Click(Sender: TObject);
begin
  UpdateEditorTabsize(1);
end;

procedure TfmMain.mnuTabsize2Click(Sender: TObject);
begin
  UpdateEditorTabsize(2);
end;

procedure TfmMain.mnuTabsize3Click(Sender: TObject);
begin
  UpdateEditorTabsize(3);
end;

procedure TfmMain.mnuTabsize4Click(Sender: TObject);
begin
  UpdateEditorTabsize(4);
end;

procedure TfmMain.mnuTabsize5Click(Sender: TObject);
begin
  UpdateEditorTabsize(5);
end;

procedure TfmMain.mnuTabsize6Click(Sender: TObject);
begin
  UpdateEditorTabsize(6);
end;

procedure TfmMain.mnuTabsize7Click(Sender: TObject);
begin
  UpdateEditorTabsize(7);
end;

procedure TfmMain.mnuTabsize8Click(Sender: TObject);
begin
  UpdateEditorTabsize(8);
end;

procedure DoParseOutputLine(const AProp: TAppPanelProps;
  const AStr: string;
  out AFilename: string;
  out ALine, ACol: integer);
var
  Parts: TRegexParts;
begin
  AFilename:= AProp.DefFilename;
  ALine:= -1;
  ACol:= 0;

  if AProp.RegexStr='' then exit;
  if AProp.RegexIdLine=0 then exit;

  if not SRegexFindParts(AProp.RegexStr, AStr, Parts) then exit;
  if AProp.RegexIdName>0 then
    AFilename:= Parts[AProp.RegexIdName].Str;
  if AProp.RegexIdLine>0 then
    ALine:= StrToIntDef(Parts[AProp.RegexIdLine].Str, -1);
  if AProp.RegexIdCol>0 then
    ACol:= StrToIntDef(Parts[AProp.RegexIdCol].Str, 0);

  if not AProp.ZeroBase then
  begin
    if ALine>0 then Dec(ALine);
    if ACol>0 then Dec(ACol);
  end;
end;

procedure TfmMain.ListboxOutClick(Sender: TObject);
var
  Prop: ^TAppPanelProps;
  ResFilename: string;
  ResLine, ResCol: integer;
  NIndex, NTag: integer;
  SText: string;
begin
  if Sender=ListboxOut then
    Prop:= @AppPanelProp_Out
  else
    Prop:= @AppPanelProp_Val;

  NIndex:= Prop^.Listbox.ItemIndex;
  if NIndex<0 then exit;
  if NIndex>=Prop^.Listbox.Items.Count then exit;

  SText:= Prop^.Listbox.Items[NIndex];
  NTag:= PtrInt(Prop^.Listbox.Items.Objects[NIndex]);

  DoParseOutputLine(Prop^, SText, ResFilename, ResLine, ResCol);
  if (ResFilename<>'') and (ResLine>=0) then
  begin
    MsgStatus(Format(msgStatusGotoFileLineCol, [ResFilename, ResLine+1, ResCol+1]));
    if FileExists(ResFilename) then
    begin
      DoFileOpen(ResFilename);
      CurrentFrame.Editor.DoCaretSingle(ResCol, ResLine);
      CurrentFrame.Editor.DoGotoCaret(cEdgeTop);
      CurrentFrame.Editor.Update;
      UpdateStatus;
    end;
  end
  else
  begin
    MsgStatus(msgStatusClickingLogLine);
    DoPyEvent(CurrentEditor, cEventOnOutputNav,
      [SStringToPythonString(SText), IntToStr(NTag)] );
  end;
end;


procedure TfmMain.ListboxOutDrawItem(Sender: TObject; C: TCanvas;
  AIndex: integer; const ARect: TRect);
const
  cDx=4; cDy=1;
var
  Prop: PAppPanelProps;
  ResFilename: string;
  ResLine, ResCol: integer;
begin
  Prop:= GetAppPanelProps_ByListbox(Sender as TATListbox);
  if Prop=nil then exit;
  if AIndex<0 then exit;

  DoParseOutputLine(Prop^, Prop^.Listbox.Items[AIndex], ResFilename, ResLine, ResCol);
  if (ResFilename<>'') and (ResLine>=0) then
  begin
    C.Font.Color:= GetAppColor('ListFontHotkey');
    C.Brush.Color:= GetAppColor('ListBg');
  end
  else
  begin
    C.Font.Color:= GetAppColor('ListFont');
    C.Brush.Color:= GetAppColor('ListBg');
  end;

  if AIndex=Prop^.Listbox.ItemIndex then
  begin
    C.Font.Color:= GetAppColor('ListSelFont');
    C.Brush.Color:= GetAppColor('ListSelBg');
    C.FillRect(ARect);
  end;

  C.TextOut(ARect.Left+cDx, ARect.Top+cDy, Prop^.Listbox.Items[AIndex]);
end;


procedure TfmMain.DoGotoDefinition;
begin
  if DoPyEvent(CurrentEditor, cEventOnGotoDef, [])<>cPyTrue then
    MsgStatus(msgStatusNoGotoDefinitionPlugins);
end;

procedure TfmMain.DoShowFuncHint;
var
  S: string;
begin
  S:= DoPyEvent(CurrentEditor, cEventOnFuncHint, []);
  if (S='') or (S='None') then exit;

  MsgStatusAlt(S, UiOps.StatusAltTime);
end;

procedure TfmMain.PopupTextPopup(Sender: TObject);
var
  Ed: TATSynEdit;
begin
  UpdateMenuItemHotkey(mnuTextUndo, cCommand_Undo);
  UpdateMenuItemHotkey(mnuTextRedo, cCommand_Redo);
  UpdateMenuItemHotkey(mnuTextCut, cCommand_ClipboardCut);
  UpdateMenuItemHotkey(mnuTextCopy, cCommand_ClipboardCopy);
  UpdateMenuItemHotkey(mnuTextPaste, cCommand_ClipboardPaste);
  UpdateMenuItemHotkey(mnuTextDelete, cCommand_TextDeleteSelection);
  UpdateMenuItemHotkey(mnuTextSel, cCommand_SelectAll);
  UpdateMenuItemHotkey(mnuTextGotoDef, cmd_GotoDefinition);
  UpdateMenuItemHotkey(mnuTextOpenUrl, cmd_LinkAtPopup_Open);

  Ed:= CurrentEditor;
  if assigned(mnuTextCut) then mnuTextCut.Enabled:= not Ed.ModeReadOnly;
  if assigned(mnuTextPaste) then mnuTextPaste.Enabled:= not Ed.ModeReadOnly and Clipboard.HasFormat(CF_Text);
  if assigned(mnuTextDelete) then mnuTextDelete.Enabled:= not Ed.ModeReadOnly and Ed.Carets.IsSelection;
  if assigned(mnuTextUndo) then mnuTextUndo.Enabled:= not Ed.ModeReadOnly and (Ed.UndoCount>0);
  if assigned(mnuTextRedo) then mnuTextRedo.Enabled:= not Ed.ModeReadOnly and (Ed.RedoCount>0);
  if assigned(mnuTextOpenUrl) then mnuTextOpenUrl.Enabled:= EditorGetLinkAtScreenCoord(Ed, PopupText.PopupPoint)<>'';
end;


procedure TfmMain.DoDialogRestoreLexerStyles;
var
  Form: TfmLexerStylesRestore;
  An: TecSyntAnalyzer;
  i: integer;
begin
  Form:= TfmLexerStylesRestore.Create(nil);
  try
    DoLocalize_FormLexerRestoreStyles(Form);
    Form.StylesFilename:= GetAppPath(cFileLexerStylesBackup);

    if Form.ShowModal=mrOk then
    begin
      for i:= 0 to Form.List.Count-1 do
        if Form.List.Checked[i] then
        begin
          An:= AppManager.FindLexerByName(Form.List.Items[i]);
          if Assigned(An) then
          begin
            DoLoadLexerStylesFromFile(An, Form.StylesFilename);
            DoLexerExportFromLibToFile(An);
          end
          else
            MsgBox(msgCannotFindLexerInLibrary+' '+Form.List.Items[i], MB_OK);
        end;

      UpdateFrame;
    end;
  finally
    FreeAndNil(Form);
  end;
end;


procedure TfmMain.CharmapOnInsert(const AStr: string);
var
  Ed: TATSynEdit;
begin
  Ed:= CurrentEditor;
  if Ed.Carets.Count=0 then exit;
  Ed.DoCommand(cCommand_TextInsert, Utf8Decode(AStr));

  UpdateFrame(true);
  UpdateStatus;
end;


procedure TfmMain.DoDialogCharMap;
begin
  if fmCharmaps=nil then
  begin
    fmCharmaps:= TfmCharmaps.Create(Self);
    fmCharmaps.OnInsert:= @CharmapOnInsert;
    DoLocalize_FormCharmap(fmCharmaps);
  end;

  fmCharmaps.InitialStr:= Utf8Encode(Widestring(EditorGetCurrentChar(CurrentEditor)));
  fmCharmaps.Show;
end;

function TfmMain.DoOnConsoleInput(const Str: string): boolean;
begin
  Result:= DoPyEvent(CurrentEditor, cEventOnConsole,
    [SStringToPythonString(Str)]) <> cPyFalse;
end;

function TfmMain.DoOnConsolePrint(const Str: string): boolean;
begin
  Result:= DoPyEvent(CurrentEditor, cEventOnConsolePrint,
    [SStringToPythonString(Str)]) <> cPyFalse;
end;

function TfmMain.DoOnConsoleClear: boolean;
begin
  Result:= DoPyEvent(CurrentEditor, cEventOnConsolePrint,
    ['None']) <> cPyFalse;
end;

function TfmMain.DoOnConsoleNav(const Str: string): boolean;
begin
  Result:= DoPyEvent(CurrentEditor, cEventOnConsoleNav,
    [SStringToPythonString(Str)]) <> cPyFalse;
end;

function TfmMain.DoOnMacro(const Str: string): boolean;
begin
  Result:= DoPyEvent(CurrentEditor, cEventOnMacro,
    [SStringToPythonString(Str)]) <> cPyFalse;
end;


function TfmMain.DoSplitter_StringToId(const AStr: string): integer;
begin
  Result:= -1;
  if AStr='L' then exit(SPLITTER_SIDE);
  if AStr='B' then exit(SPLITTER_BOTTOM);
  if AStr='G1' then exit(SPLITTER_G1);
  if AStr='G2' then exit(SPLITTER_G2);
  if AStr='G3' then exit(SPLITTER_G3);
end;

procedure TfmMain.DoSplitter_GetInfo(const Id: integer;
  out BoolVert, BoolVisible: boolean; out NPos, NTotal: integer);
  //----
  procedure GetSp(Sp: TSplitter);
  begin
    BoolVert:= (Sp.Align=alLeft) or (Sp.Align=alRight);
    BoolVisible:= Sp.Visible;
    NPos:= Sp.GetSplitterPosition;
    if BoolVert then NTotal:= Sp.Parent.Width else NTotal:= Sp.Parent.Height;
  end;
  //----
begin
  BoolVert:= false;
  BoolVisible:= true;
  NPos:= 0;
  NTotal:= 0;

  case Id of
    SPLITTER_SIDE: GetSp(SplitterVert);
    SPLITTER_BOTTOM: GetSp(SplitterHorz);
    SPLITTER_G1: GetSp(Groups.Splitter1);
    SPLITTER_G2: GetSp(Groups.Splitter2);
    SPLITTER_G3: GetSp(Groups.Splitter3);
  end;
end;


procedure TfmMain.DoSplitter_SetInfo(const Id: integer; NPos: integer);
  //
  procedure SetSp(Sp: TSplitter);
  begin
    Sp.SetSplitterPosition(NPos);
    if Assigned(Sp.OnMoved) then
      Sp.OnMoved(Self);
  end;
  //
begin
  if NPos<0 then exit;
  case Id of
    SPLITTER_SIDE: SetSp(SplitterVert);
    SPLITTER_BOTTOM: SetSp(SplitterHorz);
    SPLITTER_G1: SetSp(Groups.Splitter1);
    SPLITTER_G2: SetSp(Groups.Splitter2);
    SPLITTER_G3: SetSp(Groups.Splitter3);
  end;
end;

procedure TfmMain.FrameLexerChange(Sender: TObject);
var
  Frame: TEditorFrame;
begin
  Frame:= (Sender as TComponent).Owner as TEditorFrame;

  DoOps_LoadOptionsLexerSpecific(Frame); //options override
  DoPyEvent(Frame.Editor, cEventOnLexer, []);
  DoOps_LoadKeymap; //keymap override

  UpdateMenuPlugins_Shortcuts;
end;


procedure TfmMain.DoToolbarClick(Sender: TObject);
var
  SData: string;
  NCmd: integer;
begin
  //str(int_command) or callback string
  SData:= (Sender as TATButton).DataString;
  NCmd:= StrToIntDef(SData, 0);

  if NCmd>0 then
    CurrentEditor.DoCommand(NCmd)
  else
    DoPyCallbackFromAPI(SData, []);

  UpdateFrame;
  UpdateStatus;
end;


function TfmMain.DoMenu_GetPyProps(mi: TMenuItem): PPyObject;
var
  NTag: PtrInt;
  NCommand: integer;
  SCommand, STagString: string;
  CmdObject: PPyObject;
begin
  NTag:= mi.Tag;
  if NTag<>0 then
  begin
    NCommand:= TAppMenuProps(NTag).CommandCode;
    SCommand:= TAppMenuProps(NTag).CommandString;
    STagString:= TAppMenuProps(NTag).TagString;
  end
  else
  begin
    NCommand:= 0;
    SCommand:= '';
    STagString:= '';
  end;

  with GetPythonEngine do
  begin
    if NCommand>0 then
      CmdObject:= PyInt_FromLong(NCommand)
    else
      CmdObject:= PyString_FromString(PChar(SCommand));

    Result:= Py_BuildValue('{sLsssisssssssOsOsOsOsO}',
      'id',
      Int64(PtrInt(mi)),
      'cap',
      PChar(mi.Caption),
      'cmd',
      NCommand,
      'hint',
      PChar(SCommand),
      'hotkey',
      PChar(ShortCutToText(mi.ShortCut)),
      'tag',
      PChar(STagString),
      'command',
      CmdObject,
      'checked',
      PyBool_FromLong(Ord(mi.Checked)),
      'radio',
      PyBool_FromLong(Ord(mi.RadioItem)),
      'en',
      PyBool_FromLong(Ord(mi.Enabled)),
      'vis',
      PyBool_FromLong(Ord(mi.Visible))
      );
  end;
end;


function TfmMain.DoMenu_PyEnum(const AMenuId: string): PPyObject;
var
  mi: TMenuItem;
  NLen, i: integer;
begin
  //this updates PopupText items tags
  PopupText.OnPopup(nil);

  with GetPythonEngine do
  begin
    mi:= Py_MenuItemFromId(AMenuId);
    if not Assigned(mi) then
      exit(ReturnNone);

    NLen:= mi.Count;
    Result:= PyList_New(NLen);
    if not Assigned(Result) then
      raise EPythonError.Create(msgPythonListError);

    for i:= 0 to NLen-1 do
      PyList_SetItem(Result, i,
        DoMenu_GetPyProps(mi.Items[i])
        );
  end;
end;


procedure TfmMain.DoMenuClear(const AMenuId: string);
var
  mi: TMenuItem;
begin
  mi:= Py_MenuItemFromId(AMenuId);
  if Assigned(mi) then
  begin
    mi.Clear;
    if AMenuId=PyMenuId_Top then
    begin
      mnuFileOpenSub:= nil;
      mnuFileEnc:= nil;
      mnuThemes:= nil;
      mnuThemesUI:= nil;
      mnuThemesSyntax:= nil;
      mnuLang:= nil;
      mnuPlugins:= nil;
      mnuOpPlugins:= nil;
      mnuLexers:= nil;
    end;
    if AMenuId=PyMenuId_TopOptions then
    begin
      mnuThemes:= nil;
      mnuThemesUI:= nil;
      mnuThemesSyntax:= nil;
      mnuLang:= nil;
    end;
    if AMenuId=PyMenuId_TopFile then
    begin
      mnuFileOpenSub:= nil;
    end;
    if AMenuId=PyMenuId_TopView then
    begin
      mnuLexers:= nil;
    end;
    if AMenuId=PyMenuId_Text then
    begin
      mnuTextCopy:= nil;
      mnuTextCut:= nil;
      mnuTextDelete:= nil;
      mnuTextPaste:= nil;
      mnuTextUndo:= nil;
      mnuTextRedo:= nil;
      mnuTextSel:= nil;
      mnuTextGotoDef:= nil;
      mnuTextOpenUrl:= nil;
    end;
  end;
end;


function TfmMain.DoMenuAdd_Params(const AMenuId, AMenuCmd, AMenuCaption,
  AMenuHotkey, AMenuTagString: string; AIndex: integer): string;
var
  mi, miMain: TMenuItem;
  Num: integer;
begin
  Result:= '';
  miMain:= Py_MenuItemFromId(AMenuId);
  if Assigned(miMain) and (AMenuCaption<>'') then
  begin
    mi:= TMenuItem.Create(Self);
    mi.Caption:= AMenuCaption;
    mi.Tag:= PtrInt(TAppMenuProps.Create);
    TAppMenuProps(mi.Tag).TagString:= AMenuTagString;

    Num:= StrToIntDef(AMenuCmd, 0); //command code
    if Num>0 then
    begin
      UpdateMenuItemHotkey(mi, Num);
      UpdateMenuItemAltObject(mi, Num);
    end
    else
    if AMenuCmd='_recents' then
    begin
      mnuFileOpenSub:= mi;
      UpdateMenuRecent(nil);
    end
    else
    if AMenuCmd='_themes-ui' then
    begin
      mnuThemesUI:= mi;
      UpdateMenuThemes(true);
    end
    else
    if AMenuCmd='_themes-syntax' then
    begin
      mnuThemesSyntax:= mi;
      UpdateMenuThemes(false);
    end
    else
    if AMenuCmd='_langs' then
    begin
      mnuLang:= mi;
      UpdateMenuLangs(mi);
    end
    else
    if AMenuCmd='_plugins' then
    begin
      mnuPlugins:= mi;
      TAppMenuProps(mi.Tag).CommandString:= 'plugins';
      UpdateMenuPlugins;
    end
    else
    if AMenuCmd='_lexers' then
    begin
      mnuLexers:= mi;
      UpdateMenuLexers;
    end
    else
    if AMenuCmd='_oplugins' then
    begin
      mnuOpPlugins:= mi;
      UpdateMenuPlugins;
    end
    else
    if AMenuCmd='_enc' then
    begin
      mnuFileEnc:= mi;
      UpdateMenuEnc(mi);
    end
    else
    begin
      TAppMenuProps(mi.Tag).CommandCode:= -1;
      TAppMenuProps(mi.Tag).CommandString:= AMenuCmd;
      if (AMenuCmd<>'0') and (AMenuCmd<>'') then
        mi.OnClick:= @MenuMainClick;
    end;

    if AMenuHotkey<>'' then
      mi.ShortCut:= TextToShortCut(AMenuHotkey);

    if AIndex>=0 then
      miMain.Insert(AIndex, mi)
    else
      miMain.Add(mi);

    Result:= IntToStr(PtrInt(mi));
  end;
end;

procedure TfmMain.DoFileNewMenu(Sender: TObject);
begin
  DoPyCommand('cuda_new_file', 'menu', []);
end;

procedure TfmMain.DoCommandsMsgStatus(Sender: TObject; const ARes: string);
begin
  MsgStatus(ARes);
end;

function TfmMain.IsLexerMatches(const ANameList: string): boolean;
begin
  Result:= IsLexerListed(CurrentFrame.LexerName, ANameList);
end;

function TfmMain.LiteLexer_GetStyleHash(Sender: TObject; const AStyleName: string): integer;
var
  st: TecSyntaxFormat;
  i: integer;
begin
  Result:= -1;
  for i:= 0 to AppTheme.Styles.Count-1 do
  begin
    st:= TecSyntaxFormat(AppTheme.Styles[i]);
    if AStyleName=st.DisplayName then
      exit(i);
  end;
end;

procedure TfmMain.LiteLexer_ApplyStyle(Sender: TObject; AStyleHash: integer;
  var APart: TATLinePart);
var
  st: TecSyntaxFormat;
begin
  if AStyleHash<0 then exit;
  st:= TecSyntaxFormat(AppTheme.Styles[AStyleHash]);
  ApplyPartStyleFromEcontrolStyle(APart, st);
end;

procedure TfmMain.MenuTabsizeClick(Sender: TObject);
begin
  UpdateEditorTabsize((Sender as TComponent).Tag);
end;

procedure TfmMain.MsgLogDebug(const AText: string);
begin
  if UiOps.LogDebug then
    MsgLogToFilename(AText, FFileNameLogDebug, true);
end;

procedure TfmMain.MsgLogConsole(const AText: string);
begin
  if UiOps.LogConsole then
    MsgLogToFilename(AText, FFileNameLogConsole, false);

  if DoOnConsolePrint(AText) then
    if Assigned(fmConsole) then
      fmConsole.DoLogConsoleLine(AText);
end;


procedure TfmMain.MsgLogToFilename(const AText, AFilename: string; AWithTime: boolean);
var
  f: TextFile;
  S: string;
begin
  AssignFile(f, AFileName);
  {$I-}
  Append(f);
  if IOResult<>0 then
    Rewrite(f);
  S:= AText;
  if AWithTime then
    S:= FormatDateTime('[MM.DD hh:nn] ', Now) + S;
  Writeln(f, S);
  CloseFile(f);
  {$I+}
end;


procedure TfmMain.DoOnDeleteLexer(Sender: TObject; const ALexerName: string);
var
  Frame: TEditorFrame;
  i: integer;
begin
  for i:= 0 to FrameCount-1 do
  begin
    Frame:= Frames[i];
    if Frame.LexerName=ALexerName then
      Frame.Lexer:= nil;
  end;
end;


function TfmMain.GetFloatSide: boolean;
begin
  Result:= Assigned(FFormFloatSide) and
    (PanelLeft.Parent=FFormFloatSide);
end;

procedure TfmMain.SetFloatSide(AValue: boolean);
begin
  if GetFloatSide=AValue then exit;

  if not Assigned(FFormFloatSide) then
  begin
    FFormFloatSide:= TForm.CreateNew(Self);
    FFormFloatSide.Position:= poDesigned;
    FFormFloatSide.BoundsRect:= FBoundsFloatSide;
    FFormFloatSide.BorderIcons:= [biSystemMenu, biMaximize];
    FFormFloatSide.ShowInTaskBar:= stNever;
    FFormFloatSide.OnClose:= @FormFloatSideOnClose;
  end;

  PanelLeftTitle.Visible:= not AValue;
  FFormFloatSide.Visible:= AValue;
  FFormFloatSide.Caption:= FLastSidebarPanel + ' - ' + msgTitle;

  if AValue then
  begin
    PanelLeft.Parent:= FFormFloatSide;
    PanelLeft.Align:= alClient;
    PanelLeft.Show;
    SplitterVert.Hide;
  end
  else
  begin
    PanelLeft.Align:= alLeft;
    PanelLeft.Parent:= PanelMain;
    SplitterVert.Visible:= PanelLeft.Visible;
    SplitterVert.Left:= PanelLeft.Width;
  end
end;

procedure TfmMain.SetShowFloatGroup1(AValue: boolean);
begin
  if GetShowFloatGroup1<>AValue then
  begin
    InitFloatGroups;
    FFormFloatGroups1.Visible:= AValue;
  end;
end;

procedure TfmMain.SetShowFloatGroup2(AValue: boolean);
begin
  if GetShowFloatGroup2<>AValue then
  begin
    InitFloatGroups;
    FFormFloatGroups2.Visible:= AValue;
  end;
end;

procedure TfmMain.SetShowFloatGroup3(AValue: boolean);
begin
  if GetShowFloatGroup3<>AValue then
  begin
    InitFloatGroups;
    FFormFloatGroups3.Visible:= AValue;
  end;
end;


function TfmMain.GetFloatBottom: boolean;
begin
  Result:= Assigned(FFormFloatBottom) and
    (PanelBottom.Parent=FFormFloatBottom);
end;

procedure TfmMain.SetFloatBottom(AValue: boolean);
begin
  if GetFloatBottom=AValue then exit;

  if not Assigned(FFormFloatBottom) then
  begin
    FFormFloatBottom:= TForm.CreateNew(Self);
    FFormFloatBottom.Position:= poDesigned;
    FFormFloatBottom.BoundsRect:= FBoundsFloatBottom;
    FFormFloatBottom.BorderIcons:= [biSystemMenu, biMaximize];
    FFormFloatBottom.ShowInTaskBar:= stNever;
    FFormFloatBottom.OnClose:= @FormFloatBottomOnClose;
  end;

  FFormFloatBottom.Visible:= AValue;
  FFormFloatBottom.Caption:= FLastBottomPanel + ' - ' + msgTitle;

  if AValue then
  begin
    PanelBottom.Parent:= FFormFloatBottom;
    PanelBottom.Align:= alClient;
    PanelBottom.Show;
    SplitterHorz.Hide;
  end
  else
  begin
    PanelBottom.Align:= alBottom;
    PanelBottom.Parent:= PanelAll;
    SplitterHorz.Visible:= PanelBottom.Visible;
    SplitterHorz.Top:= PanelBottom.Top-8;
  end
end;


procedure TfmMain.FormFloatBottomOnClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  UpdateMenuItemChecked(mnuViewBottom, mnuViewBottom_Alt, false);
end;

procedure TfmMain.FormFloatGroups1_OnEmpty(Sender: TObject);
begin
  ShowFloatGroup1:= false;
end;

procedure TfmMain.FormFloatGroups2_OnEmpty(Sender: TObject);
begin
  ShowFloatGroup2:= false;
end;

procedure TfmMain.FormFloatGroups3_OnEmpty(Sender: TObject);
begin
  ShowFloatGroup3:= false;
end;

procedure TfmMain.FormFloatSideOnClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  UpdateMenuItemChecked(mnuViewSide, mnuViewSide_Alt, false);
end;

procedure TfmMain.FormFloatGroups1_OnClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  GroupsF1.MoveTabsFromGroupToAnother(
    GroupsF1.Pages1,
    Groups.Pages1
    );
end;

procedure TfmMain.FormFloatGroups2_OnClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  GroupsF2.MoveTabsFromGroupToAnother(
    GroupsF2.Pages1,
    Groups.Pages1
    );
end;

procedure TfmMain.FormFloatGroups3_OnClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  GroupsF3.MoveTabsFromGroupToAnother(
    GroupsF3.Pages1,
    Groups.Pages1
    );
end;

function TfmMain.GetFloatGroups: boolean;
begin
  Result:= Assigned(FFormFloatGroups1);
end;

function TfmMain.GetShowFloatGroup1: boolean;
begin
  Result:= Assigned(FFormFloatGroups1) and FFormFloatGroups1.Visible;
end;

function TfmMain.GetShowFloatGroup2: boolean;
begin
  Result:= Assigned(FFormFloatGroups2) and FFormFloatGroups2.Visible;
end;

function TfmMain.GetShowFloatGroup3: boolean;
begin
  Result:= Assigned(FFormFloatGroups3) and FFormFloatGroups3.Visible;
end;


procedure TfmMain.InitFloatGroup(var F: TForm; var G: TATGroups;
  ATag: integer;
  const ARect: TRect;
  AOnClose: TCloseEvent;
  AOnGroupEmpty: TNotifyEvent);
begin
  if not Assigned(F) then
  begin
    F:= TForm.CreateNew(Self);
    F.Hide;
    F.Position:= poDesigned;
    F.BoundsRect:= ARect;
    F.BorderIcons:= [biSystemMenu, biMaximize];
    F.OnClose:= AOnClose;
    F.Caption:= msgTitle + Format(' [f%d]', [ATag]);

    if UiOps.FloatGroupsInTaskbar then
      F.ShowInTaskBar:= stAlways
    else
      F.ShowInTaskBar:= stNever;

    G:= TATGroups.Create(Self);
    G.Pages1.EnabledEmpty:= true;
    G.Tag:= ATag;
    G.Parent:= F;
    G.Align:= alClient;
    G.Mode:= gmOne;

    G.OnTabFocus:= @DoOnTabFocus;
    G.OnTabAdd:= @DoOnTabAdd;
    G.OnTabClose:= @DoOnTabClose;
    G.OnTabMove:= @DoOnTabMove;
    G.OnTabPopup:= @DoOnTabPopup;
    G.OnTabOver:= @DoOnTabOver;
    G.OnEmpty:= AOnGroupEmpty;

    DoApplyThemeToGroups(G);
    DoApplyUiOpsToGroups(G);
  end;
end;

procedure TfmMain.InitFloatGroups;
begin
  InitFloatGroup(FFormFloatGroups1, GroupsF1, 1, FBoundsFloatGroups1,
    @FormFloatGroups1_OnClose,
    @FormFloatGroups1_OnEmpty);

  InitFloatGroup(FFormFloatGroups2, GroupsF2, 2, FBoundsFloatGroups2,
    @FormFloatGroups2_OnClose,
    @FormFloatGroups2_OnEmpty);

  InitFloatGroup(FFormFloatGroups3, GroupsF3, 3, FBoundsFloatGroups3,
    @FormFloatGroups3_OnClose,
    @FormFloatGroups3_OnEmpty);
end;

//----------------------------
{$I formmain_loadsave.inc}
{$I formmain_updates_proc.inc}
{$I formmain_translation.inc}
{$I formmain_frame_proc.inc}
{$I formmain_tab_proc.inc}
{$I formmain_find.inc}
{$I formmain_cmd.inc}
{$I formmain_themes.inc}
{$I formmain_sidepanel.inc}
{$I formmain_bottompanel.inc}
{$I formmain_commandline.inc}


end.

