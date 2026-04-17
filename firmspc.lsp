
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun kpk (kod dWid dH dDep lstParam imalTipi szNote / tip kulp orient model options fixKpkModel blok_list inspt mdata szMData aci 
		curCDoorId curCAuxRcps  curpanelProfileNormal curPanelData curDoorEnt curWPanelUsageType curWPanelUsageSubTypes oldHandleName mainPanelsOfThis subPanelsOfThis connInfoOfThis drawerGroupID
		)
    (setq tip 		(nth 0 lstParam)
          kulp 		(nth 1 lstParam)
		  orient	(nth 2 lstParam)
          model 	(nth 3 lstParam)
		  ;options  	(nth 4 lstParam)
    )
	
	(if (parselft model "!!FIX!!") (setq fixKpkModel "!!FIX!!" model (parselft model "!!FIX!!"))) ;fitzgerald icin fix kpk
		
	(setq szMData 
		(convertStr
			(list kod 'KPK
				dWid
				dH
				 dDep
				(cons 'QUOTE (list (list tip kulp orient model)))
				imalTipi
				szNote
			)
		)
	)
	
	(setq kod (parse$ kod))

	(if mozel_mUnit
		(progn
			(setq oldHandleName (dfetch 5 mozel_mUnit))
			(setq mainPanelsOfThis (get_mdata mozel_mUnit k:connectorMainPanels))
			(setq subPanelsOfThis (get_mdata mozel_mUnit k:connectorSubPanels))
			(setq connInfoOfThis (get_mdata mozel_mUnit k:insertedConnectorInfo))

			(setq drawerGroupID (get_mdata mozel_mUnit k:wardrobeDrawerGroupID))

			(setq inspt mozel_yp1
				aci mozel_aci
			)
			(setq curCDoorId (get_mdata mozel_mUnit k:CDoorId)
				  curCAuxRcps  (get_mdata mozel_mUnit k:CAuxRcps)
				  curWPanelUsageType (get_mdata mozel_mUnit k:WPanelUsageType )
				  curWPanelUsageSubTypes (get_mdata mozel_mUnit k:WPanelUsageSubTypes )
				  
			)
			(cleanDrawerPanelConnectors (dfetch 2 mozel_mUnit))
			(entdel mozel_mUnit)
		)
		(progn
			(setvar "OSMODE" 3) ;end + mid
			(setq inspt (getpoint (Xstr "\nBottom-mid point of door <0,0,0>: ")))
			(if (null inspt) (setq inspt '(0 0 0)))
		)
	)
	
	(setq blok_list (entlast))
	(if fixKpkModel
		(kapak_ciz (list tip model fixKpkModel) (strcase kulp) (getnth 0 inspt) (* -1 (getnth 1 inspt)) (getnth 2 inspt)  dWid dH orient (r2d (ifnull aci 0.0)))
		(kapak_ciz (list tip model) (strcase kulp) (getnth 0 inspt) (* -1 (getnth 1 inspt)) (getnth 2 inspt)  dWid dH orient (r2d (ifnull aci 0.0)))
	)
		
	(setq curDoorEnt g_lastDrawnDoor)
	(setq curPanelData (list (ifnull dDep ad_et) (lmm_convertHeiWidToPolyLineData dWid dH)))
	
	;(if aci
	;	(blok_tanimFromEnt kod inspt blok_list aci)
	;	(progn
	;		(blok_tanimFromEnt kod inspt blok_list 0.0)
	;		(princ (Xstr "\nRotation angle <0>: "))
	;		(command "_.ROTATE" curDoorEnt "" inspt PAUSE)
	;	)
	;)
    (setq mdata (list
        (cons k:MTYP "KPK")
        (cons k:WID dWid)
        (cons k:HEI dH)
        (cons k:DEP dDep)

		(if orient (cons k:myon orient))
		(if curCDoorId  (cons k:CDoorId  curCDoorId))
		(if curCAuxRcps  (cons k:CAuxRcps  curCAuxRcps))
		(if curWPanelUsageType  (cons k:WPanelUsageType curWPanelUsageType))
		(if curWPanelUsageSubTypes  (cons k:WPanelUsageSubTypes curWPanelUsageSubTypes))
		(cons k:panelProfileNormal (list 0.0 -1.0 0.0))
		
		(if curPanelData (cons k:panelDataList (convertstr curPanelData)))
		(cons k:mData szMData)
		(if drawerGroupID (cons k:wardrobeDrawerGroupID drawerGroupID))

		;(if (and SubEs (not (equal SubEs ""))) 	(cons k:subE SubEs))
    	;(cons k:mData szMData)
    	(cons k:CMtip imalTipi)
    ))
	(set_Mdata curDoorEnt  mdata)
	(writeConnXDatasAndRefresh curDoorEnt (list oldHandleName mainPanelsOfThis subPanelsOfThis connInfoOfThis))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq gm1_drawDoor nil)
(defun gm1_drawDoor (Parameters elev divindx /  doorWidth leftMid rightMid doorId currentDoorName fixeddDoor hasDoor additional_door_side_clearance)
	(gm1_setDivParams Parameters )
	(setq fixeddDoor "")
	(setq elev (if divDoorElevOffset divDoorElevOffset elev))	
	(if (or (not (member divdoortype (list "C" "S" "M" "R" "I" "T" "N")))
		(and handledivpos (wcmatch handledivpos "*D*"))
		)
		(setq isLRexist T)
	)
	(setq divH (ifnull divH ad_ET))
	(if g_gm1_Preview 
		(setq currentDoorName  "DUZKPK")
		(setq currentDoorName  (ifnull divDoorName specialDoor))
	)	
	(if currentDoorName (setq fixeddDoor "!FIX!")) 
	
	(if (checkstrinstr "rutin_KapakDaralt" (ifnull gm1rutin ""))
		(progn
			(setq parsed-string (trim (parsergt (parselft gm1rutin ")") "(")))
			(setq split-list (splitstr parsed-string " "))
			(setq additional_door_side_clearance (atof (getnth 1 split-list))) 
			(setq door_translateDirection (getnth 2 split-list))
		)
	)
	
	(cond ((member doorCount '("K"))
			(setq doorWidth (- BDEN clearXSide clearXSide))	
			(setq currDoorHorPos (/2 BDEN))
			(if additional_door_side_clearance
				(progn
					(cond 
						((or (equal door_translateDirection "SAG") (equal door_translateDirection "sag") (equal door_translateDirection 1)  (equal door_translateDirection "1"))
							(setq doorWidth (- BDEN additional_door_side_clearance clearXSide))
							(setq currDoorHorPos (+ (* doorWidth 0.5) clearXSide))
						)
						((or (equal door_translateDirection "SOL")(equal door_translateDirection "sol") (equal door_translateDirection 2) (equal door_translateDirection "2"))
							(setq doorWidth (- BDEN additional_door_side_clearance clearXSide))
							(setq currDoorHorPos (+ (* doorWidth 0.5) additional_door_side_clearance))
						)
						((or (equal door_translateDirection "SAGSOL")(equal door_translateDirection "sagsol") (equal door_translateDirection 3) (equal door_translateDirection "3"))
							(setq doorWidth (- BDEN additional_door_side_clearance additional_door_side_clearance))
							(setq currDoorHorPos (+ (* doorWidth 0.5) additional_door_side_clearance))
						)
						(T
							(setq currDoorHorPos (/2 BDEN))
						)
					)
					
					
				)
			)

			(setq doorId 
				(if (member divdoortype '("C" "I"))
					(progn				
						(draw_door_drawer (list divdoortype currentDoorName) handledivpos (/2 BDEN) ADDer (- (+ drawCurrDoorElev eleV) divdoorH) doorWidth divdoorH simetri 0.0 (list (* 0.85 ADDer) (* 0.90 doorWidth) (* 0.45 divdoorH) gm1:layerName))
					)		
					(progn
						(kapak_ciz (list divdoortype currentDoorName fixeddDoor (getNth 0 divDoorAnimateScript) nil T) handledivpos currDoorHorPos ADDer (- (+ drawCurrDoorElev eleV) divdoorH) doorWidth divdoorH simetri 0.0)
					)
				)			
			)
			(set_Mdata (entlast)  (list (cons k:animateScript (getNth 0 divDoorAnimateScript))))
			(setq doorsPropList (cons (list ( - (- (+ drawCurrDoorElev eleV) divdoorH) dAltKot)  divdoorH doorWidth handledivpos divDoorType nil divindx doorId)  doorsPropList))
			(setq hasDoor T)
		)
		((member doorCount '("K2"))
			(setq doorWidth (/2 (- BDEN clearXSide clearXBtwn clearXSide))
					leftMid	(+ clearXSide (/2 doorWidth))
					rightMid (+ clearXSide doorWidth clearXBtwn (/2 doorWidth))
			)
			
			(if additional_door_side_clearance
				(if (> additional_door_side_clearance clearXSide)
					(progn
						(cond 
							((or (equal door_translateDirection "SAG") (equal door_translateDirection "sag") (equal door_translateDirection "1") (equal door_translateDirection 1))
								(setq doorWidth (/ (- BDEN clearXBtwn clearXBtwn clearXSide additional_door_side_clearance) 2.0)
									  leftMid (+ (/ doorWidth 2) clearXSide)
									  rightMid (+ clearXBtwn clearXSide (* 3 (/ doorWidth 2))))
							)
							((or (equal door_translateDirection "SOL")(equal door_translateDirection "sol") (equal door_translateDirection "2") (equal door_translateDirection 2))
								(setq doorWidth (/ (- BDEN clearXBtwn clearXBtwn clearXSide additional_door_side_clearance) 2.0)
									  leftMid (+ (/ doorWidth 2) additional_door_side_clearance clearXBtwn)
									  rightMid (+ additional_door_side_clearance (* 3 (/ doorWidth 2)) clearXBtwn clearXBtwn) )
							)
							((or (equal door_translateDirection "SAGSOL")(equal door_translateDirection "sagsol") (equal door_translateDirection "3") (equal door_translateDirection 3))
								(setq doorWidth (/ (- BDEN clearXBtwn additional_door_side_clearance additional_door_side_clearance) 2.0)
									  leftMid (+ (/ doorWidth 2) additional_door_side_clearance)
									  rightMid (+ additional_door_side_clearance (* 3 (/ doorWidth 2)) clearXBtwn))
							)
						)	
					)
				)
			)
			
			(setq doorId (kapak_ciz (list divdoortype currentDoorName fixeddDoor (getNth 0 divDoorAnimateScript) nil T)  handledivpos leftMid ADDer (- (+ drawCurrDoorElev eleV) divdoorH) doorWidth divdoorH "soL" 0.0) )
			(set_Mdata (entlast)  (list (cons k:animateScript (getNth 0 divDoorAnimateScript))))
			
			(setq doorsPropList (cons (list ( - (- (+ drawCurrDoorElev eleV) divdoorH) dAltKot) divdoorH doorWidth handledivpos divDoorType "L" divindx doorId ) doorsPropList))
			(setq doorId (kapak_ciz (list divdoortype currentDoorName fixeddDoor (getNth 0 divDoorAnimateScript) nil T)  handledivpos rightMid ADDer (- (+ drawCurrDoorElev eleV) divdoorH) doorWidth divdoorH "saG" 0.0)
			)
			(set_Mdata (entlast)  (list (cons k:animateScript (getNth 1 divDoorAnimateScript))))
			(setq doorsPropList (cons (list ( - (- (+ drawCurrDoorElev eleV) divdoorH) dAltKot) divdoorH doorWidth handledivpos divDoorType "R" divindx doorId ) doorsPropList))			
			(setq hasDoor T)
		)
	)
	(if (and g_gm1_Preview  (or (member doorCount '("K2")) (member doorCount '("K"))) )
		(progn
			(if (equal (getVar "VIEWDIR") (list -1.0 0.0 0.0))
				(gm1_measureDivOrDoor (- (+ drawCurrDoorElev eleV) divdoorH) (cm -10.0) divdoorH (* -1 (+ ad_et ADDer)) (list -1.0 0.0 0.0) 10.0 10.0)
				(gm1_measureDivOrDoor (- (+ drawCurrDoorElev eleV) divdoorH) 0.0 divdoorH (* -1 (+ ad_et ADDer)) (list 0.0 -1.0 0.0) 10.0 10.0)				
			)
		)
	)
	(setq drawCurrDoorElev ( - drawCurrDoorElev divH))
	
	(gm1_freeDivParams)
	hasDoor
)

(defun rutin_KapakDaralt (additionalClearenceValue doorTransDirection / )
	(princ)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
