(if	(findfile (strcat ad_defpath "ulibformulhelper.lsp")) (load (strcat ad_defpath "ulibformulhelper.lsp")))

(defun explast () (command "_.EXPLODE" (entlast)) (princ))

;{(overrideHoleLayer)}
(defun overrideHoleLayer ( / returnVal )
	(cond
		(	(or (> __HOLEDIAMETER 35.0) (member __HOLEDIAMETER (list 0.1 0.2)) )
			(if (< __HOLEDEPTH ad_et)
					(setq returnVal "CONTOUR")
					(setq returnVal "POCKET")
			)
		)
		(	(member __HOLEDIAMETER (list 0.0))
			(setq returnVal "NOTHOLE")
		)
		(T
			(setq returnVal (STRCAT "HOLE_" __HOLEDIAMETER "_" __HOLEAXISTYPE))
		)
	)
	returnVal
)


(defun fixShelf_WGroove_While (code grooveParams note / ) (while T (fixShelf_WGroove code grooveParams note)) )
(defun fixShelf_WGroove (code grooveParams note / grooveWid grooveDept grooveFrontDist shelfEnt dinsp dangle dwid ddep dhei xp1 mozel_mUnit)
	(princ "\n ") (setq shelfEnt	(car (entsel)))
	(if (equal (get_mdata shelfEnt k:mtyp) "URAF")
		(progn 
			(mapcar	'set	'(grooveWid grooveDept grooveFrontDist) grooveParams)
			(setq
				dwid	(get_mdata shelfEnt k:wid)
				ddep	(get_mdata shelfEnt k:dep)
				dhei	(get_mdata shelfEnt k:hei)
				dinsp 	(dfetch 10 shelfEnt)
				dangle	(dfetch 50 shelfEnt)
			)
			
			(setq mozel_mUnit T
				xp1	(replace (+ (getnth 2 dinsp) (- ad_et)) 2 (polar dinsp (+ DEG_90 dAngle) (+  (- ddep) grooveFrontDist grooveWid))) 
			)
			
			(mapcar '(lambda(x) (createGPanel (list (list 0.0 0.0 0.0) (list dwid 0.0 0.0) (list dwid (+ grooveDept ad_et) 0.0) (list 0.0 (+ grooveDept ad_et) 0.0)) (list 0.0 0.0 0.0 0.0) grooveWid 0.0 dAngle x "railGroove" "" nil "PANELPCONN")) (list xp1))
			(princ)
		)
	)
)

(defun horizontal_WGroove (code grooveParams note / mozel_mUnit grooveWid grooveDept grooveFrontDist cutTwoRailGroove_params altkanal1pt ustkanal1pt ptMinA  ptMaxA  ptOffSet dist dDepth dAngle dHeight ptTmpMin ptTmpMax ptMinBody ptMaxBody)
	(mapcar 'set '(grooveWid grooveDept grooveFrontDist) grooveParams)
	(setq cutTwoRailGroove_params (getnth 0 (getRailParams)) )		
	(mapcar 'set '(ptMinA  ptMaxA  ptOffSet dist dDepth dAngle dHeight ptTmpMin ptTmpMax ptMinBody ptMaxBody) cutTwoRailGroove_params) 

	(setq mozel_mUnit T 
		altkanal1pt  (replace (- ad_et grooveDept) 2 (polar ptOffSet (+ DEG_90 dAngle) (+ grooveFrontDist grooveWid) ) ) 
		ustkanal1pt	 (replace (- dHeight ad_et) 2 (polar ptOffSet (+ DEG_90 dAngle) (+ grooveFrontDist grooveWid) ) )
	)
	
	(mapcar '(lambda(x) (createGPanel (list (list 0.0 0.0 0.0) (list dist 0.0 0.0) (list dist (+ grooveDept ad_et) 0.0) (list 0.0 (+ grooveDept ad_et) 0.0)) (list 0.0 0.0 0.0 0.0) grooveWid 0.0 dAngle x "railGroove" "" nil "PANELPCONN")) (list altkanal1pt ustkanal1pt))
	(princ)
)

(defun vertical_WGroove (code grooveParams note / mozel_mUnit grooveWid grooveDept grooveFrontDist makeSidesRayGroove_params  solkanal1pt sagkanal1pt heightGap ptMinA  ptMaxA  ptOffSet dist dDepth dAngle dHeight ptTmpMin ptTmpMax ptMinBody ptMaxBody)
	(mapcar 'set '(grooveWid grooveDept grooveFrontDist) grooveParams)
	
	(setq makeSidesRayGroove_params (getnth 0 (getRailParams)) )		
	(mapcar 'set '(ptMinA  ptMaxA  ptOffSet dist dDepth dAngle dHeight ptTmpMin ptTmpMax ptMinBody ptMaxBody) makeSidesRayGroove_params) 
	
	(setq heightGap (abs (- (getnth 2 ptMinBody) (getnth 2 ptMaxBody))))
	
	(setq mozel_mUnit T 
		solkanal1pt  (polar (polar ptOffSet (+ DEG_90 dAngle) (+ grooveFrontDist grooveWid)) (- DEG_180 dAngle) grooveDept)
		sagkanal1pt  (polar (polar ptOffSet (+ DEG_90 dAngle) (+ grooveFrontDist grooveWid)) dAngle (- dist ad_et))
	)
	
	(mapcar '(lambda(x) (createGPanel (list (list 0.0 0.0 0.0) (list (+ grooveDept ad_et) 0.0 0.0) (list (+ grooveDept ad_et) heightGap 0.0) (list 0.0 heightGap 0.0)) (list 0.0 0.0 0.0 0.0) grooveWid 0.0 dAngle x "railGroove" "" nil "PANELPCONN")) (list solkanal1pt sagkanal1pt))
	(princ)
)

(defun cagberk_skm40 (code note  / mozel_mUnit cagberk_skm40_params cagberk_skm40_params newPanelData tempZ)
		(setq cagberk_skm40_params (getnth 0 (getRailParams)) )		
		(mapcar 'set '(ptMinA  ptMaxA  ptOffSet dist dDepth dAngle dHeight ptTmpMin ptTmpMax ptMinBody ptMaxBody) cagberk_skm40_params) 
		
		(setq mozel_mUnit T 
			altkanal1pt  (replace (- ad_et 1.2) 2 (polar ptOffSet (+ DEG_90 dAngle) 1.9 ) ) 
			altkanal2pt  (replace (- ad_et 1.2) 2 (polar ptOffSet (+ DEG_90 dAngle) 3.0 ) )
			ustkanal1pt	 (replace (- dHeight ad_et (- ad_et 1.2) ) 2 (polar ptOffSet (+ DEG_90 dAngle) 1.25 ) )
			ustkanal2pt  (replace (- dHeight ad_et (- ad_et 1.2)) 2 (polar ptOffSet (+ DEG_90 dAngle) 3.0 ) )
		)
		
		(createGPanel (list (list 0.0 0.0 0.0) (list dist 0.0 0.0) (list dist (+ ad_et ad_et) 0.0) (list 0.0 (+ ad_et ad_et) 0.0)) (list 0.0 0.0 0.0 0.0)    0.8 0.0 dAngle altkanal1pt "railGroove" "" nil "PANELPCONN")
		(createGPanel (list (list 0.0 0.0 0.0) (list dist 0.0 0.0) (list dist (+ ad_et ad_et) 0.0) (list 0.0 (+ ad_et ad_et) 0.0)) (list 0.0 0.0 0.0 0.0) 0.8 0.0 dAngle altkanal2pt "railGroove" "" nil "PANELPCONN")
		(createGPanel (list (list 0.0 0.0 0.0) (list dist 0.0 0.0) (list dist (+ ad_et ad_et) 0.0) (list 0.0(+ ad_et ad_et) 0.0)) (list 0.0 0.0 0.0 0.0)    (- ad_et 1.2) 0.0 dAngle ustkanal1pt "railGroove" "" nil "PANELPCONN")
		(createGPanel (list (list 0.0 0.0 0.0) (list dist 0.0 0.0) (list dist (+ ad_et ad_et) 0.0) (list 0.0 (+ ad_et ad_et) 0.0)) (list 0.0 0.0 0.0 0.0)    (- ad_et 1.2) 0.0 dAngle ustkanal2pt "railGroove" "" nil "PANELPCONN")
		(princ)
)

;standart raf
(defun xmf_raf_offset (yuk y inputet) 
	(+ (* (- yuk (* inputet y)) (/ 1.0 (+ y 1.0))) inputet)
)

(defun xmf_raf_offset_list (yuk y inputet / xmf_raf_offset_result) 
	(repeat y
		(setq xmf_raf_offset_result (cons (+ (* (- yuk (* inputet y)) (/ 1.0 (+ y 1.0))) inputet) xmf_raf_offset_result))
	)
	xmf_raf_offset_result
)

;Bitiþ modülü raf aralarý eþitlemek için xmf_raf kullan
;x:Bu raf dolap içinde kaçýncý 
;y:Bu dolap içinde kaç raf var
;x ve y reelsayý olmalý 1.0 gibi 
(defun GM1_Raf (x y ) 
	(+ (* (- curDivH (* ad_et y)) (/ x (+ y 1.0)))  (* (- x 1.0) ad_et))
)

;Bitiþ modülü dikme aralarý eþitlemek için kullan
;x:Bu dikme dolap içinde kaçýncý 
;y:Bu dolap içinde kaç dikme var
;x ve y reelsayý olmalý 1.0 gibi 
(defun GM1_Dikme (x y ) 
	(+ (* (- unitW (* ad_Et 2) (* ad_et y)) (/ x (+ y 1.0)))  (* (- x 1.0) ad_et))
)

;Standar Cam raf
(defun GM1_CRaf (x y ) 
	(+ (*  curDivH (/ x (+ y 1.0)))  (* (- x 1.0) 0.8))
)

;Aventos içi iki raf olursa üsteki rafýn dolabýn üst içinden mesafesi. Örnek HF 040 {H2} 
(defun avn_ust_raf ()  
	(cond
		(	(equal 1 (length  (gm1_Ust_Raf_Kural unith ad_et)) )
			nil
		)
		(	(equal 2 (length (gm1_Ust_Raf_Kural unith ad_et)) )
			;(list (* curDivH 0.31))
			(list (- curdivH (/ (- unitH (* 4 ad_et)) 3) ad_et))

		)
		(	(equal 3 (length (gm1_Ust_Raf_Kural unith ad_et)) )
			(list  (* 0.5 (-  curDivH (* 0.5 ad_et))) )  
		)
	)
)

;Aventos içi iki raf olursa alttaki rafýn dolabýn üst içinden mesafesi 
(defun avn_alt_raf ()
	(cond
		(	(equal 1 (length  (gm1_Ust_Raf_Kural unith ad_et)) )
			(list (- curdivh (* 0.5 ad_et)) )
		)
		(	(equal 2 (length  (gm1_Ust_Raf_Kural unith ad_et)) )
;			(list (* curDivH 0.6431) )
			(list (/ (- unitH (* 4 ad_et)) 3))
		)
		(	(equal 3 (length  (gm1_Ust_Raf_Kural unith ad_et)))
			(list (- (* 0.5 (- curDivH (* 0.5 ad_et) ) ) (* 0.5 ad_et))	(- curdivh (* 0.5 ad_et)) )
		)
	)
)

;cekh
; {(- unith ad_adh g_clearwallztop g_clearwallzbtwn (- g_clearbaseztop))}
;rafh
; (list (list {(- ad_adh ad_et ad_et)}) {(bakk_raf_kural)})
(defun  bakk_raf_kural (/ oryant)
	(setq oryant ad_adh)
	(append
		(gm1_Alt_Raf_Kural oryant ad_et)
		(mapcar	'(lambda (x) (+ x (- oryant ad_et))) (gm1_ust_Raf_Kural (- unith oryant (- ad_et)) ad_et))
	)
)

;cekh
; {(- unith (- ad_udY ad_bazah) g_clearwallztop g_clearwallzbot)}
;rafh
; (list (list {(- (- ad_udY ad_bazah) ad_et)}) {(bukk_raf_kural)})
(defun  bukk_raf_kural (/ oryant)
	(setq oryant (- ad_udY ad_bazah))
	(append
		(gm1_Alt_Raf_Kural (+ oryant ad_et) ad_et)
		(mapcar	'(lambda (x) (+ x oryant)) (gm1_ust_Raf_Kural (- unith oryant) ad_et))
	)
)


;rafh
; (list (list {(- ad_adh ad_et ad_et)}) {(bkk_raf_kural (- ad_adh ad_et ad_et))})
; (list (list {100}) {(bkk_raf_kural 100)})
(defun  bkk_raf_kural (oryant /)
	(append
		(gm1_Alt_Raf_Kural (+ oryant ad_et ad_et) ad_et)
		(mapcar	'(lambda (x) (+ x oryant ad_et)) (gm1_ust_Raf_Kural (- unith oryant ad_et) ad_et))
	)
)


;_______
;Tek bölümlü dolabýn bölüm yüksekliði
(defun bh_1bd ()
	 remCTH
)

;Tek bölümlü dolabýn kapak yüksekliði
(defun kh_1bd ()
	 (- unitH ZTop ZBot)
)

;________
;4 eþit çekmeceli dolabýn 1. bölüm yüksekliði
(defun bh_4s_#1c ()
	(+ (- (kh_4s_#1c) ad_et) ZTop (* ZBtwn 0.5))
)

;4 eþit çekmeceli dolabýn 1. kapak yüksekliði
(defun kh_4s_#1c ()
	(* (- unitH ZTop ZBtwn ZBtwn ZBtwn ZBot) 0.25)
)

;Dörde bölümlü sistemin 1 çekmeceli 1 kapaklý dolabýn 3de 4e tekabül eden alt bölüm yüksekliði
(defun bh_4s_2+3+4#2b ()
	(- (kh_4s_2+3+4#2b) (- ad_et ZBot (* ZBtwn 0.5)))
)

;Dörde bölümlü sistemin 1 çekmeceli 1 kapaklý dolabýn 3de 4e tekabül eden alt bölüm kapak yüksekliði
(defun kh_4s_2+3+4#2b ()
	(+ (* (- unitH ZTop ZBtwn ZBtwn ZBtwn ZBot) 0.75)  (* 2.0 ZBtwn))
)

;_________
;Dörte bölümlü sistemin 2de 4e tekabül eden bölüm yüksekliði
(defun bh_4s_1+2_#1b ()
	(+ (- (kh_4s_1+2_#1b) ad_et) ZTop (* ZBtwn 0.5))
)

;Dörte bölümlü sistemin 2de 4e tekabül eden bölümün kapak yüksekliði
(defun kh_4s_1+2_#1b ()
	(* (- unitH ZTop ZBtwn ZBot) 0.50)
)

;Dörte bölümlü sistemin 2de 4e tekabül eden bölümün alt bölüm yüksekliði
(defun bh_4s_3+4_#2b ()
	(+ (- (kh_4s_1+2_#1b) ad_et) ZBot (* ZBtwn 0.5))
)

;Dörte bölümlü 3 çekmeceli dolap orta bölme 

(defun bh_4s_#2b ()
	(+ (kh_4s_#1c) ZBtwn)
)
;_____

;3 çekmeceli 1 dar iki eþit çekmeceli dolap orta bölme yüksekliði
(defun bh_4s_3:8b_#1b ()
	(+ (kh_4s_3:8b_#1b) ZBtwn)
)

;3 çekmeceli 1 dar iki eþit çekmeceli dolap orta bölme kapak yüksekliði
(defun kh_4s_3:8b_#1b ()
	(+ (* (- unitH ZTop ZBtwn ZBtwn ZBtwn ZBot) 0.375) (* ZBtwn 0.5))
)

;3 çekmeceli 1 dar iki eþit çekmeceli dolap alt bölme yüksekliði 

(defun bh_4s_3:8b_#2b ()
	(+ (- (kh_4s_3:8b_#1b) ad_et) ZBot (* ZBtwn 0.50))
)

;_______
;Dörde bölümlü sistemin 4 eþit çekmeceli üçüncü bölüme tekabül eden bölüm yüksekliði, kapak birinci bölümdeki gibidir.
(defun bh_4s_#3c ()
	(+ (kh_4s_#1c) ZBtwn)
)

;Dörde bölümlü sistemin 4 eþit çekmeceli dördüncü bölüme tekabül eden bölüm yüksekliði, kapak birinci bölümdeki gibidir.
(defun bh_4s_#4c ()
	(- (kh_4s_#1c) (- ad_et ZBot (* ZBtwn 0.5)))
)

;Ankastre Fýrýn alt kapak
(defun ANK_K ()
	(+ remCTH (- (* 1.5 ad_et) ZBot (* ZBtwn 0.5) ) )
)

;____
;Üst kalkar kapaklý dolap üst bölüm 
(defun bh_2b_ust_#1b ()
	(- (+ (- (kh_2b_ust_#1b) ad_et) ZTop (* ZBtwn 0.5)) (* ad_et 0.5))
)

;Üst kalkar kapaklý dolap kapaðý 
(defun kh_2b_ust_#1b ()
	(* (- unitH ZTop ZBtwn ZBot) 0.50)
)

;Üst kalkar kapaklý dolap alt bölüm 
(defun bh_2b_ust_#2b ()
	(- (+ (- (kh_2b_ust_#1b) ad_et) ZBot (* ZBtwn 0.5)) (* ad_et 0.5))
)

;_________
;Alt dolap sabit modüller için raf ayarý
(defun xmf_SabitAlt_Raf_Kural (inputet / temph)
	(setq temph (- ad_adh ad_et ad_et))
	(cond 
		((> ad_ADH 74.0) (list (xmf_raf_offset temph 2.0 inputet) (xmf_raf_offset temph 2.0 inputet)))
		((> ad_ADH 70.0) (list (xmf_raf_offset temph 1.0 inputet)))
		(T nil)
	)
)

;Üst dolap sabit modüller için raf ayarý
(defun xmf_SabitUst_Raf_Kural (inputH inputet / temph)
	(setq temph (- inputH ad_et ad_et))
	(cond
		((> inputH 95.0) (list (xmf_raf_offset temph 3.0 inputet) (xmf_raf_offset temph 3.0 inputet) (xmf_raf_offset temph 3.0 inputet)))
		((> inputH 71.0) (list (xmf_raf_offset temph 2.0 inputet) (xmf_raf_offset temph 2.0 inputet)))
		((> inputH 39.0) (list (xmf_raf_offset temph 1.0 inputet)))
		(T nil)
	)
)

;GM1 modül yüksekliðine göre raf adedi ayarý
(defun gm1_Ust_Raf_Kural (inputH inputet / tempH) 
	(setq temph (- inputH ad_et ad_et))
	(cond
		((> inputH (cm2cu 164.0)) (gm1_createShelfDividList tempH inputet 6.0))
		((> inputH (cm2cu 139.0)) (gm1_createShelfDividList tempH inputet 5.0))
		((> inputH (cm2cu 114.0)) (gm1_createShelfDividList tempH inputet 4.0))
		((> inputH (cm2cu 89.0)) (gm1_createShelfDividList tempH inputet 3.0))
		((> inputH (cm2cu 64.0)) (gm1_createShelfDividList tempH inputet 2.0))
		((> inputH (cm2cu 39.0)) (gm1_createShelfDividList tempH inputet 1.0))
		(T nil)
	)
)

(defun gm1_Alt_Raf_Kural (inputH inputet / tempH) 
	(setq temph (- inputH ad_et ad_et))
	(cond
		((> inputH (cm2cu 109.0)) (gm1_createShelfDividList tempH inputet 3.0))
		((> inputH (cm2cu 79.0)) (gm1_createShelfDividList tempH inputet 2.0))
		((> inputH (cm2cu 49.0)) (gm1_createShelfDividList tempH inputet 1.0))
		(T nil)
	)
)

;(generateHiddenList 150 25 10)
(defun generateHiddenList (tempH drwh lowPt / i totH hList eachGap hVal )
	(if (< tempH (+ lowPT drwh))
		(setq hlist nil)
		(progn
			(setq hList (list lowPt) )
			(setq totH lowPt)
			(setq i 1)
			(while
				(<= totH (- tempH drwH drwH) )
				(progn
					(setq totH (+ totH drwH) )
					(setq hlist (cons totH hList) )
					(setq i (+ i 1) )
				)
			)
			(setq toth (+ toth drwH) )
			(setq hList (reverse hList) )
				
			(setq eachGap 0)
			(if (> (length hList) 1)
				(setq eachGap (/ (- tempH totH) (length hList) ) )
			)
			
			(setq i 1)
			(foreach hVal hList
				(if (not (equal i 1))
					(progn
						(setq hList (replace (+ hVal (* eachGap (- i 1) ) ) (- i 1) HList) )
					)
				)
				(setq i (+ i 1) )
			)
		)
	)
	hList
)


;Genel modul olculeri arayuzu secilen genel ust dolap yuksekligi
(defun UDY () (eval (read (strcat "ad_UDH" (rtos ad_MAINUDHINDEX 2 0)))) )


;Alt dolap yuksekligi + baza yuksekligi
(defun ad_ADHBAZA  ()
	(+ ad_ADH ad_bazaH)
)

;Boy dolap yuksekligi 2 + baza yuksekligi
(defun ad_BDH2BAZA  ()
	(+ ad_BDH2 ad_bazaH)
)

;Yarim Boy dolap yuksekligi + baza yuksekligi
(defun ad_YBOYBAZA  ()
	(+ (YBOY) ad_bazaH)
)

;Boy dolap yuksekligi 2 + baza yuksekligi
(defun ad_BDH4BAZA  ()
	(+ ad_BDH4 ad_bazaH)
)

;Alt yarým dolap yüksekliði aDH
(defun AYRM1 ()
	(/ ad_ADH 2.0)
)
(defun AYRM () (AYRM1) )

;Üstyarým dolap yüksekliði UDH1
(defun UYRM1 ()
	(/ ad_UDH1 2.0)
)

(defun UYRM () (UYRM1) )

;Üstyarým dolap yüksekliði UDH2
(defun UYRM2 ()
	(/ ad_UDH2 2.0)
)

;Üstyarým dolap yüksekliði UDH3
(defun UYRM3 ()
	(/ ad_UDH3 2.0)
)

;Üstyarým dolap yüksekliði UDH4
(defun UYRM4 ()
	(/ ad_UDH4 2.0)
)

;Üstyarým dolap yüksekliði UDH5
(defun UYRM5 ()
	(/ ad_UDH5 2.0)
)

;Buzdolabý kabini BDH1
(defun BCH1 ()
	(+ ad_BDH1 ad_bazaH)
)
(defun BCH () (BCH1) )

;Buzdolabý kabini BDH2
(defun BCH2 ()
	(+ ad_BDH2 ad_bazaH)
)

;Buzdolabý kabini BDH3
(defun BCH3 ()
	(+ ad_BDH3 ad_bazaH)
)

;Buzdolabý kabini BDH4
(defun BCH4 ()
	(+ ad_BDH4 ad_bazaH)
)

;Buzdolabý kabini BDH5
(defun BCH5 ()
	(+ ad_BDH5 ad_bazaH)
)

(defun DALTI ()
	(/ (- ad_UDY ad_ADH ad_TezH ad_bazaH) 3)
)

(defun DALTI2 ()
	(- ad_UDY ad_ADH ad_TezH ad_bazaH)
)

;Set üstü dolap ölçüsü
(defun SETUSTU1 ()
	(+ (- ad_UDY ad_ADH ad_TezH ad_bazaH) ad_UDH)
)
(defun SETUSTU () (SETUSTU1))

;Set üstü dolap ölçüsü UDH2 
(defun SETUSTU2 ()
	(+ (- ad_UDY ad_ADH ad_TezH ad_bazaH) ad_UDH2)
)

;Set üstü dolap ölçüsü UDH3 
(defun SETUSTU3 ()
	(+ (- ad_UDY ad_ADH ad_TezH ad_bazaH) ad_UDH3)
)

;Set üstü dolap ölçüsü UDH4 
(defun SETUSTU4 ()
	(+ (- ad_UDY ad_ADH ad_TezH ad_bazaH) ad_UDH4)
)

;Set üstü dolap ölçüsü UDH5 
(defun SETUSTU5 ()
	(+ (- ad_UDY ad_ADH ad_TezH ad_bazaH) ad_UDH5)
)

;____________
;Boy dolap 
(defun bh_boy_#1b ()
	(- (- remCTH (- (- ad_UDY ad_Bazah (* ZBtwn 0.5) ) (* ad_et 1.5)))  g_ClearWallZBot )
)

(defun kh_boy_#1b ()
	;(+ (- remCTH (- (- ad_UDY ad_Bazah (* ZBtwn 0.5) ) (* ad_et 1.5))) (- ad_et ZBot (* Zbtwn 0.5)))
	;(- (- (+ (bh_boy_#1b) (* ad_et 1.5)) ZTop (* ZBtwn 0.5)) (* (- g_ClearWallZBot g_ClearWallZBtwn) 0.5))
	(- (+ (bh_boy_#1b) (* ad_et 1.5) ) ZTop (* Zbtwn 0.5))
)

(defun bh_boy_#2b ()
	(+ (- (- ad_UDY ad_Bazah (* ZBtwn 0.5) ) (* ad_et 1.5) ) g_ClearWallZBot )
)

(defun kh_boy_#2b ()
	;(- (- ad_UDY ad_Bazah (* ZBtwn 0.5) ) (* ZBtwn 0.5) ZBot)
	(- (+ (bh_boy_#2b) (* ad_et 1.5) ) ZBot (* Zbtwn 0.5))
)

;________
;Boy dolap Üst uzun kapaklý üst bölüm Alt bölüm alt modül kapaðý gibi çalýþýr
(defun bh_boy2_#1b ()
	(+ (- remCTH (- (- ad_ADH (* ZBtwn 0.5) ) (* ad_et 1.5))) (- g_ClearBaseZTop g_ClearWallZBtwn))
)
(defun kh_boy2_#1b ()
;	(+ (- remCTH (- (- ad_ADH (* ZBtwn 0.5) ) (* ad_et 1.5))) (- ad_et ZBot (* Zbtwn 0.5)))
	(- (+ (bh_boy2_#1b) (* ad_et 1.5)) ZTop (* ZBtwn 0.5))
)

(defun bh_boy2_#2b ()
	(- (- (- ad_ADH (* ZBtwn 0.5) ) (* ad_et 1.5) ) (- g_ClearBaseZTop g_ClearWallZBtwn))
)

(defun kh_boy2_#2b ()
	(- (- (- ad_ADH (* ZBtwn 0.5) ) (* ZBtwn 0.5) ZBot) (- g_ClearBaseZTop g_ClearWallZBtwn))
)

;Boy Fýrýn modülü iki çekmeceli çekmece bölümü
;üst çekmece
(defun bh_bf2c_#2b ()
	;(- (+ (* (- (- ad_ADH (* ZBtwn 0.5)) (* ZBtwn 0.5) ZBtwn ZBot) 0.50) ZBtwn) (* ad_et 0.5))
	(- (+ (kh_bf2c_#2b) ZBtwn) (* ad_et 0.5)) 
)

(defun kh_bf2c_#2b ()
	(- (* (- ad_ADH ZTop ZBtwn ZBot) 0.50) (* (- g_ClearBaseZTop g_ClearWallZBtwn) 0.5))
)

;alt çekmece
(defun bh_bf2c_#3b ()
	(- (+ (kh_bf2c_#2b) (* ZBtwn 0.5) ZBot) ad_et)
)

;Boydolap üç çekemeceli modülüm dar çekmecesi kapak boþluk tölaraslarý kapaða yedirilmi ve kapaklara paylaþtýrýlmýþtýr.
(defun bh_bf3c_#1b ()
	;(- (+ (* (- (- ad_ADH (* ZBtwn 0.5)) (* ZBtwn 0.5) ZBtwn ZBtwn ZBtwn ZBot) 0.25) ZBtwn) (* ad_et 0.5))
	(- (+ (kh_bf3c_#1b) ZBtwn) (* ad_et 0.5))
)

(defun bh_bf3c_#2b ()	
	 (+ (kh_bf3c_#1b) ZBtwn) 
)

(defun kh_bf3c_#1b ()
	(- (* (- (- ad_ADH (* ZBtwn 0.5)) (* ZBtwn 0.5) ZBtwn ZBtwn ZBtwn ZBot) 0.25) (* (- g_ClearBaseZTop g_ClearWallZBtwn) 0.25))
)

;Boydolap üç çekemeceli modülüm alt büyük çekmecesi kapak boþluk tölaraslarý kapaða yedirilmi ve kapaklara paylaþtýrýlmýþtýr.
(defun bh_bf3c_#3b ()
	(- (+ (kh_bf3c_#3b) (* ZBtwn 0.5) Zbot)  ad_et )
)
(defun kh_bf3c_#3b ()
	(- (+ (* (- (- ad_ADH (* ZBtwn 0.5)) (* ZBtwn 0.5) ZBtwn ZBtwn ZBtwn ZBot) 0.50) ZBtwn) (* (- g_ClearBaseZTop g_ClearWallZBtwn) 0.50))
)

;Boy Fýrýn Mikrodalgalý modül üst kapak bölüm
(defun bh_bfmd_#1b ()
	 (- remCTH (bh_bfmd_#2b)) 
)

(defun kh_bfmd_#1b ()
	(+ (- ( bh_bfmd_#1b ) Ztop (* ZBtwn 0.5) ) (* ad_et 1.5))
)

;Boy Fýrýn Mikrodalga alt sabit çekmeceli
(defun bh_bfmd_#2b ()
	(- (+ (kh_bfmd_#2b) (* ZBtwn 0.5) Zbot) (* ad_et 1.5))
)

(defun kh_bfmd_#2b ()
	(- (* (- ad_ADH ZTop ZBtwn ZBot) 0.50) (* (- g_ClearBaseZTop g_ClearWallZBtwn) 0.50))
)

;Buzdolabý kabini BDH1
(defun BCH1 ()
	(+ ad_BDH1 ad_bazaH)
)

;Buzdolabý kabini BDH2
(defun BCH2 ()
	(+ ad_BDH2 ad_bazaH)
)

;________
;Yarýmboy dolap yüksekliði
(defun YBOY ()
	(- ad_UDY ad_bazaH)
)

;Yarýmboy dolap içi 
(defun gm1_YBOY_RAF ()
	(gm1_createShelfDividList curDivH ad_et 3.0)
)

;Yarýmboy tek kapaklý dolap
(defun bh_yboy ()
	 remCTH
)
(defun kh_yboy ()
	 (- H ZTop ZBot)
)

;_______
;Yarýmboy Fýrýn Mikrodalga alt sabit çekmeceli
;Üst bölüm sabit parca 
(defun bh_ybd_#1b ()
	(- remCTH (- (- (* ad_ADH 0.25) (* ZBtwn 0.5) ) (* ad_et 1.5)))
)

(defun kh_ybd_#1b ()
	(+ (- remCTH (- (- (* ad_ADH 0.25) (* ZBtwn 0.5) ) (* ad_et 1.5))) (- ad_et Ztop) )
)

(defun bh_ybd_#2b ()
	(- (* ad_ADH 0.25) (* ZBtwn 0.5) (* ad_et 1.5))
)

(defun kh_ybd_#2b ()
	(- (- (* ad_ADH 0.25) (* ZBtwn 0.5)) (* ZBtwn 0.5) ZBot)
)

;bardaklýklýk
(defun Ust_Brdk_b1 (inputUDH / temph)
	(setq temph (- inputUDH ad_et ad_et ad_et (cm2cu bh_bardak)))
)
	
(defun Ust_Brdk_k1 (inputUDH / temph)
	(setq temph (- (- inputUDH (* ad_et 0.5) ad_et bh_bardak) (* ZBtwn 0.5) Ztop))
)
;Bardaklýk modülü kapak ve bölüm yükseklikleri
(setq bh_bardak (cm 26.7))

(defun kh_bardak (/)
	(+ bh_bardak ad_et (- g_ClearWallZBot) (/ (- ad_et zbtwn) 2))
)


;seramik lavabolu evye ustu
(setq bh_SEH1 (cm 25.5))
(setq bh_SEH2 (cm 12.5))
(setq bh_SEH3 (cm 18))

;TPF02 Taç parametreleri
(setq TPF02_H1 (cm 8.0))										; L taç yüksekliði ön parça
(setq TPF02_D1 (cm 6.0))										; L taç derinliði alt parça
(setq TPF02_T1 ad_et)											; L taç panel kalýnlýðý
;TPF01 Taç parametreleri
(setq PRF1_D1 (cm 8.0))											; Düz taç derinliði
(setq PRF1_T1 ad_et)											; Düz taç panel kalýnlýðý


;mikro FIRIN ve arka bosluk parametreleri
(setq applianceBackOffsetValue (cm 5.0))						; boy cihaz arka havalandýrma için kanalýn baþlayacaðý yer - henüz implemente edilmedi
(setq applianceBackOffsetTOP applianceBackOffsetValue)			; üst havalandýrma
(setq applianceBackOffsetBOT applianceBackOffsetValue)			; alt havalandýrma

(setq bh_integratedOven (cm 58.5))								; fýrýn bölümü istenen iç boþluk
(setq bh_integratedMikroValue (cm 38.5))						; mikro bölümü istenen iç boþluk
(setq kh_integratedMikroDoor (cm 10.00000001))					; mikro bölümü klapa yüksekliði


; mikro ic bosluk hesapla
(defun bh_integratedMikro ()
	(- bh_integratedMikroValue (* 0.5 zbtwn))
)

; mikrodalga sabit klapa ic bosluk hesapla
(defun bh_integratedMikroDoor ()
	(+ (- kh_integratedMikroDoor (* 0.5 (- ad_et zbtwn)) ) (* 0.5 zbtwn))
)
;mikrodalga ocak sabit klapa is bosluk hesapla
(defun bh_integratedCooktop ()
	(- kh_integratedMikroDoor (- ad_et g_ClearBaseZTop (* 0.5 zbtwn) ))
)

; firin ic bosluk tezgah arasina gore hesapla
(defun bh_integratedOvenCounter ()
	(if	(<= (yboy) (+ ad_adh (- ad_UDY ad_ADH ad_bazaH)) )
		bh_integratedOven
		(- ad_UDY ad_ADH ad_bazaH)
	)
)

;firin mikro yükseklikleri komutlarý -> anlýk çalýþýyor
(defun c:firinh (/ ovh)
	(initget 6 )
	(setq ovh (getreal (sprintf "\nFýrýn yüksekliði <~F>: " bh_integratedOven) ))
	(if ovh 
		(setq bh_integratedOven ovh)
	)
)

(defun c:mikroh (/ mwh)
	(initget 6 )
	(setq mwh (getreal (sprintf "\nMikrodalga yüksekliði <~F>: " bh_integratedMikroValue) ))
	(if mwh 
		(setq bh_integratedMikroValue mwh)
	)
)

(defun c:klapah (/ ) (c:mikroklapa))
(defun c:mikroklapa (/ mwd)
	(initget 6 )
	(setq mwd (getreal (sprintf "\nMikrodalga yüksekliði <~F>: " kh_integratedMikroDoor) ))
	(if mwd 
		(setq kh_integratedMikroDoor mwd)
	)
)

;aspiratör parametreleri
(setq gm1_aspiratorH (cm 13.80))			; cekme aspirator iç boþluk yüksekliði
(setq gm1_aspiratorH2 (cm 19.0))			; aspirator iç boþluk yüksekliði
(setq gm1_aspiratorMinH (cm 66.0))			; aspirator min tezgah boþluðu yüksekliði
(setq gm1_aspiratorMvalue nil)				; aspirator modül yüksekliði deðeri sabit

; aspirator modül yükseklik farký hesapla
(defun GM1_ASPIRATORMH ()
	(if gm1_aspiratorMvalue	gm1_aspiratorMvalue	(- gm1_aspiratorMinH (- ad_UDY ad_ADH ad_TezH ad_bazaH)))
)

;cekme aspiratör cihaz boþluðunun iç bölüm hesapla
(defun bh_aspiratorH ()
	(- unitH ad_et ad_et gm1_aspiratorH)
)

;aspiratör cihaz boþluðunun iç bölüm hesapla
(defun bh_aspiratorH2 ()
	(- unitH ad_et ad_et gm1_aspiratorH2)
)

;Asp. dolabý kapaðý
(defun kh_1bd_asp ()
	(+ (- unitH ZTop ZBot) gm1_aspiratorH)
)

(defun gm1_BOYDIVDIF ()	(- ad_et (- ad_adh (bh_boy2_#2b) ad_et)) )							;alt oryantasyonlu boy dolap sabitrafý ve adh farký hesabý
(defun appDoorLiftValue () g_ClearBaseZTop)													;arzu edilen fark
(defun appDoorLiftDiff ()	(- (+ (* 0.5 (- ad_et zbtwn)) zbtwn) (appdoorliftvalue)) )		;boy cihaz dolap sabit raf yukarý kaldýrma hesaplamasý

; Multi cek formul GM1
(defun gm1_DIVBOL (BOLUMSAYISI / RAFSAYISI inH divH)
	(setq RAFSAYISI (- BOLUMSAYISI 1) )
	(setq inH (- Unith (* 2 ad_et) ) )
	(setq divH (/ (- inH (* RAFSAYISI ad_et)) (* 1.0 BOLUMSAYISI) ) )
	divH
)
	
(defun gm1_DIVBOL_fix (BOLUMSAYISI / RAFSAYISI inH divH)
	(setq RAFSAYISI (- BOLUMSAYISI 1) )
	(setq inH (- ad_ADH (* 2 ad_et) ) )
	(setq divH (/ (- inH (* RAFSAYISI ad_et)) (* 1.0 BOLUMSAYISI) ) )
	divH
)

(defun gm1_DOORBOL (BOLSAY KAPAKSAY / k1H kxH kh)
	(setq k1H ( - unitH g_ClearBaseZBot g_ClearBaseZTop) )
	(setq kxH (/ (- k1H (* (- BOLSAY 1) ZBtwn)) (* 1.0 BOLSAY) ) )
	(setq kh (+ ( * kxh kapaksay) (* (- kapaksay 1) zbtwn) ) )
	kh
)

(defun gm1_DOORBOL_fix (BOLSAY KAPAKSAY / k1H kxH kh)
	(setq k1H ( - ad_adh g_ClearBaseZBot g_ClearBaseZTop))
	(setq kxH (/ (- k1H (* (- BOLSAY 1) ZBtwn)) (* 1.0 BOLSAY) ) )
	(setq kh (+ ( * kxh kapaksay) (* (- kapaksay 1) zbtwn) ) )
	kh
)


;;;;;;;;;;;;;;;;;;;;;;; Rutin Fonksiyonlar
; rutin fonksiyonu. module otomatik vside gyan yapar.
; (autoVsideUnit 0 15)
; (autoVsideUnit 0 ad_bazah)
(defun autoVsideUnit ( back down )
	(drawVisibleSides (entlast) 3 (list back down))
	(princ)
)

;(autoMoveUnitOnce (bzdu_moveOnce))
(defun bzdu_moveOnce ( / bzdu_moveOnceValue)
	(setq bzdu_moveOnceValue nil)
	(if	bzdu_moveOnceValue 
		bzdu_moveOnceValue
		(- ad_ADDER unitD)
	)
)

; rutin fonksiyonu. yerleþen modülü y kadar öne kaydýrýr. veya '(x y z) kadar kaydýr.
; (autoMoveUnitOnce y)
; (autoMoveUnitOnce '(x y z))
; (autoMoveUnitOnce '(x y z ang))
; (autoMoveUnitOnce (list x y z ang))
; (autoMoveUnitOnce (list (- unitw) unitd (- ad_bazah) 180))
(defun autoMoveUnitOnce (dist / myObj curAng curPos 2Pos distx disty distz 2ang)
	(if (not mozel_mUnit)
		(progn
			(if (equal (type dist) 'LIST)
				(setq
					distx	(getnth 0 dist)
					disty	(getnth 1 dist)
					distz	(getnth 2 dist)
					2ang	(getnth 3 dist)
				)
				(setq disty dist)
			)
			
			(setq 
				myObj	(entlast)						;rutine yazýnca entlast modul olur
				curAng	(+ (dfetch 50 myObj) DEG_90)
				curPos	(dfetch 10 myObj)
			)
			
			(if disty
				(progn
					(setq 2pos (polar curPos curAng (- disty)))
					(command "_.move" myObj "" curPos 2pos)
					(setq curPos 2pos)
				)
			)
		
			(if distx
				(progn
					(setq 2pos (polar curPos (- curAng DEG_90) (- distx)))
					(command "_.move" myObj "" curPos 2pos)
					(setq curPos 2pos)
				)
			)
		
			(if distz
				(progn
					;(command "_.MOVE" myObj "" "_.mOde" "" (list 0 0 distz))	; vector mOde olmuyor
					(setq 2Pos (replace (+ distz (getnth 2 curPos)) 2 curPos))
					(command "_.move" myObj "" curPos 2pos)
					(setq curPos 2pos)
				)
			)
			
			(if 2ang
				(command "_rotate" myObj "" curPos 2ang)
			)
		)
	)
	(princ)
)

(setq autoCookerNAM '(Set-ocak))
(setq autoCookerVAL 60)

;(autoCookerOnce autoCookerNAM autoCookerVAL)
;(autoCookerOnce "CGLux604GAIAL" 60)
;(autoCookerOnce '(ET73S502E) 30)
;(autoCookerOnce '(Set-ocak) 60)
;(autoCookerOnce (QUOTE (Set-ocak)) 60)
(defun autoCookerOnce (insblk ovenWID /  evmod yp1 aci H EN)
	(if (not mozel_mUnit)
		(progn
			(if (not (equal (type insblk) 'STR))
				(setq insblk (quoteList2str insblk))
			)
			(setq	evmod	(entget (car (list (entlast)  (dfetch 10 (entlast))))))
			(setq	H   	(get_Mdata evmod k:HEI))
			(setq	EN  	(get_Mdata evmod k:WID))
			(setq	aci 	(cdr (assoc 50 evmod)))
			(setq	yp1 	(cdr (assoc 10 evmod)))
			(setq	yp1		(polar yp1 aci (* 0.5 (- EN ovenWID))))

			(setlayer "APP_BODY_BASE" 7)
			(command cmdINSERT (findblock insblk))
			(command (xyofz yp1 (+ (caddr yp1) H ad_TezH (cm 0.3))) "" "" (r2d aci))
			(set_Mdata (entlast)
				(list 
					(cons k:MTYP "SET_OCAK")
				)
			)
		)
	)
)



;;;;;;;;;;;;;;;;;;;;;;; Temel Fonksiyonlar
(defun GM1_restH_BASE (divIndex)
	(if mozel_mUnit
		(gm1_calcRestH (- divIndex 1))
		(gm1_calcRestH_Selective (- divIndex 1) (if BDH BDH (if newH newH (lmm_atofFormula (getnth 3 (assoc kodFormula mLofL))))) (if divisionList divisionList (if newDivs newDivs (cadr (getnth 6 (assoc kodFormula mLofL))))))
	)
)

(defun GM1_restDoorH_BASE (divIndex)
	(if mozel_mUnit
		(gm1_calcRestDoorH (- divIndex 1))
		(gm1_calcRestDoorH_Selective (- divIndex 1) (if BDH BDH (if newH newH (lmm_atofFormula (getnth 3 (assoc kodFormula mLofL))))) (if divisionList divisionList (if newDivs newDivs (cadr (getnth 6 (assoc kodFormula mLofL))))))
	)
)

; bölüm kalaný hesaplama (bölüm numarasý ile kullanýlýr)  ;{(GM1_restH 1)}
(defun GM1_restH (divIndex) 
	(setq divHFormulation (strcat "{(GM1_restH " (rtos divIndex) ")}"))
	(rtos (GM1_restH_BASE divIndex) 2 4)
)

;{(GM1_restH_V2 3 (QUOTE (+ AY (AX) 5) ))}
;{(GM1_restH_V2 3 (QUOTE 0 ))}
(defun GM1_restH_v2 (divIndex params)
	(setq divHFormulation (strcat "{(GM1_restH_V2 " (rtos divIndex) " " (convertstr (cons 'QUOTE (list params))) ")}"))
	(rtos (+ (GM1_restH_BASE divIndex) (eval params)) 2 4)
)

;kapak kalaný hesaplama (bölüm numarasý ile kullanýlýr)  ;{(GM1_restDoorH 1)}
(defun GM1_restDoorH (divIndex)
	(setq doorHFormulation (strcat "{(GM1_restDoorH " (rtos divIndex) ")}"))
	(rtos (GM1_restDoorH_BASE divIndex) 2 4)
)

;{(GM1_restdoorH_V2 3 (QUOTE (+ AY (AX) 5) ))}
(defun GM1_restDoorH_v2 (divIndex params / response i)
	(setq doorHFormulation (strcat "{(GM1_restDoorH_v2 " (rtos divIndex) " " (convertstr (cons 'QUOTE (list params))) ")}"))
	(rtos (+ (GM1_restDoorH_BASE divIndex) (eval params)) 2 4)
)

;gola wyswyg scriptlerinde kullanýlmasý için yazýldý. kullaným -> (gm1_divHei 2 0.0) -> 2. bölümün üst kýsmýnýn module göre yüksekliðini bulur ve bu yüksekliðe 0.0 offsetini ekleyip geri döndürür.
(defun gm1_divHei (divNo heiOffset / totalHei divisionInfo i) 	
	(setq divNo (- divNo 1) totalHei 0.0 i 0)
	(while (>= divNo i)
		(setq totalHei (+ totalHei (lmm_atofFormula (if (equal i 0) ad_et (ifnull (cadr (getnth (- i 1) divisionList)) ad_et)))))
		(setq i (+ i 1))
	)
	(+ (- BDH totalHei) heiOffset)
)

;gm1 bölüm yüksekliði deðerini fonksiyona çevir. kullaným -> (gm1_divNoHei 2)
 (defun gm1_divNoHei (divNo)
	(if mozel_mUnit
		(lmm_atofFormula (cadr (getnth (- divNo 1) newDivs)))
		(lmm_atofFormula (cadr (getnth (- divNo 1) (if divisionList divisionList (cadr (getnth 6 (assoc kodFormula mLofL)))))))
	)
)

;isminde gm1 olduðuna bakmayýn. Önceden öyleydi fakat, birileri, tanýmýnda "gm1_" in belirtilmesine ramen gm1 dýþýnda da kullanýnca, genel bir curUnitH fonksiyonuna çevirdim(HASAN)
(defun gm1_curUnitH () 
	(if mozel_mUnit 
		newH 
		(if BDH ;gm1
			BDH
			(if UDH ;üst köþe
				UDH
				(if ADH ;alt köþe
					ADH
					(if (member (getnth 1 (assoc kodFormula mLofL)) (list 'AK2 'UK2))		; Köþe modül için özel kontrol
						(lmm_atofFormula (getnth 4 (assoc kodFormula mLofL)))
						(lmm_atofFormula (getnth 3 (assoc kodFormula mLofL)))
					)
				)
			)
		)
	)
)

;______________IÞIK AYARLARI_________________
(defun c:altspotofset ()
	(setq gm1_altspotofset (getreal "\Dolap altý spot deliðinin arkadan ofset deðeri?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_altspotofset" (rtos gm1_altspotofset 2 4))
	(princ)
)
(defun c:altspotdia ()
	(setq gm1_altspotdia (getreal "\Dolap altý spot deliðinin çapý?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_altspotdia" (rtos gm1_altspotdia 2 4))
	(princ)
)
(defun c:altspotdep ()
	(setq gm1_altspotdep (getreal "\Dolap altý spot deliðinin derinliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_altspotdep" (rtos gm1_altspotdep 2 4))
	(princ)
)
(defun c:ustspotofset ()
	(setq gm1_ustspotofset (getreal "\Dolap ustu spot deliðinin arkadan ofset deðeri?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_ustspotofset" (rtos gm1_ustspotofset 2 4))
	(princ)
)
(defun c:ustspotdia ()
	(setq gm1_ustspotdia (getreal "\Dolap ustu spot deliðinin çapý?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_ustspotdia" (rtos gm1_ustspotdia 2 4))
	(princ)
)
(defun c:ustspotdep ()
	(setq gm1_ustspotdep (getreal "\Dolap ustu spot deliðinin derinliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_ustspotdep" (rtos gm1_ustspotdep 2 4))
	(princ)
)
(defun c:altledofset ()
	(setq gm1_altledofset (getreal "\Dolap altý led kalanýnýn önden ofset deðeri?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_altledofset" (rtos gm1_altledofset 2 4))
	(princ)
)
(defun c:altledwid ()
	(setq gm1_altledwid (getreal "\Dolap altý led kanalý geniþliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_altledwid" (rtos gm1_altledwid 2 4))
	(princ)
)
(defun c:altleddep ()
	(setq gm1_altleddep (getreal "\Dolap altý led kanalý derinliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_altleddep" (rtos gm1_altleddep 2 4))
	(princ)
)
(defun c:solledofset ()
	(setq gm1_solledofset (getreal "\Dolap içi sol led kalanýnýn önden ofset deðeri?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_solledofset" (rtos gm1_solledofset 2 4))
	(princ)
)
(defun c:solledwid ()
	(setq gm1_solledwid (getreal "\Dolap içi sol led kanalý geniþliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_solledwid" (rtos gm1_solledwid 2 4))
	(princ)
)
(defun c:solleddep ()
	(setq gm1_solleddep (getreal "\Dolap içi sol led kanalý derinliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_solleddep" (rtos gm1_solleddep 2 4))
	(princ)
)
(defun c:sagledofset ()
	(setq gm1_sagledofset (getreal "\Dolap içi sag led kalanýnýn önden ofset deðeri?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_sagledofset" (rtos gm1_sagledofset 2 4))
	(princ)
)
(defun c:sagledwid ()
	(setq gm1_sagledwid (getreal "\Dolap içi sag led kanalý geniþliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_sagledwid" (rtos gm1_sagledwid 2 4))
	(princ)
)
(defun c:sagleddep ()
	(setq gm1_sagleddep (getreal "\Dolap içi sag led kanalý derinliði?:"))
	(iniwrite ad_MOD-INI "lightsettings" "gm1_sagleddep" (rtos gm1_sagleddep 2 4))
	(princ)
)
(setq gm1_altspotofset	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_altspotofset"	"15.0"	)))
(setq gm1_altspotdia	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_altspotdia"		"8"		)))
(setq gm1_altspotdep	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_altspotdep"		"1.2"	)))
(setq gm1_ustspotofset	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_ustspotofset"	"15.0"	)))
(setq gm1_ustspotdia	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_ustspotdia"		"8"		)))
(setq gm1_ustspotdep	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_ustspotdep"		"1.2"	)))
(setq gm1_altledofset	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_altledofset"	"15.0"	)))
(setq gm1_altledwid		(atof (iniread ad_MOD-INI  "lightsettings" "gm1_altledwid"		"1.8"	)))
(setq gm1_altleddep		(atof (iniread ad_MOD-INI  "lightsettings" "gm1_altleddep"		"1.2"	)))
(setq gm1_solledofset	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_solledofset"	"15.0"	)))
(setq gm1_solledwid		(atof (iniread ad_MOD-INI  "lightsettings" "gm1_solledwid"		"1.8"	)))
(setq gm1_solleddep		(atof (iniread ad_MOD-INI  "lightsettings" "gm1_solleddep"		"1.2"	)))
(setq gm1_sagledofset	(atof (iniread ad_MOD-INI  "lightsettings" "gm1_sagledofset"	"15.0"	)))
(setq gm1_sagledwid		(atof (iniread ad_MOD-INI  "lightsettings" "gm1_sagledwid"		"1.8"	)))
(setq gm1_sagleddep		(atof (iniread ad_MOD-INI  "lightsettings" "gm1_sagleddep"		"1.2"	)))

;;;;;;;;;;;;;;;;;;;;;;; PROFÝLLER
(setq prfKS "Kulpsuz_Cam_Kapak_Profili") 		;Cam kapak profili kulpsuz
(setq prfKL "Kulplu_Cam_Kapak_Profili")			;Cam kapak profili boy kulplu
(setq prfKL2 "Kisa_Kulplu_Cam_Kapak_Profili")	;Cam kapak profili kulplu
(setq prfT "T_Kapak_Citasi_Kalin")				;T kapak profili kalýn
(setq prfT2 "T_Kapak_Citasi_Ince")				;T kapak profili ince
(setq entT2 "Duz_entegre_kulp") 				;Düz entegre kulp
(setq entT3 "Acili_entegre_kulp") 				;Acili entegre kulp
(setq entT4 "Oval_entegre_kulp") 				;Oval entegre kulp
(setq prfA "Apachi_kulp") 						;Apachi kulp profili
(setq prfW "Ahsap_elcikli_profil") 				;Ahþap malzemeli elcikli profil kulp

;;;;;;;;;;;;;;;;;;;;;;; DXFROT4CAM
(setq DXFROT4CAM nil)

;;;;;;;;;;;;;;;;;;;;;;; iz delik
(setq izCap 3.0)
(setq izDer 1.0)

;;;;;;;;;;;;;;;;;;;;;;; KENARBANT
(setq PvcKoduKAPAK "PVC1mm")		;Genel kapak bant ismi
(setq PvcKoduProfil nil)			;Kenarlarýna kulp gelen kapaklarýn kenarbandý
(setq PvcKoduGENEL nil)				;Genel kenar bant ismi
(setq PvcKoduUST "PVC04mm")			;Üst taraflar
(setq PvcKoduALT "PVC04mm")			;Alt taraflar
(setq PvcKoduYAN "PVC04mm")			;Yan taraflar
(setq PvcKoduON "PVC04mm")			;Ön taraflar
(setq PvcKoduARKA "PVC04mm")		;Arka tarafa bakan
(setq PvcKoduSARKA "PVC04mm")		;Sabit Raf / Dikme için Arka tarafa bakan
(setq PvcKoduHRafYan "PVC04mm")		;Hareketli raf yan taraflar
(setq PvcKoduHRafArka "PVC04mm")	;Hareketli raf arka taraflar
(setq PvcKoduCONN nil)				;Baðlayýcý gelen yere bant
(setq PvcKodu45 nil)				;45 Birleþim gelen yere gelen bant
(setq PvcKoduCekUst "PVC04mm")		;Cekmece üst taraflar
(setq PvcKoduCekAlt "PVC04mm")		;Cekmece alt taraflar
(setq PvcKoduCekArka nil)			;Cekmece arka taraflar
(setq PvcKoduCekOn nil)				;Cekmece on taraflar
(setq PvcKoduCekYAN nil)			;Cekmece yan taraflar
(setq PvcKoduBazaUst "PVC04mm")		;Baza üst taraflar
(setq PvcKoduBazaAlt "PVC04mm")		;Baza alt taraflar



(if	(findfile (strcat ad_defpath "ulibformulwwg.lsp")) (load (strcat ad_defpath "ulibformulwwg.lsp")))
(if	(findfile (strcat ad_defpath "ulibformullabour.lsp")) (load (strcat ad_defpath "ulibformullabour.lsp")))
(if	(findfile (strcat ad_defpath "ulibformulgola.lsp")) (load (strcat ad_defpath "ulibformulgola.lsp")))
(if	(findfile (strcat ad_defpath "ulibformulpml.lsp")) (load (strcat ad_defpath "ulibformulpml.lsp"))) ;(progn (if (not PML_unlocked) (progn (setq PML_crashWrong T) (c:blockesc)(PML)(c:unblockesc))))
(if	(findfile (strcat ad_defpath "ulibformulkapak.lsp")) (load (strcat ad_defpath "ulibformulkapak.lsp")))