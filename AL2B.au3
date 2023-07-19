#Region ### Includes ###
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#EndRegion ### Includes ###
#Region ### Runtime Options ###
#RequireAdmin
#NoTrayIcon
#EndRegion ### Runtime Options ###
#Region ### Script Options ###
Opt("SendKeyDelay", 100)
Opt("SendKeyDownDelay", 50)
Opt("MouseClickDelay", 100)
Opt("MouseClickDownDelay", 50)
Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)
Opt("WinWaitDelay", 0)
Opt("TrayIconDebug", 1)
#EndRegion ### Script Options ###
#Region ### Locations ###
Global $SelfHPLoc = [84, 278, 46]
Global $SelfManaLoc = [77, 271, 64]
Global $MobHPLoc = [592, 736, 61]
Global $EnemyHPLoc = [591, 735, 48]
Global $CastingLoc = [543, 500]
Global $ChainMIDLoc = [766 ,285]
Global $ChainBOXLoc = [740 , 250, 790, 310]
Global $ActionMIDLoc = [[375, 423, 471 ,519, 567, 615, 664, 712, 760, 808, 856, 904], [655, 605, 558]]
Global $ActionBOXLoc = [[356, 404, 452 ,500, 548, 596, 644, 692, 740, 788, 836, 884], [655, 605, 558], [395, 443, 491 ,539, 587, 635, 683, 731, 779, 827, 875, 923], [694, 644, 597]]
For $j = 2 To 3
   For $i = 0 To 11
	  $ActionBOXLoc[$j][$i] = $ActionBOXLoc[$j][$i] - 30
   Next
Next
Global $WepBOXLoc = [250, 298, 653]
Global $CaptchaBox = [135, 495, 195, 500]
Global $DisconnectBox = [605, 265, 680, 275]
Global $StartBox = [590, 675, 640, 690]
#EndRegion ### Locations ###
#Region ### Color and CHKSM ###
Global $HPColor = 0x90071B
Global $ManaColor = 0x155DB4
Global $TargetColor = 0x1F100F
Global $WepColor = 0xF3C53F
Global $CastingColor = 0x6B0667
Global $CaptchaCHKSM = 0x655D22AA
Global $DisconnectCHKSM = 0xC86376D
Global $StartCHKSM = 0xFF165B5C
#EndRegion ### Colors ###
#Region ### Load Configuration File ###
   $FileHandle = FileOpen("Settings.ini")
   If $FileHandle <> -1 Then
	  ;Core Function Variables
	  Global $NormalAttackKey = FileReadLine($FileHandle) ;GUI INPUT
	  Global $MainWepKey = FileReadLine($FileHandle) ;GUI INPUT
	  Global $SecWepKey = FileReadLine($FileHandle) ;GUI INPUT
	  Global $HPNum = FileReadLine($FileHandle) ;GUI INPUT
	  Global $MPNum = FileReadLine($FileHandle) ;GUI INPUT
	  Global $BuffNum = FileReadLine($FileHandle) ;GUI INPUT
	  Global $SkillsNUM = FileReadLine($FileHandle) ;GUI INPUT
	  Global $HPCondition[1] ;GUI INPUT
	  $HPCondition[0] = FileReadLine($FileHandle)
	  For $i = 1 To $HPNum - 1
		 _ArrayAdd($HPCondition, FileReadLine($FileHandle))
	  Next
	  Global $MPCondition[1] ;GUI INPUT
	  $MPCondition[0] = FileReadLine($FileHandle)
	  For $i = 1 To $MPNum - 1
		 _ArrayAdd($MPCondition, FileReadLine($FileHandle))
	  Next
	  Global $RebuffTime[1] ;GUI INPUT
	  $RebuffTime[0] = FileReadLine($FileHandle)
	  For $i = 1 To $BuffNum - 1
		 _ArrayAdd($RebuffTime, FileReadLine($FileHandle))
	  Next
	  Global $BuffTimerHandler[1]
	  $BuffTimerHandler[0] = FileReadLine($FileHandle)
	  For $i = 1 To $BuffNum - 1
		 _ArrayAdd($BuffTimerHandler, FileReadLine($FileHandle))
	  Next
	  Global $HPWEP[1] ;GUI INPUT
	  $HPWEP[0] = FileReadLine($FileHandle)
	  For $i = 1 To $HPNum - 1
		 _ArrayAdd($HPWEP, FileReadLine($FileHandle))
	  Next
	  Global $MPWEP[1] ;GUI INPUT
	  $MPWEP[0] = FileReadLine($FileHandle)
	  For $i = 1 To $MPNum - 1
		 _ArrayAdd($MPWEP, FileReadLine($FileHandle))
	  Next
	  Global $BuffWEP[1] ;GUI INPUT
	  $BuffWEP[0] = FileReadLine($FileHandle)
	  For $i = 1 To $BuffNum - 1
		 _ArrayAdd($BuffWEP, FileReadLine($FileHandle))
	  Next
	  Global $SkillsWEP[1] ;GUI INPUT
	  $SkillsWEP[0] = FileReadLine($FileHandle)
	  For $i = 1 To $SkillsNum - 1
		 _ArrayAdd($SkillsWEP, FileReadLine($FileHandle))
	  Next
	  Global $HPKeys[1] ;GUI INPUT
	  $HPKeys[0] = FileReadLine($FileHandle)
	  For $i = 1 To $HPNum - 1
		 _ArrayAdd($HPKeys, FileReadLine($FileHandle))
	  Next
	  Global $MPKeys[1] ;GUI INPUT
	  $MPKeys[0] = FileReadLine($FileHandle)
	  For $i = 1 To $MPNum - 1
		 _ArrayAdd($MPKeys, FileReadLine($FileHandle))
	  Next
	  Global $BuffKeys[1] ;GUI INPUT
	  $BuffKeys[0] = FileReadLine($FileHandle)
	  For $i = 1 To $BuffNum - 1
		 _ArrayAdd($BuffKeys, FileReadLine($FileHandle))
	  Next
	  Global $SkillsKeys[1] ;GUI INPUT
	  $SkillsKeys[0] = FileReadLine($FileHandle)
	  For $i = 1 To $SkillsNum - 1
		 _ArrayAdd($SkillsKeys, FileReadLine($FileHandle))
	  Next
	  ;SWITCHES
	  If FileReadLine($FileHandle) == "True" Then ;GUI INPUT
		 Global $HPSwitch =  True
	  Else
		 Global $HPSwitch =  False
	  EndIf
	  If FileReadLine($FileHandle) == "True" Then ;GUI INPUT
		 Global $MPSwitch =  True
	  Else
		 Global $MPSwitch =  False
	  EndIf
	  If FileReadLine($FileHandle) == "True" Then ;GUI INPUT
		 Global $AutoTargetSwitch =  True
	  Else
		 Global $AutoTargetSwitch =  False
	  EndIf
	  If FileReadLine($FileHandle) == "True" Then ;GUI INPUT
		 Global $AutoLootSwitch =  True
	  Else
		 Global $AutoLootSwitch =  False
	  EndIf
	  If FileReadLine($FileHandle) == "True" Then ;GUI INPUT
		 Global $SkillsSwitch =  True
	  Else
		 Global $SkillsSwitch =  False
	  EndIf
	  If FileReadLine($FileHandle) == "True" Then ;GUI INPUT
		 Global $BuffsSwitch =  True
	  Else
		 Global $BuffsSwitch =  False
	  EndIf
	  ;close file.
	  FileClose($FileHandle)
   Else
	  ;Core Function Variables
	  Global $NormalAttackKey = "1" ;GUI INPUT
	  Global $MainWepKey = "Z" ;GUI INPUT
	  Global $SecWepKey = "X" ;GUI INPUT
	  Global $HPCondition = [0] ;GUI INPUT
	  Global $MPCondition = [0] ;GUI INPUT
	  Global $RebuffTime = [30] ;GUI INPUT
	  Global $BuffTimerHandler = [0]
	  Global $HPNum = 1 ;GUI INPUT
	  Global $MPNum = 1 ;GUI INPUT
	  Global $BuffNum = 1 ;GUI INPUT
	  Global $SkillsNUM = 1 ;GUI INPUT
	  Global $HPWEP = [0] ;GUI INPUT
	  Global $MPWEP = [0] ;GUI INPUT
	  Global $BuffWEP = [0] ;GUI INPUT
	  Global $SkillsWEP = [0] ;GUI INPUT
	  Global $HPKeys = ["1"] ;GUI INPUT
	  Global $MPKeys = ["1"] ;GUI INPUT
	  Global $BuffKeys = ["1"] ;GUI INPUT
	  Global $SkillsKeys = ["1"] ;GUI INPUT
	  ;SWITCHES
	  Global $HPSwitch = False ;GUI INPUT
	  Global $MPSwitch = False ;GUI INPUT
	  Global $AutoTargetSwitch = False ;GUI INPUT
	  Global $AutoLootSwitch = False ;GUI INPUT
	  Global $SkillsSwitch = False ;GUI INPUT
	  Global $BuffsSwitch = False ;GUI INPUT
   EndIf
#EndRegion ### Load Configuration File ###
#Region ### Core Variables ###
Global $Version = "3.5" ;GUI Display
Global $GameTitle = "Archlord2"
Global $VerboseSwitch = False
Global $State = False
Global $GameState = False
Global $FirstRun = True
Global $BuffFirstRun = True
Global $VerboseDelay = 500
Global $LootTimeout = 1000
Global $NormalAttackTimeout = 500
Global $HPSelection = 1
Global $MPSelection = 1
Global $BuffSelection = 1
Global $SkillsSelection = 1
#EndRegion ### Core Variables ###
#Region ### HotKeys ###
HotKeySet("{INSERT}", "VerboseControl")
HotKeySet("`", "RunPause")
HotKeySet("+`", "Once")
HotKeySet("^`", "End")
#EndRegion ### HotKeys ###
#Region ### START Koda GUI section ###
   #Region ### Main Display ###
   $AL2Bot = GUICreate("AL2B", 574, 516, 221, 136)
   $AutoGetTargetGUI = GUICtrlCreateCheckbox("Auto Target", 8, 40, 73, 17)
   If $AutoTargetSwitch Then
	  GUICtrlSetState(-1, $GUI_CHECKED)
   EndIf
   $AutoLootGUI = GUICtrlCreateCheckbox("Auto Loot", 96, 40, 65, 17)
   If $AutoLootSwitch Then
	  GUICtrlSetState(-1, $GUI_CHECKED)
   EndIf
   $StatusBar1 = _GUICtrlStatusBar_Create($AL2Bot)
   _GUICtrlStatusBar_SetSimple($StatusBar1)
   _GUICtrlStatusBar_SetText($StatusBar1, "Version: " & $Version)
   $NotesGUI = GUICtrlCreateEdit("", 8, 384, 553, 105)
   GUICtrlSetData(-1, StringFormat("~ All skills must be in cooldown.\r\n~ The cursor must be away from the action bar.\r\n~ Works only with default key bindings\r\n~ Run/Pause using the ` key.\r\n~ Exit using CTRL + ` key.\r\n~ Attack once using SHFT + `"))
   #EndRegion ### Main Display ###
   #Region ### NORM & WEP1 & WEP2 ###
   $NormalAttackKeyLabel = GUICtrlCreateLabel("Normal Attack Key:", 8, 16, 95, 17)
   $NormalAttackKeyGUI = GUICtrlCreateInput($NormalAttackKey, 112, 16, 17, 21)
   GUICtrlSetLimit(-1, 1)
   $MainWepKeyLabel = GUICtrlCreateLabel("1st Weapon Key:", 136, 16, 86, 17)
   $MainWepKeyGUI = GUICtrlCreateInput($MainWepKey, 240, 16, 17, 21)
   GUICtrlSetLimit(-1, 1)
   $SecWepKeyLabel = GUICtrlCreateLabel("2nd Weapon Key:", 272, 16, 90, 17)
   $SecWepKeyGUI = GUICtrlCreateInput($SecWepKey, 376, 16, 17, 21)
   GUICtrlSetLimit(-1, 1)
   #EndRegion ### NORM & WEP1 & WEP2 ###
   #Region ### HP SECTION ###
   $HPConditionLabel = GUICtrlCreateLabel("HP Conditions:", 5, 71, 74, 17)
   $HPSwitchGUI = GUICtrlCreateCheckbox("Use HP Skills", 5, 87, 81, 17)
   If $HPSwitch Then
	  GUICtrlSetState(-1, $GUI_CHECKED)
   EndIf
   $HPNumLabel = GUICtrlCreateLabel("Number of HP Conditions:", 5, 111, 126, 17)
   $HPNumGUI = GUICtrlCreateInput($HPNum, 141, 111, 25, 21)
   GUICtrlSetLimit(-1, 2)
   $HPList = GUICtrlCreateList("", 5, 135, 121, 71)
   for $i = 1 To $HPNum
	  GUICtrlSetData(-1, "Condition" & $i)
   Next
   $HPConditionLabel = GUICtrlCreateLabel("HP < (%):", 133, 135, 48, 17)
   $HPConditionGUI = GUICtrlCreateInput("0`", 181, 135, 25, 21)
   GUICtrlSetLimit(-1, 3)
   GUICTRLSetState(-1, $GUI_DISABLE)
   $HPWEPLabel = GUICtrlCreateLabel("Used Weapon:", 133, 159, 76, 17)
   $HPWEPGUI = GUICtrlCreateCombo("1st", 213, 159, 41, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "2nd")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $HPKeysLabel = GUICtrlCreateLabel("Key: ", 133, 183, 28, 17)
   $HPKeys1GUI = GUICtrlCreateCombo("None", 165, 183, 57, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "SHFT|CTRL")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $HPKeys2GUI = GUICtrlCreateInput("1", 229, 183, 17, 21)
   GUICtrlSetLimit(-1, 2)
   GUICTRLSetState(-1, $GUI_DISABLE)
   #EndRegion ### HP SECTION ###
   #Region ### MP SECTION ###
   $MPConditionLabel = GUICtrlCreateLabel("MP Conditions:", 304, 72, 75, 17)
   $MPSwitchGUI = GUICtrlCreateCheckbox("Use MP Skills", 304, 88, 81, 17)
   If $MPSwitch Then
	  GUICtrlSetState(-1, $GUI_CHECKED)
   EndIf
   $MPNumLabel = GUICtrlCreateLabel("Number of MP Conditions:", 304, 112, 127, 17)
   $MPNumGUI = GUICtrlCreateInput($MPNum, 440, 112, 25, 21)
   GUICtrlSetLimit(-1, 2)
   $MPList = GUICtrlCreateList("", 304, 136, 121, 71)
   for $i = 1 To $MPNum
	  GUICtrlSetData(-1, "Condition" & $i)
   Next
   $MPConditionLabe = GUICtrlCreateLabel("MP < (%):", 432, 136, 49, 17)
   $MPConditionGUI = GUICtrlCreateInput("0", 488, 136, 25, 21)
   GUICtrlSetLimit(-1, 3)
   GUICTRLSetState(-1, $GUI_DISABLE)
   $MPWEPLabel = GUICtrlCreateLabel("Used Weapon: ", 432, 160, 79, 17)
   $MPWEPGUI = GUICtrlCreateCombo("1st", 512, 160, 41, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "2nd")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $MPKeysLabel = GUICtrlCreateLabel("Key: ", 432, 184, 28, 17)
   $MPKeys1GUI = GUICtrlCreateCombo("None", 464, 184, 57, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "SHFT|CTRL")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $MPKeys2GUI = GUICtrlCreateInput("1", 528, 184, 17, 21)
   GUICtrlSetLimit(-1, 1)
   GUICTRLSetState(-1, $GUI_DISABLE)
   #EndRegion ### MP SECTION ###
   #Region ### Buffs SECTION ###
   $BuffLabel = GUICtrlCreateLabel("Buffs:", 303, 223, 31, 17)
   $BuffsSwitchGUI = GUICtrlCreateCheckbox("Use Buffs", 303, 239, 81, 17)
   If $BuffsSwitch Then
	  GUICtrlSetState(-1, $GUI_CHECKED)
   EndIf
   $BuffNumLabel = GUICtrlCreateLabel("Number of Buffs:", 304, 264, 83, 17)
   $BuffNumGUI = GUICtrlCreateInput($BuffNum, 400, 264, 25, 21)
   GUICtrlSetLimit(-1, 2)
   $BuffList = GUICtrlCreateList("", 303, 287, 121, 71)
   for $i = 1 To $BuffNum
	  GUICtrlSetData(-1, "Buff" & $i)
	  $RebuffTime[$i - 1] = int($RebuffTime[$i - 1]) * 60 * 1000 ;Adjust the rebuff timer to milliseconds
   Next
   $RebuffTimeLabel = GUICtrlCreateLabel("Time (min):", 431, 287, 58, 17)
   $RebuffTimeGUI = GUICtrlCreateInput("0", 495, 287, 25, 21)
   GUICtrlSetLimit(-1, 2)
   GUICTRLSetState(-1, $GUI_DISABLE)
   $BuffWEPLabel = GUICtrlCreateLabel("Used Weapon: ", 431, 311, 79, 17)
   $BuffWEPGUI = GUICtrlCreateCombo("1st", 511, 311, 41, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "2nd")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $BuffKeysLabel = GUICtrlCreateLabel("Key: ", 431, 335, 28, 17)
   $BuffKeys1GUI = GUICtrlCreateCombo("None", 463, 335, 57, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "SHFT|CTRL")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $BuffKeys2GUI = GUICtrlCreateInput("1", 527, 335, 17, 21)
   GUICtrlSetLimit(-1, 1)
   GUICTRLSetState(-1, $GUI_DISABLE)
   #EndRegion ### Buffs SECTION ###
   #Region ### Skills SECTION ###
   $SkillsLabel = GUICtrlCreateLabel("Skills:", 4, 222, 31, 17)
   $SkillsSwitchGUI = GUICtrlCreateCheckbox("Use Skills", 4, 238, 81, 17)
   If $SkillsSwitch Then
	  GUICtrlSetState(-1, $GUI_CHECKED)
   EndIf
   $SkillsNUMLabel = GUICtrlCreateLabel("Number of Skills:", 4, 262, 83, 17)
   $SkillsNUMGUI = GUICtrlCreateInput($SkillsNUM, 92, 262, 25, 21)
   GUICtrlSetLimit(-1, 2)
   $SkillsList = GUICtrlCreateList("", 4, 286, 121, 71)
   for $i = 1 To $SkillsNUM
	  GUICtrlSetData(-1, "Skill" & $i)
   Next
   $SkillsWEPLabel = GUICtrlCreateLabel("Used Weapon: ", 132, 310, 79, 17)
   $SkillsWEPGUI = GUICtrlCreateCombo("1st", 212, 310, 41, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "2nd")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $SkillsKeysLabel = GUICtrlCreateLabel("Key: ", 132, 334, 28, 17)
   $SkillsKeys1GUI = GUICtrlCreateCombo("None", 164, 334, 57, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "SHFT|CTRL")
   GUICTRLSetState(-1, $GUI_DISABLE)
   $SkillsKeys2GUI = GUICtrlCreateInput("1", 228, 334, 17, 21)
   GUICtrlSetLimit(-1, 1)
   GUICTRLSetState(-1, $GUI_DISABLE)
   #EndRegion ### Skills SECTION ###
   GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;~ option to control attack speed and loot speed
;~ healer mode
;~ option to sell items when inv is full
;~ screen detection for disconnected, dead and others to take proper actions
;~ gatherer mode

While True
   #Region Check If Game Is Running
;~    If ProcessExists("Archlord2.exe") Then
;~ 	  If NOT $GameState Then
;~ 		 $GameState = True
;~ 		 _GUICtrlStatusBar_SetText($StatusBar1, "GameState: Running      Version: " & $Version)
;~ 	  EndIf
;~    Else
;~ 	  If $GameState Then
;~ 		 $GameState = False
;~ 		 _GUICtrlStatusBar_SetText($StatusBar1, "GameState: Not Running      Version: " & $Version)
;~ 	  EndIf
;~    EndIf
   #EndRegion
   $nMsg = GUIGetMsg()
   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 End()
	  Case $AutoGetTargetGUI
		 Switch GUICtrlRead($AutoGetTargetGUI)
			Case 1
			   $AutoTargetSwitch = True
			Case 4
			   $AutoTargetSwitch = False
		 EndSwitch
	  Case $AutoLootGUI
		 Switch GUICtrlRead($AutoLootGUI)
			Case 1
			   $AutoLootSwitch = True
			Case 4
			   $AutoLootSwitch = False
		 EndSwitch
	  Case $NormalAttackKeyGUI
		 $NormalAttackKey = GUICtrlRead($NormalAttackKeyGUI)
	  Case $MainWepKeyGUI
		 $MainWepKey = GUICtrlRead($MainWepKeyGUI)
	  Case $SecWepKeyGUI
		 $SecWepKey = GUICtrlRead($SecWepKeyGUI)
	  Case $HPSwitchGUI
		 Switch GUICtrlRead($HPSwitchGUI)
			Case 1
			   $HPSwitch = True
			Case 4
			   $HPSwitch = False
		 EndSwitch
	  Case $MPSwitchGUI
		 Switch GUICtrlRead($MPSwitchGUI)
			Case 1
			   $MPSwitch = True
			Case 4
			   $MPSwitch = False
		 EndSwitch
	  Case $BuffsSwitchGUI
		 Switch GUICtrlRead($BuffsSwitchGUI)
			Case 1
			   $BuffsSwitch = True
			Case 4
			   $BuffsSwitch = False
		 EndSwitch
	  Case $SkillsSwitchGUI
		 Switch GUICtrlRead($SkillsSwitchGUI)
			Case 1
			   $SkillsSwitch = True
			Case 4
			   $SkillsSwitch = False
		 EndSwitch
	  Case $NormalAttackKeyGUI
		 Switch GUICtrlRead($NormalAttackKey)
			Case 1
			   $NormalAttackKey = True
			Case 4
			   $NormalAttackKey = False
		 EndSwitch
	  Case $MainWepKeyGUI
		 Switch GUICtrlRead($MainWepKeyGUI)
			Case 1
			   $MainWepKey = True
			Case 4
			   $MainWepKey = False
		 EndSwitch
	  Case $SecWepKeyGUI
		 Switch GUICtrlRead($SecWepKeyGUI)
			Case 1
			   $SecWepKey = True
			Case 4
			   $SecWepKey = False
		 EndSwitch
	  Case $HPNumGUI
		 $HPNum = GUICtrlRead($HPNumGUI)
		 For $i = UBound($HPCondition) To $HPNum - 1
			_ArrayAdd($HPCondition, "0")
			_ArrayAdd($HPWEP, "0")
			_ArrayAdd($HPKeys, "1")
		 Next
		 GUICtrlSetData($HPList, "")
		 for $i = 1 To $HPNum
			GUICtrlSetData($HPList, "Condition" & $i)
		 Next
	  Case $HPList
		 ;get the condition number and change it to array number
		 $HPSelection = int(StringRight(GUICtrlRead($HPList), 1)) - 1
		 If $HPSelection <> -1 Then
			;unblock the controls
			GUICTRLSetState($HPWEPGUI, $GUI_ENABLE) ;not implemented yet.
			GUICTRLSetState($HPConditionGUI, $GUI_ENABLE)
			GUICTRLSetState($HPKeys1GUI, $GUI_ENABLE)
			GUICTRLSetState($HPKeys2GUI, $GUI_ENABLE)
			;read the values from variables and put them in the controls.
			GUICtrlSetData($HPConditionGUI, $HPCondition[$HPSelection])
			GUICtrlSetData($HPWEPGUI, WEPToGUI($HPWEP[$HPSelection]))
			GUICtrlSetData($HPKeys1GUI, LevelToGUI(StringLeft($HPKeys[$HPSelection], 1)))
			GUICtrlSetData($HPKeys2GUI, StringRight($HPKeys[$HPSelection], 1))
		 Else
			GUICTRLSetState($HPWEPGUI, $GUI_DISABLE)
			GUICTRLSetState($HPConditionGUI, $GUI_DISABLE)
			GUICTRLSetState($HPKeys1GUI, $GUI_DISABLE)
			GUICTRLSetState($HPKeys2GUI, $GUI_DISABLE)
		 EndIf
	  Case $HPConditionGUI
		 $HPCondition[$HPSelection] = int(GUICtrlRead($HPConditionGUI))
	  Case $HPWEPGUI
		 $HPWEP[$HPSelection] = GUIToWEP(GUICtrlRead($HPWEPGUI))
	  Case $HPKeys1GUI
		 $HPKeys[$HPSelection] = GUIToLevel(GUICtrlRead($HPKeys1GUI)) & StringRight(GUICtrlRead($HPKeys2GUI), 1)
	  Case $HPKeys2GUI
		 $HPKeys[$HPSelection] = GUIToLevel(GUICtrlRead($HPKeys1GUI)) & StringRight(GUICtrlRead($HPKeys2GUI), 1)
	  Case $MPNumGUI
		 $MPNum = GUICtrlRead($MPNumGUI)
		 For $i = UBound($MPCondition) To $MPNum - 1
			_ArrayAdd($MPCondition, "0")
			_ArrayAdd($MPWEP, "0")
			_ArrayAdd($MPKeys, "1")
		 Next
		 GUICtrlSetData($MPList, "")
		 for $i = 1 To $MPNum
			GUICtrlSetData($MPList, "Condition" & $i)
		 Next
	  Case $MPList
		 ;get the condition number and change it to array number
		 $MPSelection = int(StringRight(GUICtrlRead($MPList), 1)) - 1
		 If $MPSelection <> -1 Then
			;unblock the controls
			GUICTRLSetState($MPWEPGUI, $GUI_ENABLE) ;not implemented yet.
			GUICTRLSetState($MPConditionGUI, $GUI_ENABLE)
			GUICTRLSetState($MPKeys1GUI, $GUI_ENABLE)
			GUICTRLSetState($MPKeys2GUI, $GUI_ENABLE)
			;read the values from variables and put them in the controls.
			GUICtrlSetData($MPConditionGUI, $MPCondition[$MPSelection])
			GUICtrlSetData($MPWEPGUI, WEPToGUI($MPWEP[$MPSelection]))
			GUICtrlSetData($MPKeys1GUI, LevelToGUI(StringLeft($MPKeys[$MPSelection], 1)))
			GUICtrlSetData($MPKeys2GUI, StringRight($MPKeys[$MPSelection], 1))
		 Else
			GUICTRLSetState($MPWEPGUI, $GUI_DISABLE)
			GUICTRLSetState($MPConditionGUI, $GUI_DISABLE)
			GUICTRLSetState($MPKeys1GUI, $GUI_DISABLE)
			GUICTRLSetState($MPKeys2GUI, $GUI_DISABLE)
		 EndIf
	  Case $MPConditionGUI
		 $MPCondition[$MPSelection] = int(GUICtrlRead($MPConditionGUI))
	  Case $MPWEPGUI
		 $MPWEP[$MPSelection] = GUIToWEP(GUICtrlRead($MPWEPGUI))
	  Case $MPKeys1GUI
		 $MPKeys[$MPSelection] = GUIToLevel(GUICtrlRead($MPKeys1GUI)) & StringRight(GUICtrlRead($MPKeys2GUI), 1)
	  Case $MPKeys2GUI
		 $MPKeys[$MPSelection] = GUIToLevel(GUICtrlRead($MPKeys1GUI)) & StringRight(GUICtrlRead($MPKeys2GUI), 1)
	  Case $BuffNumGUI
		 $BuffNum = GUICtrlRead($BuffNumGUI)
		 For $i = UBound($BuffKeys) To $BuffNum - 1
			_ArrayAdd($RebuffTime, "0")
			_ArrayAdd($BuffWEP, "0")
			_ArrayAdd($BuffKeys, "1")
		 Next
		 GUICtrlSetData($BuffList, "")
		 for $i = 1 To $BuffNum
			GUICtrlSetData($BuffList, "Buff" & $i)
		 Next
	  Case $BuffList
		 ;get the condition number and change it to array number
		 $BuffSelection = int(StringRight(GUICtrlRead($BuffList), 1)) - 1
		 If $BuffSelection <> -1 Then
			;unblock the controls
			GUICTRLSetState($RebuffTimeGUI, $GUI_ENABLE)
			GUICTRLSetState($BuffWEPGUI, $GUI_ENABLE) ;not implemented yet.
			GUICTRLSetState($BuffKeys1GUI, $GUI_ENABLE)
			GUICTRLSetState($BuffKeys2GUI, $GUI_ENABLE)
			;read the values from variables and put them in the controls.
			GUICtrlSetData($RebuffTimeGUI, $RebuffTime[$BuffSelection] / (60 * 1000))
			GUICtrlSetData($BuffWEPGUI, WEPToGUI($BuffWEP[$BuffSelection]))
			GUICtrlSetData($BuffKeys1GUI, LevelToGUI(StringLeft($BuffKeys[$BuffSelection], 1)))
			GUICtrlSetData($BuffKeys2GUI, StringRight($BuffKeys[$BuffSelection], 1))
		 Else
			GUICTRLSetState($RebuffTimeGUI, $GUI_DISABLE)
			GUICTRLSetState($BuffWEPGUI, $GUI_DISABLE)
			GUICTRLSetState($BuffKeys1GUI, $GUI_DISABLE)
			GUICTRLSetState($BuffKeys2GUI, $GUI_DISABLE)
		 EndIf
	  Case $RebuffTimeGUI
		 $RebuffTime[$BuffSelection] = int(GUICtrlRead($RebuffTimeGUI)) * 60 * 1000
	  Case $BuffWEPGUI
		 $BuffWEP[$BuffSelection] = GUIToWEP(GUICtrlRead($BuffWEPGUI))
	  Case $BuffKeys1GUI
		 $BuffKeys[$BuffSelection] = GUIToLevel(GUICtrlRead($BuffKeys1GUI)) & StringRight(GUICtrlRead($BuffKeys2GUI), 1)
	  Case $BuffKeys2GUI
		 $BuffKeys[$BuffSelection] = GUIToLevel(GUICtrlRead($BuffKeys1GUI)) & StringRight(GUICtrlRead($BuffKeys2GUI), 1)
	  Case $SkillsNumGUI
		 $SkillsNum = GUICtrlRead($SkillsNumGUI)
		 For $i = UBound($SkillsWEP) To $SkillsNum - 1
			_ArrayAdd($SkillsWEP, 0)
			_ArrayAdd($SkillsKeys, "1")
		 Next
		 GUICtrlSetData($SkillsList, "")
		 for $i = 1 To $SkillsNum
			GUICtrlSetData($SkillsList, "Skill" & $i)
		 Next
	  Case $SkillsList
		 ;get the condition number and change it to array number
		 $SkillsSelection = int(StringRight(GUICtrlRead($SkillsList), 1)) - 1
		 If $SkillsSelection <> -1 Then
			;unblock the controls
			GUICTRLSetState($SkillsWEPGUI, $GUI_ENABLE) ;not implemented yet.
			GUICTRLSetState($SkillsKeys1GUI, $GUI_ENABLE)
			GUICTRLSetState($SkillsKeys2GUI, $GUI_ENABLE)
			;read the values from variables and put them in the controls.
			GUICtrlSetData($SkillsWEPGUI, WEPToGUI($SkillsWEP[$SkillsSelection]))
			GUICtrlSetData($SkillsKeys1GUI, LevelToGUI(StringLeft($SkillsKeys[$SkillsSelection], 1)))
			GUICtrlSetData($SkillsKeys2GUI, StringRight($SkillsKeys[$SkillsSelection], 1))
		 Else
			GUICTRLSetState($SkillsWEPGUI, $GUI_DISABLE)
			GUICTRLSetState($SkillsKeys1GUI, $GUI_DISABLE)
			GUICTRLSetState($SkillsKeys2GUI, $GUI_DISABLE)
		 EndIf
	  Case $SkillsWEPGUI
		 $SkillsWEP[$SkillsSelection] = GUIToWEP(GUICtrlRead($SkillsWEPGUI))
	  Case $SkillsKeys1GUI
		 $SkillsKeys[$SkillsSelection] = GUIToLevel(GUICtrlRead($SkillsKeys1GUI)) & StringRight(GUICtrlRead($SkillsKeys2GUI), 1)
	  Case $SkillsKeys2GUI
		 $SkillsKeys[$SkillsSelection] = GUIToLevel(GUICtrlRead($SkillsKeys1GUI)) & StringRight(GUICtrlRead($SkillsKeys2GUI), 1)
   EndSwitch
WEnd

Func RunPause()
   $State = NOT $State
   If $State = True Then
	  ;Check Game Resolution
	  WinActivate($GameTitle)
	  $Dim = WinGetClientSize($GameTitle)
	  If NOT @error Then
		 If $Dim[0] = 1280 AND $Dim[1] = 720 Then
			$GameState = "RUNNING"
		 Else
			$State = False
			MsgBox(16, "AL2B","Unsupported Resolution.")
			return 0
		 EndIf
	  Else
		 $State = False
		 MsgBox(16, "AL2B","Please run the game first.")
		 return 0
	  EndIf
	  ;Calculate The Skills Checksum
	  If $FirstRun = True Then
		 DebugMSG("Calculating Checksum")
		 $FirstRun = False
		 WinActivate($GameTitle)
		 Global $SkillCHKSM[3][12]
		 For $j = 0 To 2 Step 1
			For $i = 0 To 11 Step 1
			   WinWaitActive($GameTitle)
			   While UsedWeapon() = 1
				  Send($MainWepKey)
			   WEnd
			   $SkillCHKSM[$j][$i] = PixelChecksum($ActionBOXLoc[0][$i], $ActionBOXLoc[1][$j], $ActionBOXLoc[2][$i], $ActionBOXLoc[3][$j])
			Next
		 Next
		 DebugMSG("Checksum Calculated!")
	  EndIf
   Else
	  DebugMSG("Paused")
   EndIf
   While $State = True AND ProcessExists("Archlord2.exe") <> 0
	  #Region first things first you need to check on your HP
	  If $HPSwitch = True Then
		 Local $myHP = GetSelfHP()
		 DebugMSG("Self HP Perc.: " & $myHP)
		 For $i = $HPNum - 1 To 0 Step -1
			If $myHP < $HPCondition[$i] AND SkillAvailable($HPKeys[$i]) = 1 Then
			   DebugMSG("Using HP Key: " & $HPKeys[$i] & " Using Weapon: " & $HPWEP[$i])
			   SPAM($HPKeys[$i], $HPWEP[$i])
			EndIf
		 Next
	  EndIf
	  #EndRegion
	  #Region now check on MP too
	  If $MPSwitch = True Then
		 Local $myMP = GetSelfMana()
		 DebugMSG("Self MP Perc.: " & $myMP)
		 For $i = $MPNum - 1 To 0 Step -1
			If $myMP < $MPCondition[$i] And SkillAvailable($MPKeys[$i]) = 1 Then
			   DebugMSG("Using MP Key: " & $MPKeys[$i] & " Using Weapon: " & $MPWEP[$i])
			   SPAM($MPKeys[$i], $MPWEP[$i])
			EndIf
		 Next
	  EndIf
	  #EndRegion
	  #Region check if u need to rebuff.
	  If $BuffsSwitch = True Then
		 For $i = $BuffNum - 1 To 0 Step -1
			Local $BuffTimerValue = TimerDiff($BuffTimerHandler[$i])
			If $BuffTimerValue >= $RebuffTime[$i] Or $BuffFirstRun = True Then
			   DebugMSG("Rebuffing: " & $BuffKeys[$i])
			   SPAM($BuffKeys[$i], $BuffWEP[$i])
			   $BuffTimerHandler[$i] = TimerInit()
			   $BuffFirstRun = False
			EndIf
		 Next
	  EndIf
	  #EndRegion
	  #Region get a target.
	  If $AutoTargetSwitch = True Then
		 ;check you target HP.
		 Local $HP = GetTargetHP()
		 DebugMSG("Target HP Perc.: " & $HP)
		 ;if you cant get target HP
		 If $HP = -1 Then
			;look for another target
			WinWaitActive($GameTitle)
			DebugMSG("Looking For Target")
			Send("{TAB}")
		 ;wanna use autoloot?
		 ElseIf $HP = 0 Then
			If $AutoLootSwitch = True Then
			   WinWaitActive($GameTitle)
			   DebugMSG("Looting and Looking For New Target")
			   Local $LootTimer = TimerInit()
			   While TimerDiff($LootTimer) < $LootTimeout
				  Send("{F}")
			   WEnd
			EndIf
			;sometimes when other mob is attacking u, u already have it as a target this fixs changing targets.
			WinWaitActive($GameTitle)
			If GetTargetHP() <= 0 Then
			   Send("{TAB}")
			EndIf
		 EndIf
	  EndIf
	  #EndRegion
	  #Region choose a skill to use.
	  If $SkillsSwitch = True Then
		 ;This fixes a the very little hp detected as dead mob problem
		 Send($NormalAttackKey)
		 ;Try To Loot Again
		 Send("{F}")
		 ;check on your target HP
		 If GetTargetHP() <= 0 Then
			DebugMSG("Target is invalid cant use skills on invalid target")
			ContinueLoop
		 EndIf

		 local $NormalAttackTimer = TimerInit()
		 While TimerDiff($NormalAttackTimer) < $NormalAttackTimeout
			;send normal attack key
			Send($NormalAttackKey)
		 WEnd

		 ;Check if a Chain Exists.
		 Local $ChainKey = ChainCheck()
		 If $ChainKey <> -1 Then
			DebugMSG("Chaining Skill: " & $ChainKey)
			SPAM($ChainKey)
			ContinueLoop
		 EndIf

		 ;pick a random skill if there is no chain.
		 Local $RAND = Random(0, $SkillsNUM - 1, 1)
		 Local $SpamKey = $SkillsKeys[$RAND]
		 Local $SpamWEP = $SkillsWEP[$RAND]
		 If SkillAvailable($SpamKey) Then
			DebugMSG("Using Skill: " & $SpamKey & "With Weapon: " & $SpamWEP)
			SPAM($SpamKey, $SpamWEP)
		 Else
			DebugMSG("Skill: " & $SpamKey & "With Weapon: " & $SpamWEP & " is in cooldown")
			ContinueLoop
		 EndIf
	  EndIf
	  #EndRegion
   WEnd
   ;if you exited the while loop this means the bot loop has ended
   $State = False
   DebugMSG("Paused")
EndFunc

Func Once()
   #Region ### Intialize ###
   ;Check Game Resolution
   WinActivate($GameTitle)
   $Dim = WinGetClientSize($GameTitle)
   If NOT @error Then
	  If $Dim[0] = 1280 AND $Dim[1] = 720 Then
		 $GameState = "RUNNING"
	  Else
		 $State = False
		 MsgBox(16, "AL2B","Unsupported Resolution.")
		 return 0
	  EndIf
   Else
	  $State = False
	  MsgBox(16, "AL2B","Please run the game first.")
	  return 0
   EndIf
   ;Calculate The Skills Checksum
   If $FirstRun = True Then
	  DebugMSG("Calculating Checksum")
	  $FirstRun = False
	  WinActivate($GameTitle)
	  Global $SkillCHKSM[3][12]
	  For $j = 0 To 2 Step 1
		 For $i = 0 To 11 Step 1
			WinWaitActive($GameTitle)
			While UsedWeapon() = 1
			   Send($MainWepKey)
			WEnd
			$SkillCHKSM[$j][$i] = PixelChecksum($ActionBOXLoc[0][$i], $ActionBOXLoc[1][$j], $ActionBOXLoc[2][$i], $ActionBOXLoc[3][$j])
		 Next
	  Next
	  DebugMSG("Checksum Calculated!")
   EndIf
   #EndRegion ### Intialize ###
   While GetTargetHP() > 0
   #Region first things first you need to check on your HP
   If $HPSwitch = True Then
	  Local $myHP = GetSelfHP()
	  DebugMSG("Self HP Perc.: " & $myHP)
	  For $i = $HPNum - 1 To 0 Step -1
		 If $myHP < $HPCondition[$i] AND SkillAvailable($HPKeys[$i]) = 1 Then
			DebugMSG("Using HP Key: " & $HPKeys[$i] & " Using Weapon: " & $HPWEP[$i])
			SPAM($HPKeys[$i], $HPWEP[$i])
		 EndIf
	  Next
   EndIf
   #EndRegion
   #Region now check on MP too
   If $MPSwitch = True Then
	  Local $myMP = GetSelfMana()
	  DebugMSG("Self MP Perc.: " & $myMP)
	  For $i = $MPNum - 1 To 0 Step -1
		 If $myMP < $MPCondition[$i] And SkillAvailable($MPKeys[$i]) = 1 Then
			DebugMSG("Using MP Key: " & $MPKeys[$i] & " Using Weapon: " & $MPWEP[$i])
			SPAM($MPKeys[$i], $MPWEP[$i])
		 EndIf
	  Next
   EndIf
   #EndRegion
   #Region choose a skill to use.
   If $SkillsSwitch = True Then
	  local $NormalAttackTimer = TimerInit()
	  While TimerDiff($NormalAttackTimer) < $NormalAttackTimeout
		 ;send normal attack key
		 Send($NormalAttackKey)
	  WEnd

	  ;Check if a Chain Exists.
	  Local $ChainKey = ChainCheck()
	  If $ChainKey <> -1 Then
		 DebugMSG("Chaining Skill: " & $ChainKey)
		 SPAM($ChainKey)
		 ContinueLoop
	  EndIf

	  ;pick a random skill if there is no chain.
	  Local $RAND = Random(0, $SkillsNUM - 1, 1)
	  Local $SpamKey = $SkillsKeys[$RAND]
	  Local $SpamWEP = $SkillsWEP[$RAND]
	  If SkillAvailable($SpamKey) = 1 Then
		 DebugMSG("Using Skill: " & $SpamKey & "With Weapon: " & $SpamWEP)
		 SPAM($SpamKey, $SpamWEP)
	  Else
		 DebugMSG("Skill: " & $SpamKey & "With Weapon: " & $SpamWEP & " is in cooldown")
		 ContinueLoop
	  EndIf
   EndIf
   #EndRegion
   WEnd
   DebugMSG("Invalid Target")
   DebugMSG("Paused")
EndFunc

Func End()
   $FileHandle = FileOpen("Settings.ini" ,$FO_OVERWRITE)
   FileWriteLine($FileHandle, $NormalAttackKey)
   FileWriteLine($FileHandle, $MainWepKey)
   FileWriteLine($FileHandle, $SecWepKey)
   FileWriteLine($FileHandle, $HPNum)
   FileWriteLine($FileHandle, $MPNum)
   FileWriteLine($FileHandle, $BuffNum)
   FileWriteLine($FileHandle, $SkillsNUM)
   For $i = 0 To $HPNum - 1
	  FileWriteLine($FileHandle, $HPCondition[$i])
   Next
   For $i = 0 To $MPNum - 1
	  FileWriteLine($FileHandle, $MPCondition[$i])
   Next
   For $i = 0 To $BuffNum - 1
	  $RebuffTime[$i] = int($RebuffTime[$i]) / (60 * 1000) ;Adjust the rebuff timer to seconds
	  FileWriteLine($FileHandle, $RebuffTime[$i])
   Next
   For $i = 0 To $BuffNum - 1
	  FileWriteLine($FileHandle, $BuffTimerHandler[$i])
   Next
   For $i = 0 To $HPNum - 1
	  FileWriteLine($FileHandle, $HPWEP[$i])
   Next
   For $i = 0 To $MPNum - 1
	  FileWriteLine($FileHandle, $MPWEP[$i])
   Next
   For $i = 0 To $BuffNum - 1
	  FileWriteLine($FileHandle, $BuffWEP[$i])
   Next
   For $i = 0 To $SkillsNum - 1
	  FileWriteLine($FileHandle, $SkillsWEP[$i])
   Next
   For $i = 0 To $HPNum - 1
	  FileWriteLine($FileHandle, $HPKeys[$i])
   Next
   For $i = 0 To $MPNum - 1
	  FileWriteLine($FileHandle, $MPKeys[$i])
   Next
   For $i = 0 To $BuffNum - 1
	  FileWriteLine($FileHandle, $BuffKeys[$i])
   Next
   For $i = 0 To $SkillsNum - 1
	  FileWriteLine($FileHandle, $SkillsKeys[$i])
   Next
   ;SWITCHES
   FileWriteLine($FileHandle, $HPSwitch)
   FileWriteLine($FileHandle, $MPSwitch)
   FileWriteLine($FileHandle, $AutoTargetSwitch)
   FileWriteLine($FileHandle, $AutoLootSwitch)
   FileWriteLine($FileHandle, $SkillsSwitch)
   FileWriteLine($FileHandle, $BuffsSwitch)
   ;close file.
   FileClose($FileHandle)
   Exit
EndFunc

Func GetPercentage($X1, $X2, $Y, $Color)
   WinWaitActive($GameTitle)
   Local $Total = $X2 - $X1
   Local $aCoord = PixelSearch($X2, $Y, $X1, $Y, $Color, 40)
   If Not @error Then
	  return (($aCoord[0] - $X1)/$Total) * 100
   EndIf
EndFunc

Func GetSelfHP()
   return GetPercentage($SelfHPLoc[0], $SelfHPLoc[1], $SelfHPLoc[2], $HPColor)
EndFunc

Func GetSelfMana()
   return GetPercentage($SelfManaLoc[0], $SelfManaLoc[1], $SelfManaLoc[2], $ManaColor)
EndFunc

Func TargetExist()
   WinWaitActive($GameTitle)
   If PixelGetColor($MobHPLoc[0] - 1, $MobHPLoc[2]) = $TargetColor Then
	  return 1
   Else
	  If PixelGetColor($EnemyHPLoc[0] - 1, $EnemyHPLoc[2]) = $TargetColor Then
		 return 2
	  Else
		 return 0
	  EndIf
   EndIf
EndFunc

Func GetTargetHP()
   If TargetExist() = 1 Then
	  return GetPercentage($MobHPLoc[0], $MobHPLoc[1], $MobHPLoc[2], $HPColor)
   ElseIf TargetExist() = 2 Then
	  return GetPercentage($EnemyHPLoc[0], $EnemyHPLoc[1], $EnemyHPLoc[2], $HPColor)
   Else
	  return -1
   EndIf
EndFunc

Func GetKeyFromArr($VAR, $Level)
   Local $Key

   Switch $VAR
	  Case 0 To 8
		 $Key = string($VAR + 1)
	  Case 9
		 $Key = "0"
	  Case 10
		 $Key = "-"
	  Case "11"
		 $Key = "="
   EndSwitch

   Switch $Level
	  Case 1
		 $Key = string("+" & $Key)
	  Case 2
		 $Key = string("^" & $Key)
   EndSwitch

   return $Key
EndFunc

Func GetARRFromKey($Key)
   Local $VAR[2]
   Local $Key2 = StringRight($Key, 1)
   Switch $Key2
   Case "0"
		 $VAR[0] = 9
	  Case "1" To "9"
		 $VAR[0] = int($Key2) - 1
	  Case "-"
		 $VAR[0] = 10
	  Case "="
		 $VAR[0] = 11
   EndSwitch

   Switch StringLeft($Key, 1)
   Case "+"
	  $VAR[1] = 1
   Case "^"
	  $VAR[1] = 2
   Case StringRight($Key, 1)
	  $VAR[1] = 0
   EndSwitch

   return $VAR
EndFunc

Func UsedWeapon()
   WinWaitActive($GameTitle)
   If PixelGetColor($WepBOXLoc[1], $WepBOXLoc[2]) = $WepColor Then
	  return 1 ;Secondary
   ElseIf PixelGetColor($WepBOXLoc[0], $WepBOXLoc[2]) = $WepColor Then
	  return 0 ;Primary
   EndIf
EndFunc

Func SkillAvailable($Key)
   ;check if that skill is not in cooldown
   ;map skill to array location
   Local $ArrLOC = GetARRFromKey($Key)
   Local $VAR = $ArrLOC[0]
   Local $Level = $ArrLOC[1]
   ;calculate current skill checksum
   WinWaitActive($GameTitle)
   Local $CHKSM = PixelChecksum($ActionBOXLoc[0][$VAR], $ActionBOXLoc[1][$Level], $ActionBOXLoc[2][$VAR], $ActionBOXLoc[3][$Level])
   ;check if skill is not in cooldown
   If ($CHKSM = $SkillCHKSM[$Level][$VAR]) Then
	  return 1
   Else
	  return 0
   EndIf
EndFunc

Func ChainCheck()
   WinWaitActive($GameTitle)
   $ChainBOX = PixelChecksum($ChainMIDLoc[0] - 2, $ChainMIDLoc[1] - 2, $ChainMIDLoc[0] + 2, $ChainMIDLoc[1] + 2, 2)
   For $Level = 0 To 2 Step 1
	  For $VAR = 0 To 11 Step 1
		 WinWaitActive($GameTitle)
		 $SkillBOX = PixelChecksum($ActionMIDLoc[0][$VAR] - 2, $ActionMIDLoc[1][$Level] + 20 - 2, $ActionMIDLoc[0][$VAR] + 2, $ActionMIDLoc[1][$Level] + 20 + 2, 2)
		 If $ChainBOX = $SkillBOX Then
			return GetKeyFromArr($VAR, $Level)
		 EndIf
	  Next
   Next
   return -1
EndFunc

Func SPAM($Key, $SEC = 0);, $AddNorm = True)
   WinWaitActive($GameTitle)
   If $SEC = 1 Then
	  While UsedWeapon() = 0
	  WinWaitActive($GameTitle)
		 Send($SecWepKey)
	  WEnd
   Else
	  While UsedWeapon() = 1
		 WinWaitActive($GameTitle)
		 Send($MainWepKey)
	  WEnd
   EndIf

;~    Local $TimeoutHandler = TimerInit()
;~    If $AddNorm = True AND $SEC = 0 AND GetTargetHP() > 0 AND TimerDiff($TimeoutHandler) < 1000 Then
;~ 	  While SkillAvailable($NormalAttackKey) = 1 AND GetTargetHP() > 0
;~ 		 WinWaitActive($GameTitle)
;~ 		 Send($NormalAttackKey)
;~ 	  WEnd
;~    EndIf

   Local $Data = GetARRFromKey($Key)
   Local $VAR = $Data[0]
   Local $Level = $Data[1]
   Local $bCHKSM = PixelChecksum($ActionMIDLoc[0][$VAR] - 2, $ActionMIDLoc[1][$Level] + 20 - 2, $ActionMIDLoc[0][$VAR] + 2, $ActionMIDLoc[1][$Level] + 20 + 2, 2)
   Local $aCHKSM = $bCHKSM
   Send($Key) ;send the key once since some skills dun have a target.
   Local $TimeoutHandler = TimerInit()
   While $aCHKSM = $bCHKSM  AND GetTargetHP() > 0 AND TimerDiff($TimeoutHandler) < 1000
	  WinWaitActive($GameTitle)
	  Send($Key)
	  $aCHKSM = PixelChecksum($ActionMIDLoc[0][$VAR] - 2, $ActionMIDLoc[1][$Level] + 20 - 2, $ActionMIDLoc[0][$VAR] + 2, $ActionMIDLoc[1][$Level] + 20 + 2, 2)
   WEnd

   While PixelGetColor($CastingLoc[0], $CastingLoc[1]) = $CastingColor
   WEnd
;~    Local $TimeoutHandler = TimerInit()
;~    If $AddNorm = True AND $SEC = 0  AND GetTargetHP() > 0 AND TimerDiff($TimeoutHandler) < 1000 Then
;~ 	  While SkillAvailable($NormalAttackKey) = 1 AND GetTargetHP() > 0
;~ 		 WinWaitActive($GameTitle)
;~ 		 Send($NormalAttackKey)
;~ 	  WEnd
;~    EndIf

   If $SEC = 1 Then
	  While UsedWeapon() = 1
		 WinWaitActive($GameTitle)
		 Send($MainWepKey)
	  WEnd
   EndIf
EndFunc

Func LevelToGUI($Level)
   Switch $Level
	  Case "+"
		 return "SHFT"
	  Case "^"
		 return "CTRL"
	  Case Else
		 return "None"
   EndSwitch
EndFunc

Func GUIToLevel($GUI)
   Switch $GUI
	  Case "SHFT"
		 return "+"
	  Case "CTRL"
		 return "^"
	  Case "None"
		 return ""
   EndSwitch
EndFunc

Func WEPToGUI($WEP)
   Switch $WEP
	  Case 0
		 return "1st"
	  Case 1
		 return "2nd"
   EndSwitch
EndFunc

Func GUIToWEP($GUI)
   Switch $GUI
	  Case "1st"
		 return 0
	  Case "2nd"
		 return 1
   EndSwitch
EndFunc

Func Captcha()
   WinWaitActive($GameTitle)
   If PixelChecksum($CaptchaBox[0], $CaptchaBox[1], $CaptchaBox[2], $CaptchaBox[3]) = $CaptchaCHKSM Then
	  return 1
   Else
	  return 0
   EndIf
EndFunc

Func Disconnected()
   WinWaitActive($GameTitle)
   If PixelChecksum($DisconnectBox[0], $DisconnectBox[1], $DisconnectBox[2], $DisconnectBox[3]) = $DisconnectCHKSM Then
	  return 1
   Else
	  return 0
   EndIf
EndFunc

Func SelectCharacterScreen()
   WinWaitActive($GameTitle)
   If PixelChecksum($StartBox[0], $StartBox[1], $StartBox[2], $StartBox[3]) = $StartCHKSM Then
	  return 1
   Else
	  return 0
   EndIf
EndFunc

Func VerboseControl()
   $VerboseSwitch = Not $VerboseSwitch
EndFunc

Func DebugMSG($MSG, $Delay = $VerboseDelay, $Activated = $VerboseSwitch)
	  If $Activated = True Then
		 ToolTip($MSG)
		 Sleep($Delay)
		 ToolTip("")
	  Else
		 _GUICtrlStatusBar_SetText($StatusBar1, "Version: " & $Version & "      " & $MSG)
	  EndIf
EndFunc