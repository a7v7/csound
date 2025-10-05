sr	=  176400
kr	=  22050
ksmps	=  8
nchnls	=  2

/* mono output file name */

#define OUTFLNAME # "_tmp.dat" #

/* ------------------------------------------- */

/* parameters for spatialization */

#define SOUNDSPEED	# 340.0 #
#define EARDIST		# 0.18 #
#define DELAYOFFS1	# 0.02 #
#define AMPDIST0	# 10 #

/* ------------------------------------------- */

/* convert distance to delay time */

#define Dist2Delay(xdst)
# ((($xdst)/$SOUNDSPEED)+$DELAYOFFS1) #

/* convert distance to amplitude */

#define Dist2Amp(xdst)
# (1/(($xdst)+1/$AMPDIST0)) #

/* azimuth to LEFT channel amp. */

#define Azim2AmpL(xazim)
# abs(1.4142135*cos((($xazim)+1.570796)/2)) #

/* azimuth to RIGHT channel amp. */

#define Azim2AmpR(xazim)
# abs(1.4142135*sin((($xazim)+1.570796)/2)) #

/* ------------------------------------------- */

/* temp macro for filtering */

#define SpatFilter #

a_	butterlp	0.333*a_L_, 500
a_1_	butterlp	0.533*a_L_, 4000
a_2_	tone		0.134*a_L_, 12000
a_2_	=  a_ + a_1_ + a_2_

a_	butterlp	0.333*a_R_, 500
a_1_	butterlp	0.533*a_R_, 4000
a_3_	tone		0.134*a_R_, 12000
a_3_	=  a_ + a_1_ + a_3_

#

#define SpatStereo #

i_1_	wrap i_az_, -180, 180
i_1_	mirror i_1_*3.141593/180, \
		-1.570796, 1.570796

i_2_	limit i_d_, 0, $SOUNDSPEED*0.95

i_3_	=  i_2_*cos(i_1_)		/* Yd */
i_4_	=  i_2_*sin(i_1_) + $EARDIST/2	/* XdL */
i_5_	=  i_2_*sin(i_1_) - $EARDIST/2	/* XdR */
i_4_	=  sqrt(i_4_*i_4_+i_3_*i_3_)	/* dL */
i_5_	=  sqrt(i_5_*i_5_+i_3_*i_3_)	/* dR */

i_2_	=  $Dist2Amp(i_4_)	/* amp. / L */
i_3_	=  $Dist2Amp(i_5_)	/* amp. / R */
i_6_	=  $Azim2AmpL(i_1_)	/* high lvl. L */
i_7_	=  $Azim2AmpR(i_1_)	/* high lvl. R */

/* lock i-rate variables */

k_2_	samphold i_2_, -1, i_2_, 0
k_3_	samphold i_3_, -1, i_3_, 0
k_6_	samphold i_6_, -1, i_6_, 0
k_7_	samphold i_7_, -1, i_7_, 0

a_4_	=  a_

/* delay */

a_L_	delay a_*k_2_, \
	(int($Dist2Delay(i_4_)*sr+0.5)+0.01)/sr
a_R_	delay a_*k_3_, \
	(int($Dist2Delay(i_5_)*sr+0.5)+0.01)/sr

$SpatFilter

/* mix output */

a_L_	=  k_6_*a_L_ + (1-k_6_)*a_2_
a_R_	=  k_7_*a_R_ + (1-k_7_)*a_3_

a_	=  a_4_

#

/* ------------------------------------------- */

/* spatializer macro */

#define SPATMACRO # $SpatStereo #


/* convert MIDI note number to frequency */

#define MIDI2CPS(xmidikey)
# (440.0*exp(log(2.0)*(($xmidikey)-69.0)/12.0)) #

/* convert frequency to MIDI note number */

#define CPS2MIDI(xfreqcps)
# (12.0*(log(($xfreqcps)/440.0)/log(2.0))+69.0) #

/* convert velocity to amplitude */

#define VELOC2AMP(xvelocity)
# (0.0039+(($xvelocity)*($xvelocity))/16192.0) #

/* convert amplitude to velocity */

#define AMP2VELOC(xamplitude)
# (sqrt((($xamplitude)-0.0039)*16192.0)) #

/* generate ftables */

i_	=  0

loop_01:

i_cps_	=  $MIDI2CPS(i_)
i__	=  int(i_+256.5)
idummy	ftgen i__, 0, 16384, 11, \
		int(44100/(2*i_cps_)), 1, 1.0
	tableigpw i__
i_	=  int(i_+1.5)
	if (i_<127.5) igoto loop_01

/* ------------------------------------------- */

#define LP1FRQ # 10.0 #

	seed 0

ga0x	init 0

	instr 1

p3	=  p3 + 0.2

icps	=  $MIDI2CPS(p4)
iamp	=  $VELOC2AMP(p5)
iazm	=  p6
ielv	=  0
idst	=  1

ifnum	limit p4, 0, 127	/* ftable */
ifnum	=  int(ifnum+256.5)	/* number */

kcps	port icps*4, p3/4, icps

kwsize	=  64.0/kcps
kdens	=  16.0/kwsize
aphs	unirand 1.0
atrns	trirand 1.0
atrns	=  kcps*(atrns*0.02+1.0)*(16384/sr)
a0x	fog 1.0, kdens, atrns, aphs, 0, 0, 0, kwsize, kwsize, 256, ifnum, 1, \
		3600, 0, 0

a0x	tone a0x*(sr/(3.14159265*($LP1FRQ))), ($LP1FRQ)

a_	=  a0x

i_az_	=  iazm
i_el_	=  ielv
i_d_	=  idst

$SPATMACRO

	outs a_L_, a_R_

	endin

	instr 90

	soundout ga0x, $OUTFLNAME, 6
ga0x	=  0

	endin


