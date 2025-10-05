; Mandelbrot Set Orchestra
; by Hans Mikelson

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 10

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)
kxtrace   init      p6
kytrace   init      p7
kxstep    init      p8
kystep    init      p9*ifqc/55               ; MAKE SCAN AREA INDEPENDENT OF FREQUENCY. 
ilpmax    init      p10       
kclk      init      1
aout2     init      0
kcntold   init      0
kdy       init      1

kfco      linseg    200, idur*.3, 5000, idur*.2, 300, idur*.2, 1000, idur*.3, 10000

kclkold   =         kclk
kclk      oscil     1, ifqc, 2 ; Clock
kdclick   linseg    0, .001, iamp, idur-.002, iamp, .001, 0 

kcount    =         0
kx        =         0
ky        =         0

mandloop: 
; ITERATION FOR CALCULATING THE MANDELBROT SET.

kxx       =          kx*kx-ky*ky+kxtrace
kyy       =         2*kx*ky+kytrace
kx        =         kxx
ky        =         kyy
kcount    =         kcount + 1

          if        ((kx*kx+ky*ky<4) && (kcount<ilpmax)) goto mandloop 

; UPDATE THE TRACES.                    
kytrace   =         kytrace + kystep         ; STEP IN THE Y DIRECTION (i COMPLEX)

          if        (kclkold == kclk) goto endif1 ; CLOCK TIME-OUT, REVERSE SCAN DIRECTION. 

kdy       =         -kdy
kystep    =         kdy*kystep
kxtrace   =         kxtrace+kxstep

endif1:

aout1     =         kcount*kdclick
aout2     tone      aout1, kfco
kcntold   =         kcount

          outs      aout2, aout2
          endin
