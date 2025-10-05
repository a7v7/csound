sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          instr 1             ; SURFACE GENERATOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p3        =         .01
gisize    =         256                      ; NUMBER AND SIZE OF THE TABLES
gifn0     =         301
krow      init      0

; FILL isize TABLES OF SIZE isize TO CREATE THE SURFACE
loop:
iftnum    =         gifn0+i(krow)
iafno     ftgen     iftnum, 0, gisize+1 , 9, 1, 1, 90 ; X=COS()

krow      =         krow + 1
          if        krow >= gisize + 2 goto end
          reinit    loop

end:
          endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          instr 2             ; ORBIT & WAVEFORM GENERATOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

inote     =         p4
iamp      =         20000

; SET A CIRCULAR ORBIT TO INDEX THE SURFACE

kradius   linseg    .05, p3/2, .5, p3/2, .05
kx        oscili    kradius, inote, 1        ; SINE (-1 TO 1 COMPENSATED WITH TABLE XOFF)
ky        oscili    kradius, inote, 2, 1/4   ; COSINE (0 TO 1 HERE)

; MAP THE ORBIT THROUGH THE SURFACE
; TABLE INDEXES

kfn       =         int(ky*gisize/2) + gifn0
kndx      =         kx

;         igoto     end

;         table     read

az        tableikt  kndx,kfn, 1,.5, 1

; FINAL OUTPUT & ENDIN
          out       iamp*az

end:
          endin



