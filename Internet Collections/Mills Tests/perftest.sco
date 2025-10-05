
; score test critical capabilities of perf.ppc on a system
; you should run "simpletest.orc" and "simpletest.sco" to determine that 
; things *basically* are working

; instrument                  determines that
; 1 - simple pluck u.g.  score & orc processing work
; 2 - stereo pan              output device is stereo
; 3 - soundin u.g. works      can find and read sample
; 4 - gen 01 & loscil work    can deferred read sample into gen array
; 5 - lpc "works"             can read analysis file

; *************************   Instructions   *********************************

; Perf.ppc:

; First, make sure that you have removed all older versions of csound.ppc and
; perf.ppc from ALL disks attached to your Mac

; Setting folders:

; in csound.ppc, using the  "Default Directories" dialog:
; 1) set the "Sound Sample Directory" to the "samples" folder in the parent 
;    folder of this file 
; 2) set the "Sound Analysis Directory" to the "analyses" folder in the parent 
;    folder of this file 
; 3) set the "Sound Files Directory"  to the "sounds" folder in the parent 
;    folder of this file

; Sound Control Panel:

; make sure your sound output is set to 44k stereo on your Mac using the
; proper control panel for your release of the OS

; should create a file called "perftest.snd" in the "sounds" folder in the parent
;    folder of this file

; Dave Madole 11/1/96

f1 0 8193 9 1 1 90            ; big cosine for Mr. Buzz
f2 0 1025 7 0 1025 1
f3 0 0 -1 "snap1.aiff" 0 0 1

; test simple pluck, ten seconds at 100 cps
i1 0 10 100

; the same, this time pan stereo using f2
i2 10 10 100 2

; see if soundin is working - determines that perf can find and read samples
i3 20 2 

; see if gen 01 (f3) & loscil are working at 100 cps with "base frequency" == 100
i4 22 10 3 100 100

; see if lpc is working - determines that perf can find and read analysis files
i5 32 5 
