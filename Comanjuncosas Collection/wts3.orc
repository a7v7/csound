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
iafno     ftgen     iftnum, 0, gisize , 9, 1, 1, 90 ; X = COS()

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

; SET A SPIRAL OF KRADIUS TO INDEX THE SURFACE

kradius   linseg    .05, p3/2, .45, p3/2, .05
kx        oscili    kradius, inote, 1        ; SINE
ky        oscili    kradius, inote, 1, 1/4   ; COSINE

; NOTICE THAT THE SPIRAL IS CENTERED AT (.5,.5)
; BECAUSE fn1 GOES FROM 0 TO 1
; MAP THE ORBIT THROUGH THE SURFACE
; TABLE INDEXES

kfnup     =         int(1+ky*gisize) + gifn0
kfndown   =         int(ky*gisize)   + gifn0
kndxleft  =         int(kx*gisize)
kndxright =         int(1+kx*gisize)

;         igoto     end                      ; MAYBE YOU´LL NEED IT IN 3.46 ...

;         table     read

azuplf    tablera   kfnup,   kndxleft,  0
azdownlf  tablera   kfndown, kndxleft,  0
azuprg    tablera   kfnup,   kndxright, 0
azdownrg  tablera   kfndown, kndxright, 0

; 2D LINEAR INTERPOLATION

ax        upsamp    frac(kx*gisize)
ay        upsamp    frac(ky*gisize)

az        =         (1-ax)*ay*azuplf+(1-ax)*(1-ay)*azdownlf+ax*ay*azuprg+ax*(1-ay)*azdownrg

; FINAL OUTPUT & ENDIN

          out       iamp*az

end:
          endin


