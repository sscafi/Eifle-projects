note
	description: "Interface definition for an ETF play command, which handles gameplay actions."
	author: "Saher"
	date: "2024-07-03"
	revision: "1.1"

deferred class
	ETF_PLAY_INTERFACE
inherit
	ETF_COMMAND
		-- Redefine the `make` routine to initialize the ETF play command.
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(
		an_etf_cmd_name: STRING; 
		etf_cmd_args: TUPLE; 
		an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE
		)
			-- Initialize the ETF play command with specified parameters.
		do
			Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
			etf_cmd_routine := agent play(?, ?, ?, ?)
			etf_cmd_routine.set_operands(etf_cmd_args)
			if attached {INTEGER_32} etf_cmd_args[1] as row and then attached {INTEGER_32} etf_cmd_args[2] as column and then attached {INTEGER_32} etf_cmd_args[3] as player_mov and then attached {INTEGER_32} etf_cmd_args[4] as project_mov then
				out := "play(" + etf_event_argument_out("play", "row", row) + "," + etf_event_argument_out("play", "column", column) + "," + etf_event_argument_out("play", "player_mov", player_mov) + "," + etf_event_argument_out("play", "project_mov", project_mov) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- Command Precondition 

	play_precond(row: INTEGER_32; column: INTEGER_32; player_mov: INTEGER_32; project_mov: INTEGER_32): BOOLEAN
		-- Check if the play command's parameters are within valid ranges.
		do  
			Result := 
				is_max_row(row)  -- Ensures the row value is within acceptable limits.
				and then is_max_column(column)  -- Ensures the column value is within acceptable limits.
				and then is_player_mov(player_mov)  -- Ensures the player movement value is within acceptable limits.
				and then is_project_mov(project_mov)  -- Ensures the project movement value is within acceptable limits.
		ensure then  
			Result = 
				is_max_row(row)
				and then is_max_column(column)
				and then is_player_mov(player_mov)
				and then is_project_mov(project_mov)
		end 

feature -- Command 

	play(row: INTEGER_32; column: INTEGER_32; player_mov: INTEGER_32; project_mov: INTEGER_32)
		-- Deferred feature representing the implementation of the ETF play command.
		require 
			play_precond(row, column, player_mov, project_mov)  -- Enforce precondition before execution.
		deferred
	end
end
