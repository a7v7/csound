sr	=  44100
kr	=  22050
ksmps	=  2
nchnls	=  1

	seed 0

#define MIDI2CPS(xmidi) # (440.0*exp(log(2.0)*(($xmidi)-69.0)/12.0)) #
#define CPS2MIDI(xcps)  # ((log(($xcps)/440.0)/log(2.0))*12.0+69.0) #

	instr 1

/* ------------------------------------------------------------------------- */

ivol	=  2.0		/* volume					*/
ibpm	=  130		/* tempo					*/

irel	=  0.05		/* release time					*/

istrtf1	=  5.3333	/* start frequency 1				*/
ifdec1	=  20		/* freq. decay speed 1				*/
istrtf2	=  0.5		/* start frequency 2				*/
ifdec2	=  256		/* freq. decay speed 2				*/

insmix	=  4.0		/* noise mix					*/

iLPf	=  2.0		/* LP filter start frequency / osc. freq.	*/
iLPd	=  4.0		/* LP filter freq. decay speed			*/

iAM1s	=  3.0		/* amp. envelope 1 start value			*/
iAM1d	=  1024		/* amp. envelope 1 decay speed			*/
iAM2s	=  0.25		/* amp. envelope 2 start value			*/
iAM2d	=  4		/* amp. envelope 2 decay speed			*/

/* ------------------------------------------------------------------------- */

ibtime	=  60/ibpm

p3	=  p3+irel+0.05

imkey	=  p4
imvel	=  p5

icps	=  $MIDI2CPS(imkey)
iamp	=  (0.0039+imvel*imvel/16192)*ivol*16384
kamp	linseg 1,p3-(irel+0.05),1,irel,0,0.05,0

k_	port 1,ibtime/ifdec1,istrtf1		/* calculate base frequency */
k__	port 1,ibtime/ifdec2,istrtf2
kcps	=  icps*k_*k__

knumh	=  sr/(2*kcps)			/* oscillator */
a1	buzz sr/(10*3.14159265), kcps, knumh, 256, 0
a2	buzz sr/(10*3.14159265), kcps, knumh, 256, 0.5
a1	tone a1-a2, 10
a0	=  a1					/* a0 = osc. signal */

a_	unirand 2				/* noise generator */
a_	tone a_-1,kcps
a0	=  a0+a_*insmix

k_	expseg 1,ibtime/iAM1d,0.5			/* amp. envelopes */
k__	expseg 1,ibtime/iAM2d,0.5
k_	=  (1-k_)*(1-iAM1s)+iAM1s
k__	=  (1-k__)*(1-iAM2s)+iAM2s
a0	=  a0*k_*k__

a1	=  a0

k_	port 0,ibtime/iLPd,iLPf			/* LP filter */
a0	butterlp a0,kcps*k_

a_	butterhp a1,kcps*1
a_	butterlp a_,kcps*8
k_	expseg 1,0.005,0.5
a0	=  a0+1.5*a_*k_

a0	butterlp a0*iamp*kamp,sr*0.48
a0	limit a0, -30000, 30000

	out a0

	endin


