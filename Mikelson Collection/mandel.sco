; Mandelbrot Set Score
; by Hans Mikelson

; f1=Sine, f2= Square
f1 0 8192 10 1
f2 0 1024 7 1 512 1 0 -1 512 -1

; Waveform from the Mandelbrot set.
; Sta Dur Amp Pitch XCorner YCorner XStep YStep MaxLoop 
i10 0 4.0 60 6.03 -0.8   -0.8 .002 .002 400
i10 + 0.5 .    6.05 -0.6 -0.8 .0002 .002 400
i10 . 0.5 .    6.07 -0.6 -0.8 .0002 .002 400
i10 . 0.5 .    8.00 -0.6 -0.8 .0002 .002 400
i10 + 2.0 50 6.03 -0.8   -0.7 .002 .002 400
i10 . 2.0 50 6.03 -0.8   -0.6 .002 .002 400
i10 . 2.0 50 6.03 -0.8   -0.5 .002 .002 400
