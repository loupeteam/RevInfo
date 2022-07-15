
PROGRAM _INIT

	// Log revision information
	//---------------------------------------------------------------
	
	logInfo('App', 0, '************ RevInfo Start ************', 0);

	// revision
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Revision: ';
	brsstrcat(ADR(tempString), ADR(revision));
	logInfo('App', 0, tempString, 0);

	// revisionDate
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Commit Date: ';
	brsstrcat(ADR(tempString), ADR(revisionDate));
	logInfo('App', 0, tempString, 0);

	// revisionAuthor
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Author: ';
	brsstrcat(ADR(tempString), ADR(revisionAuthor));
	logInfo('App', 0, tempString, 0);
	
	// branchName
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Branch Name: ';
	brsstrcat(ADR(tempString), ADR(branchName));
	logInfo('App', 0, tempString, 0);
 
	// uncommittedChanges
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Uncommitted Changes: ';
	brsstrcat(ADR(tempString), ADR(uncommittedChanges));
	logInfo('App', 0, tempString, 0);

	// buildDate
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Build Date: ';
	brsstrcat(ADR(tempString), ADR(buildDate));
	logInfo('App', 0, tempString, 0);

	// buildConfiguration
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Configuration: ';
	brsstrcat(ADR(tempString), ADR(buildConfiguration));
	logInfo('App', 0, tempString, 0);

	// builder
	brsmemset(ADR(tempString), 0, SIZEOF(tempString));
	tempString := 'Builder: ';
	brsstrcat(ADR(tempString), ADR(builder));
	logInfo('App', 0, tempString, 0);

	logInfo('App', 0, '************ RevInfo End ************', 0);
	
END_PROGRAM


PROGRAM _CYCLIC
	
	// Detect an AS transfer
	IF NOT download THEN
		download := TRUE;
		brsmemset(ADR(gDataValid), 0, SIZEOF(gDataValid));
		MessageBox_AddMsg(ADR('Download may have caused data loss. Please reboot to reload. If this was the first boot after a download, you may reset DataValid to maintain data.'), ADR('Reboot'), ADR(reboot), ADR('RESET DataValid'), ADR(dataOK));
	END_IF	
	
	IF dataOK THEN	
		dataOK := FALSE;
		FOR i := 0 TO SIZEOF(gDataValid)/SIZEOF(gDataValid[0]) - 1 BY 1 DO
			gDataValid[i] := 1;
		END_FOR
	END_IF
	
	IF reboot THEN
		SYSreset(1, 1);
	END_IF
	
END_PROGRAM
