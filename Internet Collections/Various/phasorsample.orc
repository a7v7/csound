instr 1
 
 aindex line 0, p3, 1               ; RISES FROM 0 TO 1 IN THE TOTAL DURATION
 asig table aindex*32768, 1         ; READ TABLE 1 (WITH RAW VALUES) 
 out asig                           ; OUTPUT 


endin
