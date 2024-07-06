note
	description: "Interface for an ETF move command."
	author: "Saher"
	date: "2024-07-06"
	revision: "1.1"

deferred class
	ETF_MOVE_INTERFACE
inherit
	ETF_COMMAND
		-- Redefine make to implement ETF move command.
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(
		an_etf_cmd_name: STRING; 
		etf_cmd_args: TUPLE; 
		an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE
		)
			-- Initialize ETF move command with specified parameters.
		do
			Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
			etf_cmd_routine := agent move(?, ?)
			etf_cmd_routine.set_operands(etf_cmd_args)
			if attached {INTEGER_32} etf_cmd_args[1] as row and then attached {INTEGER_32} etf_cmd_args[2] as column then
				out := "move(" + etf_event_argument_out("move", "row", row) + "," + etf_event_argument_out("move", "column", column) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- Command Precondition 

	move_precond(row: INTEGER_32; column: INTEGER_32): BOOLEAN
		-- Check if the move command's parameters meet the precondition.
		do  
			Result := 
				is_row(row)
				and then is_column(column)
		ensure then  
			Result = 
				is_row(row)
				and then is_column(column)
		end 

feature -- Command 

	move(row: INTEGER_32; column: INTEGER_32)
		-- Deferred feature for ETF move command.
		require 
			move_precond(row, column)
		deferred
	end
end
