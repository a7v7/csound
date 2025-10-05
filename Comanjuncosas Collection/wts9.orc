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

; GENERATE TABLES TO CONTROL THE STRENGHT OF PARTIALS GENERATED
;STRENGTH FOR PARTIAL 1
iafno     ftgen     3, 0, gisize, 7, 1, gisize/2, 1, gisize/4, 0, gisize/4, 0

; STRENGTH FOR PARTIALS 3, 5 & 7
iafno     ftgen     4, 0, gisize, 7, 0, gisize/4, 0, gisize/4, 1, gisize/4, 0, gisize/4, 0

; STRENGTH FOR PARTIALS 2, 4 & 6
iafno     ftgen     5, 0, gisize, 7, 0, gisize/2, 0, gisize/4, 1, gisize/4, 1

loop:
irow      =         i(krow)
ip1       tablei    irow, 3
ip2       tablei    irow, 4
ip3       tablei    irow, 5

iftnum    =         gifn0+i(krow)
iafno     ftgen     iftnum, 0, gisize+1 , 13, 1, 1, 0, ip1, ip2, ip3, ip2, ip3, ip2, ip3

krow      =         krow + 1
          if        krow >= gisize goto end
          reinit    loop

end:
          endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          instr 2             ; ORBIT & WAVEFORM GENERATOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

inote     =         p4
iamp      =         20000

; SET AN ASCENDING ELLIPSE TO INDEX THE SURFACE

kx        oscili    .5, inote, 1             ; SINE
kycosine  oscili    .05, inote, 2, 1/4       ; COSINE
kyline    line      .1, p3, .9
ky        =         kycosine + kyline

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


