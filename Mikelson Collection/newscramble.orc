; Orchestra
; Scrambler by Hans Mikelson
sr     =       44100
kr     =       4410
ksmps  =       10
nchnls =       2

; Select random sections from a file and loop them a few times.

       instr   1

irlps  =       p4                ; Max random loops
irdr1  =       p5                ; Max random duration
irdr2  =       p6                ; Minimum duration
iroff  =       p7                ; Max random offset
ipanl  =       sqrt(p8)          ; Pan left
ipanr  =       sqrt(1-p8)        ; or right

idur    =      rnd(irdr1)+irdr2  ; Initial random duration
ioffs   =      rnd(iroff)        ; Initial random offset
inloops =      rnd(irlps)        ; Initial random loops

icount  =      0                 ; Count starts at zero

kdclk   linseg  0, .002, 1, p3-.004, 1, .002, 0 ; Overall declick

loop:                                              ; Reinit loop here
  kaenv  linseg  0, .002, 1, idur-.004, 1, .002, 0 ; Segment declick
  asig   diskin  "allofme.aif", 1, ioffs           ; Read in the sound
  aout   =       asig*kaenv                        ; Declick the segment

  timout 0, idur, cont1                            ; If time isn't up goto cont1
    icount = icount + 1                            ; Count number of segments
    if (icount<=inloops) igoto next                ; if (Count>NLoops) then
       icount  = 0                                 ;   Reset count to zero
       inloops = rnd(irlps)                        ;   Get next random loops
       idur    = rnd(irdr1)+irdr2                  ;   Get next random duration
       ioffs   = rnd(iroff)                        ;   Get next random offset
next:                                              ; Endif

  reinit loop                                      ; Reinit up to loop

cont1:                                             ; Arrive here before timeout

       outs    aout*kdclk*ipanl, aout*kdclk*ipanr  ; Overall declick, pan and output

       endin
