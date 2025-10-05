sr	=  44100
kr	=  44100
ksmps	=  1
nchnls	=  1

	instr 1

iatt	=  0.002	; attack time
imaxamp	=  1.333	; max. amplitude at attack end
idec	=  0.005	; decay time
irel	=  0.05		; release time

imaxfrq	=  2.0		; max freq. / base frequency
ifrqdec	=  0.0025	; freq. decay time

; ------------------------------------------------------------

p3	=  p3+irel
imaxamp	=  sqrt(imaxamp)

icps	=  440.0*exp(log(2.0)*(p4-69.0)/12.0)
kcps	port 1, ifrqdec, imaxfrq
kcps2	port 1, 0.0002, 16
kcps	=  kcps*icps*kcps2

iamp	=  0.0039+p5*p5/16192
kamp	linseg 0,iatt,imaxamp,idec,1,p3-(iatt+idec+irel),1,irel,0,1,0
kamp	=  iamp*kamp*kamp

a1	oscil3 kamp*15000,kcps,1,0

kffrq	port 0, (60/134)*0.5, icps*8.0
kffrq2	port 0, 0.0005, 10000
a1	pareq a1, 5000, 16.0, 0.7071, 2
a1	butterlp a1, kffrq + kffrq2

	out a1

	endin


