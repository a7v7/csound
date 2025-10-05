;----------------------------------------------
; REAL TIME MIDI CONTROLLED CSOUND
; BY HANS MIKELSON  JULY 1999
; TESTED WITH MALDONADO'S CSOUND ON A 300 MHZ PENTIUM
; I USE THE FOLLOWING ONE LINE BATCH FILE CSM.BAT:
; csound -+k -+q -b128 -+p4 -+o %1.orc %1.sco
; called as follows for fofrt.orc & fofrt.sco:
; csm anmod
;----------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

gifqc     init      440
gasigl    init      0
gasigr    init      0

;-----------------------------------------------------------
; SIMPLE FOF SOUND
;-----------------------------------------------------------
          instr 1

ivel      veloc                                        ; Velocity
iamp      tablei    ivel, 3                            ; Convert to amplitude
ifqc      cpsmidi                                      ; Get the note in cps

; AMP   RISE, DEC, ATDEC

kamp      linenr    iamp, .05,  .05, .05               ; Declick envelope
kven      linseg    0, .2, 0, .1, .02, .1, .02         ; Vibrato ramp
kvbr      oscil     kven, 6, 1                         ; Vibrato LFO

kfqcl     =         (kvbr+1)*ifqc                      ; Calculate vibrato

; GENERATE THREE DIFFERENT FORMANTS

; AMP  FUND   FORM  OCT BAND RISE  DUR1  DEC   OVRLPS  FNA FNB DUR2

a1l       fof       .16, kfqcl, 564,  0,  200, .003, .017, .005, 40,     1,  19, 2,   0, 1
a2l       fof       .08, kfqcl, 1156, 0,  200, .003, .017, .005, 40,     1,  19, 2,   0, 1
a3l       fof       .06, kfqcl, 2552, 0,  200, .003, .017, .005, 40,     1,  19, 2,   0, 1

aoutl     butterlp  a1l+a2l+a3l, 5000                  ; LOWPASS FILTER

          outs      aoutl*kamp, aoutl*kamp             ; OUTPUT

          endin

