
return


F2::
InputBox, TimerMin, Input minutes, Type the remaining minutes.
EndTick := A_TickCount + TimerMin*60*1000
WinId := WinExist("A")
SetKeyDelay, 50
writecount := 2
s1 := "in "
Send %s1%

Loop
{
	
RemainingTick := EndTick - A_TickCount
if (RemainingTick < 0) {
	Goto, Finalize
}
RemainingSec := Floor(RemainingTick/1000)
rMin := Floor(RemainingSec/60)
rSec := RemainingSec - rMin*60
s2 := rMin . " minutes and "
s3 := rSec . " seconds."
mStr := s3
if (writecount > 1)
	mStr := s2 . mStr
if (WinActive("A") <> WinId) 
	ExitApp
Send %mStr%

Sleep 1600  ; wait after completion

delcount := StrLen(s3)
writecount := 1
RemainingTick := EndTick - A_TickCount
if (RemainingTick < 0) {
	Goto, Finalize
}
RemainingSec := Floor(RemainingTick/1000)
cMin := Floor(RemainingSec/60)
cSec := RemainingSec - cMin*60
if (cMin <> rMin) {
	delcount := delcount + StrLen(s2)
	writecount++
}

if (WinActive("A") <> WinId) 
	ExitApp
RemoveString(delcount)

}
return

Finalize:
delcount := StrLen(s1) + StrLen(s2) + StrLen(s3)
RemoveString(delcount)
Send now.
ExitApp


F1::

WinId := WinExist("A")
SetKeyDelay, 200
writecount := 3

Loop
{
	
cHour := A_Hour
if (cHour > 12) {
	dHour := cHour - 12
	cAPM := "PM"
} else {
	dHour := cHour
	cAPM := "AM"
}
cMin := A_Min
cSec := A_Sec

s1 := cAPM . " " . dHour . ":"	; dHour is for display, cHour is for memory
s2 := cMin . ":"
s3 := cSec
mStr := s3
if (writecount > 1)
	mStr := s2 . mStr
if (writecount > 2)
	mStr := s1 . mStr
if (WinActive("A") <> WinId) 
	ExitApp
Send %mStr%

Sleep 1600  ; wait after completion

delcount := StrLen(s3)
writecount := 1
if (cMin <> A_Min) {
	delcount := delcount + StrLen(s2)
	writecount++
}
if (cHour <> A_Hour) {
	delcount := delcount + StrLen(s1)
	writecount++
}

if (WinActive("A") <> WinId) 
	ExitApp
RemoveString(delcount)

}
return

ESC::
ExitApp

RemoveString(count)
{
	;SetKeyDelay, 200
	Random, rand, 1, 3
	if (rand > 2) {
		Send +{Left %count%}
		Send {Del}
		return
	}
	if (rand > 1) {
		Send {BS %count%}
		return
	}
	Send {Left %count%}
	Send {Del %count%}
	return
}

	
	
