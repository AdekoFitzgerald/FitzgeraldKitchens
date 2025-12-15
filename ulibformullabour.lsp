(setq p2C_Labour_Calc nil)		; ISCILIK HESAPLA ;;; CALCULATE LABOURS >>>>> restart adeko
(if p2C_Labour_Calc
	(progn
		(setq g_MatMatrixList	; malzeme tipine gore mat matrix ;;; mat matrix according to material type
			(list			;fonksiyon ;her sefer			;material tag ;her rastlanan										;pvc kenar bant ;ilk rastlanan
				(list (list "NONE" "lib" 			) (list "NONE" "lib" 												) (list "##"											)) ; eger hic biri degilse hepsi icin // NONE // wildcard ## orjinal bant kodunu doner ;;; wildcard ## returns original edgeband code
				(list (list "MA"	           		) (list "MASÝF" "Masif"	"massif" "MASSIF"							) (list "" 0.0											)) ; bantsýz ve kalinlik 0.0
				(list (list "DR" 	         		) (list "DURALÝT" "Duralit"											) (list nil												)) ; bant ismi degistirme ;;; dont override edgeband
				(list (list "OS" "HAM"         		) (list "OSB"														) (list nil												))
				(list (list "KP" "HAM"         		) (list "Kontrplak"													) (list nil												))
				(list (list "PW" "HAM"         		) (list "PLYWOOD" "Poliwood" "POLYWOOD"	"PLEYMUT"					) (list nil												))
				(list (list "KR" "HAM"         		) (list "KERESTE"													) (list nil												))
				(list (list "HAM"            		) (list "HAM" "RAW"													) (list nil												))
				(list (list "AST" "HAM"       		) (list "ASTARPAN"													) (list nil												))
				(list (list "MDF" "HAM" "HAMMDF"	) (list "HAM MDF"													) (list nil												))
				(list (list "SNT" "HAM" "HAMSNT"	) (list "HAM SUNTA" 												) (list nil												))
				(list (list "ML" "MDF"        		) (list "MDFLAM" "MDF" "MDF LAM"									) (list "{(rtos pnlT)}x##_{pnlMat}"						)) ; "18xPVC08mm_Mat Beyaz MDF" //  {pnlMat} {(rtos pnlT)} // panel malzemesi ve kalinlik doner ;;; returns panel material and thickness
				(list (list "SL" "SNT"        		) (list "SUNTALAM" "SUNTA" "SNT" "SUNTA LAM"						) (list "{(rtos pnlT)}x##_{pnlMat}"						))
				(list (list "AC" "MDF"         		) (list "Akrilik" "AKRÝLÝK" 										) (list "{(rtos pnlT)}x##_{pnlMat}"						)) ; "18xPVC1mm_Beyaz Akrilik"
				(list (list "HG" "MDF"         		) (list "High Gloss" "GLOSSY" "HAYGLOS" "PARLAK"					) (list "{(rtos pnlT)}x##_3D_{pnlMat}"					)) ; "18xPVC1mm_3D_Beyaz Akrilik"
				(list (list "LA"            		) (list "LAKE"												"BOYA"	) (list "{(rtos pnlT)}xPVC08mm_BOYANABILIR" 0.8			)) ; "18xPVC08mm_BOYANABILIR" ve bant kalýnlýk 0.8 ;;; and band thickness 0.8
				(list (list "LM" "LA" "MDF"    		) (list "LAKE MDF" 											"BOYA"	) (list "{(rtos pnlT)}xPVC08mm_BOYANABILIR" 0.8			))
				(list (list "LS" "LA" "SNT"    		) (list "LAKE SUNTA" 										"BOYA"	) (list "{(rtos pnlT)}xPVC08mm_BOYANABILIR" 0.8			))
				(list (list "KA"		    		) (list "KAPLAMA"									"KAPLA"			) (list "{(rtos pnlT)}x{PvcKoduKAPAK}_KAPLAMA_{pnlMat}"	)) ; "18xPVC1mm_KAPLAMA_KESTANE ORMA" // {PvcKoduKAPAK} degisken ile ;;; with variable
				(list (list "KM" "KA" "MDF"	    	) (list "KAPLAMA MDF" "KAPLAMALI MDF"				"KAPLA"			) (list "{(rtos pnlT)}x{PvcKoduKAPAK}_KAPLAMA_{pnlMat}"	))
				(list (list "KS" "KA" "SNT"	    	) (list "KAPLAMA SUNTA"	"KAPLAMALI SUNTA"			"KAPLA"			) (list "{(rtos pnlT)}x{PvcKoduKAPAK}_KAPLAMA_{pnlMat}"	))
				(list (list "LK" "KA" "LA"     		) (list "LAKE KAPLAMA"								"KAPLA"	"BOYA"	) (list "{(rtos 18)}x{PvcKoduON}_KAPLAMA_{pnlMat}"		)) ; "18xPVC08mm_KAPLAMA_RAL 9003"
				(list (list "CM" "KA" "LA" "MDF"	) (list "LAKE KAPLAMA MDF" 							"KAPLA"	"BOYA"	) (list "{(rtos 18)}x{PvcKoduON}_KAPLAMA_{pnlMat}"		))
				(list (list "CS" "KA" "LA" "SNT"	) (list "LAKE KAPLAMA SUNTA"						"KAPLA"	"BOYA"	) (list "{(rtos 18)}x{PvcKoduON}_KAPLAMA_{pnlMat}"		))
				(list (list "ME" "KA" "LA"			) (list "MELAMÝN" "MELAMIN" "Melamin"				"KAPLA"	"BOYA"	) (list "{(rtos pnlT)}x{PvcKoduKAPAK}_BOYANABILIR"		)) ; "18xPVC1mm_BOYANABILIR"
				(list (list "UL" "LA"				) (list "UVLAK" "UV LAK" "UV" "UV LACQUER" "LAK"			"BOYA"	) (list "{(rtos pnlT)}x{PvcKoduKAPAK}_PARLAK_{pnlMat}"	)) ; "18xPVC1mm_PARLAK_RAL 9003"
				(list (list "PM" "KA"          		) (list "POLÝMERÝK" "Polimerik" "Polimer" "Polymer"	"KAPLA"			) (list "KenarKaplama"									)) ; "KenarKaplama
				(list (list "KL" 	         		) (list "KOMPAKT" "KOMPAKTLAM"										) (list "" 0.0											))
				(list (list "PL"            		) (list "PLASTÝK" "Plastik" "PLASTIK" "PLASTIC"						) (list "" 0.0											))
				(list (list "CM"            		) (list "CAM" "GLASS"												) (list "" 0.0											))
				(list (list "AL"            		) (list "ALUMINYUM" "Aluminyum"	"ALUMINIUM"	"Alu"					) (list "" 0.0											))
				(list (list "AR" "BP"          		) (list "Arkalýk" "ARKALIK"	"Arkalik" "8MM" "5mm" "4mm" "3mm"		) (list "" 0.0											))
				(list (list "DP" 	        		) (list "36MM" "ÇÝFTPANEL" "YAPIÞTIRMA"	"DOUBLE"					) (list "{(rtos pnlT)}x##_{pnlMat}"						)) ; "36xPVC08mm_RAL 9003" // malzeme matrix yerine panel kalinlik kontrolu de yapilabilir
			)
		)
		
		(setq																;çeviri/conversion
			p2c_Labour_Time_Frame				"saat"						;her zaman dilimi icin iscilik ;;; each time frame
			p2c_Labour_Time						3600.0 						;sn ;;; seconds
			p2c_Labour_Weight_Type				"kg" 						;her aðýrlýk dilimi icin iscilik ;;; each weight type
			p2c_Labour_Weight					1000.0						;gr ;;; grams
		)
		
		(setq																;temel iscilik
			p2c_Labour_Modul    				(list "iscilik_modul" '("iscilik_yukleme" 2 "sefer") '("iscilik_kurulum" (/ 930 p2c_Labour_Time) p2c_Labour_Time_Frame) );her modul adet icin iscilik ;;; each unit
			p2c_Labour_Modul_Multiply			1
			p2c_Labour_Modul_Type				"pc"
			p2c_Labour_Modul_Exclude			(list "__NOMODUL__")		;modul kodu haric ;;; exclude unit codes
			
			p2c_Labour_UnitM3	    			"iscilik_paket_m3"			;her modul m3 (en boy der) icin iscilik ;;; each unit m3 (wid hei dep)
			p2c_Labour_UnitM3_Multiply			1.1
			p2c_Labour_UnitM3_Type				"m3"
			p2c_Labour_UnitM3_Exclude			(list "__NOMODUL__")		;modul kodu haric ;;; exclude unit codes
			
			p2c_Labour_UnitM2	    			"iscilik_modul_m2"
			p2c_Labour_UnitM2_Multiply			1.1
			p2c_Labour_UnitM2_Type				"m2"
			p2c_Labour_UnitM2_Exclude			(list "__NOMODUL__")		;modul kodu haric ;;; exclude unit codes
			
			p2c_Labour_UnitM	    			(list "iscilik_modul_mt" "iscilik_uretim" "iscilik_montaj" "iscilik_nakliye" "amortisman")		;her modul mt (en) icin iscilik ;;; each unit m (wid)
			p2c_Labour_UnitM_Multiply			1
			p2c_Labour_UnitM_Type				"mt"
			p2c_Labour_UnitM_Exclude			(list "__NOMODUL__")		;modul kodu haric ;;; exclude unit codes
			
			;p2c_Labour_Part    				"iscilik_panel"				;her panel adet icin iscilik ;;; each part
			p2c_Labour_Part_Multiply			1
			p2c_Labour_Part_Type				"pc"
			;p2c_Labour_Part_SeparateM			T							;malzemeye ayýr ;;; separate by mat --> nil T
			;p2c_Labour_Part_SeparateT			T							;kalinliga ayýr ;;; separate by thick --> nil T
			p2c_Labour_Part_Exclude				(list "CAM" "Glass" "Water" "KAPLAMA" "SANAL")				;malzeme haric ;;; exclude materials
			
			;p2c_Labour_PerimeterCut  			"iscilik_tras"				;her panel cevresi metre icin iscilik ;;; each part perimeter length m
			p2c_Labour_PerimeterCut_Multiply	1
			p2c_Labour_PerimeterCut_Type		"m"
			;p2c_Labour_PerimeterCut_SeparateM 	T							;malzemeye ayýr ;;; separate by mat --> nil T
			;p2c_Labour_PerimeterCut_SeparateT	T							;kalinliga ayýr ;;; separate by thick --> nil T
			p2c_Labour_PerimeterCut_Exclude		(list "CAM" "Glass" "Water" "KAPLAMA" "SANAL")				;malzeme haric ;;; exclude materials
			
			p2c_Labour_PanelM2      			"iscilik_m2"				;her panel metrekare icin iscilik ;;; each part m2
			p2c_Labour_PanelM2_Multiply			1
			p2c_Labour_PanelM2_Type         	"m2"
			;p2c_Labour_PanelM2_SeparateM     	T							;malzemeye ayýr ;;; separate by mat --> nil T
			;p2c_Labour_PanelM2_SeparateT     	T							;kalinliga ayýr ;;; separate by thick --> nil T
			p2c_Labour_PanelM2_Exclude			(list "CAM" "Glass" "Water" "KAPLAMA" "SANAL")				;malzeme haric ;;; exclude materials
			
			p2c_Labour_Palet      				"Palet"    					;her 1 palette 7 plaka (3660mm 1830mm 18mm) icin m3 hesapla ;;; each 1 pallet used for 7 plates (366 183 18) with m3 calculation
			p2c_Labour_Palet_Multiply			(/ 1 (* 7  (* 0.000000001 (apply '* '(3660 1830 18))))) 
			p2c_Labour_Palet_Type      			"pc"
			
			p2c_Labour_PanelM3      			(list "iscilik_kesim_hacim" '(p2c_Labour_Palet p2c_Labour_Palet_Multiply p2c_Labour_Palet_Type))	;her panel m3 icin iscilik ;;; each part m3
			p2c_Labour_PanelM3_Multiply			1
			p2c_Labour_PanelM3_Type         	"m3"
			;p2c_Labour_PanelM3_SeparateM     	T							;malzemeye ayýr ;;; separate by mat --> nil T
			;p2c_Labour_PanelM3_SeparateT     	T							;kalinliga ayýr ;;; separate by thick --> nil T
			p2c_Labour_PanelM3_Exclude			(list "CAM")				;malzeme haric ;;; exclude materials
			
			p2c_Labour_Notched	    			"iscilik_kertik"			;her kertik adet icin iscilik ;;; each notched part
			p2c_Labour_Notched_Multiply			1
			p2c_Labour_Notched_Type      		"pc"
			
			;p2c_Labour_NotchM	    			"iscilik_kesik"				;her kertme kesim operasyonu uzunlugu metre icin iscilik ;;; each notch cut operation length m
			p2c_Labour_NotchM_Multiply			1
			p2c_Labour_NotchM_Type      		"m"
			
			p2c_Labour_Groove	    			"iscilik_kanal"				;her kanal uzunlugu metre icin iscilik ;;; each groove length m
			p2c_Labour_Groove_Multiply			1
			p2c_Labour_Groove_Type         		"m"
			;p2c_Labour_Groove_SeparateW    	T							;genislige ayýr ;;; separate by Wid --> nil T
			p2c_Labour_Groove_Exclude			(list 0 17)					;genislik haric ;;; exclude Wid
			
			p2c_Labour_Hole 					"iscilik_delik"				;her coklu delik adet icin iscilik ;;; each multi drill hole operation
			p2c_Labour_Hole_Multiply			1
			p2c_Labour_Hole_Type         		"pc"
			;p2c_Labour_Hole_separateD			T							;cap ayýr ;;; separate by dia --> nil T
			p2c_Labour_Hole_Exclude				(list 0 37)					;cap haric ;;; exclude by dia
			
			;p2c_Labour_Raw						"iscilik_ham"				;her ham panel malzemesinde yazan attritibute yazan bilgisi icin HAM m2 iscilik ;;; each raw panel m2 for each material attritibute 
			p2c_Labour_Raw_Multiply				0.99
			p2c_Labour_Raw_Type    				"m2"
			p2c_Labour_Raw_Prefix				(list "HAM" "HAM MDF" "HAM SUNTA" "ASTARPAN" "RAW") 
			;p2c_Labour_RawPanel				"iscilik_ham_Panel"			;panel adet ;;; each part
			p2c_Labour_RawPanel_Multiply		1
			p2c_Labour_RawPanel_Type    		"pc"
			p2c_Labour_Raw_Exclude				(list "CAM")				;malzeme haric ;;; exclude materials
			
			p2c_Labour_Veneer					"iscilik_kaplama"			;her malzeme attritibute'de yazan bilgi(prefix) icin KAPLAMA m2 iscilik  ;;; each COVER panel m2 for each material attritibute 
			p2c_Labour_Veneer_Multiply			1.1
			p2c_Labour_Veneer_Type    			"m2"
			p2c_Labour_Veneer_Prefix			(list "KAPLA")
			p2c_Labour_Veneer_Sides				T
			p2c_Labour_Veneer_SeparateM			T
			;p2c_Labour_VeneerPanel				"iscilik_kaplama_panel"		;panel adet ;;; each part
			p2c_Labour_VeneerPanel_Multiply		1
			p2c_Labour_VeneerPanel_Type    		"pc"
			p2c_Labour_VeneerPanel_SeparateM	T
			p2c_Labour_VeneerWrap	    		"KAPLAMA"
			p2c_Labour_VeneerWrap_Add			4
			p2c_Labour_Veneer_Exclude			(list "CAM")				;malzeme haric ;;; exclude materials
			
			p2c_Labour_CoatPaint   				"iscilik_boya"				;her malzeme attritibute'de yazan bilgi(prefix) icin TEK YUZ BOYA m2 iscilik ;;; each painted panel surface m2 for each material attritibute
			p2c_Labour_CoatPaint_Multiply		1.1
			p2c_Labour_CoatPaint_Type    		"m2"
			p2c_Labour_CoatPaint_Prefix			(list "BOYA" "BOYA1" "LAKE")
			p2c_Labour_CoatPaint_Sides			T	
			p2c_Labour_CoatPaint_SeparateM		T	
			;p2c_Labour_CoatPaintPanel   		"iscilik_boya_panel"		;panel adet ;;; each part
			p2c_Labour_CoatPaintPanel_Multiply	1
			p2c_Labour_CoatPaintPanel_Type    	"pc"
			p2c_Labour_CoatPaintPanel_SeparateM T
			p2c_Labour_CoatPaint_Exclude		(list "CAM")				;malzeme haric ;;; exclude materials
			
			p2c_Labour_Coat2Paint   			"iscilik_boya"				;her malzeme attritibute'de yazan bilgi(prefix) icin CIFT YUZ BOYA m2 iscilik  ;;; each painted panel BACK surface m2 for each material attritibute
			p2c_Labour_Coat2Paint_Prefix		(list "BOYA" "BOYA2" "LAKE")
			;p2c_Labour_Coat2Paint_Sides		T			
			;p2c_Labour_Coat2PaintPanel   		"iscilik_boya_panel"		;panel adet ;;; each part
			p2c_Labour_Coat2PaintPanel_Multiply	1
			p2c_Labour_Coat2PaintPanel_Type    	"pc"	
			
			p2c_Labour_CoatSanding				"Boya_Alt_Zimpara"			;ilk kat - her boyali parca m2 ile zimpara solüsyon ;;; first coating ;;; each painted surface sanding solution lt
			p2c_Labour_CoatSanding_Multiply		0.48
			p2c_Labour_CoatSanding_Type			"Lt"
			;p2c_Labour_CoatSanding_SeparateM	T
			
			p2c_Labour_CoatVarnish				"Boya_Ust_Vernik"			;iki kat - her boyali parca m2 ile vernik lt solüsyon ;;; secondary coating ;;; each painted surface varnish solution lt
			p2c_Labour_CoatVarnish_Multiply		0.32
			p2c_Labour_CoatVarnish_Type			"Lt"
			;p2c_Labour_CoatVarnish_SeparateM	T
			
			p2c_Labour_CoatSolvent				"Boya_Bitis_Tiner"			;son kat - her boyali parca m2 ile tiner lt solüsyon ;;; finishing coating ;;; each painted surface polishing thinner sealing solution lt
			p2c_Labour_CoatSolvent_Multiply		0.72
			p2c_Labour_CoatSolvent_Type			"Lt"
			;p2c_Labour_CoatSolvent_SeparateM	T
			
			p2c_Labour_CoatThinner				"Boya_Ek_Renk"				;her boyali parca m2 ile renk lt solüsyon - boya ;;; additive paint lt
			p2c_Labour_CoatThinner_Multiply		0.08
			p2c_Labour_CoatThinner_Type			"Lt"		
			p2c_Labour_CoatThinner_SeparateM	T		
			
			p2c_Labour_EdgeM					"iscilik_bant"				;her kenarda kullanilan kenar bandý metrajý isciligi ;;; each edge band side length
			p2c_Labour_EdgeM_Multiply			1
			p2c_Labour_EdgeM_Add				0.04						;bas son kesme ekle ;;; start-finish lose cut
			p2c_Labour_EdgeM_Type				"m"
			;p2c_Labour_EdgeM_SeparateM			T							;kod ile ayýr ;;; separate by code --> nil T
			p2c_Labour_EdgeM_SeparateT			T							;kalinlik ile ayýr ;;; separate by thick --> nil T
			;p2c_Labour_Edge					"iscilik_kenar" 			;her bantlanan parca kenarý adedi isciligi ;;; each edge banded side pc
			p2c_Labour_Edge_Multiply			1
			p2c_Labour_Edge_Type				"pc"
			;p2c_Labour_Edge_SeparateM			T							;kod ile ayýr ;;; separate by code --> nil T
			;p2c_Labour_Edge_SeparateT			T							;kalinlik ile ayýr ;;; separate by thick --> nil T
			p2c_Labour_EdgeGlue					"Bant_Tutkal"				;her kenar bandý metrajýnda kullanilan tutkal gr isciligi ;;; additive glue gr according to edge length
			p2c_Labour_EdgeGlue_Multiply		(/ 1  p2c_Labour_Weight)
			p2c_Labour_EdgeGlue_Type			p2c_Labour_Weight_Type
			;p2c_Labour_EdgeGlue_SeparateM		T							;kod ile ayýr ;;; separate by code --> nil T
			;p2c_Labour_EdgeGlue_SeparateT		T							;kalinlik ile ayýr ;;; separate by thick --> nil T
			p2c_Labour_Edge_Exclude				(list "PVC0" "KenarKaplama");bant kodu haric ;;; exclude band code
			
			;p2c_Labour_Door						"iscilik_kapak_panel"		;her kapak adet isciligi ;;; each door
			p2c_Labour_Door_Multiply			1
			p2c_Labour_Door_Type				"pc"
			;p2c_Labour_Door_GroupSuffix		T							;grup ismi ekle	;;; add group name
			p2c_Labour_Door_ModelSuffix			T							;model ismi ekle ;;; add model name
			p2c_Labour_Door_CostSuffix			T							;tip ismi ekle A-B ;;; add type name A-B
			;p2c_Labour_Door_FormSuffix			T							;form ismi ekle ;;; add type name
			;p2c_Labour_Door_MatSuffix			T							;Mat ismi ekle ;;; add type name  --> wip - receteden yorum yapilmasi gerek -->> currentDoorsource0 esitlenebilir
			p2c_Labour_Door_Exclude				(list "DUZKPK")				;model haric ;;; exclude models
			
			p2c_Labour_DoorM2					"iscilik_kapak"				;her kapak m2 isciligi ;;; each door m2
			p2c_Labour_DoorM2_Multiply			1
			p2c_Labour_DoorM2_Type				"m2"
			;p2c_Labour_DoorM2_GroupSuffix		T							;grup ismi ekle ;;; add group name
			p2c_Labour_DoorM2_ModelSuffix		T							;model ismi ekle ;;; add model name
			p2c_Labour_DoorM2_CostSuffix		T							;tip ismi ekle A-B ;;; add type name A-B
			;p2c_Labour_DoorM2_FormSuffix		T							;form ismi ekle ;;; add type name
			;p2c_Labour_DoorM2_MatSuffix		T							;Mat ismi ekle ;;; add type name  --> wip - receteden yorum yapilmasi gerek -->> currentDoorsource0 esitlenebilir
			p2c_Labour_DoorM2_Exclude			(list "DUZKPK")				;model haric ;;; exclude models
			
		)
	)
)


;;;;;;;;;;;;;;;;; ISCILIK TEMEL FONKSIYONLAR ;;;;;;;;;

;(post.iTag (list "code" 1 "ad" "tag2" "tag1")) ; _itemmain ve _puttag yapar
(defun post.iTag (args / itm) 
	(setq itm (ifnull (getnth 0 args) (ifnull labourItem "itag")))
	(_ITEMMAIN itm itm (list (ifnull (getnth 1 args) 1.0) (ifnull (getnth 2 args) "pc")))
	(_PUTTAG itm itm (ifnull (getnth 4 args) "p2cLabour")) ; tag1
	(_PUTTAG itm itm (ifnull (getnth 3 args) (ifnull doSomething "itag"))) ;tag2
	(if (getnth 5 args) (_PUTTAG itm itm (ifnull (getnth 5 args))))
	(if (getnth 6 args) (_PUTTAG itm itm (ifnull (getnth 6 args))))
	(if (getnth 7 args) (_PUTTAG itm itm (ifnull (getnth 7 args))))
	(if (getnth 8 args) (_PUTTAG itm itm (ifnull (getnth 8 args))))
	(if (getnth 9 args) (_PUTTAG itm itm (ifnull (getnth 9 args))))
)


(defun Post_Unit_P2C_Labour_Process (/ labourType labourSize labourItem item mdlcode) ; her lmm_runMacroByModule modul ile
	(setq mdlCode (parseLFT __MODULCODE "$"))
	(if (and p2c_Labour_Modul (not (member mdlCode p2c_Labour_Modul_Exclude)))
		(progn
			(if (not (islist p2c_Labour_Modul)) (setq p2c_Labour_Modul (list p2c_Labour_Modul)))
			(foreach item p2c_Labour_Modul
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourSize 1)
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_Modul_Type))
				(post.iTag (list labourItem (* p2c_Labour_Modul_Multiply labourSize) labourType "p2c_Labour_Modul"))
			)
		)
	)
	(if (and p2c_Labour_UnitM3 (not (member mdlCode p2c_Labour_UnitM3_Exclude)))
		(progn
			(if (not (islist p2c_Labour_UnitM3)) (setq p2c_Labour_UnitM3 (list p2c_Labour_UnitM3)))
			(foreach item p2c_Labour_UnitM3
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourSize (* (* __DEP 0.001) (* __HEI 0.001) (* __WID 0.001)))
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_UnitM3_type))
				(post.iTag (list labourItem (* p2c_Labour_UnitM3_Multiply labourSize) labourType "p2c_Labour_UnitM3"))
			)
		)
	)
	(if (and p2c_Labour_UnitM2 (not (member mdlCode p2c_Labour_UnitM2_Exclude)))
		(progn
			(if (not (islist p2c_Labour_UnitM2)) (setq p2c_Labour_UnitM2 (list p2c_Labour_UnitM2)))
			(foreach item p2c_Labour_UnitM2
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourSize (* (* __DEP 0.001) (* __HEI 0.001)))
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_UnitM2_type))
				(post.iTag (list labourItem (* p2c_Labour_UnitM2_Multiply labourSize) labourType "p2c_Labour_UnitM2"))
			)
		)
	)
	(if (and p2c_Labour_UnitM (not (member mdlCode p2c_Labour_UnitM_Exclude)))
		(progn
			(if (not (islist p2c_Labour_UnitM)) (setq p2c_Labour_UnitM (list p2c_Labour_UnitM)))
			(foreach item p2c_Labour_UnitM
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourSize (* __WID 0.001))
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_UnitM_type))
				(post.iTag (list labourItem (* p2c_Labour_UnitM_Multiply labourSize) labourType "p2c_Labour_UnitM"))
			)
		)
	)
	(princ)
)
(defun Post_PanelMain_P2C_Labour_Process (/ subFlag labourType labourSize labourItem item boundSize pnlM pnlM2 pnlM2Sides pnlm2cube pnlH pnlW pnlT pnlMAT pnlRot pnlMatAttributes pnlMatAttributesUcase) ; her _panelmain panel ile
	(setq boundSize (getBBox panelEnt))	; panel olculeri (mm)
	(setq pnlH (getnth 2 boundSize))
	(setq pnlW (getnth 3 boundSize))
	(setq pnlT __PANELDEPTH)
	(setq pnlMat tempMaterial)
	(setq pnlRot tempRotations)
	(setq pnlM	(+ (* pnlW 2 0.001) (* pnlH 2 0.001)))
	(setq pnlM2	(* (* pnlW 0.001) (* pnlH 0.001)))
	(setq pnlM2Sides (+ (* 2 (* pnlH 0.001) (* pnlT 0.001)) (* 2 (* pnlW 0.001) (* pnlT 0.001)))) ; panel m2 4 sides
	(setq pnlM3	(* pnlM2 (* pnlT 0.001)))
	(setq pnlMatAttributes
		(list
			pnlMAT							; malzeme ismi
			(car (getmatcode pnlMAT))		; uretim kodu
			(car (getmatattribute1 pnlMAT))	; nitelik 1
			(car (getmatattribute2 pnlMAT))	; nitelik 2
			(car (getmatattribute3 pnlMAT))	; nitelik 3
			(car (getmatattribute4 pnlMAT))	; nitelik 4
		)
	)
	(setq pnlMatAttributesUcase (mapcar '(lambda (x) (if x (strcase x))) pnlMatAttributes))
	
	(if (not (checkStrInStr "!!SFACE" panelCode) ) ; sface arka yuz degilse
		(progn
			(if (and p2c_Labour_Part (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_Part_Exclude))))
				(progn
					(if (not (islist p2c_Labour_Part)) (setq p2c_Labour_Part (list p2c_Labour_Part)))
					(foreach item p2c_Labour_Part
						(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
						(setq labourItem (if (islist item) (car item) item))
						(if p2c_Labour_Part_SeparateM (setq labourItem (strcat labourItem "_" pnlMat)))
						(if p2c_Labour_Part_SeparateT (setq labourItem (strcat labourItem "_" (rtos pnlT))))
						(setq labourSize 1)
						(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
						(setq labourType (if (islist item) (caddr item) p2c_Labour_Part_type))
						(post.iTag (list labourItem (* p2c_Labour_Part_Multiply labourSize) labourType "p2c_Labour_Part"))
					)
				)
			)
			(if (and p2c_Labour_PerimeterCut (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_PerimeterCut_Exclude))))
				(progn
					(if (not (islist p2c_Labour_PerimeterCut)) (setq p2c_Labour_PerimeterCut (list p2c_Labour_PerimeterCut)))
					(foreach item p2c_Labour_PerimeterCut
						(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
						(setq labourItem (if (islist item) (car item) item))
						(if p2c_Labour_PerimeterCut_SeparateM (setq labourItem (strcat labourItem "_" pnlMat)))
						(if p2c_Labour_PerimeterCut_SeparateT (setq labourItem (strcat labouutilrItem "_" (rtos pnlT))))
						(setq labourSize pnlM)
						(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
						(setq labourType (if (islist item) (caddr item) p2c_Labour_PerimeterCut_type))
						(post.iTag (list labourItem (* p2c_Labour_PerimeterCut_Multiply labourSize) labourType "p2c_Labour_PerimeterCut"))
					)
				)
			)
			(if (and p2c_Labour_PanelM2 (< pnlt 72) (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_PanelM2_Exclude))))
				(progn
					(if (not (islist p2c_Labour_PanelM2)) (setq p2c_Labour_PanelM2 (list p2c_Labour_PanelM2)))
					(foreach item p2c_Labour_PanelM2
						(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
						(setq labourItem (if (islist item) (car item) item))
						(if p2c_Labour_PanelM2_SeparateM (setq labourItem (strcat labourItem "_" pnlMat)))
						(if p2c_Labour_PanelM2_SeparateT (setq labourItem (strcat labourItem "_" (rtos pnlT))))
						(setq labourSize pnlM2)
						(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
						(setq labourType (if (islist item) (caddr item) p2c_Labour_PanelM2_type))
						(post.iTag (list labourItem (* p2c_Labour_PanelM2_Multiply labourSize) labourType "p2c_Labour_PanelM2"))
					)
				)
			)
			(if (and p2c_Labour_PanelM3 (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_PanelM3_Exclude))))
				(progn
					(if (not (islist p2c_Labour_PanelM3)) (setq p2c_Labour_PanelM3 (list p2c_Labour_PanelM3)))
					(foreach item p2c_Labour_PanelM3
						(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
						(setq labourItem (if (islist item) (car item) item))
						(if p2c_Labour_PanelM3_SeparateM (setq labourItem (strcat labourItem "_" pnlMat)))
						(if p2c_Labour_PanelM3_SeparateT (setq labourItem (strcat labourItem "_" (rtos pnlT))))
						(setq labourSize pnlM3)
						(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
						(setq labourType (if (islist item) (caddr item) p2c_Labour_PanelM3_type))
						(post.iTag (list labourItem (* p2c_Labour_PanelM3_Multiply labourSize) labourType "p2c_Labour_PanelM3"))
					)
				)
			)
			(if	(and (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_Raw_Exclude))) (apply 'OR (mapcar '(lambda (x) (member x pnlMatAttributesUCASE)) (mapcar 'strcase p2c_Labour_Raw_Prefix))))
				(progn
					(if p2c_Labour_Raw
						(progn
							(if (not (islist p2c_Labour_Raw)) (setq p2c_Labour_Raw (list p2c_Labour_Raw)))
							(foreach item p2c_Labour_Raw
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(setq labourSize pnlM2)
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_Raw_type))
								(post.iTag (list labourItem (* p2c_Labour_Raw_Multiply labourSize) labourType "p2c_Labour_Raw"))
							)
						)
					)
					(if p2c_Labour_RawPanel
						(progn
							(if (not (islist p2c_Labour_RawPanel)) (setq p2c_Labour_RawPanel (list p2c_Labour_RawPanel)))
							(foreach item p2c_Labour_RawPanel
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(setq labourSize 1)
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_RawPanel_type))
								(post.iTag (list labourItem (* p2c_Labour_RawPanel_Multiply labourSize) labourType "p2c_Labour_RawPanel"))
							)
						)
					)
				)
			)
			(if (and (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_Veneer_Exclude))) (apply 'OR (mapcar '(lambda (x) (member x pnlMatAttributesUCASE)) (mapcar 'strcase p2c_Labour_Veneer_Prefix))))
				(progn
					(if p2c_Labour_Veneer
						(progn
							(if (not (islist p2c_Labour_Veneer)) (setq p2c_Labour_Veneer (list p2c_Labour_Veneer)))
							(foreach item p2c_Labour_Veneer
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_Veneer_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (* (* (+ pnlW (* 2 (if p2c_Labour_Veneer_Sides pnlT 0.0))) 0.001) (* (+ pnlH (* 2 (if p2c_Labour_Veneer_Sides pnlT 0.0))) 0.001)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_Veneer_type))
								(post.iTag (list labourItem (* p2c_Labour_Veneer_Multiply labourSize) labourType "p2c_Labour_Veneer"))
							)
						)
					)
					(if p2c_Labour_VeneerPanel
						(progn
							(if (not (islist p2c_Labour_VeneerPanel)) (setq p2c_Labour_VeneerPanel (list p2c_Labour_VeneerPanel)))
							(foreach item p2c_Labour_VeneerPanel
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_VeneerPanel_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize 1)
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_VeneerPanel_type))
								(post.iTag (list labourItem (* p2c_Labour_VeneerPanel_Multiply labourSize) labourType "p2c_Labour_VeneerPanel"))
							)
						)
					)
				)
			)

			(if (and (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_CoatPaint_Exclude))) (apply 'OR (mapcar '(lambda (x) (member x pnlMatAttributesUCASE)) (mapcar 'strcase p2c_Labour_CoatPaint_Prefix))))
				(progn
					(if p2c_Labour_CoatPaintPanel
						(progn
							(if (not (islist p2c_Labour_CoatPaintPanel)) (setq p2c_Labour_CoatPaintPanel (list p2c_Labour_CoatPaintPanel)))
							(foreach item p2c_Labour_CoatPaintPanel
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatPaintPanel_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize 1)
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatPaintPanel_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatPaintPanel_Multiply labourSize) labourType "p2c_Labour_CoatPaintPanel"))
							)
						)
					)
					
					(if p2c_Labour_CoatPaint
						(progn
							(if (not (islist p2c_Labour_CoatPaint)) (setq p2c_Labour_CoatPaint (list p2c_Labour_CoatPaint)))
							(foreach item p2c_Labour_CoatPaint
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatPaint_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_CoatPaint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatPaint_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatPaint_Multiply labourSize) labourType "p2c_Labour_CoatPaint"))
							)
						)
					)
					(if (and p2c_Labour_CoatPaint p2c_Labour_CoatSanding)
						(progn
							(if (not (islist p2c_Labour_CoatSanding)) (setq p2c_Labour_CoatSanding (list p2c_Labour_CoatSanding)))
							(foreach item p2c_Labour_CoatSanding
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatSanding_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_CoatPaint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatSanding_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatSanding_Multiply labourSize p2c_Labour_CoatPaint_Multiply) labourType "p2c_Labour_CoatSanding"))
							)
						)
					)
					(if (and p2c_Labour_CoatPaint p2c_Labour_CoatVarnish)
						(progn
							(if (not (islist p2c_Labour_CoatVarnish)) (setq p2c_Labour_CoatVarnish (list p2c_Labour_CoatVarnish)))
							(foreach item p2c_Labour_CoatVarnish
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatVarnish_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_CoatPaint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatVarnish_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatVarnish_Multiply labourSize p2c_Labour_CoatPaint_Multiply) labourType "p2c_Labour_CoatVarnish"))
							)
						)
					) 
					(if (and p2c_Labour_CoatPaint p2c_Labour_CoatSolvent)
						(progn
							(if (not (islist p2c_Labour_CoatSolvent)) (setq p2c_Labour_CoatSolvent (list p2c_Labour_CoatSolvent)))
							(foreach item p2c_Labour_CoatSolvent
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatSolvent_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_CoatPaint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatSolvent_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatSolvent_Multiply labourSize p2c_Labour_CoatPaint_Multiply) labourType "p2c_Labour_CoatSolvent"))
							)
						)
					) 
					(if (and p2c_Labour_CoatPaint p2c_Labour_CoatThinner)
						(progn
							(if (not (islist p2c_Labour_CoatThinner)) (setq p2c_Labour_CoatThinner (list p2c_Labour_CoatThinner)))
							(foreach item p2c_Labour_CoatThinner
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatThinner_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_CoatPaint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatThinner_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatThinner_Multiply labourSize p2c_Labour_CoatPaint_Multiply) labourType "p2c_Labour_CoatThinner"))
							)
						)
					)
				)
			)
			(if (and (not (apply 'or (mapcar '(lambda (x) (equal (substr (strcase pnlMAT) 1 (strlen (strcase x))) (strcase x))) p2c_Labour_CoatPaint_Exclude))) (apply 'OR (mapcar '(lambda (x) (member x pnlMatAttributesUCASE)) (mapcar 'strcase p2c_Labour_Coat2Paint_Prefix))))
				(progn
					(if p2c_Labour_Coat2Paint
						(progn
							(if (not (islist p2c_Labour_Coat2Paint)) (setq p2c_Labour_Coat2Paint (list p2c_Labour_Coat2Paint)))
							(foreach item p2c_Labour_Coat2Paint
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatPaint_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_Coat2Paint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatPaint_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatPaint_Multiply labourSize) labourType "p2c_Labour_Coat2Paint"))
							)
						)
					)
					(if (and p2c_Labour_Coat2Paint p2c_Labour_CoatSanding)
						(progn
							(if (not (islist p2c_Labour_CoatSanding)) (setq p2c_Labour_CoatSanding (list p2c_Labour_CoatSanding)))
							(foreach item p2c_Labour_CoatSanding
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatSanding_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_Coat2Paint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatSanding_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatSanding_Multiply labourSize) labourType "p2c_Labour_Coat2Paint"))
							)
						)
					)
					(if (and p2c_Labour_Coat2Paint p2c_Labour_CoatVarnish)
						(progn
							(if (not (islist p2c_Labour_CoatVarnish)) (setq p2c_Labour_CoatVarnish (list p2c_Labour_CoatVarnish)))
							(foreach item p2c_Labour_CoatVarnish
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatVarnish_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_Coat2Paint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatVarnish_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatVarnish_Multiply labourSize p2c_Labour_CoatPaint_Multiply) labourType "p2c_Labour_Coat2Paint"))
							)
						)
					)
					(if (and p2c_Labour_Coat2Paint p2c_Labour_CoatSolvent)
						(progn
							(if (not (islist p2c_Labour_CoatSolvent)) (setq p2c_Labour_CoatSolvent (list p2c_Labour_CoatSolvent)))
							(foreach item p2c_Labour_CoatSolvent
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatSolvent_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_Coat2Paint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatSolvent_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatSolvent_Multiply labourSize p2c_Labour_CoatPaint_Multiply) labourType "p2c_Labour_Coat2Paint"))
							)
						)
					)
					(if (and p2c_Labour_Coat2Paint p2c_Labour_CoatThinner)
						(progn
							(if (not (islist p2c_Labour_CoatThinner)) (setq p2c_Labour_CoatThinner (list p2c_Labour_CoatThinner)))
							(foreach item p2c_Labour_CoatThinner
								(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
								(setq labourItem (if (islist item) (car item) item))
								(if p2c_Labour_CoatThinner_SeparateM (setq labourItem (strcat labourItem "_"  pnlMat)))
								(setq labourSize (+ pnlM2 (if p2c_Labour_Coat2Paint_Sides pnlM2Sides 0.0)))
								(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
								(setq labourType (if (islist item) (caddr item) p2c_Labour_CoatThinner_type))
								(post.iTag (list labourItem (* p2c_Labour_CoatThinner_Multiply labourSize p2c_Labour_CoatPaint_Multiply) labourType "p2c_Labour_Coat2Paint"))
							)
						)
					) 
				)
			)
			(if Post_Panel_Process (Post_Panel_Process)) ; PANELMAIN BITINCE YONLENDIRME
		)
	)
	(princ)
)
(defun Post_onlyIrregularSides_P2C_Labour_Process (/ labourType labourSize labourItem item i pt ptList ptDist distList totalNotchDist) ; her lmm-s-onlyIrregularSides kertik operasyonu ile
	(if p2c_Labour_Notch
		(progn
			(if (not (islist p2c_Labour_Notch)) (setq p2c_Labour_Notch (list p2c_Labour_Notch)))
			(foreach item p2c_Labour_Notch
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourSize (* (lmm_getPolylinePointsDist tempPolEnt) 0.001))
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_Notch_Type))
				(post.iTag (list labourItem (* p2c_Labour_Notch_Multiply labourSize) labourType "p2c_Labour_Notch"))
			)
		)
	)
	(if p2c_Labour_Notched
		(progn
			(if (not (islist p2c_Labour_Notched)) (setq p2c_Labour_Notched (list p2c_Labour_Notched)))
			(foreach item p2c_Labour_Notched
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourSize 1)
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_Notched_Type))
				(post.iTag (list labourItem (* p2c_Labour_Notched_Multiply labourSize) labourType "p2c_Labour_Notched"))
			)
		)
	)
	(princ)
)
(defun Post_Groove_P2C_Labour_Process (/ subFlag labourType labourSize labourItem item grooveLengthM) ; her _groove kanal ile
	(setq grooveLengthM (if pointList (* 0.001 (distance (getnth 0 pointList) (getnth 1 pointList))) 0.0))
	(if (and p2c_Labour_Groove (> width 0.0) (> tempDepth 0.0) (not (member width p2c_Labour_Groove_Exclude)))
		(progn
			(if (not (islist p2c_Labour_Groove)) (setq p2c_Labour_Groove (list p2c_Labour_Groove)))
			(foreach item p2c_Labour_Groove
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourItem (if p2c_Labour_Groove_SeparateW (setq labourItem (strcat item (rtos width))) labourItem))
				(setq labourSize grooveLengthM)
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_Groove_Type))
				(post.iTag (list labourItem (* p2c_Labour_Groove_Multiply labourSize) labourType "p2c_Labour_Groove"))
			)
		)
	)
	(if Post_Groove_Process (Post_Groove_Process)) ; GROOVE BITINCE YONLENDIRME
	(princ)
)
(defun Post_Hole_P2C_Labour_Process (/ subFlag labourType labourSize labourItem item) ; her _holemain delik ile
	(if (and p2c_Labour_Hole (> diameter 0.0) (not (member diameter p2c_Labour_Hole_Exclude)))
		(progn
			(if (not (islist p2c_Labour_Hole)) (setq p2c_Labour_Hole (list p2c_Labour_Hole)))
			(foreach item p2c_Labour_Hole
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourItem (if p2c_Labour_Hole_separateD (strcat labourItem "_" (rtos diameter)) labourItem))
				(setq labourSize 1)
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_Hole_Type))
				(post.iTag (list labourItem (* p2c_Labour_Hole_Multiply labourSize) labourType "p2c_Labour_Hole"))
			)
		)
	)
	(if Post_Hole_Process (Post_Hole_Process)) ; HOLEMAIN BITINCE YONLENDIRME
	(princ)
)
(defun Post_EdgeMain_P2C_Labour_Process (/ subFlag labourType labourSize labourItem item edgeStripLengthM) ; her _EdgeMain kenarbant ile
	(setq edgeStripLengthM (* 0.001 (distance (getnth 0 polylineData) (getnth 2 polylineData))))
	
	(if (and p2c_Labour_EdgeM (not (member tempMaterial p2c_Labour_Edge_Exclude)))
		(progn
			(if (not (islist p2c_Labour_EdgeM)) (setq p2c_Labour_EdgeM (list p2c_Labour_EdgeM)))
			(foreach item p2c_Labour_EdgeM
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(if p2c_Labour_EdgeM_SeparateM (setq labourItem (strcat labourItem "_" tempMaterial)))
				(if p2c_Labour_EdgeM_SeparateT (setq labourItem (strcat labourItem "_" (rtos width))))
				(setq labourSize (+ p2c_Labour_EdgeM_add edgeStripLengthM))
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_EdgeM_Type))
				(post.iTag (list labourItem (* p2c_Labour_EdgeM_Multiply labourSize) labourType "p2c_Labour_EdgeM"))
			)
		)
	)
	(if (and p2c_Labour_Edge (not (member tempMaterial p2c_Labour_Edge_Exclude)))
		(progn
			(if (not (islist p2c_Labour_Edge)) (setq p2c_Labour_Edge (list p2c_Labour_Edge)))
			(foreach item p2c_Labour_Edge
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(if p2c_Labour_Edge_SeparateM (setq labourItem (strcat labourItem "_" tempMaterial)))
				(if p2c_Labour_Edge_SeparateT (setq labourItem (strcat labourItem "_" (rtos width))))
				(setq labourSize 1)
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_Edge_Type))
				(post.iTag (list labourItem (* p2c_Labour_Edge_Multiply labourSize) labourType "p2c_Labour_Edge"))
			)
		)
	)
	(if (and p2c_Labour_EdgeGlue (not (member tempMaterial p2c_Labour_Edge_Exclude)))
		(progn
			(if (not (islist p2c_Labour_EdgeGlue)) (setq p2c_Labour_EdgeGlue (list p2c_Labour_EdgeGlue)))
			(foreach item p2c_Labour_EdgeGlue
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(if p2c_Labour_EdgeGlue_SeparateM (setq labourItem (strcat labourItem "_" tempMaterial)))
				(if p2c_Labour_EdgeGlue_SeparateT (setq labourItem (strcat labourItem "_" (rtos width))))
				(setq labourSize (* p2c_Labour_EdgeM_Multiply (+ p2c_Labour_EdgeM_add edgeStripLengthM)))
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_EdgeGlue_Type))
				(post.iTag (list labourItem (* p2c_Labour_EdgeGlue_Multiply labourSize) labourType "p2c_Labour_EdgeGlue"))
			)
		)
	)
	(if Post_Edge_Process (Post_Edge_Process)) ; EDGEMAIN BITINCE YONLENDIRME
	(princ)
)
(defun Post_Door_P2C_Labour_Process (/ subFlag labourType labourSize labourItem pnlM pnlM2 pnlM2Sides pnlM2cube pnlH pnlW pnlT pnlMAT pnlRot pnlMatAttributes pnlMatAttributesUcase pnlCita pnlCitaX pnlCitaY) ; her p2c ve wrd kapak recetesi calistiginda her kapak ile
	;post_panelmain ile ayni olsun diye bunlar eklendi
	(setq pnlH currentDoorHEI)
	(setq pnlW currentDoorWID)
	(setq pnlT (ifnull currentDoorSource1 __AD_PANELTHICK))
	(setq pnlMat (ifnull doorLayerMAT (ifnull currentDoorSource0 "nullmat"))) ;failsafe nullmat
	(setq pnlRot (ifnull doorgrain currentDoorGrain))
	(setq pnlM (+ (* pnlW 2 0.001) (* pnlH 2 0.001)))
	(setq pnlM2 areaOfDoor)
	(setq pnlM2Sides (+ (* 2 (* pnlH 0.001) (* pnlT 0.001)) (* 2 (* pnlW 0.001) (* pnlT 0.001)))) ; panel m2 4 sides
	(setq pnlM3 (* pnlM2 (* pnlT 0.001)))
	(setq pnlMatAttributes
		(list
			pnlMAT							; malzeme ismi
			(car (getmatcode pnlMat))		; uretim kodu
			(car (getmatattribute1 pnlMat))	; nitelik 1
			(car (getmatattribute2 pnlMat))	; nitelik 2
			(car (getmatattribute3 pnlMat))	; nitelik 3
			(car (getmatattribute4 pnlMat))	; nitelik 4
		)
	)
	(setq pnlMatAttributesUcase (mapcar '(lambda (x) (if x (strcase x))) pnlMatAttributes))

	(if (and currentdoorform (parsergt currentdoorform "cita"))
		(progn
			(setq pnlCita (mapcar 'atoi (splitstr (parsergt currentdoorform "cita") "."))) 
			(setq pnlCitaX (cadr pnlCita))
			(setq pnlCitaY (car pnlCita))
			(setq pnlCita (apply '+ pnlCita)) ;cita sayisi hesabý : KPK'DAN DRAWBARS SONRASINDA DOORFORM : cita X . Y
		)
		(setq pnlCita 0 pnlCitaX 0 pnlCitaY 0)
	)

	(if p2c_Labour_Door
		(progn
			(if (not (islist p2c_Labour_Door)) (setq p2c_Labour_Door (list p2c_Labour_Door)))
			(foreach item p2c_Labour_Door
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourItem (strcat labourItem (if p2c_Labour_Door_GroupSuffix (strcat "_" currentDoorGROUP) "") (if p2c_Labour_Door_ModelSuffix (strcat "_" currentDoorMODEL) "") (if p2c_Labour_Door_CostSuffix (strcat "_" doorCostType) "") (if p2c_Labour_Door_FormSuffix (strcat "_" currentDoorForm) "")))
				(setq labourSize 1)
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_Door_Type))
				(post.iTag (list labourItem (* p2c_Labour_Door_Multiply labourSize) labourType "p2c_Labour_Door"))
			)
		)
	)
	(if p2c_Labour_DoorM2
		(progn
			(if (not (islist p2c_Labour_DoorM2)) (setq p2c_Labour_DoorM2 (list p2c_Labour_DoorM2)))
			(foreach item p2c_Labour_DoorM2
				(if (not (equal (type item) 'STR)) (setq item (mapcar 'eval item)))
				(setq labourItem (if (islist item) (car item) item))
				(setq labourItem (strcat labourItem (if p2c_Labour_DoorM2_GroupSuffix (strcat "_" currentDoorGROUP) "") (if p2c_Labour_DoorM2_ModelSuffix (strcat "_" currentDoorMODEL) "")  (if p2c_Labour_DoorM2_CostSuffix (strcat "_" doorCostType) "") (if p2c_Labour_DoorM2_FormSuffix (strcat "_" currentDoorForm) "")))
				(setq labourSize (if areaOfDoor areaOfDoor 0.0))
				(setq labourSize (if (islist item) (* labourSize (cadr item)) labourSize))
				(setq labourType (if (islist item) (caddr item) p2c_Labour_DoorM2_Type))
				(post.iTag (list labourItem (* p2c_Labour_DoorM2_Multiply labourSize) labourType "p2c_Labour_DoorM2"))
			)
		)
	)
	(if Post_Door_Process (Post_Door_Process)) ; DOOR.p2c BITINCE YONLENDIRME
	(princ)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; OPERASYON & MODEL & MALZEME TIPI TEMEL YONLENDIRME FONKSIYONU ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; OPERATION & MODEL & MATERIAL TYPE BASIC REDIRECTION FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun Post_Edge_Process	( / doSomething panelCode.PARENT tempMaterial.PARENT width.PARENT edgeStripLengthM.PARENT)
	(if (not subFlag)
		(progn
			(setq subFlag T)
			(mapcar '(lambda (x) (set (read (strcat (sym2str x) ".PARENT")) (eval x)))
			'(panelCode tempMaterial width edgeStripLengthM)
			)
			
			(if tempMaterial			
				(if (eval (read (setq doSomething (strcat "PostRun." tempMaterial))))
					(eval (read (strcat "(" doSomething ")")))
					(if (eval (read (setq doSomething "PostRun.Edge")))
						(eval (read (strcat "(" doSomething ")")))
					)
				)
			)
		)
	)
)

; (defun Postrun.Edge ()
	; (princ)
; )

(defun Post_Hole_Process	( / doSomething diameter.PARENT)
	(if (not subFlag)
		(progn
			(setq subFlag T)
			(setq diameter.PARENT diameter)
			(if (eval (read (setq doSomething (strcat "PostRun." "Hole" "_" (rtos diameter)))))
				(eval (read (strcat "(" doSomething ")")))
				(if (eval (read (setq doSomething "PostRun.Hole")))
					(eval (read (strcat "(" doSomething ")")))
				)
			)
		)
	)
)

; (defun Postrun.Hole ()
	; (princ)
; )

(defun Post_Groove_Process	( / doSomething width.PARENT tempDepth.PARENT grooveLengthM.PARENT)
	(if (not subFlag)
		(progn
			(setq subFlag T)
			(mapcar '(lambda (x) (set (read (strcat (sym2str x) ".PARENT")) (eval x)))
			'(width tempDepth grooveLengthM)
			)
			(if (eval (read (setq doSomething (strcat "PostRun." "GROOVE" "_" (rtos width)))))
				(eval (read (strcat "(" doSomething ")")))
				(if (eval (read (setq doSomething "PostRun.GROOVE")))
					(eval (read (strcat "(" doSomething ")")))
				)
			)
		)
	)
)

; (defun Postrun.Groove ()
	; (princ)
; )

(defun Post_Door_Process	( / i iLen doSomething currentDoorGROUP.PARENT currentDoorMODEL.PARENT doorCostType.PARENT currentDoorForm.PARENT areaOfDoor.PARENT pnlMatAttributesUcase.parent pnlCita.parent
								pnlCita.parent pnlCitaX.parent pnlCitaY.parent
								panelCode.PARENT pnlH.PARENT pnlW.PARENT pnlT.PARENT pnlM.parent pnlM2.PARENT pnlM2Sides.PARENT pnlMat.PARENT pnlRot.PARENT pnlMatAttributes.PARENT
							)
	(if (not subFlag)
		(progn
			(setq subFlag T)
			(mapcar '(lambda (x) (set (read (strcat (sym2str x) ".PARENT")) (eval x)))
					'(
					currentDoorGROUP currentDoorMODEL doorCostType currentDoorForm areaOfDoor currentdoorwid currentdoorhei pnlCita
					pnlCita pnlCitaX pnlCitaY
					pnlM pnlM2 pnlM2Sides pnlM2cube pnlM pnlH pnlW pnlT pnlMAT pnlRot pnlMatAttributes pnlMatAttributesUcase
					)
			)
			
			(setq doSomething (list ))
			(if p2c_Labour_Door_GroupSuffix (setq doSomething (append (list currentDoorGROUP	) doSomething)))
			(if p2c_Labour_Door_ModelSuffix (setq doSomething (append (list currentDoorMODEL	) doSomething)))
			(if p2c_Labour_Door_CostSuffix 	(setq doSomething (append (list doorCostType		) doSomething)))
			(if p2c_Labour_Door_FormSuffix 	(setq doSomething (append (list currentDoorForm		) doSomething)))
			
			(setq doSomething (reverse doSomething))
			(setq i 1)
			(setq iLen (length doSomething))
			(while (< i (- (* 2 iLen) 1))
					(setq doSomething (insmemb "_" i doSomething))
					(setq i (+ 2 i))
			)
		
			(setq doSomething (apply 'strcat doSomething))
			(if (member doSomething (list nil "")) (setq doSomething "Door"))
			(if (eval (read (setq doSomething (strcat "PostRun." doSomething))))
				(eval (read (strcat "(" doSomething ")")))
				(if (eval (read (setq doSomething "PostRun.Door" )))
					(eval (read (strcat "(" doSomething ")")))
				)
			)
		)
	)
)

; (defun Postrun.Door ()
	; (princ)
; )

(defun Post_Panel_Process	( / doSomething doSomethick MatPrefixList MatPrefixList.PARENT
							panelCode.PARENT  pnlH.PARENT pnlW.PARENT pnlT.PARENT pnlM.parent pnlM2.PARENT pnlM2Sides.PARENT pnlMat.PARENT pnlRot.PARENT pnlMatAttributes.PARENT
							)
	(if (not subFlag) ;sub degilse 1 kere gir   -->>  Post_PanelMain fonksiyonunda local subFlag
		(progn
			(setq subFlag T) ; sub parca gir
			(mapcar '(lambda (x) (set (read (strcat (sym2str x) ".PARENT")) (eval x))) 		;ana degerleri .PARENT diye setle
			'(panelCode pnlH pnlW pnlT pnlM pnlM2 pnlM2Sides pnlMat pnlRot pnlMatAttributes)	;degerler
			)
			(if (not MatPrefixList) (setq MatPrefixList (getMatPrefixes pnlMat)))
			(foreach matPrefix (if MatPrefixList MatPrefixList (list "none")) ; hicbiri degilse none
				(if (eval (read (setq doSomething (strcat "PostRun." matPrefix ))))
					(eval (read (strcat "(" doSomething ")")))
				)
			)
			(if (eval (read (setq doSomethick (strcat "PostRun." (rtos pnlT.PARENT) "mm"))))
				(eval (read (strcat "(" doSomethick ")")))
			)
		)
	)
)

; (defun PostRun.none ()
	; (princ)
; )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun getMatPrefixes ( pnlMAT / pnlMatAttributes j i stop  matMatrix matPrefix MatPrefixes)
	(setq pnlMatAttributes
		(list
			pnlMAT							; malzeme ismi
			(car (getmatcode pnlMAT))		; uretim kodu
			(car (getmatattribute1 pnlMAT))	; nitelik 1
			(car (getmatattribute2 pnlMAT))	; nitelik 2
			(car (getmatattribute3 pnlMAT))	; nitelik 3
			(car (getmatattribute4 pnlMAT))	; nitelik 4
		)
	)
	(if g_MatMatrixList
		(progn
			(setq i 0)
			(while (and (not stop) (< i (length pnlMatAttributes)))
				(setq j 0)
				(while (and (not stop) (< j (length g_MatMatrixList)))
					(if (member
							(nth i (mapcar '(lambda (x) (if x (strcase x) x)) pnlMatAttributes))
							(mapcar 'strcase (cadr (setq matMatrix (nth j g_MatMatrixList))))
						)
						(progn
							;(setq stop T) ; stop when found
							(foreach matPrefix  (car matMatrix)
								(if (not (member matPrefix MatPrefixes))
									(setq MatPrefixes (cons (strcase matPrefix) MatPrefixes))
								)
							)
						)
					)
					(setq j (+ 1 j))
				)
				(setq i (+ 1 i))
			)
		)
	)
	(reverse MatPrefixes)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; URETIM & UYGULAMAYA OZEL FONKSIYONLAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PRODUCTION & PROCESS SPESIFIC FUNCTION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(post.kapPaKes (list kod w h t mat rot (_ pvc1 pvc2 pvc3 pvc4)))
(defun post.kapPaKes (args /	PCode pWid pHei pThick pMat pRot pEdge i)
	(mapcar 'set '(PCode pWid pHei pThick pMat pRot pEdge) args)
	(if pRot nil (setq pRot 0.0))

	(if pCode
		(setq pCode (strcase (strcat currentDoorCODE "_" pCode)))
		(progn
			(setq i 0)
			(while (_EXISTPANEL (setq PCode (strcase (strcat currentDoorCODE "_" (itoa i)))))
				(setq i (+ i 1))
			)
		)
	)
	
	(if (and pWid (> pWid 0.0) pHei (> pHei 0.0) pMat)
		(progn
			(_PANEL PCode (_ pWid pHei pRot pMat pThick))
			(setq PEdge	(_
							(_ (getnth 0 pEdge) (_GETEDGESTRIPWIDFROMDB (getnth 0 pEdge)))
							(_ (getnth 1 pEdge) (_GETEDGESTRIPWIDFROMDB (getnth 1 pEdge)))
							(_ (getnth 2 pEdge) (_GETEDGESTRIPWIDFROMDB (getnth 2 pEdge)))
							(_ (getnth 3 pEdge) (_GETEDGESTRIPWIDFROMDB (getnth 3 pEdge)))
						)
			)
			(_CREATEEDGESTRIPS PCode PEdge)
			
			; Tag operations
			(_PUTLABEL Pcode Pcode "kapPa")
			(_PUTSOURCETAG Pcode Pcode "INSOURCE")
			(_PUTUSAGETYPETAG Pcode Pcode "DOOR")
			(_PUTMODELTYPETAG Pcode Pcode currentDoorMODEL)
			(_PUTCOSTTYPETAG Pcode Pcode doorCostType)
			(if doSomething
				(progn
					(_PUTTAG Pcode Pcode "p2cLabour") ;tag1
					(_PUTTAG PCode PCode (ifnull doSomething "kapPaKes")) ;tag2
				)
			)
			(_PUTTAG Pcode Pcode currentDoorTAGS)
			(_PUTLMMDATAMAIN (list Pcode Pcode lmm-k-doorform currentDoorForm nil))
		)
		(princ (strcat "\nInvalid value detected in kapPaKes: " doSomething))
	)
)

(defun PostRun.KaplamaKes (/ kaplamaMinDim)
	(setq kaplamaMinDim 101)
	(if p2c_Labour_VeneerWrap
		(cond
			(	KaplamaYama
				(_RUNHELPERRCP "BODY\\20-BUILD\\20-PARTS\\10-GENERAL_PANELS\\OZELPANELLER\\SUBPARTS\\KAPLAMA3" T "p2c")
			)
			(	(or (< pnlW kaplamaMinDim) (< pnlH kaplamaMinDim))
				(_RUNHELPERRCP "BODY\\20-BUILD\\20-PARTS\\10-GENERAL_PANELS\\OZELPANELLER\\SUBPARTS\\KAPLAMA1" T "p2c")
			)
			(	T
				(_RUNHELPERRCP "BODY\\20-BUILD\\20-PARTS\\10-GENERAL_PANELS\\OZELPANELLER\\SUBPARTS\\KAPLAMA2" T "p2c")
			)
		)
	)
)

(defun PostRun.CiftKes ()
	(_RUNHELPERRCP "BODY\\20-BUILD\\20-PARTS\\10-GENERAL_PANELS\\OZELPANELLER\\SUBPARTS\\CIFT" T "p2c")
)

(defun PostRun.Ham ()
	(if	(not
			(equal
				nil										
				(car (getmatcode pnlMAT.parent))		; uretim kodu
			)
		)
		(progn
			(post.iTag (list pnlMat.PARENT pnlM2.PARENT "m2"))
		)
	)
)

(defun PostRun.Firin ()
	(post.iTag (list "iscilik_Firin" pnlM2.PARENT "m2"))
)

(defun PostRun.Polisaj ()
	(post.itag (list "iscilik_Polisaj" pnlM2.PARENT "m2"))
)

(defun PostRun.Boya ()
	(PostRun.Firin)
	(PostRun.Polisaj)
)
(defun PostRun.Lake ()
	(PostRun.Boya)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; OPERASYONA OZEL FONKSIYONLAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; OPERATION SPESIFIC FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun PostRun.Hole_37 ()
(post.itag (list "iscilik_delik_mentese" 1.0 "ad" dosomethick))
)


(defun PostRun.Groove_17 ()
	(post.iTag (list "Ýscilik_Kanal_17" (* 0.001 (distance (getnth 0 pointList) (getnth 1 pointList))) "m"))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MALZEME KALINLIGINA OZEL FONKSIYONLAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MATERIAL THICKNESS SPESIFIC FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun PostRun.36MM ()
	(PostRun.CiftKes)
	(princ "\n36mm panel tespit edildi. Cift panel kesime yonlendiriliyor")
)

; her 4mm ile zýmba hesapla
(defun PostRun.4mm ()
	(post.itag (list (strcat "ZIMBA" "_" (rtos pnlT.PARENT)) (/ (* 2 (+ pnlH pnlW)) 200.0) "ad")) ; her 200 mm ile ZIMBA_4
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KENARA GORE FONKSIYONLAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EDGES SPESIFIC FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun PostRun.KenarKaplama (/ labourItem  laboursize)
	(setq labourItem "KENAR ZIMPARA")
	(if p2c_Labour_EdgeM_SeparateM (setq labourItem (strcat labourItem "_" tempMaterial)))
	(if p2c_Labour_EdgeM_SeparateT (setq labourItem (strcat labourItem "_" (rtos width))))
	(post.itag (list labourItem (+ p2c_Labour_EdgeM_add edgeStripLengthM) p2c_Labour_Time_Frame))

	;(setq labourItem p2c_Labour_EdgeGlue)
	;(setq labourSize (* p2c_Labour_EdgeM_Multiply (+ p2c_Labour_EdgeM_add edgeStripLengthM)))
	;(setq labourType (if (islist item) (caddr item) p2c_Labour_EdgeGlue_Type))
	;(post.iTag (list labourItem (* p2c_Labour_EdgeGlue_Multiply labourSize) labourType "p2c_Labour_EdgeGlue"))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MALZEMEYE OZEL FONKSIYONLAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MATERIAL SPESIFIC FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (defun PostRun.KA ()
	(PostRun.KaplamaKes)
)

(defun PostRun.LA ()
	(PostRun.Lake)
)

(defun PostRun.KV ()
	(post.itag (list (strcat "Vernik_" pnlMat.PARENT) pnlM2.PARENT "m2"))
)

(defun PostRun.KC ()
	(post.itag (list (strcat "Cila" pnlMat.PARENT) pnlM2.PARENT "m2"))
)

(defun PostRun.LK ()
	(post.itag (list (strcat "LakeCila_" pnlMat.PARENT) pnlM2.PARENT "m2"))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KAPAK OZEL FONKSIYONLAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DOOR SPESIFIC FUNCTIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;bkz kapaksets.lsp
;bkz ulibformulkapak.lsp

