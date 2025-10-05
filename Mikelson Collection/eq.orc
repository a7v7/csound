
;----------------------------------------------------------------
; BIQUADRATIC EQUALIZER FILTER
; CODED BY HANS MIKELSON NOVEMBER 1998
;----------------------------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


zakinit   30, 30

;----------------------------------------------------------------
; 1 BAND PARAMETRIC EQUALIZER BY ROBERT BRISTOW-JOHNSON
;----------------------------------------------------------------
        instr 10

ifc       =         p4     ; Center Frequency
ibw       =         p5     ; Band Width in Octaves
igain     =         p6     ; Gain/Cut in dB

iomega0   =         2*taninv(ifc*6.5/2/sr)  ; I seem to have to multiply by 6.5 to get Fc correct?
igamma    =         sinh(log(2)/2*ibw*iomega0/sin(iomega0))*sin(iomega0) ; Gamma as defined in the paper
ik        =         ampdb(igain)             ; Convert dB to Amplitude

igrtk     =         igamma*sqrt(ik)               ; Calculate in advance
igortk    =         igamma/sqrt(ik)               ; to save time

kb0       =         1+igrtk                  ; Compute the coefficients
kb1       =         -2*cos(iomega0)
kb2       =         1-igrtk
ka0       =         1+igortk
ka1       =         kb1
ka2       =         1-igortk

asig      rand      10000                        ; Random number source for testing

aout      biquad    asig, kb0, kb1, kb2, ka0, ka1, ka2  ; Biquad filter  
          outs      aout, aout              ; Output the results

          endin

;----------------------------------------------------------------
; LOW SHELF BY CHRIS TOWNSEND CONVERTED TO CSOUND BY HANS MIKELSON
;----------------------------------------------------------------
          instr     11

ifc       =         p4     ; Center / Shelf
iq        =         p5     ; Quality factor sqrt(.5) is no resonance
igain     =         p6     ; Gain/Cut in dB
i2pi      =         2*3.14159265

iomega0   =         i2pi*ifc/sr
ik        =         tan(iomega0/2)
iv        =         ampdb(igain)             ; Convert dB to Amplitude
     
kb0       =         1+sqrt(2*iv)*ik+iv*ik*ik ; Compute the coefficients
kb1       =         2*(iv*ik*ik-1)
kb2       =         1-sqrt(2*iv)*ik+iv*ik*ik
ka0       =         1+ik/iq+ik*ik
ka1       =         2*(ik*ik-1)
ka2       =         1-ik/iq+ik*ik

asig      rand      5000                    ; Random number source for testing

; aout    biquad    asig, kb0, kb1, kb2, ka0, ka1, ka2  ; Biquad filter    
aout      pareq     asig, ifc, iv, iq, 1
          outs      aout, aout              ; Output the results

          endin

;----------------------------------------------------------------
; HIGH SHELF BY HANS MIKELSON DERIVED FROM LOW SHELF BY CHRIS TOWNSEND
;----------------------------------------------------------------
          instr     12

ifc       =         p4     ; Center / Shelf
iq        =         p5     ; Quality factor sqrt(.5) is no resonance
igain     =         p6     ; Gain/Cut in dB
ipi       =         3.14159265
i2pi      =         2*ipi

iomega0   =         i2pi*ifc/sr
ik        =         tan((ipi-iomega0)/2)
iv        =         ampdb(igain)             ; Convert dB to Amplitude

kb0       =         1+sqrt(2*iv)*ik+iv*ik*ik ; Compute the coefficients
kb1       =         -2*(iv*ik*ik-1)
kb2       =         1-sqrt(2*iv)*ik+iv*ik*ik
ka0       =         1+ik/iq+ik*ik
ka1       =         -2*(ik*ik-1)
ka2       =         1-ik/iq+ik*ik

asig      rand      5000                   ; Random number source for testing
     
aout      biquad    asig, kb0, kb1, kb2, ka0, ka1, ka2  ; Biquad filter  
     
          outs      aout, aout              ; Output the results

          endin

;----------------------------------------------------------------
; PEAKING EQ BY CHRIS TOWNSEND CONVERTED TO CSOUND BY HANS MIKELSON
;----------------------------------------------------------------
          instr     13

ifc       =         p4     ; Center / Shelf
iq        =         p5     ; Quality factor
igain     =         p6     ; Gain/Cut in dB
ipi       =         3.14159265
i2pi      =         2*ipi

iomega0   =         i2pi*ifc/sr
ik        =         tan(iomega0/2)
iv        =         ampdb(igain)             ; Convert dB to Amplitude

kb0       =         1+iv*ik/iq+ik*ik  ; Compute the coefficients
kb1       =         2*(ik*ik-1)
kb2       =         1-iv*ik/iq+ik*ik
ka0       =         1+ik/iq+ik*ik
ka1       =         2*(ik*ik-1)
ka2       =         1-ik/iq+ik*ik

asig      rand      5000                   ; Random number source for testing

aout      biquad    asig, kb0, kb1, kb2, ka0, ka1, ka2  ; Biquad filter  

          outs      aout, aout              ; Output the results

          endin

;----------------------------------------------------------------
; THREE BAND EQUALIZER BY HANS MIKELSON
;----------------------------------------------------------------
          instr     14

inch      =         p4
ifcl      =         p5     ; Low shelf f
iql       =         p6     ; Quality factor sqrt(.5) is no resonance
igainl    =         p7     ; Gain/Cut in dB
ifcc      =         p8     ; EQ fc
iqc       =         p9     ; Quality factor
igainc    =         p10    ; Gain/Cut in dB
ifch      =         p11    ; High shelf f
iqh       =         p12    ; Quality factor
igainh    =         p13    ; Gain/Cut in dB
ipi       =         3.14159265
i2pi      =         2*ipi
     
asig      zar       inch                    ; Random number source for testing

; LOW SHELF
iomega0l  =         i2pi*ifcl/sr
ikl       =         tan(iomega0l/2)
ivl       =         ampdb(igainl)             ; Convert dB to Amplitude
kb0l      =         1+sqrt(2*ivl)*ikl+ivl*ikl*ikl ; Compute the coefficients
kb1l      =         2*(ivl*ikl*ikl-1)
kb2l      =         1-sqrt(2*ivl)*ikl+ivl*ikl*ikl
ka0l      =         1+ikl/iql+ikl*ikl
ka1l      =         2*(ikl*ikl-1)
ka2l      =         1-ikl/iql+ikl*ikl

aoutl     biquad    asig, kb0l, kb1l, kb2l, ka0l, ka1l, ka2l  ; Biquad filter

; CENTER FREQUENCY
iomega0c  =         i2pi*ifcc/sr
ikc       =         tan(iomega0c/2)
ivc       =         ampdb(igainc)             ; Convert dB to Amplitude
kb0c      =         1+ivc*ikc/iqc+ikc*ikc  ; Compute the coefficients
kb1c      =         2*(ikc*ikc-1)
kb2c      =         1-ivc*ikc/iqc+ikc*ikc
ka0c      =         1+ikc/iqc+ikc*ikc
ka1c      =         2*(ikc*ikc-1)
ka2c      =         1-ikc/iqc+ikc*ikc

aoutc     biquad    aoutl, kb0c, kb1c, kb2c, ka0c, ka1c, ka2c  ; Biquad filter  

; HIGH SHELF
iomega0h  =         i2pi*ifch/sr
ikh       =         tan((ipi-iomega0h)/2)
ivh       =         ampdb(igainh)             ; Convert dB to Amplitude
kb0h      =         1+sqrt(2*ivh)*ikh+ivh*ikh*ikh ; Compute the coefficients
kb1h      =         -2*(ivh*ikh*ikh-1)
kb2h      =         1-sqrt(2*ivh)*ikh+ivh*ikh*ikh
ka0h      =         1+ikh/iqh+ikh*ikh
ka1h      =         -2*(ikh*ikh-1)
ka2h      =         1-ikh/iqh+ikh*ikh

aout      biquad    aoutc, kb0h, kb1h, kb2h, ka0h, ka1h, ka2h  ; Biquad filter  

          outs      aout, aout              ; Output the results

          endin

;----------------------------------------------------------------
; LOW SHELF BY CHRIS TOWNSEND CONVERTED TO CSOUND BY HANS MIKELSON
;----------------------------------------------------------------
          instr 15

ifc       =         p4     ; Center / Shelf
iq        =         p5     ; Quality factor sqrt(.5) is no resonance
igain     =         p6     ; Gain/Cut in dB
iv        =         ampdb(igain)             ; Convert dB to Amplitude

asig      rand      5000                    ; Random number source for testing

aout      pareq     asig, ifc, iv, iq, 1
          outs      aout, aout              ; Output the results

          endin
