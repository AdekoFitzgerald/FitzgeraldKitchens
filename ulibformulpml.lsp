;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; pml capsule example with all local arguments
(defun PML_capsule ( / PML_unlocked PML_licenseList PML_dontAskPass PML_msgPass PML_customPass PML_runCorrect PML_msgCorrect PML_runWrong PML_msgWrong PML_crashWrong)
	(if (not (setq PML_dontAskPass (or (member (getlicenseowner) (mapcar 'ascii2Str (quote (

"65 68 69 75 79 32 84 69 67 72 78 79 76 79 71 73 69 83" "65 100 101 107 111 32 84 101 99 104 110 111 108 111 103 105 101 115"
))))(member (getSerialLast4Digit) (setq PML_licenseList (mapcar 'ascii2Str (quote (  ; getmyascii
"51 67 65 48"
"49 66 68 52"
	))))))))(setq PML_licenseList nil))
	;(setq PML_customPass "tdçikkbsymöçs")

	(defun PML_runCorrect (PP / ) ;if pml T
		(setq PML_capsule_state T)
	)

	(defun PML_runWrong (PP / ) ;if pml nil
		(setq PML_capsule_state nil)
		(alert (strcase (strcat	(ascii2str "70 73 82 77 65 32 75 85 84 85 80 72 65 78 69 83 73 32 75 79 80 89 65 76 65 78 77 73 83 46") "\n" (ascii2Str "85 89 71 85 78 83 85 90 32 75 85 76 76 65 78 73 77 32 84 69 83 80 73 84 32 69 68 73 76 68 73 46 32" ) "\n\n" (ascii2str "58 40") "\n\n" (getlicenseowner) "\n" (ascii2str "88 88 88 88 45 88 88 88 88 45 88 88 45 88 88 88 88 45") (getSerialLast4Digit) "\n" ad_defpath  "\n" (last (splitstr ad_defpath "\\")) " - " (iniread ad_MOD-INI "updater" "version" "") "\n" (rtos (getvar "cdate") 2 6) "\n" (ascii2str "91 72 65 82 73 84 65 46 75 79 78 85 77 46 46 46 93 32 82 65 80 79 82 32 69 68 73 76 68 73 46"))))
		;(setq PML_crashWrong T) ; (terminateAdeko)
	)
	(c:blockesc)(PML)(c:unblockesc)
)
;(defun tnt () (if (not PML_capsule_state) (PML_capsule)) (princ)) (if tnt (tnt) (if PML_capsule (PML_capsule) (pml)))