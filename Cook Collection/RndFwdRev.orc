sr     = 44100
kr     = 44100
ksmps  = 1
nchnls = 1

instr    1 ; Constant pitch random forward / reverse Sample indexer

ilevl    = p4*32767            ; Output level
istart   = p5                  ; Initial position
irate    = p6/kr               ; Replay rate: 1=Original Pitch
irev     = p7                  ; Reversing rate
kramp    init istart           ; Initialise ramp

iseed    = rnd(1)              ; Generate random seed value
krnd     randi  1, irev, iseed ; Generate random numbers
if       krnd > 0 goto up      ; Goto 'up' 50% of the time, if not...
kramp    = kramp + irate       ; ...Decrement ramp
goto     out
up:
kramp    = kramp - irate       ; Increment ramp
goto     out
out:
kind     mirror  kramp, 0, 1   ; Constrain ramp 0 < 1
ain      tablei  kind, 1, 1    ; Index Sample table
out      ain*ilevl             ; Output and level

endin
