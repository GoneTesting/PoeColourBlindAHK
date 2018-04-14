#IfWinActive Path of Exile
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CreateGemStrings:
WhiteGems:= "Portal|Detonate Mines|Vaal Breach"
RedGems:= "Abyssal Cry|Ancestral Protector|Ancestral Warchief|Anger|Animate Guardian|Cleave|Decoy Totem|Determination|Devouring Totem|Dominating Blow|Earthquake|Enduring Cry|Flame Totem|Glacial Hammer|Ground Slam|Heavy Strike|Herald of Ash|Ice Crash|Immortal Call|Infernal Blow|Leap Slam|Molten Shell|Molten Strike|Punishment|Purity of Fire|Rallying Cry|Reckoning|Rejuvenation Totem|Searing Bond|Shield Charge|Shockwave Totem|Static Strike|Summon Flame Golem|Summon Stone Golem|Sunder|Sweep|Vengeance|Vigilant Strike|Vitality|Warlord's Mark|Added Fire Damage Support|Blood Magic Support|Bloodlust Support|Brutality Support|Burning Damage Support|Cast on Melee Kill Support|Cast when Damage Taken Support|Chance to Bleed Support|Cold to Fire Support|Damage on Full Life Support|Elemental Damage with Attacks Support|Empower Support|Endurance Charge on Melee Stun Support|Fire Penetration Support|Fortify Support|Generosity Support|Increased Duration Support|Iron Grip Support|Iron Will Support|Item Quantity Support|Knockback Support|Less Duration Support|Life Gain on Hit Support|Life Leech Support|Maim Support|Melee Physical Damage Support|Melee Splash Support|Multistrike Support|Ranged Attack Totem Support|Reduced Mana Support|Spell Totem Support|Stun Support|Vile Toxins Support|Vaal Glacial Hammer|Vaal Ground Slam|Vaal Immortal Call|Vaal Molten Shell"
BlueGems:= "Arc|Arctic Breath|Assassin's Mark|Ball Lightning|Blight|Bone Offering|Clarity|Cold Snap|Conductivity|Contagion|Conversion Trap|Convocation|Darkpact|Discharge|Discipline|Elemental Weakness|Enfeeble|Essence Drain|Fire Nova Mine|Fireball|Firestorm|Flame Dash|Flame Surge|Flameblast|Flammability|Flesh Offering|Freezing Pulse|Frost Bomb|Frost Wall|Frostbite|Frostbolt|Glacial Cascade|Herald of Thunder|Ice Nova|Ice Spear|Incinerate|Kinetic Blast|Lightning Tendrils|Lightning Trap|Lightning Warp|Magma Orb|Orb of Storms|Power Siphon|Purity of Elements|Purity of Lightning|Raise Spectre|Raise Zombie|Righteous Fire|Scorching Ray|Shock Nova|Spark|Spirit Offering|Storm Burst|Storm Call|Summon Chaos Golem|Summon Lightning Golem|Summon Raging Spirit|Summon Skeleton|Tempest Shield|Vortex|Vulnerability|Wither|Wrath|Added Chaos Damage Support|Added Lightning Damage Support|Blasphemy Support|Cast when Stunned Support|Cast while Channelling Support|Chance to Ignite Support|Concentrated Effect Support|Controlled Destruction Support|Curse on Hit Support|Decay Support|Efficacy Support|Elemental Focus Support|Elemental Proliferation Support|Enlighten Support|Faster Casting Support|Immolate Support|Ignite Proliferation Support|Increased Area of Effect Support|Increased Critical Damage Support|Increased Critical Strikes Support|Innervate Support|Item Rarity Support|Lightning Penetration Support|Minefield Support|Minion and Totem Elemental Resistance Support|Minion Damage Support|Minion Life Support|Minion Speed Support|Power Charge On Critical Support|Remote Mine Support|Spell Echo Support|Vaal Arc|Vaal Clarity|Vaal Cold Snap|Vaal Discipline|Vaal Fireball|Vaal Flameblast|Vaal Ice Nova|Vaal Lightning Trap|Vaal Lightning Warp|Vaal Power Siphon|Vaal Righteous Fire|Vaal Spark|Vaal Storm Call|Vaal Summon Skeletons"
GreenGems:= "Animate Weapon|Arctic Armour|Barrage|Bear Trap|Blade Flurry|Blade Vortex|Bladefall|Blast Rain|Blink Arrow|Blood Rage|Burning Arrow|Caustic Arrow|Charged Dash|Cyclone|Desecrate|Detonate Dead|Double Strike|Dual Strike|Elemental Hit|Ethereal Knives|Explosive Arrow|Fire Trap|Flicker Strike|Freeze Mine|Frenzy|Frost Blades|Grace|Haste|Hatred|Herald of Ice|Ice Shot|Ice Trap|Lacerate|Lightning Arrow|Lightning Strike|Mirror Arrow|Phase Run|Poacher's Mark|Projectile Weakness|Puncture|Purity of Ice|Rain of Arrows |Reave|Riposte|Shrapnel Shot|Siege Ballista|Smoke Mine|Spectral Throw|Split Arrow|Summon Ice Golem|Temporal Chains|Tornado Shot|Viper Strike|Whirling Blades|Wild Strike|Added Cold Damage Support|Additional Accuracy Support|Blind Support|Block Chance Reduction Support|Cast On Critical Strike Support|Cast on Death Support|Chain Support|Chance to Flee Support|Cluster Trap Support|Cold Penetration Support|Culling Strike Support|Deadly Ailments Support|Enhance Support|Faster Attacks Support|Faster Projectiles Support|Fork Support|Greater Multiple Projectiles Support|Hypothermia Support|Ice Bite Support|Lesser Multiple Projectiles Support|Lesser Poison Support|Mana Leech Support|Multiple Traps Support|Physical Projectile Attack Damage Support|Pierce Support|Point Blank Support|Poison Support|Slower Projectiles Support|Swift Affliction Support|Trap Support|Trap Cooldown Support|Trap and Mine Damage Support|Unbound Ailments Support|Void Manipulation Support|Vaal Burning Arrow|Vaal Cyclone|Vaal Detonate Dead|Vaal Double Strike|Vaal Grace|Vaal Haste|Vaal Lightning Strike|Vaal Rain of Arrows|Vaal Reave|Vaal Spectral Throw"

^c::
	Clipboard :=
	Send ^{sc02E}	; ^{c}
	Sleep 100

	CBContents := GetClipboardContents()
	CBContents := PreProcessContents(CBContents)
	ColourBlindTT := ColourBlindCheck(CBContents)	

MouseGetPos, xpos, ypos
LastMouseTipX := xpos
LastMouseTipY := ypos

ToolTipFont("s17", "Arial")
Tooltip, %ColourBlindTT%, xpos + 25, ypos + 10
SetTimer, RemoveToolTip, 4500
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

PreProcessContents(CBContents)
{
; --- Place fixes for data inconsistencies here ---
	
; Remove the line that indicates an item cannot be used due to missing character stats
	Needle := "You cannot use this item. Its stats will be ignored`r`n--------`r`n"
	StringReplace, CBContents, CBContents, %Needle%,
; Replace double separator lines with one separator line
	Needle := "--------`r`n--------`r`n"
	StringReplace, CBContents, CBContents, %Needle%, --------`r`n, All
	return CBContents
}

GetClipboardContents(DropNewlines=False)
{
	Result =
	Note =
	If Not DropNewlines
	{
		Loop, Parse, Clipboard, `n, `r
		{
			IfInString, A_LoopField, note:
			
			; new code added by Bahnzo - The ability to add prices to items causes issues. 
			; Building the code sent from the clipboard differently, and ommiting the line with "Note:" on it partially fixes this.
			; We also have to omit the \newline \return that gets added at the end.
			; Not adding the note to ClipboardContents but its own variable should solve all problems.
			{
				Note := A_LoopField
				; We drop the "note:", but the "--------" has already been added and we don't want it, so we delete the last 8 chars.
				Result := SubStr(Result, 1, -8)
				break                       
			}
			IfInString, A_LoopField, Map drop
			{
				break
			}
			If A_Index = 1                  ; so we start with just adding the first line w/o either a `n or `r
			{
				Result := Result . A_LoopField
			}
			Else
			{
				Result := Result . "`r`n" . A_LoopField  ; and then adding those before adding lines. This makes sure there are no trailing `n or `r.
				;Result := Result . A_LoopField . "`r`n"  ; the original line, left in for clarity.
			}
		}
	}
	Else
	{
		Loop, Parse, Clipboard, `n, `r
		{
			IfInString, A_LoopField, note:
			{
				Note := A_LoopField
				Result := SubStr(Result, 1, -8)
				break
			}
			Result := Result . A_LoopField
		}
	}
	RegExMatch(Trim(Note), "i)^Note: (.*)", match)
	Globals.Set("ItemNote", match1)
	return Result
}

ColourBlindCheck(CBContents) {

Global WhiteGems
Global RedGems
Global BlueGems
Global GreenGems

Loop, Parse, CBContents, `n, `r)
	{
		If (A_LoopField ="")
		{
			break
		}
		If InStr(WhiteGems, A_LoopField, CaseSensitive := true)
		{	
			Result := "W"
			Break
		}
		If InStr(RedGems, A_LoopField, CaseSensitive := true)
		{	
			Result := "R"
			Break
		}	
		If InStr(BlueGems, A_LoopField, CaseSensitive := true)
		{	
			Result := "B"
			Break
		}
		If InStr(GreenGems, A_LoopField, CaseSensitive := true)
		{	
			Result := "G"
			Break
		}			
		If InStr(A_LoopField, "Sockets", CaseSensitive := true)
		{	
			Result := A_LoopField
			Break
		}
	}
return Result
}


; ToolTipOpt v1.004
; Changes:
;  v1.001 - Pass "Default" to restore a setting to default
;  v1.002 - ANSI compatibility
;  v1.003 - Added workarounds for ToolTip's parameter being overwritten
;           by code within the message hook.
;  v1.004 - Fixed text colour.
 
ToolTipFont(Options := "", Name := "", hwnd := "") {
    static hfont := 0
    if (hwnd = "")
        hfont := Options="Default" ? 0 : _TTG("Font", Options, Name), _TTHook()
    else
        DllCall("SendMessage", "ptr", hwnd, "uint", 0x30, "ptr", hfont, "ptr", 0)
}
 
ToolTipColor(Background := "", Text := "", hwnd := "") {
    static bc := "", tc := ""
    if (hwnd = "") {
        if (Background != "")
            bc := Background="Default" ? "" : _TTG("Color", Background)
        if (Text != "")
            tc := Text="Default" ? "" : _TTG("Color", Text)
        _TTHook()
    }
    else {
        VarSetCapacity(empty, 2, 0)
        DllCall("UxTheme.dll\SetWindowTheme", "ptr", hwnd, "ptr", 0
            , "ptr", (bc != "" && tc != "") ? &empty : 0)
        if (bc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1043, "ptr", bc, "ptr", 0)
        if (tc != "")
            DllCall("SendMessage", "ptr", hwnd, "uint", 1044, "ptr", tc, "ptr", 0)
    }
}
 
_TTHook() {
    static hook := 0
    if !hook
        hook := DllCall("SetWindowsHookExW", "int", 4
            , "ptr", RegisterCallback("_TTWndProc"), "ptr", 0
            , "uint", DllCall("GetCurrentThreadId"), "ptr")
}
 
_TTWndProc(nCode, _wp, _lp) {
    Critical 999
   ;lParam  := NumGet(_lp+0*A_PtrSize)
   ;wParam  := NumGet(_lp+1*A_PtrSize)
    uMsg    := NumGet(_lp+2*A_PtrSize, "uint")
    hwnd    := NumGet(_lp+3*A_PtrSize)
    if (nCode >= 0 && (uMsg = 1081 || uMsg = 1036)) {
        _hack_ = ahk_id %hwnd%
        WinGetClass wclass, %_hack_%
        if (wclass = "tooltips_class32") {
            ToolTipColor(,, hwnd)
            ToolTipFont(,, hwnd)
        }
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "ptr", _wp, "ptr", _lp, "ptr")
}
 
_TTG(Cmd, Arg1, Arg2 := "") {
    static htext := 0, hgui := 0
	
    if !htext {
        Gui _TTG: Add, Text, +hwndhtext
        Gui _TTG: +hwndhgui +0x40000000
    }
    Gui _TTG: %Cmd%, %Arg1%, %Arg2%
    if (Cmd = "Font") {
        GuiControl _TTG: Font, %htext%
        SendMessage 0x31, 0, 0,, ahk_id %htext%
        return ErrorLevel
    }
    if (Cmd = "Color") {
        hdc := DllCall("GetDC", "ptr", htext, "ptr")
        SendMessage 0x138, hdc, htext,, ahk_id %hgui%
        clr := DllCall("GetBkColor", "ptr", hdc, "uint")
        DllCall("ReleaseDC", "ptr", htext, "ptr", hdc)
        return clr
    }
}