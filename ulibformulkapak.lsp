

(setq BTypeDoorList ; Secilen kapak modeli icerisinde B kanat yoksa modele gore otomatik ata
	(list 
		(list "BDALGA"		"CAMKPK"		"CMKPK100"		)
		(list "MINE"		"CAMKPK"		"ALMPRFKULP"	)
		(list "ORCUN"		"CAMKPK"		"ALMPRFKULP"	)
		(list "KANKEN1"		"CNC"			"KANKEN1C"		)
		(list "KANKEN2"		"CNC"			"KANKEN2C"		)
		(list "KANKEN3"		"CNC"			"KANKEN3C"		)
		(list "KANKEN4"		"CNC"			"KANKEN4C"		)
		(list "KANKEN5"		"CNC"			"KANKEN5C"		)
		(list "KANKEN6"		"CNC"			"KANKEN6C"		)
	)
)


;;;;;;;;;kanken a kanat;;;;;;;;;
(defun KANKEN1_Direct (x z)	(if (null KANKEN_Akanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKEN.KPK"))) (KANKEN_Akanat x z))
(defun KANKEN2_Direct (x z)	(if (null KANKEN_Akanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKEN.KPK"))) (KANKEN_Akanat x z))
(defun KANKEN3_Direct (x z)	(if (null KANKEN_Akanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKEN.KPK"))) (KANKEN_Akanat x z))
(defun KANKEN4_Direct (x z)	(if (null KANKEN_Akanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKEN.KPK"))) (KANKEN_Akanat x z))
(defun KANKEN5_Direct (x z)	(if (null KANKEN_Akanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKEN.KPK"))) (KANKEN_Akanat x z))
(defun KANKEN6_Direct (x z)	(if (null KANKEN_Akanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKEN.KPK"))) (KANKEN_Akanat x z))


;;;;;;;;;kanken b kanat;;;;;;;;;
(defun KANKEN1C_Direct (x z) (if (null KANKENC_Bkanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKENC.KPK"))) (KANKENC_Bkanat x z))
(defun KANKEN2C_Direct (x z) (if (null KANKENC_Bkanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKENC.KPK"))) (KANKENC_Bkanat x z))
(defun KANKEN3C_Direct (x z) (if (null KANKENC_Bkanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKENC.KPK"))) (KANKENC_Bkanat x z))
(defun KANKEN4C_Direct (x z) (if (null KANKENC_Bkanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKENC.KPK"))) (KANKENC_Bkanat x z))
(defun KANKEN5C_Direct (x z) (if (null KANKENC_Bkanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKENC.KPK"))) (KANKENC_Bkanat x z))
(defun KANKEN6C_Direct (x z) (if (null KANKENC_Bkanat) (load (strcat _kapaklsp-getAllDoorDIRPath "KANKENC.KPK"))) (KANKENC_Bkanat x z))

