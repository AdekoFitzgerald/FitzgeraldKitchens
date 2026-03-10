
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