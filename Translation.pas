unit Translation;

interface

uses WinAPI.Windows;

const
   EN_US = 'English';
   RU_RU = 'Русский';
   RO_RO = 'Română';

   // MainForm
   //---------------------------------------------------------------------------
   GLOBAL_LANG = 'GLOBAL_LANG';
   GLOBAL_HINT_CAPT_BTN1 = 'GLOBAL_HINT_CAPT_BTN1';
   GLOBAL_CPTN_MENUITEM_Main_N1 = 'GLOBAL_CPTN_MENUITEM_Main_N1';
   GLOBAL_CPTN_MENUITEM_Main_N2 = 'GLOBAL_CPTN_MENUITEM_Main_N2';
   GLOBAL_CPTN_MENUITEM_Main_N5 = 'GLOBAL_CPTN_MENUITEM_Main_N5';
   GLOBAL_HINT_IMG_MainImg = 'GLOBAL_HINT_IMG_MainImg';
   GLOBAL_HINT_IMG_LogImg = 'GLOBAL_HINT_IMG_LogImg';
   GLOBAL_HINT_IMG_TimerImg = 'GLOBAL_HINT_IMG_TimerImg';
   GLOBAL_HINT_IMG_FavImg = 'GLOBAL_HINT_IMG_FavImg';
   GLOBAL_CPTN_CHKBOX_CHKBOX1 = 'GLOBAL_CPTN_CHKBOX_CHKBOX1';
   GLOBAL_CPTN_CHKBOX_CHKBOX2 = 'GLOBAL_CPTN_CHKBOX_CHKBOX2';
   GLOBAL_CPTN_CHKBOX_CHKBOX3 = 'GLOBAL_CPTN_CHKBOX_CHKBOX3';
   GLOBAL_CPTN_GRPBOX_GrpBox1 = 'GLOBAL_CPTN_GRPBOX_GrpBox1';
   GLOBAL_CPTN_COMBOBOX_PosBox1 = 'GLOBAL_CPTN_COMBOBOX_PosBox1';
   GLOBAL_ACTION_BTN_BTN1 = 'GLOBAL_ACTION_BTN_BTN1';
   GLOBAL_CPTN_LBL_LBL1 = 'GLOBAL_CPTN_LBL_LBL1';
   GLOBAL_HINT_BTN_BTN2 = 'GLOBAL_HINT_BTN_BTN2';
   GLOBAL_HINT_BTN_BTN3 = 'GLOBAL_HINT_BTN_BTN3';
   GLOBAL_CPTN_LBL_LBL2 = 'GLOBAL_CPTN_LBL_LBL2';
   GLOBAL_HINT_BTN_BTN4 = 'GLOBAL_HINT_BTN_BTN4';
   GLOBAL_CPTN_GRPBOX_GrpBox2 = 'GLOBAL_CPTN_GRPBOX_GrpBox2';
   GLOBAL_HINT_BTN_BTN5 = 'GLOBAL_HINT_BTN_BTN5';
   GLOBAL_CPTN_RADGRP_RADGrp1 = 'GLOBAL_CPTN_RADGRP_RADGrp1';
   GLOBAL_TEXT_RADGRP_RADGrp1 = 'GLOBAL_TEXT_RADGRP_RADGrp1';
   GLOBAL_CPTN_CHKBOX_CHKBOX4 = 'GLOBAL_CPTN_CHKBOX_CHKBOX4';
   GLOBAL_CPTN_LBL_LBL3 = 'GLOBAL_CPTN_LBL_LBL3';
   GLOBAL_HINT_BTN_BTN6 = 'GLOBAL_HINT_BTN_BTN6';
   GLOBAL_CPTN_LBL_LBL4 = 'GLOBAL_CPTN_LBL_LBL4';
   GLOBAL_CPTN_LBL_LBL5 = 'GLOBAL_CPTN_LBL_LBL5';
   GLOBAL_HINT_LBL_LBL5 = 'GLOBAL_HINT_LBL_LBL5';
   GLOBAL_CPTN_GRPBOX_GrpBox3 = 'GLOBAL_CPTN_GRPBOX_GrpBox3';
   GLOBAL_CPTN_CHKBOX_CHKBOX5 = 'GLOBAL_CPTN_CHKBOX_CHKBOX5';
   GLOBAL_CPTN_GRPBOX_GrpBox4 = 'GLOBAL_CPTN_GRPBOX_GrpBox4';
   GLOBAL_CPTN_CHKBOX_CHKBOX6 = 'GLOBAL_CPTN_CHKBOX_CHKBOX6';
   GLOBAL_TEXT_RADGRP_RADGrp2 = 'GLOBAL_TEXT_RADGRP_RADGrp2';
   GLOBAL_CPTN_GRPBOX_GrpBox5 = 'GLOBAL_CPTN_GRPBOX_GrpBox5';
   GLOBAL_HINT_GRPBOX_GrpBox5 = 'GLOBAL_HINT_GRPBOX_GrpBox5';
   GLOBAL_CPTN_CHKBOX_CHKBOX7 = 'GLOBAL_CPTN_CHKBOX_CHKBOX7';
   GLOBAL_HINT_CHKBOX_CHKBOX7 = 'GLOBAL_HINT_CHKBOX_CHKBOX7';
   GLOBAL_CPTN_CHKBOX_CHKBOX8 = 'GLOBAL_CPTN_CHKBOX_CHKBOX8';
   GLOBAL_TEXT_MSG1 = 'GLOBAL_TEXT_MSG1';
   GLOBAL_TEXT_MSG2 = 'GLOBAL_TEXT_MSG2';
   GLOBAL_CPTN_BTN_BTN10 = 'GLOBAL_CPTN_BTN_BTN10';
   // HotKeyChanger
   //---------------------------------------------------------------------------
   HOTKEYCHANGER_CPTN = 'HOTKEYCHANGER_CPTN';
   HOTKEYCHANGER_CPTN_BTN_BTN1 = 'HOTKEYCHANGER_CPTN_BTN_BTN1';
   HOTKEYCHANGER_CPTN_BTN_BTN2 = 'HOTKEYCHANGER_CPTN_BTN_BTN2';
   HOTKEYCHANGER_CPTN_BTN_BTN3 = 'HOTKEYCHANGER_CPTN_BTN_BTN3';
   // HelpForm
   //---------------------------------------------------------------------------
   HELP_CPTN_PAGECTRL_TAB1 = 'HELP_CPTN_PAGECTRL_TAB1';
   HELP_CPTN_PAGECTRL_TAB2 = 'HELP_CPTN_PAGECTRL_TAB2';
   HELPFORM_TEXT_MEMO1 = 'HELPFORM_MEMO1';
   HELPFORM_TEXT_LSTVIEW_COL1 = 'HELPFORM_TEXT_LSTVIEW_COL1';
   HELPFORM_TEXT_LSTVIEW_HEAD1 = 'HELPFORM_TEXT_LSTVIEW_HEAD1';
   HELPFORM_TEXT_LSTVIEW_ITEM1 = 'HELPFORM_TEXT_LSTVIEW_ITEM1';
   HELPFORM_TEXT_LSTVIEW_ITEM2 = 'HELPFORM_TEXT_LSTVIEW_ITEM2';
   HELPFORM_TEXT_LSTVIEW_ITEM6 = 'HELPFORM_TEXT_LSTVIEW_ITEM6';
   // FavoritesForm
   //---------------------------------------------------------------------------
   LNK_CPTN_MENUITEM_GEN_N1 = 'LNK_CPTN_MENUITEM_GEN_N1';
   LNK_CPTN_MENUITEM_GEN_N2 = 'LNK_CPTN_MENUITEM_GEN_N2';
   LNK_CPTN_MENUITEM_GEN_N3 = 'LNK_CPTN_MENUITEM_GEN_N3';
   LNK_CPTN_MENUITEM_GEN_N4 = 'LNK_CPTN_MENUITEM_GEN_N4';
   LNK_CPTN_MENUITEM_GEN_N5 = 'LNK_CPTN_MENUITEM_GEN_N5';
   LNK_CPTN_MENUITEM_LST_N1 = 'LNK_CPTN_MENUITEM_LST_N1';
   LNK_CPTN_MENUITEM_LST_N2 = 'LNK_CPTN_MENUITEM_LST_N2';
   LNK_CPTN_MENUITEM_LST_N3 = 'LNK_CPTN_MENUITEM_LST_N3';
   LNK_CPTN_MENUITEM_LST_N4 = 'LNK_CPTN_MENUITEM_LST_N4';
   LNK_CPTN_MENUITEM_LST_N5 = 'LNK_CPTN_MENUITEM_LST_N5';
   LNK_CPTN_MENUITEM_LST_N6 = 'LNK_CPTN_MENUITEM_LST_N6';
   LNK_CPTN_MENUITEM_LST_N7 = 'LNK_CPTN_MENUITEM_LST_N7';
   LNK_CPTN_MENUITEM_LST_N8 = 'LNK_CPTN_MENUITEM_LST_N8';
   LNK_CPTN_MENUITEM_LST_N9 = 'LNK_CPTN_MENUITEM_LST_N9';
   LNK_CPTN_MENUITEM_LST_N10 = 'LNK_CPTN_MENUITEM_LST_N10';
   LNK_CPTN_MENUITEM_LST_N11 = 'LNK_CPTN_MENUITEM_LST_N11';
   LNK_CPTN_MENUITEM_LST_N12 = 'LNK_CPTN_MENUITEM_LST_N12';
   LNK_CPTN_MENUITEM_LST_N13 = 'LNK_CPTN_MENUITEM_LST_N13';
   LNK_CPTN_MENUITEM_LST_SMALL = 'LNK_CPTN_MENUITEM_LST_SMALL';
   LNK_CPTN_MENUITEM_LST_Normal = 'LNK_CPTN_MENUITEM_LST_Normal';
   LNK_CPTN_MENUITEM_LST_ExtraLarge = 'LNK_CPTN_MENUITEM_LST_ExtraLarge';
   LNK_CPTN_MENUITEM_LST_Jumbo = 'LNK_CPTN_MENUITEM_LST_Jumbo';
   LNK_CPTN_MENUITEM_LST_N14 = 'LNK_CPTN_MENUITEM_LST_N14';
   LNK_CPTN_MENUITEM_LST_ICON = 'LNK_CPTN_MENUITEM_LST_ICON';
   LNK_CPTN_MENUITEM_LST_TILE = 'LNK_CPTN_MENUITEM_LST_TILE';
   LNK_CPTN_MENUITEM_LST_N15 = 'LNK_CPTN_MENUITEM_LST_N15';
   LNK_GLOBAL_TEXT_MSG1 = 'LNK_GLOBAL_TEXT_MSG1';
   LNK_GLOBAL_TEXT_MSG2 = 'LNK_GLOBAL_TEXT_MSG2';
   LNK_GLOBAL_TEXT_MSG3 = 'LNK_GLOBAL_TEXT_MSG3';
   LNK_GLOBAL_TEXT_MSG4 = 'LNK_GLOBAL_TEXT_MSG4';
   LNK_GLOBAL_TEXT_MSG5 = 'LNK_GLOBAL_TEXT_MSG5';
   LNK_GLOBAL_TEXT_MSG6 = 'LNK_GLOBAL_TEXT_MSG6';
   LNK_GLOBAL_TEXT_MSG7 = 'LNK_GLOBAL_TEXT_MSG7';
   LNK_GLOBAL_TEXT_MSG8 = 'LNK_GLOBAL_TEXT_MSG8';
   LNK_GLOBAL_TEXT_MSG9 = 'LNK_GLOBAL_TEXT_MSG9';
   LNK_GLOBAL_TEXT_MSG10 = 'LNK_GLOBAL_TEXT_MSG10';
   LNK_HINT_BTN_BTN1 = 'LNK_HINT_BTN_BTN1';
   LNK_HINT_BTN_BTN2 = 'LNK_HINT_BTN_BTN2';
   LNK_HINT_SPDBTN_BTN2 = 'LNK_HINT_BTN_SPDBTN2';
   // LNK_Utils
   //---------------------------------------------------------------------------
   LNK_UTILS_GLOBAL_TEXT_MSG1 = 'LNK_UTILS_GLOBAL_TEXT_MSG1';
   LNK_UTILS_GLOBAL_TEXT_MSG2 = 'LNK_UTILS_GLOBAL_TEXT_MSG2';
   LNK_UTILS_GLOBAL_TEXT_MSG3 = 'LNK_UTILS_GLOBAL_TEXT_MSG3';
   LNK_UTILS_GLOBAL_TEXT_MSG4 = 'LNK_UTILS_GLOBAL_TEXT_MSG4';
   LNK_UTILS_GLOBAL_TEXT_MSG5 = 'LNK_UTILS_GLOBAL_TEXT_MSG5';
   LNK_UTILS_GLOBAL_TEXT_MSG6 = 'LNK_UTILS_GLOBAL_TEXT_MSG6';
   LNK_UTILS_GLOBAL_TEXT_MSG7 = 'LNK_UTILS_GLOBAL_TEXT_MSG7';
   LNK_UTILS_GLOBAL_TEXT_MSG8 = 'LNK_UTILS_GLOBAL_TEXT_MSG8';
   LNK_UTILS_GLOBAL_TEXT_MSG9 = 'LNK_UTILS_GLOBAL_TEXT_MSG9';
   LNK_UTILS_GLOBAL_TEXT_MSG10 = 'LNK_UTILS_GLOBAL_TEXT_MSG10';
   LNK_UTILS_GLOBAL_TEXT_MSG11 = 'LNK_UTILS_GLOBAL_TEXT_MSG11';
   LNK_UTILS_GLOBAL_TEXT_MSG12 = 'LNK_UTILS_GLOBAL_TEXT_MSG12';
   LNK_UTILS_GLOBAL_TEXT_MSG13 = 'LNK_UTILS_GLOBAL_TEXT_MSG13';
   LNK_UTILS_GLOBAL_TEXT_MSG14 = 'LNK_UTILS_GLOBAL_TEXT_MSG14';
   // ProcessesForm
   //---------------------------------------------------------------------------
   PROC_CPTN = 'PROC_CPTN';
   PROC_CPTN_BTN_BTN1 = 'PROC_CPTN_BTN_BTN1';
   PROC_CPTN_BTN_BTN2 = 'PROC_CPTN_BTN_BTN2';
   PROC_CPTN_BTN_BTN2_1 = 'PROC_CPTN_BTN_BTN2_1';
   // LNK_Properties
   //---------------------------------------------------------------------------
   LNKPROP_CPTN_LBLEDIT5 = 'LNKPROP_CPTN_LBLEDIT5';
   PROC_HINT_BTN_BTN1 = 'PROC_HINT_BTN_BTN1';
   PROC_GLOBAL_TEXT_MSG1 = 'PROC_GLOBAL_TEXT_MSG1';
   // TimerForm
   //---------------------------------------------------------------------------
   Timer_CPTN_GRPBOX_GrpBox1 = 'Timer_CPTN_GRPBOX_GrpBox1';
   Timer_TEXT_COMBO_ComboBox1 = 'Timer_TEXT_COMBO_ComboBox1';
   Timer_CPTN_RADBTN_RADBTN1 = 'Timer_CPTN_RADBTN_RADBTN1';
   Timer_TEXT_COMBO_ComboBox2 = 'Timer_TEXT_COMBO_ComboBox2';
   Timer_CPTN_LBL_LBL2 = 'Timer_CPTN_LBL_LBL2';
   Timer_CPTN_RADBTN_RADBTN2 = 'Timer_CPTN_RADBTN_RADBTN2';
   Timer_CPTN_LBL_LBL3 = 'Timer_CPTN_LBL_LBL3';
   Timer_CPTN_CHKBOX_CHKBOX1 = 'Timer_CPTN_CHKBOX_CHKBOX1';
   Timer_CPTN_CHKBOX_CHKBOX2 = 'Timer_CPTN_CHKBOX_CHKBOX2';
   Timer_CPTN_LBL_LBL4 = 'Timer_CPTN_LBL_LBL4';
   Timer_CPTN_BTN_BTN1 = 'Timer_CPTN_BTN_BTN1';
   Timer_CPTN_BTN_BTN1_2 = 'Timer_CPTN_BTN_BTN1_2';
   Timer_GLOBAL_TEXT_MSG1 = 'Timer_GLOBAL_TEXT_MSG1';
   Timer_GLOBAL_TEXT_MSG2 = 'Timer_GLOBAL_TEXT_MSG2';
   Timer_GLOBAL_TEXT_MSG3 = 'Timer_GLOBAL_TEXT_MSG3';
   Timer_GLOBAL_TEXT_MSG4 = 'Timer_GLOBAL_TEXT_MSG4';
   Timer_GLOBAL_TEXT_MSG5 = 'Timer_GLOBAL_TEXT_MSG5';
   Timer_GLOBAL_TEXT_MSG6 = 'Timer_GLOBAL_TEXT_MSG6';

function _( const StringID : String; aLanguageID : String = EN_US ) : String;

implementation

function _( const StringID : String; aLanguageID : String = EN_US ) : String;
begin
if aLanguageID = EN_US then
 begin
  // MainForm
  //----------------------------------------------------------------------------
  if StringID  = GLOBAL_LANG then
     Result := 'English';
  if StringID  = GLOBAL_HINT_CAPT_BTN1 then
     Result := 'Hide';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N1 then
     Result := 'Help';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N2 then
     Result := 'Change hotKey';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N5 then
     Result := 'Language';
  if StringID  = GLOBAL_HINT_IMG_MainImg then
     Result := 'Main menu';
  if StringID  = GLOBAL_HINT_IMG_LogImg then
     Result := 'Read the log file';
  if StringID  = GLOBAL_HINT_IMG_TimerImg then
     Result := 'Timer';
  if StringID  = GLOBAL_HINT_IMG_FavImg then
     Result := 'Favorites';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX1 then
     Result := 'Start when I log on (with Admin privileges)';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX2 then
     Result := 'Enable the log file';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX3 then
     Result := 'Mute sound when hiding processes';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox1 then
     Result := 'Hide process using the mouse';
  if StringID  = GLOBAL_CPTN_COMBOBOX_PosBox1 then
     Result := 'none;left;right;top;bottom';
  if StringID  = GLOBAL_ACTION_BTN_BTN1 then
     Result := 'Hide all processes when the mouse is moved to the selected screen position';
  if StringID  = GLOBAL_CPTN_LBL_LBL1 then
     Result := 'Process list :';
  if StringID  = GLOBAL_HINT_BTN_BTN2 then
     Result := 'New tab';
  if StringID  = GLOBAL_HINT_BTN_BTN3 then
     Result := 'Remove tab';
  if StringID  = GLOBAL_CPTN_LBL_LBL2 then
     Result := 'Process Name :';
  if StringID  = GLOBAL_HINT_BTN_BTN4 then
     Result := 'Select from all running processes';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox2 then
     Result := 'HotKey';
  if StringID  = GLOBAL_HINT_BTN_BTN5 then
     Result := 'Click to change hotkey';
  if StringID  = GLOBAL_CPTN_RADGRP_RADGrp1 then
     Result := 'Process state';
  if StringID  = GLOBAL_TEXT_RADGRP_RADGrp1 then
     Result := 'Normal;Minimized';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX4 then
     Result := 'Do not open';
  if StringID  = GLOBAL_CPTN_LBL_LBL3 then
     Result := 'File location :';
  if StringID  = GLOBAL_HINT_BTN_BTN6 then
     Result := 'Select executable file';
  if StringID  = GLOBAL_CPTN_LBL_LBL4 then
     Result := 'Working dir :';
  if StringID  = GLOBAL_CPTN_LBL_LBL5 then
     Result := 'Click to show running process list';
  if StringID  = GLOBAL_HINT_LBL_LBL5 then
     Result := 'Click to show hidden or running process list';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox3 then
     Result := 'Task Managers';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX5 then
     Result := 'Terminate all running processes when launching an application from the list';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox4 then
     Result := 'Boss hotkey';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX6 then
     Result := 'Enabled';
  if StringID  = GLOBAL_TEXT_RADGRP_RADGrp2 then
     Result := 'Hide process;Kill process';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox5 then
     Result := 'Clear data (need Admin Privileges)';
  if StringID  = GLOBAL_HINT_GRPBOX_GrpBox5 then
     Result := '1. Clear data usage Ethernet (need Admin Privileges)'+#10+
                 '2. Delete data from the "Recent and Prefetch" folder (only what is launched from this application, including the program itself)'+#10+
                 '3. Delete data from registry (only what is launched from this application, including the program itself).';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX7 then
     Result := 'When starting Task Managers';
  if StringID  = GLOBAL_HINT_CHKBOX_CHKBOX7 then
     Result := 'It only works if the checkbox "Task Managers" is checked.';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX8 then
     Result := 'When the boss hotkey is pressed';
  if StringID  = GLOBAL_TEXT_MSG1 then
     Result := 'The log file does not exist.';
  if StringID  = GLOBAL_TEXT_MSG2 then
     Result := 'Are you sure you want to delete the selected tab?';
  if StringID  = GLOBAL_CPTN_BTN_BTN10 then
     Result := 'Save changes';
  // HotKeyChanger
  //----------------------------------------------------------------------------
  if StringID  = HOTKEYCHANGER_CPTN then
     Result := 'Change hotkey';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN1 then
     Result := 'Clear';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN2 then
     Result := 'Change';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN3 then
     Result := 'Cancel';
  // HelpForm
  //----------------------------------------------------------------------------
  if StringID  = HELP_CPTN_PAGECTRL_TAB1 then
     Result := 'About';
  if StringID  = HELP_CPTN_PAGECTRL_TAB2 then
     Result := 'Keyboard shortcuts';
  if StringID  = HELPFORM_TEXT_MEMO1 then
     Result := 'Anti Boss Agent is a portable open source application for Windows that can easily hide any window in the background with hotkey.;;'+
               'Features:;'+
               '* Run your selected process from file and hide with the same hotkey.;'+
               '* Hide all processes using your mouse.;'+
               '* Automatically terminate all running processes when Task Managers starts.;'+
               '* Clear history of all running processes from registry, special folders and network usage statistics.;'+
               '* Set a timer to shut down, reboot, etc. your PC.;'+
               '* Add your favorites apps, personal folders, system folders and apps in one form and in one click.;'+
               '* And many others features.;;'+
               'Run with parameters:;'+
               '-    Enabled timer "--enable".;'+
               '-    Force kill processes that don"t respond "--force".;'+
               '-    Ignore wake up "--ignore_wakeup".;'+
               '-    Poweroff "--POWEROFF".;'+
               '-    Shutdown "--SHUTDOWN".;'+
               '-    Reboot "--REBOOT".;'+
               '-    Logoff "--LOGOFF".;'+
               '-    Standby "--STANDBY".';
  if StringID  = HELPFORM_TEXT_LSTVIEW_COL1 then
     Result := 'Action';
  if StringID  = HELPFORM_TEXT_LSTVIEW_HEAD1 then
     Result := 'Main form';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM1 then
     Result := 'Show or hide form';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM2 then
     Result := 'Clear history';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM6 then
     Result := 'Change tabs';
  // FavoritesForm
  //----------------------------------------------------------------------------
  if StringID  = LNK_CPTN_MENUITEM_GEN_N1 then
     Result := 'Show';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N2 then
     Result := 'Do not hide automatically';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N3 then
     Result := 'Hide after app open';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N4 then
     Result := 'Prevent moving off screen';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N5 then
     Result := 'Show tray icon';
  if StringID  = LNK_CPTN_MENUITEM_LST_N1 then
     Result := 'Open';
  if StringID  = LNK_CPTN_MENUITEM_LST_N2 then
     Result := 'Open location';
  if StringID  = LNK_CPTN_MENUITEM_LST_N3 then
     Result := 'Create a shortcut';
  if StringID  = LNK_CPTN_MENUITEM_LST_N4 then
     Result := 'Remove shortcut';
  if StringID  = LNK_CPTN_MENUITEM_LST_N5 then
     Result := 'Copy to';
  if StringID  = LNK_CPTN_MENUITEM_LST_N6 then
     Result := 'Move to';
  if StringID  = LNK_CPTN_MENUITEM_LST_N7 then
     Result := 'Add to process list';
  if StringID  = LNK_CPTN_MENUITEM_LST_N8 then
     Result := 'New tab';
  if StringID  = LNK_CPTN_MENUITEM_LST_N9 then
     Result := 'Delete tab';
  if StringID  = LNK_CPTN_MENUITEM_LST_N10 then
     Result := 'Import from system';
  if StringID  = LNK_CPTN_MENUITEM_LST_N11 then
     Result := 'Apps';
  if StringID  = LNK_CPTN_MENUITEM_LST_N12 then
     Result := 'Folders';
  if StringID  = LNK_CPTN_MENUITEM_LST_N13 then
     Result := 'Icons size';
  if StringID  = LNK_CPTN_MENUITEM_LST_SMALL then
     Result := 'Small';
  if StringID  = LNK_CPTN_MENUITEM_LST_Normal then
     Result := 'Normal';
  if StringID  = LNK_CPTN_MENUITEM_LST_ExtraLarge then
     Result := 'Large';
  if StringID  = LNK_CPTN_MENUITEM_LST_Jumbo then
     Result := 'Extra large';
  if StringID  = LNK_CPTN_MENUITEM_LST_N14 then
     Result := 'Icons style';
  if StringID  = LNK_CPTN_MENUITEM_LST_ICON then
     Result := 'Icon';
  if StringID  = LNK_CPTN_MENUITEM_LST_TILE then
     Result := 'Tile';
  if StringID  = LNK_CPTN_MENUITEM_LST_N15 then
     Result := 'Properties';
  if StringID  = LNK_GLOBAL_TEXT_MSG1 then
     Result := 'Select file or folder';
  if StringID  = LNK_GLOBAL_TEXT_MSG2 then
     Result := 'Do you really want to remove ';
  if StringID  = LNK_GLOBAL_TEXT_MSG3 then
     Result := 'Create new tab';
  if StringID  = LNK_GLOBAL_TEXT_MSG4 then
     Result := 'Name:';
  if StringID  = LNK_GLOBAL_TEXT_MSG5 then
     Result := 'A tab with this name already exists, please choose another name.';
  if StringID  = LNK_GLOBAL_TEXT_MSG6 then
     Result := 'Are you sure you want to delete the tab ';
  if StringID  = LNK_GLOBAL_TEXT_MSG7 then
     Result := 'This is not an executable file or it does not exist.';
  if StringID  = LNK_GLOBAL_TEXT_MSG8 then
     Result := 'A tab with this name already exists, please delete it and try again.';
  if StringID  = LNK_GLOBAL_TEXT_MSG9 then
     Result := 'System applications';
  if StringID  = LNK_GLOBAL_TEXT_MSG10 then
     Result := 'System folders';
  if StringID  = LNK_HINT_BTN_BTN1 then
     Result := 'My Computer';
  if StringID  = LNK_HINT_BTN_BTN2 then
     Result := 'Parameters';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG1 then
     Result := 'Recycle Bin';
  // LNK_Utils
  //----------------------------------------------------------------------------
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG1 then
     Result := ' free of ';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG2 then
     Result := 'Control Panel (category view)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG3 then
     Result := 'Control Panel (icons view)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG4 then
     Result := 'Control Panel (all tasks)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG5 then
     Result := 'Device Manager';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG6 then
     Result := 'System';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG7 then
     Result := 'Desktop';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG8 then
     Result := 'Documents';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG9 then
     Result := 'Downloads';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG10 then
     Result := 'Music';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG11 then
     Result := 'Pictures';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG12 then
     Result := 'Saved Games';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG13 then
     Result := 'Videos';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG14 then
     Result := 'Empty Recycle Bin';
  // ProcessesForm
  //----------------------------------------------------------------------------
  if StringID  = PROC_CPTN then
     Result := 'Select a process from the list';
  if StringID  = PROC_CPTN_BTN_BTN1 then
     Result := 'Refresh';
  if StringID  = PROC_CPTN_BTN_BTN2 then
     Result := 'Add';
  if StringID  = PROC_CPTN_BTN_BTN2_1 then
     Result := 'Kill process';
  // LNK_Properties
  //----------------------------------------------------------------------------
  if StringID  = LNKPROP_CPTN_LBLEDIT5 then
     Result := 'Icon location';
  if StringID  = PROC_HINT_BTN_BTN1 then
     Result := 'Click to change icon';
  if StringID  = PROC_GLOBAL_TEXT_MSG1 then
     Result := 'Select file';
  // TimerForm
  //----------------------------------------------------------------------------
  if StringID  = Timer_CPTN_GRPBOX_GrpBox1 then
     Result := 'Options';
  if StringID  = Timer_TEXT_COMBO_ComboBox1 then
     Result := 'PowerOff;Shutdown;Reboot;Logoff;StandBy';
  if StringID  = Timer_CPTN_RADBTN_RADBTN1 then
     Result := 'in';
  if StringID  = Timer_TEXT_COMBO_ComboBox2 then
     Result := 'minutes;hours';
  if StringID  = Timer_CPTN_LBL_LBL2 then
     Result := 'from now !';
  if StringID  = Timer_CPTN_RADBTN_RADBTN2 then
     Result := 'at';
  if StringID  = Timer_CPTN_LBL_LBL3 then
     Result := 'localtime !';
  if StringID  = Timer_CPTN_CHKBOX_CHKBOX1 then
     Result := 'and force end processes that don"t respond';
  if StringID  = Timer_CPTN_CHKBOX_CHKBOX2 then
     Result := 'disable wakeup events';
  if StringID  = Timer_CPTN_LBL_LBL4 then
     Result := 'The timer is disabled !';
  if StringID  = Timer_CPTN_BTN_BTN1 then
     Result := 'Enable timer';
  if StringID  = Timer_CPTN_BTN_BTN1_2 then
     Result := 'Stop timer';
  if StringID  = Timer_GLOBAL_TEXT_MSG1 then
     Result := 'Timer not active';
  if StringID  = Timer_GLOBAL_TEXT_MSG2 then
     Result := 'Missing is parameters ...';
  if StringID  = Timer_GLOBAL_TEXT_MSG3 then
     Result := 'Shutdown';
  if StringID  = Timer_GLOBAL_TEXT_MSG4 then
     Result := 'seconds ...';
  if StringID  = Timer_GLOBAL_TEXT_MSG5 then
     Result := 'Error ';
  if StringID  = Timer_GLOBAL_TEXT_MSG6 then
     Result := ' occured. All Timers stopped !';
  end else
if aLanguageID = RU_RU then
 begin
  // MainForm
  //----------------------------------------------------------------------------
  if StringID  = GLOBAL_LANG then
     Result := 'Русский';
  if StringID  = GLOBAL_HINT_CAPT_BTN1 then
     Result := 'Скрыть';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N1 then
     Result := 'Помощь';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N2 then
     Result := 'Изменить горячую клавишу';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N5 then
     Result := 'Язык';
  if StringID  = GLOBAL_HINT_IMG_MainImg then
     Result := 'Главное меню';
  if StringID  = GLOBAL_HINT_IMG_LogImg then
     Result := 'Прочитать файл журнала';
  if StringID  = GLOBAL_HINT_IMG_TimerImg then
     Result := 'Таймер';
  if StringID  = GLOBAL_HINT_IMG_FavImg then
     Result := 'Избранное';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX1 then
     Result := 'Запускать при входе в систему (с правами администратора)';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX2 then
     Result := 'Включить файл журнала';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX3 then
     Result := 'Отключить звук при скрытии процессов';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox1 then
     Result := 'Скрыть процесс с помощью мыши';
  if StringID  = GLOBAL_CPTN_COMBOBOX_PosBox1 then
     Result := 'нет;левый;право;сверху;cнизу';
  if StringID  = GLOBAL_ACTION_BTN_BTN1 then
     Result := 'Скрыть все процессы при перемещении мыши в выбранную позицию на экране';
  if StringID  = GLOBAL_CPTN_LBL_LBL1 then
     Result := 'Список процессов :';
  if StringID  = GLOBAL_HINT_BTN_BTN2 then
     Result := 'Новая вкладка';
  if StringID  = GLOBAL_HINT_BTN_BTN3 then
     Result := 'Удалить вкладку';
  if StringID  = GLOBAL_CPTN_LBL_LBL2 then
     Result := 'Имя процесса :';
  if StringID  = GLOBAL_HINT_BTN_BTN4 then
     Result := 'Выбрать из всех запущенных процессов';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox2 then
     Result := 'Горячая клавиша';
  if StringID  = GLOBAL_HINT_BTN_BTN5 then
     Result := 'Нажмите, чтобы изменить горячую клавишу';
  if StringID  = GLOBAL_CPTN_RADGRP_RADGrp1 then
     Result := 'Состояние процесса';
  if StringID  = GLOBAL_TEXT_RADGRP_RADGrp1 then
     Result := 'Нормальный;Свернут';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX4 then
     Result := 'Не открывать';
  if StringID  = GLOBAL_CPTN_LBL_LBL3 then
     Result := 'Расположение файла :';
  if StringID  = GLOBAL_HINT_BTN_BTN6 then
     Result := 'Выберите исполняемый файл';
  if StringID  = GLOBAL_CPTN_LBL_LBL4 then
     Result := 'Рабочий каталог :';
  if StringID  = GLOBAL_CPTN_LBL_LBL5 then
     Result := 'Нажмите чтобы отобразить список процессов';
  if StringID  = GLOBAL_HINT_LBL_LBL5 then
     Result := 'Нажмите, чтобы отобразить список скрытых или запущенных процессов';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox3 then
     Result := 'Диспетчеры задач';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX5 then
     Result := 'Завершить все работающие процессы при запуске приложения из списка';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox4 then
     Result := 'Горячая клавиша босса';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX6 then
     Result := 'Включено';
  if StringID  = GLOBAL_TEXT_RADGRP_RADGrp2 then
     Result := 'Скрыть процесс;Убить процесс';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox5 then
     Result := 'Очистить данные (требуются права администратора)';
  if StringID  = GLOBAL_HINT_GRPBOX_GrpBox5 then
     Result := '1. Очистить использование данных Ethernet (требуются права администратора)'+#10+
                '2. Удалить данные из папки «Recent and Prefetch» (только то, что запускается из этого приложения, включая саму программу)'+#10+
                '3. Удалить данные из реестра (только то, что запускается из этого приложения, включая саму программу).';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX7 then
     Result := 'При запуске диспетчеров задач';
  if StringID  = GLOBAL_HINT_CHKBOX_CHKBOX7 then
     Result := 'Работает только если стоит галочка у "Диспетчеры задач".';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX8 then
     Result := 'Когда нажимается горячая клавиша босса';
  if StringID  = GLOBAL_TEXT_MSG1 then
     Result := 'Файл журнала не существует.';
  if StringID  = GLOBAL_TEXT_MSG2 then
     Result := 'Вы уверены, что хотите удалить выбранную вкладку?';
  if StringID  = GLOBAL_CPTN_BTN_BTN10 then
     Result := 'Сохранять изменения';
  // HotKeyChanger
  //----------------------------------------------------------------------------
  if StringID  = HOTKEYCHANGER_CPTN then
     Result := 'Изменение горячей клавиши';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN1 then
     Result := 'Очистить';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN2 then
     Result := 'Изменить';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN3 then
     Result := 'Отмена';
  // HelpForm
  //----------------------------------------------------------------------------
  if StringID  = HELP_CPTN_PAGECTRL_TAB1 then
     Result := 'О программе';
  if StringID  = HELP_CPTN_PAGECTRL_TAB2 then
     Result := 'Сочетание клавиш';
  if StringID  = HELPFORM_TEXT_MEMO1 then
     Result := 'Anti Boss Agent — это портативное приложение с открытым исходным кодом для Windows, которое может легко скрыть любое окно в фоновом режиме с помощью горячей клавиши.;;'+
               'Особенности:;'+
               '* Запустите выбранный процесс из файла и скройте его с помощью той же горячей клавиши..;'+
               '* Скройте все процессы с помощью вашей мыши.;'+
               '* Автоматическое завершение всех запущенных процессов при запуске диспетчера задач.;'+
               '* Очистите историю всех запущенных процессов, из реестра, специальных папок и статистику использования сети.;'+
               '* Установите таймер для выключения, перезагрузки и т. д. вашего ПК.;'+
               '* Добавьте ваши любимые приложения, личные папки, системные папки и приложения в одной форме и одним щелчком мыши.;'+
               '* И многие другие особенности.;;'+
               'Запуск с параметрами:;'+
               '-    Включен таймер "--enable".;'+
               '-    Принудительно завершать процессы, которые не отвечают "--force".;'+
               '-    Игнорировать пробуждение "--ignore_wakeup".;'+
               '-    Выключить питание "--POWEROFF".;'+
               '-    Выключение "--SHUTDOWN".;'+
               '-    Перезагрузить "--REBOOT".;'+
               '-    Выйти "--LOGOFF".;'+
               '-    Режим ожидания "--STANDBY".';
  if StringID  = HELPFORM_TEXT_LSTVIEW_COL1 then
     Result := 'Действие';
  if StringID  = HELPFORM_TEXT_LSTVIEW_HEAD1 then
     Result := 'Главная форма';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM1 then
     Result := 'Показать или скрыть форму';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM2 then
     Result := 'Очистить историю';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM6 then
     Result := 'Изменить вкладки';
  // FavoritesForm
  //----------------------------------------------------------------------------
  if StringID  = LNK_CPTN_MENUITEM_GEN_N1 then
     Result := 'Показывать';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N2 then
     Result := 'Не скрывать автоматически';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N3 then
     Result := 'Скрыть после открития приложения';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N4 then
     Result := 'Запретить перемещение за пределы экрана';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N5 then
     Result := 'Показать значок в трее';
  if StringID  = LNK_CPTN_MENUITEM_LST_N1 then
     Result := 'Открыть';
  if StringID  = LNK_CPTN_MENUITEM_LST_N2 then
     Result := 'Открытое местоположение';
  if StringID  = LNK_CPTN_MENUITEM_LST_N3 then
     Result := 'Создать ярлык';
  if StringID  = LNK_CPTN_MENUITEM_LST_N4 then
     Result := 'Удалить ярлык';
  if StringID  = LNK_CPTN_MENUITEM_LST_N5 then
     Result := 'Копировать в';
  if StringID  = LNK_CPTN_MENUITEM_LST_N6 then
     Result := 'Переместить в';
  if StringID  = LNK_CPTN_MENUITEM_LST_N7 then
     Result := 'Добавить в список процессов';
  if StringID  = LNK_CPTN_MENUITEM_LST_N8 then
     Result := 'Новая вкладка';
  if StringID  = LNK_CPTN_MENUITEM_LST_N9 then
     Result := 'Удалить вкладку';
  if StringID  = LNK_CPTN_MENUITEM_LST_N10 then
     Result := 'Импорт из системы';
  if StringID  = LNK_CPTN_MENUITEM_LST_N11 then
     Result := 'Приложения';
  if StringID  = LNK_CPTN_MENUITEM_LST_N12 then
     Result := 'Папки';
  if StringID  = LNK_CPTN_MENUITEM_LST_N13 then
     Result := 'Размер иконок';
  if StringID  = LNK_CPTN_MENUITEM_LST_SMALL then
     Result := 'Мелькие';
  if StringID  = LNK_CPTN_MENUITEM_LST_Normal then
     Result := 'Обычные';
  if StringID  = LNK_CPTN_MENUITEM_LST_ExtraLarge then
     Result := 'Крупные';
  if StringID  = LNK_CPTN_MENUITEM_LST_Jumbo then
     Result := 'Огромные';
  if StringID  = LNK_CPTN_MENUITEM_LST_N14 then
     Result := 'Стиль иконок';
  if StringID  = LNK_CPTN_MENUITEM_LST_ICON then
     Result := 'Значки';
  if StringID  = LNK_CPTN_MENUITEM_LST_TILE then
     Result := 'Плитка';
  if StringID  = LNK_CPTN_MENUITEM_LST_N15 then
     Result := 'Свойства';
  if StringID  = LNK_GLOBAL_TEXT_MSG1 then
     Result := 'Выберите файл или папку';
  if StringID  = LNK_GLOBAL_TEXT_MSG2 then
     Result := 'Вы действительно хотите удалить ';
  if StringID  = LNK_GLOBAL_TEXT_MSG3 then
     Result := 'Создать новую вкладку';
  if StringID  = LNK_GLOBAL_TEXT_MSG4 then
     Result := 'Имя:';
  if StringID  = LNK_GLOBAL_TEXT_MSG5 then
     Result := 'Вкладка с таким названием уже существует, выберите другое название.';
  if StringID  = LNK_GLOBAL_TEXT_MSG6 then
     Result := 'Вы действительно хотите удалить вкладку ';
  if StringID  = LNK_GLOBAL_TEXT_MSG7 then
     Result := 'Файл не является исполняемым или не существует.';
  if StringID  = LNK_GLOBAL_TEXT_MSG8 then
     Result := 'Вкладка с таким названием уже существует, удалите его и повторите попытку.';
  if StringID  = LNK_GLOBAL_TEXT_MSG9 then
     Result := 'Системные приложения';
  if StringID  = LNK_GLOBAL_TEXT_MSG10 then
     Result := 'Системные папки';
  if StringID  = LNK_HINT_BTN_BTN1 then
     Result := 'Мой компьютер';
  if StringID  = LNK_HINT_BTN_BTN2 then
     Result := 'Параметры';
  if StringID  = LNK_HINT_SPDBTN_BTN2 then
     Result := 'Корзина';
  // LNK_Utils
  //----------------------------------------------------------------------------
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG1 then
     Result := ' свободно из ';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG2 then
     Result := 'Панель управления (вид по категориям)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG3 then
     Result := 'Панель управления (вид по иконкам)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG4 then
     Result := 'Панель управления (все задачи)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG5 then
     Result := 'Диспетчер устройств';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG6 then
     Result := 'Система';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG7 then
     Result := 'Рабочий стол';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG8 then
     Result := 'Документы';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG9 then
     Result := 'Загрузки';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG10 then
     Result := 'Музыка';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG11 then
     Result := 'Изображения';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG12 then
     Result := 'Сохраненные игры';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG13 then
     Result := 'Видео';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG14 then
     Result := 'Очистить корзину';
  // ProcessesForm
  //----------------------------------------------------------------------------
  if StringID  = PROC_CPTN then
     Result := 'Выберите процесс из списка';
  if StringID  = PROC_CPTN_BTN_BTN1 then
     Result := 'Обновить';
  if StringID  = PROC_CPTN_BTN_BTN2 then
     Result := 'Добавить';
  if StringID  = PROC_CPTN_BTN_BTN2_1 then
     Result := 'Убить процесс';
  // LNK_Properties
  //----------------------------------------------------------------------------
  if StringID  = LNKPROP_CPTN_LBLEDIT5 then
     Result := 'Расположение иконки';
  if StringID  = PROC_HINT_BTN_BTN1 then
     Result := 'Нажмите, чтобы изменить значок';
  if StringID  = PROC_GLOBAL_TEXT_MSG1 then
     Result := 'Выберите файл';
  // TimerForm
  //----------------------------------------------------------------------------
  if StringID  = Timer_CPTN_GRPBOX_GrpBox1 then
     Result := 'Опции';
  if StringID  = Timer_TEXT_COMBO_ComboBox1 then
     Result := 'Выкл. питание;Завершение;Перезагрузить;Выйти;Ожидание';
  if StringID  = Timer_CPTN_RADBTN_RADBTN1 then
     Result := 'в';
  if StringID  = Timer_TEXT_COMBO_ComboBox2 then
     Result := 'минуты;часы';
  if StringID  = Timer_CPTN_LBL_LBL2 then
     Result := 'отныне!';
  if StringID  = Timer_CPTN_RADBTN_RADBTN2 then
     Result := 'в';
  if StringID  = Timer_CPTN_LBL_LBL3 then
     Result := 'местное время!';
  if StringID  = Timer_CPTN_CHKBOX_CHKBOX1 then
     Result := 'принудительно завершить процессы';
  if StringID  = Timer_CPTN_CHKBOX_CHKBOX2 then
     Result := 'отключить пробуждение событий';
  if StringID  = Timer_CPTN_LBL_LBL4 then
     Result := 'Таймер отключён !';
  if StringID  = Timer_CPTN_BTN_BTN1 then
     Result := 'Включить таймер';
  if StringID  = Timer_CPTN_BTN_BTN1_2 then
     Result := 'Остановить таймер';
  if StringID  = Timer_GLOBAL_TEXT_MSG1 then
     Result := 'Таймер не активен';
  if StringID  = Timer_GLOBAL_TEXT_MSG2 then
     Result := 'Отсутствуют параметры ...';
  if StringID  = Timer_GLOBAL_TEXT_MSG3 then
     Result := 'Завершение';
  if StringID  = Timer_GLOBAL_TEXT_MSG4 then
     Result := 'секунды ...';
  if StringID  = Timer_GLOBAL_TEXT_MSG5 then
     Result := 'Ошибка ';
  if StringID  = Timer_GLOBAL_TEXT_MSG6 then
     Result := ' произошло. Все таймеры остановлены !';
  end else
if aLanguageID = RO_RO then
 begin
  // MainForm
  //----------------------------------------------------------------------------
  if StringID  = GLOBAL_LANG then
     Result := 'Română';
  if StringID  = GLOBAL_HINT_CAPT_BTN1 then
     Result := 'Ascunde';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N1 then
     Result := 'Ajutor';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N2 then
     Result := 'Schimbă tasta rapidă principală';
  if StringID  = GLOBAL_CPTN_MENUITEM_Main_N5 then
     Result := 'Limbă';
  if StringID  = GLOBAL_HINT_IMG_MainImg then
     Result := 'Meniul principal';
  if StringID  = GLOBAL_HINT_IMG_LogImg then
     Result := 'Citiți fișierul jurnal';
  if StringID  = GLOBAL_HINT_IMG_TimerImg then
     Result := 'Cronometru';
  if StringID  = GLOBAL_HINT_IMG_FavImg then
     Result := 'Preferate';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX1 then
     Result := 'Rulați la autentificare (cu drepturi de administrator)';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX2 then
     Result := 'Activati fișierul log';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX3 then
     Result := 'Dezactivați sunetul când ascundeți procesele';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox1 then
     Result := 'Ascundeți procesul folosind mouse-ul';
  if StringID  = GLOBAL_CPTN_COMBOBOX_PosBox1 then
     Result := 'nu;stânga;dreapta;sus;jos';
  if StringID  = GLOBAL_ACTION_BTN_BTN1 then
     Result := 'Ascundeți toate procesele când mutați mouse-ul într-o poziție selectată de pe ecran';
  if StringID  = GLOBAL_CPTN_LBL_LBL1 then
     Result := 'Lista de procese :';
  if StringID  = GLOBAL_HINT_BTN_BTN2 then
     Result := 'Filă nouă';
  if StringID  = GLOBAL_HINT_BTN_BTN3 then
     Result := 'Șterge fila';
  if StringID  = GLOBAL_CPTN_LBL_LBL2 then
     Result := 'Nume proces :';
  if StringID  = GLOBAL_HINT_BTN_BTN4 then
     Result := 'Selectați dintre toate procesele care rulează';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox2 then
     Result := 'Tasta rapidă';
  if StringID  = GLOBAL_HINT_BTN_BTN5 then
     Result := 'Faceți clic pentru a schimba tasta rapidă';
  if StringID  = GLOBAL_CPTN_RADGRP_RADGrp1 then
     Result := 'Starea procesului';
  if StringID  = GLOBAL_TEXT_RADGRP_RADGrp1 then
     Result := 'Normal;Minimizat';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX4 then
     Result := 'Nu deschide';
  if StringID  = GLOBAL_CPTN_LBL_LBL3 then
     Result := 'Locația fișierului :';
  if StringID  = GLOBAL_HINT_BTN_BTN6 then
     Result := 'Selectați fișierul executabil';
  if StringID  = GLOBAL_CPTN_LBL_LBL4 then
     Result := 'Director de lucru :';
  if StringID  = GLOBAL_CPTN_LBL_LBL5 then
     Result := 'Clic pentru a afișa lista de procese';
  if StringID  = GLOBAL_HINT_LBL_LBL5 then
     Result := 'Faceți clic pentru a afișa lista de procese ascunse sau care rulează';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox3 then
     Result := 'Manageri de activități';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX5 then
     Result := 'Opriți toate procesele care rulează la pornirea unei aplicații din listă';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox4 then
     Result := 'Tasta rapidă a șefului';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX6 then
     Result := 'Activat';
  if StringID  = GLOBAL_TEXT_RADGRP_RADGrp2 then
     Result := 'Ascundeți procesul;Ucideți procesul';
  if StringID  = GLOBAL_CPTN_GRPBOX_GrpBox5 then
     Result := 'Ștergeți datele (sunt necesare drepturi de administrator)';
  if StringID  = GLOBAL_HINT_GRPBOX_GrpBox5 then
     Result := '1. Ștergeți utilizarea datelor Ethernet (sunt necesare drepturi de administrator)'+#10+
               '2. Ștergeți datele din folderul „Recent și Prefetch” (doar ceea ce este lansat din această aplicație, inclusiv programul în sine)'+#10+
               '3. Ștergeți datele din registru (doar ceea ce este lansat din această aplicație, inclusiv programul în sine).';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX7 then
     Result := 'La pornirea managerilor de activități';
  if StringID  = GLOBAL_HINT_CHKBOX_CHKBOX7 then
     Result := 'Funcționează doar dacă este bifat „Manager de activități”.';
  if StringID  = GLOBAL_CPTN_CHKBOX_CHKBOX8 then
     Result := 'Când este apăsată tasta rapidă a șefului';
  if StringID  = GLOBAL_TEXT_MSG1 then
     Result := 'Fișierul jurnal nu există.';
  if StringID  = GLOBAL_TEXT_MSG2 then
     Result := 'Sigur doriți să ștergeți fila selectată?';
  if StringID  = GLOBAL_CPTN_BTN_BTN10 then
     Result := 'Salvați modificările';
  // HotKeyChanger
  //----------------------------------------------------------------------------
  if StringID  = HOTKEYCHANGER_CPTN then
     Result := 'Schimbarea tastei rapide';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN1 then
     Result := 'Șterge';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN2 then
     Result := 'Schimbă';
  if StringID  = HOTKEYCHANGER_CPTN_BTN_BTN3 then
     Result := 'Anulează';
  // HelpForm
  //----------------------------------------------------------------------------
  if StringID  = HELP_CPTN_PAGECTRL_TAB1 then
     Result := 'Despre program';
  if StringID  = HELP_CPTN_PAGECTRL_TAB2 then
     Result := 'Comenzile rapide de la tastatură';
  if StringID  = HELPFORM_TEXT_MEMO1 then
     Result := '';
  if StringID  = HELPFORM_TEXT_MEMO1 then
     Result := 'Anti Boss Agent — este o aplicație portabilă open source pentru Windows care poate ascunde cu ușurință orice fereastră în fundal folosind o tastă rapidă.;;'+
               'Caracteristici:;'+
               '* Lansați procesul selectat din fișier și ascundeți-l folosind aceeași tastă rapidă.;'+
               '* Ascundeți toate procesele folosind mouse-ul dvs.;'+
               '* Încheierea automată a tuturor proceselor care rulează la pornirea managerilor de activități.;'+
               '* Ștergeți istoricul tuturor proceselor care rulează, din registru, foldere speciale și statistici de utilizare a rețelei.;'+
               '* Setați un cronometru pentru a opri, reporni, etc. computerul.;'+
               '* Adăugați aplicațiile preferate, folderele personale, folderele de sistem și aplicațiile într-o singură formă și cu un singur clic.;'+
               '* Și multe alte caracteristici.;;'+
               'Lansare cu parametri:;'+
               '-    Cronometru activat "--enable".;'+
               '-    Forțați oprirea proceselor care nu răspund "--force".;'+
               '-    Ignorați trezirea "--ignore_wakeup".;'+
               '-    Opriți alimentarea "--POWEROFF".;'+
               '-    Închidere "--SHUTDOWN".;'+
               '-    Repornire "--REBOOT".;'+
               '-    Ieșire "--LOGOFF".;'+
               '-    Modul de așteptare "--STANDBY".';
  if StringID  = HELPFORM_TEXT_LSTVIEW_COL1 then
     Result := 'Acţiune';
  if StringID  = HELPFORM_TEXT_LSTVIEW_HEAD1 then
     Result := 'Forma principală';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM1 then
     Result := 'Afișează sau ascunde fereastra';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM2 then
     Result := 'Ștergeți istoricul';
  if StringID  = HELPFORM_TEXT_LSTVIEW_ITEM6 then
     Result := 'Schimbați filele';
  // FavoritesForm
  //----------------------------------------------------------------------------
  if StringID  = LNK_CPTN_MENUITEM_GEN_N1 then
     Result := 'Arată';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N2 then
     Result := 'Nu ascunde automat';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N3 then
     Result := 'Ascundeți după deschiderea aplicației';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N4 then
     Result := 'Preveniți deplasarea în afara ecranului';
  if StringID  = LNK_CPTN_MENUITEM_GEN_N5 then
     Result := 'Afișați pictograma tavă';
  if StringID  = LNK_CPTN_MENUITEM_LST_N1 then
     Result := 'Deschide';
  if StringID  = LNK_CPTN_MENUITEM_LST_N2 then
     Result := 'Deschide locația';
  if StringID  = LNK_CPTN_MENUITEM_LST_N3 then
     Result := 'Creează o scurtătură';
  if StringID  = LNK_CPTN_MENUITEM_LST_N4 then
     Result := 'Eliminați scurtătura';
  if StringID  = LNK_CPTN_MENUITEM_LST_N5 then
     Result := 'Copiați în';
  if StringID  = LNK_CPTN_MENUITEM_LST_N6 then
     Result := 'Mutați la';
  if StringID  = LNK_CPTN_MENUITEM_LST_N7 then
     Result := 'Adăugați la lista de procese';
  if StringID  = LNK_CPTN_MENUITEM_LST_N8 then
     Result := 'Filă nouă';
  if StringID  = LNK_CPTN_MENUITEM_LST_N9 then
     Result := 'Ștergeți fila';
  if StringID  = LNK_CPTN_MENUITEM_LST_N10 then
     Result := 'Import din sistem';
  if StringID  = LNK_CPTN_MENUITEM_LST_N11 then
     Result := 'Aplicațiile';
  if StringID  = LNK_CPTN_MENUITEM_LST_N12 then
     Result := 'Dosarele';
  if StringID  = LNK_CPTN_MENUITEM_LST_N13 then
     Result := 'Dimensiunea pictogramei';
  if StringID  = LNK_CPTN_MENUITEM_LST_SMALL then
     Result := 'Mici';
  if StringID  = LNK_CPTN_MENUITEM_LST_Normal then
     Result := 'Obișnuite';
  if StringID  = LNK_CPTN_MENUITEM_LST_ExtraLarge then
     Result := 'Mari';
  if StringID  = LNK_CPTN_MENUITEM_LST_Jumbo then
     Result := 'Uriașe';
  if StringID  = LNK_CPTN_MENUITEM_LST_N14 then
     Result := 'Stilul pictogramei';
  if StringID  = LNK_CPTN_MENUITEM_LST_ICON then
     Result := 'Iconițe';
  if StringID  = LNK_CPTN_MENUITEM_LST_TILE then
     Result := 'Plăci';
  if StringID  = LNK_CPTN_MENUITEM_LST_N15 then
     Result := 'Proprietăți';
  if StringID  = LNK_GLOBAL_TEXT_MSG1 then
     Result := 'Selectați un fișier sau dosar';
  if StringID  = LNK_GLOBAL_TEXT_MSG2 then
     Result := 'Sigur doriți să ștergeți ';
  if StringID  = LNK_GLOBAL_TEXT_MSG3 then
     Result := 'Creați o filă nouă';
  if StringID  = LNK_GLOBAL_TEXT_MSG4 then
     Result := 'Nume:';
  if StringID  = LNK_GLOBAL_TEXT_MSG5 then
     Result := 'Există deja o filă cu același nume, vă rugăm să selectați un alt nume.';
  if StringID  = LNK_GLOBAL_TEXT_MSG6 then
     Result := 'Sigur doriți să ștergeți fila ';
  if StringID  = LNK_GLOBAL_TEXT_MSG7 then
     Result := 'Fișierul nu este executabil sau nu există.';
  if StringID  = LNK_GLOBAL_TEXT_MSG8 then
     Result := 'O filă cu același nume există deja, ștergeți-o și încercați din nou.';
  if StringID  = LNK_GLOBAL_TEXT_MSG9 then
     Result := 'Aplicații de sistem';
  if StringID  = LNK_GLOBAL_TEXT_MSG10 then
     Result := 'Dosarele de sistem';
  if StringID  = LNK_HINT_BTN_BTN1 then
     Result := 'Calculatorul meu';
  if StringID  = LNK_HINT_BTN_BTN2 then
     Result := 'Opțiuni';
  if StringID  = LNK_HINT_SPDBTN_BTN2 then
     Result := 'Coş';
  // LNK_Utils
  //----------------------------------------------------------------------------
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG1 then
     Result := ' liber din ';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG2 then
     Result := 'Panou de control (vizualizare categorie)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG3 then
     Result := 'Panou de control (vizualizare pictograme)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG4 then
     Result := 'Panou de control (toate sarcinile)';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG5 then
     Result := 'Manager de dispozitive';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG6 then
     Result := 'Sistem';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG7 then
     Result := 'Desktop';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG8 then
     Result := 'Documente';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG9 then
     Result := 'Descărcările';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG10 then
     Result := 'Muzica';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG11 then
     Result := 'Imaginile';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG12 then
     Result := 'Jocurile salvate';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG13 then
     Result := 'Video';
  if StringID  = LNK_UTILS_GLOBAL_TEXT_MSG14 then
     Result := 'Goliți coșul de gunoi';
  // ProcessesForm
  //----------------------------------------------------------------------------
  if StringID  = PROC_CPTN then
     Result := 'Alegeți un proces din listă';
  if StringID  = PROC_CPTN_BTN_BTN1 then
     Result := 'Actualizați';
  if StringID  = PROC_CPTN_BTN_BTN2 then
     Result := 'Adăuga';
  if StringID  = PROC_CPTN_BTN_BTN2_1 then
     Result := 'Ucideți procesul';
  // LNK_Properties
  //----------------------------------------------------------------------------
  if StringID  = LNKPROP_CPTN_LBLEDIT5 then
     Result := 'Locația pictogramei';
  if StringID  = PROC_HINT_BTN_BTN1 then
     Result := 'Faceți clic pentru a schimba pictograma';
  if StringID  = PROC_GLOBAL_TEXT_MSG1 then
     Result := 'Selectați un fișier';
  // TimerForm
  //----------------------------------------------------------------------------
  if StringID  = Timer_CPTN_GRPBOX_GrpBox1 then
     Result := 'Opțiuni';
  if StringID  = Timer_TEXT_COMBO_ComboBox1 then
     Result := 'Oprire;Închidere;Repornire;Deconectare;Așteptare';
  if StringID  = Timer_CPTN_RADBTN_RADBTN1 then
     Result := 'în';
  if StringID  = Timer_TEXT_COMBO_ComboBox2 then
     Result := 'minute;ore';
  if StringID  = Timer_CPTN_LBL_LBL2 then
     Result := 'de acum!';
  if StringID  = Timer_CPTN_RADBTN_RADBTN2 then
     Result := 'la';
  if StringID  = Timer_CPTN_LBL_LBL3 then
     Result := 'ora locala!';
  if StringID  = Timer_CPTN_CHKBOX_CHKBOX1 then
     Result := 'forțați oprirea proceselor';
  if StringID  = Timer_CPTN_CHKBOX_CHKBOX2 then
     Result := 'dezactivați activarea evenimentelor';
  if StringID  = Timer_CPTN_LBL_LBL4 then
     Result := 'Cronometrul este dezactivat !';
  if StringID  = Timer_CPTN_BTN_BTN1 then
     Result := 'Activați cronometrul';
  if StringID  = Timer_CPTN_BTN_BTN1_2 then
     Result := 'Opriți cronometrul';
  if StringID  = Timer_GLOBAL_TEXT_MSG1 then
     Result := 'Cronometrul nu este activ';
  if StringID  = Timer_GLOBAL_TEXT_MSG2 then
     Result := 'Lipsesc parametrii ...';
  if StringID  = Timer_GLOBAL_TEXT_MSG3 then
     Result := 'Închidere';
  if StringID  = Timer_GLOBAL_TEXT_MSG4 then
     Result := 'secunde ...';
  if StringID  = Timer_GLOBAL_TEXT_MSG5 then
     Result := 'Eroare ';
  if StringID  = Timer_GLOBAL_TEXT_MSG6 then
     Result := ' sa întâmplat. Toate cronometrele sunt oprite!';
  end;
end;

end.
