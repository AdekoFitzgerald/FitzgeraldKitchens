;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; GOLA part2cam formulleri
(defun ManualBottomPanelGolaOp () (ManualPanelGolaOp "BOTTOM"))
(defun ManualTopPanelGolaOp () (ManualPanelGolaOp "TOP"))
(defun ManualPanelGolaOp ( args / pH pD gU aL cL BL aR cR bR leftSideLine rightSideLine leftLowLine rectL rectR)

;               |^ y+                | bottom panel
;               |                    |
;               |                    |
;    al.___gU___|ph__.cl      cr.____|________.ar
;               |    |          |    |
;               |____pd_________|____|
;              0     |          |    > x+
;					 |		    |
;					 |		    |
;                    .bL        . bR

	(if (and (equal args "BOTTOM") (not (equal BOTTOMSIDE_STYLE "BOTTOM_BETWEEN_SIDES")))
		(progn
			(setq
				pD	(- ( cu2mm ad_golaTallModuleSidePanelFrontVariance))	;onden front
				pH	__AD_PANELTHICK											;yandan side
				gU	(ifnull GOLA_APPROACH_DISTANCE 3.0)						;yaklasma / uzaklasma
				aL	(_	(+ 0 pD)	(- __WID (- 0 gU)))
				cL	(_	(+ 0 pD)	(- __WID (+ 0 pH)))
				bL	(_	(- 0 gU)	(- __WID (+ 0 pH)))
				aR	(_	(+ 0 pD)	(- __WID (+ __WID gU)))
				cR	(_	(+ 0 PD)	(- __WID (- __WID pH)))
				bR	(_	(- 0 gU)	(- __WID (- __WID pH)))
			)			;Y			;X						; alt panelde lmm_drawPolyline fonksiyonunda ( X Y ) ters. Yani ( Y X )
			
			(if (car (isSidesOccupiedByVerticalGolaProfile g_currentModulEnt ad_verticalGolaLayers)) ;solda boy vertical gola varsa
				(progn
					(setq leftSideLine (lmm_drawPolyline (_ al 0.0 cl 0.0 (_ (+ (- gU) pD) (- __WID (+ 0 pH))) 0.0) "GOLA_LAYER_TOP_2" "nil"))
					(changeEntPro leftSideLine 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA leftSideLine "GOLA" BOTTOM_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq leftLowline (lmm_drawPolyline (_ bL 0.0 cl 0.0 (_ (+ 0 pD) (- __WID (+ 0 pH (- gU)))) 0.0) "GOLA_LAYER_TOP_1" "nil"))
					(changeEntPro leftLowline 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA leftLowline "GOLA" BOTTOM_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq rectL (lmm_drawPolyline
							(_ 
								(reverse (_ __WID 0.0)) 0.0
								(reverse (_ __WID	pD)) 0.0
								(reverse (_ (- __WID pH) pD)) 0.0
								(reverse (_ (- __WID pH) 0.0)) 0.0 
								(reverse (_ __WID 0.0)) 0.0
							) "PK2" "nil" ))
					(changeEntPro rectL 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rectL "GOLA" BOTTOM_PANEL_CODE nil "GOLA" (_ 1 0))
				)
			)
		
			(if (cadr (isSidesOccupiedByVerticalGolaProfile g_currentModulEnt ad_verticalGolaLayers)) ;sagda boy vertical gola varsa
				(progn
					(setq rightSideLine (lmm_drawPolyline (_ aR 0.0 cR 0.0 (_ (+ (- gU) pD) (- __WID (- __WID pH))) 0.0) "GOLA_LAYER_TOP_2" "nil"))
					(changeEntPro rightSideLine 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rightSideLine "GOLA" BOTTOM_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq rightLowLine (lmm_drawPolyline (_ bR 0.0 cR 0.0 (_ (+ 0 pD) (- __WID (- __WID pH (- gU)))) 0.0) "GOLA_LAYER_TOP_1" "nil"))
					(changeEntPro rightLowLine 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rightLowLine "GOLA" BOTTOM_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq rectR (lmm_drawPolyline
							(_ 
								(reverse (_ 0.0 0.0)) 0.0
								(reverse (_ 0.0	pD)) 0.0
								(reverse (_ pH	pD)) 0.0
								(reverse (_ pH	0.0)) 0.0 
								(reverse (_ 0.0 0.0)) 0.0
							) "PK2" "nil"))
					(changeEntPro rectR 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rectR "GOLA" BOTTOM_PANEL_CODE nil "GOLA" (_ 1 0))
				)
			)
		)
	)

;			   0
;               |^ y+                | top panel
;               |                    |
;               |                    |
;    ar.___gU___|ph__.cr      cl.____|________.al
;               |    |          |    |
;               |____pd_________|____| __WID
;       topPanelHei  |          |    > x+
;					 bR	        bL
	
	(if (and (equal args "TOP") (not (equal TOPSIDE_STYLE "TOP_BETWEEN_SIDES")))
		(progn
			(setq
				topPanelHei TOP_PANEL_HEI
				pD	(- ( cu2mm ad_golaTallModuleSidePanelFrontVariance))
				pH	__AD_PANELTHICK
				gU	(ifnull GOLA_APPROACH_DISTANCE 3.0)
				aL	(_	(- topPanelHei pD)	(+ __WID gU))    ; Negated X
				cL	(_	(- topPanelHei pD)	(- __WID pH))     ; Negated X
				bL	(_	(+ topPanelHei gU)  (- __WID pH))    ; Negated X
				aR (_ (- topPanelHei pD) (- gU))
				cR (_ (- topPanelHei pD) pH)
				bR (_ (+ topPanelHei gU) pH)
			)
			(if (car (isSidesOccupiedByVerticalGolaProfile g_currentModulEnt ad_verticalGolaLayers))
				(progn
					;modulun soluna atýlan gola, ust panelin sagina kertik acar
					(setq leftSideLine (lmm_drawPolyline (_ al 0.0 cl 0.0 (_ (- topPanelHei (- pD gU)) (- __WID pH)) 0.0) "GOLA_LAYER_TOP_2" "nil"))
					(changeEntPro leftSideLine 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA leftSideLine "GOLA" TOP_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq leftLowline (lmm_drawPolyline (_ bL 0.0 cl 0.0 (_ (- topPanelHei pD) (- __WID (- pH gU))) 0.0) "GOLA_LAYER_TOP_1" "nil"))
					(changeEntPro leftLowline 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA leftLowline "GOLA" TOP_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq rectL (lmm_drawPolyline
							(_ 
								(_ topPanelHei __WID) 0.0
								(_ topPanelHei (- __WID pH)) 0.0
								(_ (- topPanelHei pD) (- __WID pH)) 0.0
								(_ (- topPanelHei pD) __WID) 0.0 
								(_ topPanelHei __WID) 0.0
							) "PK2" "nil" ))
					(changeEntPro rectL 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rectL "GOLA" TOP_PANEL_CODE nil "GOLA" (_ 1 0))
				)
			)
			;modulun sagina atýlan gola, ust panelin soluna kertik acar
			(if (cadr (isSidesOccupiedByVerticalGolaProfile g_currentModulEnt ad_verticalGolaLayers))
				(progn
					(setq rightSideLine (lmm_drawPolyline (_ aR 0.0 cR 0.0 (_ (- topPanelHei (- pD gU)) pH) 0.0) "GOLA_LAYER_TOP_2" "nil"))
					(changeEntPro rightSideLine 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rightSideLine "GOLA" TOP_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq rightLowLine (lmm_drawPolyline (_ bR 0.0 cR 0.0 (_ (- topPanelHei pD) gU) 0.0) "GOLA_LAYER_TOP_1" "nil"))
					(changeEntPro rightLowLine 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rightLowLine "GOLA" TOP_PANEL_CODE nil "GOLA" (_ 1 0))
					(setq rectR (lmm_drawPolyline
							(_ 
								(_ topPanelHei 0.0) 0.0
								(_ topPanelHei pH) 0.0
								(_ (- topPanelHei pD) pH) 0.0
								(_ (- topPanelHei pD) 0.0) 0.0 
								(_ topPanelHei 0.0) 0.0
							) "PK2" "nil"))
					(changeEntPro rectR 39 (- __AD_PANELTHICK))
					(lmm_createObjsLMMDATA rectR "GOLA" TOP_PANEL_CODE nil "GOLA" (_ 1 0))
				)
			)
		)
	)
)

(defun generate_special_golaRectPattern (panelCode ctrlPLineLists / gU panelOrientType golaType pairedPlineLists orderedPLineLists pLine newPLine golaP1 golaP2 golaP3 golaP4 orderedPLine orderedPLine1 orderedPLine2 orderedPLine3 orderedPLine4 golaRect)
	
	(setq gU (ifnull GOLA_APPROACH_DISTANCE 3.0))
	
	;approach value should be adjusted according to which panel we are working on
	(cond
		((member panelCode (list (XSTR "LEFT_PANEL") (strcat (XSTR "CORNER_UNIT") "_" (XSTR "LEFT_PANEL")) (XSTR "NOTCHED_RIGHT_PANEL") (strcat (XSTR "CORNER_UNIT") "_" (XSTR "NOTCHED_LEFT_PANEL"))))
			(setq panelOrientType "LEFT")
		)
		((member panelCode (list (XSTR "RIGHT_PANEL") (strcat (XSTR "CORNER_UNIT") "_" (XSTR "RIGHT_PANEL")) (XSTR "NOTCHED_LEFT_PANEL") (strcat (XSTR "CORNER_UNIT") "_" (XSTR "NOTCHED_RIGHT_PANEL"))))
			(setq panelOrientType "RIGHT")
		)
	)
	
	;discard third point on each gola position list
	(setq ctrlPLineLists
		(mapcar '(lambda (x) 
			(reverse (cdr (reverse x)))
			) CtrlPLineLists)
	)
	
	;join related polylines
	(setq pairedPlineLists '())
	(setq i 0)
	(while (< (+ i 1) (length CtrlPLineLists))
		(setq pairedPlineLists 
			(append pairedPlineLists 
				(list (append (nth i CtrlPLineLists) 
							 (nth (+ i 1) CtrlPLineLists)))
			)
		)
		(setq i (+ i 2))
	)
	
	;put points inside list in order
	(setq orderedPLineLists '())
	(foreach pLine (reverse pairedPlineLists)
		(setq golaType nil)
		(if (equal (length pLine) 3) (setq golaType "LGOLA") (setq golaType "CGOLA"))
		(cond 
			((equal golaType "LGOLA")
				(setq golaP1 (removeat 2 (getnth 0 pLine)) 
					  golaP2 (removeat 2 (getnth 1 pLine)) 
					  golaP3 (removeat 2 (getnth 2 pLine))
					  golaP4 (list (getnth 0 golaP1) (getnth 1 golaP3))
				)
				
				;;;add approach distance according to gola type
				(if (equal panelOrientType "LEFT")
					(setq golaP1 (list (- (getnth 0 golaP1) gU) (getnth 1 golaP1))
						  golaP3 (list (getnth 0 golaP3) (+ (getnth 1 golaP3) gU))
						  golaP4 (list (- (getnth 0 golaP4) gU) (+ (getnth 1 golaP4) gU))
					)
				)
				(if (equal panelOrientType "RIGHT")
					(setq golaP1 (list (+ (getnth 0 golaP1) gU) (getnth 1 golaP1))
						  golaP3 (list (getnth 0 golaP3) (+ (getnth 1 golaP3) gU))
						  golaP4 (list (+ (getnth 0 golaP4) gU) (+ (getnth 1 golaP4) gU))
					)
				)
				(setq newPLine (list golaP1 golaP2 golaP3 golaP4))
				(setq orderedPLineLists (append (list newPLine) orderedPLineLists))
			)
			((equal golaType "CGOLA")
				;;reassign coordinates
				(setq golaP1 (removeat 2 (getnth 0 pLine)) 
					  golaP2 (removeat 2 (getnth 1 pLine)) 
					  golaP3 (removeat 2 (getnth 3 pLine))
					  golaP4 (removeat 2 (getnth 2 pLine))
				)
				
				;;;add approach distance according to gola type
				(if (equal panelOrientType "LEFT")
					(setq golaP1 (list (- (getnth 0 golaP1) gU) (getnth 1 golaP1))
						  golaP4 (list (- (getnth 0 golaP4) gU) (getnth 1 golaP4))
					)
				)
				(if (equal panelOrientType "RIGHT")
					(setq golaP1 (list (+ (getnth 0 golaP1) gU) (getnth 1 golaP1))
						  golaP4 (list (+ (getnth 0 golaP4) gU) (getnth 1 golaP4))
					)
				)
				(setq newPLine (list golaP1 golaP2 golaP3 golaP4))
				(setq orderedPLineLists (append (list newPLine) orderedPLineLists))
			)
		)
	)
	
	;create polylines according to data we have
	(foreach orderedPLine orderedPLineLists
		(setq orderedPLine1 (getnth 0 orderedPLine)
			  orderedPLine2 (getnth 1 orderedPLine)
			  orderedPLine3 (getnth 2 orderedPLine)
			  orderedPLine4 (getnth 3 orderedPLine)
		)
		(setq golaRect (lmm_drawPolyline (_ orderedPLine1 0.0 orderedPLine2 0.0 orderedPLine3 0.0 orderedPLine4 0.0 orderedPLine1 0.0) "GOLA_RECT" "nil"))
        (changeEntPro golaRect 39 (- __AD_PANELTHICK))
        (lmm_createObjsLMMDATA golaRect "GOLA" panelCode nil "GOLA" (_ 1 0))
	)
)

;modul tipine gore sag / sol gola op
(defun golaBlindSideOpDetection ()
	(if (or (equal __MODULTYPE "AK1") (equal __MODULTYPE "UK1"))
		(if (equal __MODULDIRECTION "L")
			2
			1
		)
		3
	)
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; GOLA S	;;;;;;;;;;;;;;;;;;;;;; GOLA S	;;;;;;;;;;;;;;;;;;;;;; GOLA S	;;;;;;;;;;;;;;;;;;;;;; GOLA S
(defun SgolaiLZBot () (cm 2.0))																														; S Sarkýk Gola (üst modül) kapak aþaðý sarkýtma hesaplamasý
(defun SgolaiLZ (tempCurDoorH) (+ (SgolaiLZbot) g_ClearWallZBot tempCurDoorH))																		; S Sarkýk Gola (üst modül) için  kapak ek toplam fonksiyonu -> modüldeki kapak formülüne SgolaiLZBotValue toplatmak için kullanýlýr.
(defun ke_SgolaiL () (- (SgolaiLZbot)))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; GOLA 1	;;;;;;;;;;;;;;;;;;;;;; GOLA 1	;;;;;;;;;;;;;;;;;;;;;; GOLA 1	;;;;;;;;;;;;;;;;;;;;;; GOLA 1
(setq 1GolaVLZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyL")))))                                             ; Boy VL Gola Derinliði
(setq 1GolaVLZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyL")))))                                             ; Boy VL Gola Yüksekliði
(setq 1GolaVLZThick (getnth 2 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyL")))))                                           ; Boy VL Gola Alu kalinligi

(setq 1GolaVCZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyC")))))                                             ; Boy VC Gola Derinliði
(setq 1GolaVCZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyC")))))                                             ; Boy VC Gola Yüksekliði
(setq 1GolaVCZThick (getnth 2 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyC")))))                                           ; Boy VC Gola Yüksekliði

(setq 1GolaViLZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyiL")))))                                           ; Boy ViL Gola Derinliði
(setq 1GolaViLZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileBoyiL")))))                                           ; Boy ViL Gola Alu kalinligi

(setq 1GolaiLZBotValue nil)																															; iL Gola (üst modül) kapak aþaðý sarkýtma deðeri -> nil ise yok.
(defun 1GolaiLZBot () (if 1GolaiLZBotValue 1GolaiLZbotValue (- 0 g_ClearWallZBot)))																	; iL Gola (üst modül) kapak aþaðý sarkýtma hesaplamasý
(defun 1GolaiLZ (tempCurDoorH) (+ (1GolaiLZbot) g_ClearWallZBot tempCurDoorH))																		; iL Gola (üst modül) için  kapak ek toplam fonksiyonu -> modüldeki kapak formülüne 1GolaiLZBotValue toplatmak için kullanýlýr.
(defun 1GolaiLZ/2 (tempCurDoorH) (+ (* 0.5 (1GolaiLZbot)) g_ClearWallZBot tempCurDoorH) )															; iL Gola (üst modül) için kapak ek yarým toplam fonksiyonu -> modüldeki kapak formülüne 1GolaiLZBotValue/2 toplattýrmak için kullanýlýr.
(setq 1GolaiLZDepValue (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileiL")))))											; iL Gola (üst modül) panel çektirme deðeri -> Modul.ini içinden iL1 profil derinliðini okur
(defun 1GolaiLZDep () (if 1GolaiLZDepValue 1GolaiLZDepValue 0))																						; iL Gola (üst modül) panel çektirme hesaplamasý
(defun 1GolaiLZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileiL")))))											; iL Gola profil yüksekliði -> Modul.ini içinden iL profil derinliðini okur						; iL Gola (üst modül) alt panel çektirme hesaplamasý
(defun ke_1GolaiLdep () (cu2mm (1GolaiLZDep)) )																										; iL gola için panel derinlik çektirme
(defun ke_1GolaiL () (- (if 1GolaiLZBotValue (+ 1GolaiLZBotValue g_ClearWallZBot) 0.0)))															; iL gola uk1 uk2 kapak sarkýtma (/kýrpma)

(setq 1GolaCZBot (cm 1.4))																															; C gola kapak alta uzatma istenen deðeri
(setq 1GolaCZTop 1GolaCZBot)                                                                                                                        ; C gola kapak uste uzatma istenen deðeri
(defun 1GolaCBtwn () (- (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileC")))) 1GolaCZBot 1GolaCZTop))					; C gola iki kapak arasý hesaplama -> Modul.ini içinden C1 profil yüksekliðini okuyor.
(defun 1GolaCZDep () (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileC")))))												; C gola profil derinliði -> Modul.ini içinden C1 profil derinliðini okur
(defun 1GolaCZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileC")))))												; C gola profil yüksekliði -> Modul.ini içinden C1 profil derinliðini okur

(setq 1GolaLZTop (1GolaCBtwn))																														; L gola kapak üstten boþluðu istenen deðeri
(defun 1GolaLZDep () (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileL")))))												; L gola profil derinliði -> Modul.ini içinden L1 profil derinliðini okur
(defun 1GolaLZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "1gola_profileL")))))												; L gola profil yüksekliði -> Modul.ini içinden L1 profil derinliðini okur

(defun ke_1GolaLAK () (- 1golaLZTop g_ClearBaseZTop))																								; L gola ak1 / ak2 kapak kýrpma
(defun ke_1GolaL () (- (- 1golaLZTop ad_et)))																										; L gola gm1 kapak indirme (/yükseltme)
(defun ke_1GolaL_bot () (- (- 1golaLZTop (* ZBtwn 0.5))))																							; L gola gm1 kapak alta indirme (/yükseltme)
(defun ke_1GolaC () (- (- (1GolaCBtwn) (* ZBtwn 0.5))))																								; C Gola gm1 kapak alta indirme (/yükseltme)

(defun ke_1GolaLdep () (cu2mm (1GolaLZDep)) )																										; L gola için üst panel derinlik çektirme -> kayýtlarý da etkiler.
(defun ke_1GolaCdep () (cu2mm (1GolaCZDep)) )																										; C Gola için üst panel derinlik çektirme

(setq ke_1golaZDep 0)																																; Gola alt modül extra derinleþtirme istenen deðeri
(setq ke_1golaZHvalue 0)																															; Gola alt/boy modül extra yükseltme istenen deðeri -> nil ise gola kapak ile normal kapak eþit olur
(defun ke_1golaZH () (if ke_1golaZHvalue ke_1golaZHvalue (- (- ad_ADH g_ClearBaseZTop g_ClearBaseZbot) (- ad_ADH g_ClearBaseZbot 1golaLZTop))))		; Gola alt/boy modül extra yükseltme hesaplamasý
(defun 1gola_ADH () (+ ad_ADH (ke_1golaZH)))																										; Gola alt Modül yüksekliði hesaplamasý
(defun 1gola_BDH () (+ ad_BDH2 (ke_1golaZH)))																										; Gola boy Modül yüksekliði hesaplamasý

(setq ke_1golaDrw1DiffVal 0)																														; Gola çekmece 4ün 1.si ölçü farký deðeri
(defun ke_1golaDrw1Diff () ke_1golaDrw1DiffVal)																										; Gola çekmece 4ün 1.si ölçü farký hesaplamasý

(setq ke_1golaDrw2DiffVal 0)																														; Gola çekmece 4ün 2.si ölçü farký ve gola kaldýrma deðeri
(defun ke_1golaDrw2Diff () ke_1golaDrw2DiffVal)																										; Gola çekmece 4ün 2.si ölçü farký ve gola kaldýrma hesaplamasý

;gola L, tek kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_1GolaL (divNo) 
	 (+ (- (gm1_divNoHei divNo) 1golaLZTop ZBot) (* 2 ad_et))
)
;gola LC, tek kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_1GolaLC (divNo)
	(- (+ (gm1_divNoHei divNo) ad_et) 1golaLZTop (* ZBtwn 0.5))
)
;gola C, üst kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_1GolaC_top (divNo)
	(+ (- (gm1_divNoHei divNo) ZBtwn))
)
;gola C, alt kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_1GolaC (divNo)
	(+ (- (gm1_divNoHei divNo) (- (1GolaCBtwn) (* ZBtwn 0.5))) ZBtwn)
)
;gola C, alt-son kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_1GolaC_bot (divNo)
	(+ (- (gm1_divNoHei divNo) (- (1GolaCBtwn) (* ZBtwn 0.5))) (- ad_et ZBot))
)
;gola C, alt-son kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_1GolaL_bot (divNo)
	(+ (- (gm1_divNoHei divNo) (- 1golaLZTop (* ZBtwn 0.5))) (- ad_et ZBot))
)

;gola çekmece /2 yükseklikleri
(defun kh_1GolaDrw2 ()
	(+ (ke_1golaDrw1Diff) (ke_1golaDrw2Diff) (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)))
)
(defun kh_1GolaDrw2_fix ()
	(+ (ke_1golaDrw1Diff) (ke_1golaDrw2Diff) (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)))
)
(defun bh_1GolaLB1 ()
	(+ (* (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 1golaLZTop ad_et) (ke_1golaDrw1Diff) (ke_1golaDrw2Diff))
)
(defun bh_1GolaLB1_fix ()
	(+ (* (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 1golaLZTop ad_et) (ke_1golaDrw1Diff) (ke_1golaDrw2Diff))
)
(defun bh_1GolaLB2 ()
	(- (- (gm1_curUnitH) (* 2 ad_et)) (+ (* (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 1golaLZTop ad_et)) (ke_1golaDrw1Diff) (ke_1golaDrw2Diff))
)
(defun bh_1GolaLB2_fix ()
	(- (- (1gola_ADH) (* 2 ad_et)) (+ (* (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 1golaLZTop ad_et)) (ke_1golaDrw1Diff) (ke_1golaDrw2Diff))
)


;gola çekmece /4 yükseklikleri
(defun kh_1GolaDrw4 ()
	(+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) (ke_1golaDrw1Diff))
	;(+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) (ke_1golaDrw1Diff))
)
(defun kh_1GolaDrw4_fix ()
	(+ (* 0.5 (- (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) (ke_1golaDrw1Diff))
	;(+ (* 0.5 (- (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) (ke_1golaDrw1Diff))
)
(defun bh_1GolaDrw4B1 ()
	(- (+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop (* ZBtwn 0.5) (ke_1golaDrw1Diff)) ad_et )
	;(- (+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop (* ZBtwn 0.5) (ke_1golaDrw1Diff)) ad_et )
)
(defun bh_1GolaDrw4B1_fix ()
	(- (+ (* 0.5 (- (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop (* ZBtwn 0.5) (ke_1golaDrw1Diff)) ad_et )
	;(- (+ (* 0.5 (- (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop (* ZBtwn 0.5) (ke_1golaDrw1Diff)) ad_et )
)
(defun bh_1GolaDrw4b2 ()
	(+ (ke_1golaDrw2Diff) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) ZBtwn)
)
(defun bh_1GolaDrw4b2_fix ()
	(+ (ke_1golaDrw2Diff) (* 0.5 (- (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) ZBtwn)
)
(defun bh_1GolaDrw4b3_fix ()
	(+ (ke_1golaDrw1Diff) (ke_1golaDrw2Diff) (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) ZBtwn)
)

;gola çekmece /3 yükseklikleri
(defun kh_GolaDrw3 ()
	(* 0.5 (- (gm1_curUnitH) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop zbtwn (1GolaCBtwn) zbot))
)
(defun kh_1GolaDrw3_fix ()
	(* 0.5 (- (1gola_ADH) (* 0.5 (- (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop zbtwn (1GolaCBtwn) zbot))
)
(defun bh_1GolaDrw3b2 ()
	(- (+ (* 0.5 (- (gm1_curUnitH) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop zbtwn (1GolaCBtwn) zbot)) 1golaCZTop zbtwn) 1golaCZTop)
)
(defun bh_1GolaDrw3b2_fix ()
	(- (+ (* 0.5 (- (1gola_ADH) (* 0.5 (- (* 0.5 (- (1gola_ADH) 1golaLZTop (1GolaCBtwn) zbot)) zbtwn)) 1golaLZTop zbtwn (1GolaCBtwn) zbot)) 1golaCZTop zbtwn) 1golaCZTop)
)
(defun bh_1GolaDrw3b3 ()
		(* 0.5 (- (gm1_curUnitH) zbot ad_et (bh_1golaDrw4B1) (* 2 (1golaCBtwn)) (* -2.5 zbtwn))) ; sorma ne haldeyim sorma soyleyemem
)
(defun bh_1GolaDrw3b3_fix ()
		(* 0.5 (- (1gola_ADH) zbot ad_et (bh_1golaDrw4B1) (* 2 (1golaCBtwn)) (* -2.5 zbtwn)))
)

;boy gola için parametreleri
(defun 1GolaBoyDoorDiff () (- (- (1gola_ADH) 1golaLZTop) (- ad_ADH g_ClearBaseZTop)))
(setq 1GolaZFSValue nil)																; boy cihaz dolap sabit raf kapak boþluðu deðeri
(defun 1GolaZFS () (if 1GolaZFSValue 1GolaZFSValue (appDoorLiftValue)))					; boy cihaz dolap sabit raf kapak boþluðu hesaplama
(defun ke_1GolaZFS () (if (1GolaZFS) (- ad_et (1GolaZFS)) (* 0.5 (- ad_et zbtwn))))		; boy cihaz dolap sabit raf kapak kaldýrma

(defun bh_1GolaFSCBot () (+ (- (1GolaCBtwn) (* 0.5 zbtwn)) kh_integratedMikroDoor))
(defun bh_1GolaCboyBot () (+ (1gola_ADH) (- ad_et) (- (1golaCBtwn) 1golaLZTop)))

(defun kh_1golaBoy (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 (1GolaZFS) ztop))
)

(defun kh_1golaFSBoy (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 ztop) 1GolaCZBot)
)

(defun kh_1golaLS (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 ztop))
)

(defun kh_1GolaCFS_top (divNo)
	(+ (+ (- (gm1_divNoHei divNo) ZBtwn)) (- ad_et (1GolaZFS)) (* 0.5 zbtwn))
)

(defun bh_1GolaFSDrw4b2_fix ()
	(- (bh_1GolaDrw4b2_fix) (- ad_et (1GolaZFS)) (* 0.5 zbtwn))
)

(defun bh_1GolaFSDrw4b3_fix ()
	(- (bh_1GolaDrw4b3_fix) (- ad_et (1GolaZFS)) (* 0.5 zbtwn))
)

;alt dolap gola cihaz fýrýn hesaplarý
(defun kh_1golaOven ()
	(* 0.5 (- (gm1_curUnitH) (+ bh_integratedOven (* 0.5 zbtwn)) 1GolaLZTop (appDoorLiftValue) g_clearbasezbot))
)
(defun bh_1golaOven ()
	(+ (- 1GolaLZTop ad_et) (* 0.5 zbtwn)  (kh_1golaOven) )
)

;gola profil parametrik fix yükseklik deðerleri -> Normalde profiller bölümlere baðlanabiliyor. Bu yükseklikler boy dolaplara özel olarak kullanýlabilir.
(defun ph_1GolaL () (gm1_curUnitH))								; L gola 1 kapaklý profil yüksekliði
(defun ph_1GolaL_fix () (1gola_ADH))							; L gola 1 kapaklý profil yüksekliði -> fix (1gola_ADH)
(defun ph_1golaCdrw2 () (+ (bh_1GolaLB2) ad_et))				; C gola 2 çekmece profil yüksekliði
(defun ph_1golaCdrw2_fix () (+ (bh_1GolaLB2_fix) ad_et))		; C gola 2 çekmece profil yüksekliði -> fix (1gola_ADH)
(defun ph_1golaCdrw3 () (+ (bh_1GolaDrw3b2) ad_et))				; C gola 3 çekmece profil yüksekliði
(defun ph_1golaCdrw3_fix () (+ (bh_1GolaDrw3b2_fix) ad_et))		; C gola 3 çekmece profil yüksekliði -> fix (1gola_ADH)
(defun ph_1golaCdrw4 () (+ (bh_1GolaDrw4b2) ad_et))				; C gola 4 çekmece profil yüksekliði
(defun ph_1golaCdrw4_fix () (+ (bh_1GolaDrw4b2_fix) ad_et))		; C gola 4 çekmece profil yüksekliði -> fix (1gola_ADH)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; GOLA 2	;;;;;;;;;;;;;;;;;;;;;; GOLA 2	;;;;;;;;;;;;;;;;;;;;;; GOLA 2	;;;;;;;;;;;;;;;;;;;;;; GOLA 2
(setq 2golaVLZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyL")))))                                             ; Boy VL Gola Derinliði
(setq 2golaVLZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyL")))))                                             ; Boy VL Gola Yüksekliði
(setq 2golaVLZThick (getnth 2 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyL")))))                                           ; Boy VL Gola Panel Kalinligi

(setq 2golaVCZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyC")))))                                             ; Boy VC Gola Derinliði
(setq 2golaVCZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyC")))))                                             ; Boy VC Gola Yüksekliði
(setq 2golaVCZThick (getnth 2 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyC")))))                                           ; Boy VC Gola Panel Kalinligi

(setq 2golaViLZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyiL")))))                                           ; Boy ViL Gola Derinliði
(setq 2golaViLZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileBoyiL")))))                                           ; Boy ViL Gola Yüksekliði

(setq 2GolaiLZBotValue (cm 2))																														; iL Gola (üst modül) kapak aþaðý sarkýtma deðeri -> nil ise yok.
(defun 2GolaiLZBot () (if 2GolaiLZBotValue 2GolaiLZbotValue (- 0 g_ClearWallZBot)))																	; iL Gola (üst modül) kapak aþaðý sarkýtma hesaplamasý
(defun 2GolaiLZ (tempCurDoorH) (+ (2GolaiLZbot) g_ClearWallZBot tempCurDoorH))																		; iL Gola (üst modül) için  kapak ek toplam fonksiyonu -> modüldeki kapak formülüne 2GolaiLZBotValue toplatmak için kullanýlýr.
(defun 2GolaiLZ/2 (tempCurDoorH) (+ (* 0.5 (2GolaiLZbot)) g_ClearWallZBot tempCurDoorH) )															; iL Gola (üst modül) için kapak ek yarým toplam fonksiyonu -> modüldeki kapak formülüne 2GolaiLZBotValue/2 toplattýrmak için kullanýlýr.
(setq 2GolaiLZDepValue (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2Gola_profileiL")))))											; iL Gola (üst modül) panel çektirme deðeri -> Modul.ini içinden iL1 profil derinliðini okur
(defun 2GolaiLZDep () (if 2GolaiLZDepValue 2GolaiLZDepValue 0))																						; iL Gola (üst modül) panel çektirme hesaplamasý
(defun 2GolaiLZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2Gola_profileiL")))))											; iL Gola profil yüksekliði -> Modul.ini içinden iL profil derinliðini okur						; iL Gola (üst modül) alt panel çektirme hesaplamasý
(defun ke_2GolaiLdep () (cu2mm (2GolaiLZDep)) )																										; iL gola için panel derinlik çektirme -> eðer çektirme olmayacaksa set içindeki default reçeteyi sil.
(defun ke_2GolaiL () (- (if 2GolaiLZBotValue (+ 2GolaiLZBotValue g_ClearWallZBot) 0.0)))															; iL gola uk1 uk2 kapak sarkýtma (/kýrpma)

(setq 2golaCZBot (cm 2.3 ))																															; C gola kapak alta uzatma istenen deðeri
(setq 2golaCZTop (cm 3.0 ))																											; C gola kapak uste uzatma istenen deðeri
(defun 2golaCBtwn () (- (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileC")))) 2golaCZBot 2golaCZTop))					; C gola iki kapak arasý hesaplama -> Modul.ini içinden C1 profil yüksekliðini okuyor.
(defun 2golaCZDep () (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileC")))))												; C gola profil derinliði -> Modul.ini içinden C1 profil derinliðini okur
(defun 2golaCZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileC")))))												; C gola profil yüksekliði -> Modul.ini içinden C1 profil derinliðini okur

(setq 2golaLZTop 2.35)																														; L gola kapak üstten boþluðu istenen deðeri
(defun 2golaLZDep () (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileL")))))												; L gola profil derinliði -> Modul.ini içinden L1 profil derinliðini okur
(defun 2golaLZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "2gola_profileL")))))												; L gola profil yüksekliði -> Modul.ini içinden L1 profil derinliðini okur

(defun ke_2golaLAK () (- 2golaLZTop g_ClearBaseZTop))																								; L gola ak1 / ak2 kapak kýrpma
(defun ke_2golaL () (- (- 2golaLZTop ad_et)))																										; L gola gm1 kapak indirme (/yükseltme)
(defun ke_2golaL_Bot () (- (- 2golaLZTop (* ZBtwn 0.5))))																							; L Gola gm1 kapak alta indirme (/yükseltme)
(defun ke_2golaC () (- (- (2golaCBtwn) (* ZBtwn 0.5))))																								; C Gola gm1 kapak alta indirme (/yükseltme)

(defun ke_2golaLdep () (cu2mm (2golaLZDep)) )																										; L gola için panel derinlik çektirme -> kayýtlarý da etkiler.
(defun ke_2golaCdep () (cu2mm (2golaCZDep)) )																										; C Gola için panel derinlik çektirme

(setq ke_2golaZDep 0)																																; Gola alt modül extra derinleþtirme istenen deðeri
(setq ke_2golaZHvalue 0)																															; Gola alt/boy modül extra yükseltme istenen deðeri -> nil ise gola kapak ile normal kapak eþit olur
(defun ke_2golaZH () (if ke_2golaZHvalue ke_2golaZHvalue (- (- ad_ADH g_ClearBaseZTop g_ClearBaseZbot) (- ad_ADH g_ClearBaseZbot 2golaLZTop))))		; Gola alt/boy modül extra yükseltme hesaplamasý
(defun 2gola_ADH () (+ ad_ADH (ke_2golaZH)))																										; Gola alt Modül yüksekliði hesaplamasý
(defun 2gola_BDH () (+ ad_BDH2 (ke_2golaZH)))																										; Gola boy Modül yüksekliði hesaplamasý

(setq ke_2GolatDrw1DiffVal -1.925)																														; Gola çekmece 4ün 1.si ölçü farký deðeri
(defun ke_2GolaDrw1Diff () ke_2GolatDrw1DiffVal)																									; Gola çekmece 4ün 1.si ölçü farký hesaplamasý

(setq ke_2GolaDrw2DiffVal -1.925)																														; Gola çekmece 4ün 2.si ölçü farký ve gola kaldýrma deðeri
(defun ke_2GolaDrw2Diff () ke_2GolaDrw2DiffVal)																										; Gola çekmece 4ün 2.si ölçü farký ve gola kaldýrma hesaplamasý



;gola L, tek kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_2GolaL (divNo) 
	 (+ (- (gm1_divNoHei divNo) 2GolaLZTop ZBot) (* 2 ad_et))
)
;gola LC, tek kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_2GolaLC (divNo)
	(- (+ (gm1_divNoHei divNo) ad_et) 2GolaLZTop (* ZBtwn 0.5))
)
;gola C, üst kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_2GolaC_top (divNo)
	(+ (- (gm1_divNoHei divNo) ZBtwn))
)
;gola C, alt kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_2GolaC (divNo)
	(+ (- (gm1_divNoHei divNo) (- (2GolaCBtwn) (* ZBtwn 0.5))) ZBtwn)
)
;gola C, alt-son kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_2GolaC_bot (divNo)
	(+ (- (gm1_divNoHei divNo) (- (2GolaCBtwn) (* ZBtwn 0.5))) (- ad_et ZBot))
)
;gola C, alt-son kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_2GolaL_bot (divNo)
	(+ (- (gm1_divNoHei divNo) (- 2GolaLZTop (* ZBtwn 0.5))) (- ad_et ZBot))
)

;gola çekmece /2 yükseklikleri
(defun kh_2GolaDrw2 ()
	(+ (ke_2GolaDrw1Diff) (ke_2GolaDrw2Diff) (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)))
)
(defun kh_2GolaDrw2_fix ()
	(+ (ke_2GolaDrw1Diff) (ke_2GolaDrw2Diff) (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)))
)
(defun bh_2GolaLB1 ()
	(+ (* (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 2GolaLZTop ad_et) (ke_2GolaDrw1Diff) (ke_2GolaDrw2Diff))
)
(defun bh_2GolaLB1_fix ()
	(+ (* (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 2GolaLZTop ad_et) (ke_2GolaDrw1Diff) (ke_2GolaDrw2Diff))
)
(defun bh_2GolaLB2 ()
	(- (- (gm1_curUnitH) (* 2 ad_et)) (+ (* (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 2GolaLZTop ad_et)) (ke_2GolaDrw1Diff) (ke_2GolaDrw2Diff))
)
(defun bh_2GolaLB2_fix ()
	(- (- (2Gola_ADH) (* 2 ad_et)) (+ (* (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 2GolaLZTop ad_et)) (ke_2GolaDrw1Diff) (ke_2GolaDrw2Diff))
)


;gola çekmece /4 yükseklikleri
(defun kh_2GolaDrw4 ()
	(+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) (ke_2GolaDrw1Diff))
	;(+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) (ke_2GolaDrw1Diff))
)
(defun kh_2GolaDrw4_fix ()
	(+ (* 0.5 (- (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) (ke_2GolaDrw1Diff))
	;(+ (* 0.5 (- (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) (ke_2GolaDrw1Diff))
)
(defun bh_2GolaDrw4B1 ()
	(- (+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop (* ZBtwn 0.5) (ke_2GolaDrw1Diff)) ad_et )
	;(- (+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop (* ZBtwn 0.5) (ke_2GolaDrw1Diff)) ad_et )
)
(defun bh_2GolaDrw4B1_fix ()
	(- (+ (* 0.5 (- (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop (* ZBtwn 0.5) (ke_2GolaDrw1Diff)) ad_et )
	;(- (+ (* 0.5 (- (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop (* ZBtwn 0.5) (ke_2GolaDrw1Diff)) ad_et )
)
(defun bh_2GolaDrw4b2 ()
	(+ (ke_2GolaDrw2Diff) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) ZBtwn)
)
(defun bh_2GolaDrw4b2_fix ()
	(+ (ke_2GolaDrw2Diff) (* 0.5 (- (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) ZBtwn)
)
(defun bh_2GolaDrw4b3_fix ()
	(+ (ke_2GolaDrw1Diff) (ke_2GolaDrw2Diff) (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) ZBtwn)
)

;gola çekmece /3 yükseklikleri
(defun kh_GolaDrw3 ()
	(* 0.5 (- (gm1_curUnitH) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop zbtwn (2GolaCBtwn) zbot))
)
(defun kh_2GolaDrw3_fix ()
	(* 0.5 (- (2Gola_ADH) (* 0.5 (- (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop zbtwn (2GolaCBtwn) zbot))
)
(defun bh_2GolaDrw3b2 ()
	(- (+ (* 0.5 (- (gm1_curUnitH) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop zbtwn (2GolaCBtwn) zbot)) 2GolaCZTop zbtwn) 2GolaCZTop (* 0.5 ke_2GolatDrw1DiffVal))
)
(defun bh_2GolaDrw3b2_fix ()
	(- (+ (* 0.5 (- (2Gola_ADH) (* 0.5 (- (* 0.5 (- (2Gola_ADH) 2GolaLZTop (2GolaCBtwn) zbot)) zbtwn)) 2GolaLZTop zbtwn (2GolaCBtwn) zbot)) 2GolaCZTop zbtwn) 2GolaCZTop (* 0.5 ke_2GolatDrw1DiffVal))
)
(defun bh_2GolaDrw3b3 ()
		(* 0.5 (- (gm1_curUnitH) zbot ad_et (bh_2golaDrw4B1) (* 2 (2golaCBtwn)) (* -2.5 zbtwn)))
)
(defun bh_2GolaDrw3b3_fix ()
		(* 0.5 (- (2gola_ADH) zbot ad_et (bh_2golaDrw4B1) (* 2 (2golaCBtwn)) (* -2.5 zbtwn)))
)



(defun bh_2GolaDrw3b3L ()
		(* 0.5 (- (gm1_curUnitH) zbot ad_et (bh_2golaDrw4B1) (* 2 (2golaCBtwn)) (* -2.5 zbtwn)))
)


;boy gola için parametreleri
(defun 2GolaBoyDoorDiff () (- (- (2Gola_ADH) 2GolaLZTop) (- ad_ADH g_ClearBaseZTop)))
(setq 2GolaZFSValue nil)																; boy cihaz dolap sabit raf kapak boþluðu deðeri
(defun 2GolaZFS () (if 2GolaZFSValue 2GolaZFSValue (appDoorLiftValue)))					; boy cihaz dolap sabit raf kapak boþluðu hesaplama
(defun ke_2GolaZFS () (if (2GolaZFS) (- ad_et (2GolaZFS)) (* 0.5 (- ad_et zbtwn))))		; boy cihaz dolap sabit raf kapak kaldýrma

(defun bh_2GolaFSCBot () (+ (- (2GolaCBtwn) (* 0.5 zbtwn)) kh_integratedMikroDoor))
(defun bh_2GolaCboyBot () (+ (2Gola_ADH) (- ad_et) (- (2golaCBtwn) 2golaLZTop)))

(defun kh_2GolaBoy (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 (2GolaZFS) ztop))
)

(defun kh_2GolaFSBoy (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 ztop) 2GolaCZBot)
)

(defun kh_2GolaLS (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 ztop))
)

(defun kh_2GolaCFS_top (divNo)
	(+ (+ (- (gm1_divNoHei divNo) ZBtwn)) (- ad_et (2GolaZFS)) (* 0.5 zbtwn))
)

(defun bh_2GolaFSDrw4b2_fix ()
	(- (bh_2GolaDrw4b2_fix) (- ad_et (2GolaZFS)) (* 0.5 zbtwn))
)

(defun bh_2GolaFSDrw4b3_fix ()
	(- (bh_2GolaDrw4b3_fix) (- ad_et (2GolaZFS)) (* 0.5 zbtwn))
)

;alt dolap gola cihaz fýrýn hesaplarý
(defun kh_2GolaOven ()
	(* 0.5 (- (gm1_curUnitH) (+ bh_integratedOven (* 0.5 zbtwn)) 2GolaLZTop (appDoorLiftValue) g_clearbasezbot))
)
(defun bh_2GolaOven ()
	(+ (- 2GolaLZTop ad_et) (* 0.5 zbtwn)  (kh_2GolaOven) )
)

;gola profil parametrik fix yükseklik deðerleri -> Normalde profiller bölümlere baðlanabiliyor. Bu yükseklikler boy dolaplara özel olarak kullanýlabilir.
(defun ph_2golaL () (gm1_curUnitH))								; L gola 1 kapaklý profil yüksekliði
(defun ph_2golaL_fix () (2gola_ADH))							; L gola 1 kapaklý profil yüksekliði -> fix (2gola_ADH)
(defun ph_2golaCdrw2 () (+ (bh_2golaLB2) ad_et))				; C gola 2 çekmece profil yüksekliði
(defun ph_2golaCdrw2_fix () (+ (bh_2golaLB2_fix) ad_et))		; C gola 2 çekmece profil yüksekliði -> fix (2gola_ADH)
(defun ph_2golaCdrw3 () (+ (bh_2golaDrw3b2) ad_et))				; C gola 3 çekmece profil yüksekliði
(defun ph_2golaCdrw3_fix () (+ (bh_2golaDrw3b2_fix) ad_et))		; C gola 3 çekmece profil yüksekliði -> fix (2gola_ADH)
(defun ph_2golaCdrw4 () (+ (bh_2golaDrw4b2) ad_et))				; C gola 4 çekmece profil yüksekliði
(defun ph_2golaCdrw4_fix () (+ (bh_2golaDrw4b2_fix) ad_et))		; C gola 4 çekmece profil yüksekliði -> fix (2gola_ADH)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; GOLA 2	;;;;;;;;;;;;;;;;;;;;;; GOLA 2	;;;;;;;;;;;;;;;;;;;;;; GOLA 2	;;;;;;;;;;;;;;;;;;;;;; GOLA 2
(setq 3golaVLZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyL")))))                                             ; Boy VL Gola Derinliði
(setq 3golaVLZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyL")))))                                             ; Boy VL Gola Yüksekliði
(setq 3golaVLZThick (getnth 2 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyL")))))                                           ; Boy VL Gola Panel Kalinligi

(setq 3golaVCZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyC")))))                                             ; Boy VC Gola Derinliði
(setq 3golaVCZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyC")))))                                             ; Boy VC Gola Yüksekliði
(setq 3golaVCZThick (getnth 2 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyC")))))                                           ; Boy VC Gola Panel Kalinligi

(setq 3golaViLZDep (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyiL")))))                                           ; Boy ViL Gola Derinliði
(setq 3golaViLZHei (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileBoyiL")))))                                           ; Boy ViL Gola Yüksekliði

(setq 3golaiLZBotValue (cm 2))																														; iL Gola (üst modül) kapak aþaðý sarkýtma deðeri -> nil ise yok.
(defun 3golaiLZBot () (if 3golaiLZBotValue 3golaiLZbotValue (- 0 g_ClearWallZBot)))																	; iL Gola (üst modül) kapak aþaðý sarkýtma hesaplamasý
(defun 3golaiLZ (tempCurDoorH) (+ (3golaiLZbot) g_ClearWallZBot tempCurDoorH))																		; iL Gola (üst modül) için  kapak ek toplam fonksiyonu -> modüldeki kapak formülüne 3golaiLZBotValue toplatmak için kullanýlýr.
(defun 3golaiLZ/2 (tempCurDoorH) (+ (* 0.5 (3golaiLZbot)) g_ClearWallZBot tempCurDoorH) )															; iL Gola (üst modül) için kapak ek yarým toplam fonksiyonu -> modüldeki kapak formülüne 3golaiLZBotValue/2 toplattýrmak için kullanýlýr.
(setq 3golaiLZDepValue (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileiL")))))											; iL Gola (üst modül) panel çektirme deðeri -> Modul.ini içinden iL1 profil derinliðini okur
(defun 3golaiLZDep () (if 3golaiLZDepValue 3golaiLZDepValue 0))																						; iL Gola (üst modül) panel çektirme hesaplamasý
(defun 3golaiLZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileiL")))))											; iL Gola profil yüksekliði -> Modul.ini içinden iL profil derinliðini okur						; iL Gola (üst modül) alt panel çektirme hesaplamasý
(defun ke_3golaiLdep () (cu2mm (3golaiLZDep)) )																										; iL gola için panel derinlik çektirme -> eðer çektirme olmayacaksa set içindeki default reçeteyi sil.
(defun ke_3golaiL () (- (if 3golaiLZBotValue (+ 3golaiLZBotValue g_ClearWallZBot) 0.0)))															; iL gola uk1 uk2 kapak sarkýtma (/kýrpma)

(setq 3golaCZBot (cm 0.0 ))																															; C gola kapak alta uzatma istenen deðeri
(setq 3golaCZTop (cm 2.9 ))																											; C gola kapak uste uzatma istenen deðeri
(defun 3golaCBtwn () (- (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileC")))) 3golaCZBot 3golaCZTop))					; C gola iki kapak arasý hesaplama -> Modul.ini içinden C1 profil yüksekliðini okuyor.
(defun 3golaCZDep () (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileC")))))												; C gola profil derinliði -> Modul.ini içinden C1 profil derinliðini okur
(defun 3golaCZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileC")))))												; C gola profil yüksekliði -> Modul.ini içinden C1 profil derinliðini okur

(setq 3golaLZTop 2.35)																														; L gola kapak üstten boþluðu istenen deðeri
(defun 3golaLZDep () (getnth 1 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileL")))))												; L gola profil derinliði -> Modul.ini içinden L1 profil derinliðini okur
(defun 3golaLZHei () (getnth 0 (getnth 2 (read (iniread ad_MOD-INI "golaProfiles" "3gola_profileL")))))												; L gola profil yüksekliði -> Modul.ini içinden L1 profil derinliðini okur

(defun ke_3golaLAK () (- 3golaLZTop g_ClearBaseZTop))																								; L gola ak1 / ak2 kapak kýrpma
(defun ke_3golaL () (- (- 3golaLZTop ad_et)))																										; L gola gm1 kapak indirme (/yükseltme)
(defun ke_3golaL_Bot () (- (- 3golaLZTop (* ZBtwn 0.5))))																							; L Gola gm1 kapak alta indirme (/yükseltme)
(defun ke_3golaC () (- (- (3golaCBtwn) (* ZBtwn 0.5))))																								; C Gola gm1 kapak alta indirme (/yükseltme)

(defun ke_3golaLdep () (cu2mm (3golaLZDep)) )																										; L gola için panel derinlik çektirme -> kayýtlarý da etkiler.
(defun ke_3golaCdep () (cu2mm (3golaCZDep)) )																										; C Gola için panel derinlik çektirme

(setq ke_3golaZDep 0)																																; Gola alt modül extra derinleþtirme istenen deðeri
(setq ke_3golaZHvalue 0)																															; Gola alt/boy modül extra yükseltme istenen deðeri -> nil ise gola kapak ile normal kapak eþit olur
(defun ke_3golaZH () (if ke_3golaZHvalue ke_3golaZHvalue (- (- ad_ADH g_ClearBaseZTop g_ClearBaseZbot) (- ad_ADH g_ClearBaseZbot 3golaLZTop))))		; Gola alt/boy modül extra yükseltme hesaplamasý
(defun 3gola_ADH () (+ ad_ADH (ke_3golaZH)))																										; Gola alt Modül yüksekliði hesaplamasý
(defun 3gola_BDH () (+ ad_BDH2 (ke_3golaZH)))																										; Gola boy Modül yüksekliði hesaplamasý

(setq ke_3golatDrw1DiffVal -2.45)																														; Gola çekmece 4ün 1.si ölçü farký deðeri
(defun ke_3golaDrw1Diff () ke_3golatDrw1DiffVal)																									; Gola çekmece 4ün 1.si ölçü farký hesaplamasý

(setq ke_3golaDrw2DiffVal -2.45)																														; Gola çekmece 4ün 2.si ölçü farký ve gola kaldýrma deðeri
(defun ke_3golaDrw2Diff () ke_3golaDrw2DiffVal)																										; Gola çekmece 4ün 2.si ölçü farký ve gola kaldýrma hesaplamasý



;gola L, tek kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_3golaL (divNo) 
	 (+ (- (gm1_divNoHei divNo) 3golaLZTop ZBot) (* 2 ad_et))
)
;gola LC, tek kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_3golaLC (divNo)
	(- (+ (gm1_divNoHei divNo) ad_et) 3golaLZTop (* ZBtwn 0.5))
)
;gola C, üst kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_3golaC_top (divNo)
	(+ (- (gm1_divNoHei divNo) ZBtwn))
)
;gola C, alt kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_3golaC (divNo)
	(+ (- (gm1_divNoHei divNo) (- (3golaCBtwn) (* ZBtwn 0.5))) ZBtwn)
)
;gola C, alt-son kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_3golaC_bot (divNo)
	(+ (- (gm1_divNoHei divNo) (- (3golaCBtwn) (* ZBtwn 0.5))) (- ad_et ZBot))
)
;gola C, alt-son kapak yüksekliði -> bölüm ölçüsüne göre dinamik
(defun kh_3golaL_bot (divNo)
	(+ (- (gm1_divNoHei divNo) (- 3golaLZTop (* ZBtwn 0.5))) (- ad_et ZBot))
)

;gola çekmece /2 yükseklikleri
(defun kh_3golaDrw2 ()
	(+ (ke_3golaDrw1Diff) (ke_3golaDrw2Diff) (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)))
)
(defun kh_3golaDrw2_fix ()
	(+ (ke_3golaDrw1Diff) (ke_3golaDrw2Diff) (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)))
)
(defun bh_3golaLB1 ()
	(+ (* (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 3golaLZTop ad_et) (ke_3golaDrw1Diff) (ke_3golaDrw2Diff))
)
(defun bh_3golaLB1_fix ()
	(+ (* (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 3golaLZTop ad_et) (ke_3golaDrw1Diff) (ke_3golaDrw2Diff))
)
(defun bh_3golaLB2 ()
	(- (- (gm1_curUnitH) (* 2 ad_et)) (+ (* (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 3golaLZTop ad_et)) (ke_3golaDrw1Diff) (ke_3golaDrw2Diff))
)
(defun bh_3golaLB2_fix ()
	(- (- (3gola_ADH) (* 2 ad_et)) (+ (* (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot) 0.5) (* 0.5 zbtwn) (- 3golaLZTop ad_et)) (ke_3golaDrw1Diff) (ke_3golaDrw2Diff))
)


;gola çekmece /4 yükseklikleri
(defun kh_3golaDrw4 ()
	(+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) (ke_3golaDrw1Diff))
	;(+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) (ke_3golaDrw1Diff))
)
(defun kh_3golaDrw4_fix ()
	(+ (* 0.5 (- (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) (ke_3golaDrw1Diff))
	;(+ (* 0.5 (- (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) (ke_3golaDrw1Diff))
)
(defun bh_3golaDrw4B1 ()
	(- (+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop (* ZBtwn 0.5) (ke_3golaDrw1Diff)) ad_et )
	;(- (+ (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop (* ZBtwn 0.5) (ke_3golaDrw1Diff)) ad_et )
)
(defun bh_3golaDrw4B1_fix ()
	(- (+ (* 0.5 (- (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop (* ZBtwn 0.5) (ke_3golaDrw1Diff)) ad_et )
	;(- (+ (* 0.5 (- (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop (* ZBtwn 0.5) (ke_3golaDrw1Diff)) ad_et )
)
(defun bh_3golaDrw4b2 ()
	(+ (ke_3golaDrw2Diff) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) ZBtwn)
)
(defun bh_3golaDrw4b2_fix ()
	(+ (ke_3golaDrw2Diff) (* 0.5 (- (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) ZBtwn)
)
(defun bh_3golaDrw4b3_fix ()
	(+ (ke_3golaDrw1Diff) (ke_3golaDrw2Diff) (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) ZBtwn)
)

;gola çekmece /3 yükseklikleri
(defun kh_GolaDrw3 ()
	(* 0.5 (- (gm1_curUnitH) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop zbtwn (3golaCBtwn) zbot))
)
(defun kh_3golaDrw3_fix ()
	(* 0.5 (- (3gola_ADH) (* 0.5 (- (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop zbtwn (3golaCBtwn) zbot))
)
(defun bh_3golaDrw3b2 ()
	(- (+ (* 0.5 (- (gm1_curUnitH) (* 0.5 (- (* 0.5 (- (gm1_curUnitH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop zbtwn (3golaCBtwn) zbot)) 3golaCZTop zbtwn) 3golaCZTop (* 0.5 ke_3golatDrw1DiffVal))
)
(defun bh_3golaDrw3b2_fix ()
	(- (+ (* 0.5 (- (3gola_ADH) (* 0.5 (- (* 0.5 (- (3gola_ADH) 3golaLZTop (3golaCBtwn) zbot)) zbtwn)) 3golaLZTop zbtwn (3golaCBtwn) zbot)) 3golaCZTop zbtwn) 3golaCZTop (* 0.5 ke_3golatDrw1DiffVal))
)
(defun bh_3golaDrw3b3 ()
		(* 0.5 (- (gm1_curUnitH) zbot ad_et (bh_3golaDrw4B1) (* 2 (3golaCBtwn)) (* -2.5 zbtwn)))
)
(defun bh_3golaDrw3b3_fix ()
		(* 0.5 (- (3gola_ADH) zbot ad_et (bh_3golaDrw4B1) (* 2 (3golaCBtwn)) (* -2.5 zbtwn)))
)



(defun bh_3golaDrw3b3L ()
		(* 0.5 (- (gm1_curUnitH) zbot ad_et (bh_3golaDrw4B1) (* 2 (3golaCBtwn)) (* -2.5 zbtwn)))
)


;boy gola için parametreleri
(defun 3golaBoyDoorDiff () (- (- (3gola_ADH) 3golaLZTop) (- ad_ADH g_ClearBaseZTop)))
(setq 3golaZFSValue nil)																; boy cihaz dolap sabit raf kapak boþluðu deðeri
(defun 3golaZFS () (if 3golaZFSValue 3golaZFSValue (appDoorLiftValue)))					; boy cihaz dolap sabit raf kapak boþluðu hesaplama
(defun ke_3golaZFS () (if (3golaZFS) (- ad_et (3golaZFS)) (* 0.5 (- ad_et zbtwn))))		; boy cihaz dolap sabit raf kapak kaldýrma

(defun bh_3golaFSCBot () (+ (- (3golaCBtwn) (* 0.5 zbtwn)) kh_integratedMikroDoor))
(defun bh_3golaCboyBot () (+ (3gola_ADH) (- ad_et) (- (3golaCBtwn) 3golaLZTop)))

(defun kh_3golaBoy (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 (3golaZFS) ztop))
)

(defun kh_3golaFSBoy (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 ztop) 3golaCZBot)
)

(defun kh_3golaLS (divNo)
	(+ (gm1_divNoHei divNo) (* 2 ad_et) (- 0 ztop))
)

(defun kh_3golaCFS_top (divNo)
	(+ (+ (- (gm1_divNoHei divNo) ZBtwn)) (- ad_et (3golaZFS)) (* 0.5 zbtwn))
)

(defun bh_3golaFSDrw4b2_fix ()
	(- (bh_3golaDrw4b2_fix) (- ad_et (3golaZFS)) (* 0.5 zbtwn))
)

(defun bh_3golaFSDrw4b3_fix ()
	(- (bh_3golaDrw4b3_fix) (- ad_et (3golaZFS)) (* 0.5 zbtwn))
)

;alt dolap gola cihaz fýrýn hesaplarý
(defun kh_3golaOven ()
	(* 0.5 (- (gm1_curUnitH) (+ bh_integratedOven (* 0.5 zbtwn)) 3golaLZTop (appDoorLiftValue) g_clearbasezbot))
)
(defun bh_3golaOven ()
	(+ (- 3golaLZTop ad_et) (* 0.5 zbtwn)  (kh_3golaOven) )
)

;gola profil parametrik fix yükseklik deðerleri -> Normalde profiller bölümlere baðlanabiliyor. Bu yükseklikler boy dolaplara özel olarak kullanýlabilir.
(defun ph_3golaL () (gm1_curUnitH))								; L gola 1 kapaklý profil yüksekliði
(defun ph_3golaL_fix () (3gola_ADH))							; L gola 1 kapaklý profil yüksekliði -> fix (3gola_ADH)
(defun ph_3golaCdrw2 () (+ (bh_3golaLB2) ad_et))				; C gola 2 çekmece profil yüksekliði
(defun ph_3golaCdrw2_fix () (+ (bh_3golaLB2_fix) ad_et))		; C gola 2 çekmece profil yüksekliði -> fix (3gola_ADH)
(defun ph_3golaCdrw3 () (+ (bh_3golaDrw3b2) ad_et))				; C gola 3 çekmece profil yüksekliði
(defun ph_3golaCdrw3_fix () (+ (bh_3golaDrw3b2_fix) ad_et))		; C gola 3 çekmece profil yüksekliði -> fix (3gola_ADH)
(defun ph_3golaCdrw4 () (+ (bh_3golaDrw4b2) ad_et))				; C gola 4 çekmece profil yüksekliði
(defun ph_3golaCdrw4_fix () (+ (bh_3golaDrw4b2_fix) ad_et))		; C gola 4 çekmece profil yüksekliði -> fix (3gola_ADH)


