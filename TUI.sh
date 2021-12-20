export NCURSES_NO_UTF8_ACS=1

welcomemsg () {
	dialog --title "Bioinformatics Analysis Wizard" --ok-button "next" --msgbox "$(cat welcome.txt)" 20 60
}

mainoption() {
	MAINOPTION=$(dialog --title "Bioinformatics Analysis Wizard" --menu "Please choose from the following\
	analysis options" 20 60 3 \
	"1" "Start DNA analysis" \
	"2" "Start RNA analysis" \
	"3" "Start Protein analysis" \
	3>&1 1>&2 2>&3)
	
	if [ $MAINOPTION = 1 ]; then
    DNA_analysis
	elif [ $MAINOPTION = 2 ]; then
    RNA_analysis
	elif [ $MAINOPTION = 3 ]; then
    Prot_analysis
	fi
}

DNA_analysis() {
  #Displays files listed in aanlysis folder
	if (dialog --title "Bioinformatics Analysis Wizard" --yesno \
		"Are these the samples you are expecting? \n\n$(ls [Your_Input_Directory.*])" 20 60)
		then
			$(yes | bash [YOUR_DNA_ANALYSIS_SCRIPT_HERE] 2>&1 out.log) | dialog --title "Bioinformatics Analysis Wizard" \
      --infobox "Performing DNA analysis, please wait" 8 60
		else
			mainoption
	fi
}

exitmsg () {
	dialog --title "Bioinformatics Analysis Wizard" --ok-button "exit" --msgbox "$(cat exitmsg.txt)" 20 60
}

welcomemsg
mainoption
exitmsg
