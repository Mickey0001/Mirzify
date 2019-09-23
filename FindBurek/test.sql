	-------------------------------------------------------------------------------------------------------------------------------------	
	-- NBPR Template
	-- Version: 3.07
	-------------------------------------------------------------------------------------------------------------------------------------	
	   
	SET NOCOUNT ON

	-------------------------------------------------------------------------------------------------------------------------------------	
	-- Variable declaration and initialisation
	-------------------------------------------------------------------------------------------------------------------------------------	
	DECLARE @err int, @ScriptName varchar(255), @OneTimeOnly bit, @CanRun bit, @Purpose varchar(255), @Author varchar(100)
	DECLARE @errorMessage nvarchar(max), @errorSeverity int, @errorState int;
	DECLARE @RecordCount int

	-------------------------------------------------------------------------------------------------------------------------------------	
	-- *** PLEASE CHANGE THE FOLLOWING VARIABLES ***
	-- *** Press Ctrl Shift M to invoke the macro ***
	-------------------------------------------------------------------------------------------------------------------------------------	
	SELECT   @ScriptName = 'Hotfix TTN-15083 Spaces - Germany-German -LN - Spaces App E-Mail - Poor Translation Add team member email (TTN-15052)'		-- CHANGE THIS TO THE NAME OF YOUR SCRIPT
			,@OneTimeOnly = 0						-- CHANGE THIS TO 1 if you want this script to run just once but in the main
														-- scripts should be written to run multiple times so they get tested every build
			,@Purpose = 'Updating translation for Add team member email on German' 		-- Change this to a BRIEF description of what the script does	
			,@Author = 'Gregory Garcia'
			
	-- Can we run this script?
	IF DB_NAME() = 'TitanProduction' and ( @@SERVERNAME = 'REG10VSS05TTN\REG10VSS05TTN' OR @@SERVERNAME = 'REG1099DBS50TTN')
		BEGIN
		SET @OneTimeOnly = 1 --Scripts in PRODUCTION should only ever be run once so hard code this value
		SELECT @CanRun = dbo.DataScripts_IsRunnable(@ScriptName, @OneTimeOnly)
		END
	ELSE
		BEGIN
		SELECT @CanRun = dbo.DataScripts_IsRunnable(@ScriptName, @OneTimeOnly)
		END

	IF @CanRun = 0
	BEGIN
		SELECT @ScriptName + ' has been run before *** SKIPPING FILE *** '  
	END
	ELSE
	BEGIN
		DECLARE @timer datetime	SET @timer = getdate()
		DECLARE @UserName varchar(101) = 'System.Administrator(' + @ScriptName + ')'	
		SELECT convert(varchar, @timer, 120), 'Executing: ''' + @ScriptName + ''' on ' + @@servername + '.' + db_name()

		SET @err = 0 
		-------------------------------------------------------------------------------------------------------------------------------------	
		-- *** YOUR SCRIPT CODE STARTS HERE ... NOTICE THE DEFAULT ERROR HANDLING ***
		-------------------------------------------------------------------------------------------------------------------------------------	
			BEGIN TRY
			
					UPDATE		dbo.PhraseTranslation 
					SET			Translation = N'Willkommen in Ihrem Kundenportal.'
					WHERE		PhraseID = 286
					AND			LanguageID IN (2000, 84000);

					select @@ROWCOUNT as 'PhraseID 286 rows updated';
					
					UPDATE		dbo.PhraseTranslation 
					SET			Translation = N'Reservieren Sie Tagesbüros, Gemeinschaftsbüros-Räume oder Konferenz- und Tagungsräume online von jedem Ort der Welt aus'
					WHERE		PhraseID = 277
					AND			LanguageID IN (2000, 84000)

					select @@ROWCOUNT as 'PhraseID 277 rows updated';
	
			END TRY
			BEGIN CATCH
			
				SELECT 	'**** UnexpectedError ****',	
						ERROR_NUMBER() as ErrorNumber,
						ERROR_SEVERITY()  as ErrorSeverity,
						ERROR_LINE() as ErrorLine,
						ERROR_MESSAGE()  as ErrorMessage,
						ERROR_STATE() as ErrorState, 
						ERROR_PROCEDURE() as ErrorProcedure

				SET @err = isnull(ERROR_NUMBER(), 1)
				SELECT @errorMessage = ERROR_MESSAGE() + ' Line ' + cast(ERROR_LINE() as nvarchar(5)), @errorSeverity = ERROR_SEVERITY(), @errorState = ERROR_STATE();
			END CATCH
			-------------------------------------------------------------------------------------------------------------------------------------	
			-- *** YOUR SCRIPT CODE ENDS HERE ***
			-------------------------------------------------------------------------------------------------------------------------------------	
			ErrorHandler:
			IF @err = 0
			BEGIN
				EXEC dbo.DataScripts_Update @ScriptName = @ScriptName, @OneTimeOnly = @OneTimeOnly, @Purpose = @Purpose, @Author = @Author
				SELECT convert(varchar, getdate(), 120), 'Completed successfully in ' + convert(varchar, datediff(s, @timer, getdate())) + ' seconds ' as Notes
			END
			ELSE
			BEGIN
				SELECT convert(varchar, getdate(), 120), 'Script: ' + @ScriptName + ' **** FAILED ****' as Notes
				-- re-raise the error after rollback to prevent DBGhost / TeamCity continuing
				raiserror (@errorMessage, @errorSeverity, @errorState);	
			END
		END
	GO