sr		=		44100
kr		=		44100
ksmps	=		1
nchnls	=		1

		instr 	1

; LORENZ EQUATIONS SYSTEM AT A-RATE WITH ALL PARAMETERS TIME-VARIABLE


ipi 		init 6.283184
amix 	init 0

;p4 p5 i p6 = INITIAL VALUES FOR CONTROL PARAMETERS
;p7 = TIME DIFFERENTIAL (NOT LESS THAN 0.02 - MAY BE IMPROVED USING RUNGE-KUTTA
;	   INTEGRATION METHODE BUT IT IS VERY TIME CONSUMING )
;p8 AMPLITUDE
;p9 ZOOM FACTOR (A KIND OF TEMPORAL WINDOW APPLIED TO TRAJECTORIES, VALUES OF
;			 APROX. 5 ARE EQUIVALENT-ALMOST- TO DOWNING P7 AT THE PRICE OF
;			 A BIT SLOWING DOWN COMPUTING TIME...)
;p10 p11 p12 = DEVIATION VALUE FOR p6 p7 p8
;			 (IT IS IMPLEMENTED WITH A SIMPLE LINE STATEMENT, BUT
;			  IMPROVING IT IS STRAIGHTFORWARD)


kcontzoom init 0
kzoom 	init p9
iprof 	init p8
idt 		init p7

; NEWTON INTEGRATION METHODE

adx 		init 0		;DIFERENTIALS
ady 		init 0
adz 		init 0
ax 		init .6	  	;VALUES
ay 		init .6
az 		init .6

;AA, AB AND AC HOLDS FOR THE VALUES OF CONTROL PARAMETERS

	  aa line p4,p3,p4+p10
	  ab line p5,p3,p5+p11
	  ac line p6,p3,p6+p12

aa init p4
ab init p5
ac init p6

loop1: adx=aa*(ay-ax)
	  ady=ax*(ab-az)-ay
	  adz=ax*ay-ac*az
	  ax=ax+(idt*adx)
	  ay=ay+(idt*ady)
	  az=az+(idt*adz)

kcontzoom=kcontzoom+1

if kcontzoom>=kzoom kgoto sortida
if kcontzoom!=kzoom kgoto loop1

sortida:amix = ax*iprof

out amix

kcontzoom=0

endin



