; ORCHESTRA
;---------------------------------------------------------
; Runge-Kutta Mass Spring Stimulated by an oscillator
; Coded by Hans Mikelson April, 2000
;---------------------------------------------------------
sr      =        44100                      ; Sample rate
kr      =        44100                      ; Kontrol rate
ksmps   =        1                          ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Runge-Kutta Implementation of Moog VCF
;---------------------------------------------------------
        instr  6

idur   =      p3            ; Duration
iamp   =      p4            ; Amplitude
ifco   =      p5            ; Spring/Mass constant
iq     =      p6            ; Damping factor
ih     =      p7            ; Diff eq step size
ipanl  =      sqrt(p8)      ; Pan left
ipanr  =      sqrt(1-p8)    ; Pan right
ifqc   =      cpspch(p9)    ; Pitch to frequency

kdclck linseg 0, .02, 1, idur-.04, 1, .02, 0 ; Declick envelope
kfco   expseg ifco, idur, ifco*.1
kq     =      iq*kfco^1.2*.1
kfc    =      kfco/8/sr*44100

ay     init   0
ay1    init   0
ay2    init   0
ay3    init   0                      ; No history to start with
ax     vco   1, ifqc, 2, 1, 1, 1        ; Square wave

   ; R-K Section 1
   afdbk =      kq*tanh(ay)
   ak11  =      ih*((ax-ay1)*kfc-afdbk)
   ak21  =      ih*((ax-(ay1+.5*ak11))*kfc-afdbk)
   ak31  =      ih*((ax-(ay1+.5*ak21))*kfc-afdbk)
   ak41  =      ih*((ax-(ay1+ak31))*kfc-afdbk)
   ay1   =      ay1+(ak11+2*ak21+2*ak31+ak41)/6

   ; R-K Section 2
   ak12  =      ih*((ay1-ay2)*kfc)
   ak22  =      ih*((ay1-(ay2+.5*ak12))*kfc)
   ak32  =      ih*((ay1-(ay2+.5*ak22))*kfc)
   ak42  =      ih*((ay1-(ay2+ak32))*kfc)
   ay2   =      ay2+(ak12+2*ak22+2*ak32+ak42)/6

   ; R-K Section 3
   ak13  =      ih*((ay2-ay3)*kfc)
   ak23  =      ih*((ay2-(ay3+.5*ak13))*kfc)
   ak33  =      ih*((ay2-(ay3+.5*ak23))*kfc)
   ak43  =      ih*((ay2-(ay3+ak33))*kfc)
   ay3   =      ay3+(ak13+2*ak23+2*ak33+ak43)/6

   ; R-K Section 4
   ak14  =      ih*((ay3-ay)*kfc)
   ak24  =      ih*((ay3-(ay+.5*ak14))*kfc)
   ak34  =      ih*((ay3-(ay+.5*ak24))*kfc)
   ak44  =      ih*((ay3-(ay+ak34))*kfc)
   ay    =      ay+(ak14+2*ak24+2*ak34+ak44)/6

aout   =      ay*iamp*kdclck*1.5/(1+iq) ; Apply amp envelope and declick

        outs   aout*ipanl, aout*ipanr  ; Output the sound

        endin

;---------------------------------------------------------
; Runge-Kutta Modified Moog VCF to only oscillate positive
;---------------------------------------------------------
        instr  7

idur   =      p3            ; Duration
iamp   =      p4            ; Amplitude
ifco   =      p5            ; Spring/Mass constant
iq     =      p6            ; Damping factor
ih     =      p7            ; Diff eq step size
ipanl  =      sqrt(p8)      ; Pan left
ipanr  =      sqrt(1-p8)    ; Pan right
ifqc   =      cpspch(p9)    ; Pitch to frequency

kdclck linseg 0, .02, 1, idur-.04, 1, .02, 0 ; Declick envelope
kfco   expseg ifco, idur, ifco*.1
kq     =      iq*kfco^1.2*.1
kfc    =      kfco/8/sr*44100

ay     init   0
ay1    init   0
ay2    init   0
ay3    init   0                         ; No history to start with
ax     vco   1, ifqc, 2, 1, 1, 1        ; Square wave

   ; R-K Section 1
   afdbk =      kq*ay/(1+exp(-ay*3))             ; Only oscillate in 
one direction
   ak11  =      ih*((ax-ay1)*kfc-afdbk)
   ak21  =      ih*((ax-(ay1+.5*ak11))*kfc-afdbk)
   ak31  =      ih*((ax-(ay1+.5*ak21))*kfc-afdbk)
   ak41  =      ih*((ax-(ay1+ak31))*kfc-afdbk)
   ay1   =      ay1+(ak11+2*ak21+2*ak31+ak41)/6

   ; R-K Section 2
   ak12  =      ih*((ay1-ay2)*kfc)
   ak22  =      ih*((ay1-(ay2+.5*ak12))*kfc)
   ak32  =      ih*((ay1-(ay2+.5*ak22))*kfc)
   ak42  =      ih*((ay1-(ay2+ak32))*kfc)
   ay2   =      ay2+(ak12+2*ak22+2*ak32+ak42)/6

   ; R-K Section 3
   ak13  =      ih*((ay2-ay3)*kfc)
   ak23  =      ih*((ay2-(ay3+.5*ak13))*kfc)
   ak33  =      ih*((ay2-(ay3+.5*ak23))*kfc)
   ak43  =      ih*((ay2-(ay3+ak33))*kfc)
   ay3   =      ay3+(ak13+2*ak23+2*ak33+ak43)/6

   ; R-K Section 4
   ak14  =      ih*((ay3-ay)*kfc)
   ak24  =      ih*((ay3-(ay+.5*ak14))*kfc)
   ak34  =      ih*((ay3-(ay+.5*ak24))*kfc)
   ak44  =      ih*((ay3-(ay+ak34))*kfc)
   ay    =      ay+(ak14+2*ak24+2*ak34+ak44)/6

aout   =      ay*iamp*kdclck*1.5 ; Apply amp envelope and declick

        outs   aout*ipanl, aout*ipanr  ; Output the sound

        endin
