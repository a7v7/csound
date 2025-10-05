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

; SET A SPIRAL OF kradius TO INDEX THE SURFACE

kradius   linseg    .05, p3/2, .5, p3/2, .05
kx        oscili    kradius, inote, 1        ; SINE
ky        oscili    kradius, inote, 2, 1/4   ; COSINE

; MAP THE ORBIT THROUGH THE SURFACE
; TABLE INDEXES

kfndown   =         int(ky*gisize) + gifn0 
kfnup     =         int(1+ky*gisize) + gifn0
kndx      =         kx                       ; NORMALIZED 0 TO 1

          igoto     end

;         table     read

azdown    tableikt  kndx,kfndown, 1, .5, 1
azup      tableikt  kndx,kfnup,   1, .5, 1


; LINEAR INTERPOLATION

ay        upsamp    frac(ky*gisize)

az        =         (1-ay)*azdown + ay*azup

; FINAL OUTPUT & ENDIN
          out       iamp*az

end:
          endin


