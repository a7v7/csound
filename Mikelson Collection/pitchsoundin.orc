;====================================================================;
;       EXAMPLE ORCHESTRA FOR PLAYING SOUNDIN FILES                  ;
;====================================================================;
    sr   	=   18900
    kr   	=   1890
    ksmps   =   10
;===========================================;
;      		STRAIGHT MIXING INSTRUMENT             ;
;   P4 		= 	FILE A     P5 	= 	FILE B         ;
;   P6 		= 	A RISE     P7 	= 	A DECAY        ;
;   P8 		= 	B RISE     P9 	= 	B DECAY        ;
;===========================================;
instr	1
    	asiga   soundin 	p4
    	asiga   linen   	asiga,p6,p3,p7
    	asigb   soundin 	p5
    	asigb   linen   	asigb,p8,p3,p9   
        		out     	asiga+asigb
endin
;===========================================;
;        PITCH CHANGING INSTRUMENT          ;
;       P4 = SOUNDIN #  P5 = DESIRED PITCH  ;
;       P6 = OLD PITCH  P7 = ORIGINAL SR    ;
;===========================================;
 instr   2
    	icpsnew 	=       cpspch(p5)
    	icpsold 	=       cpspch(p6)
    	ioldsr  	=       p7
    	incr    	=       ioldsr/sr * icpsnew/icpsold
    	kphase  	init    0                       	;INITIALIZE PHASE
    	aphase  	interp  kphase                  	;CONVERT TO ARATE
    	asig    	tablei  aphase,1                	;RESAMPLE THE SOUND
    	kphase  	=       kphase+incr*ksmps       	;UPDATE FOR NEXT K
            		out     asig
endin
