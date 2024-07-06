note
	description: "Interface definition for an ETF redo command, used to repeat the last action."
	author: "Saher"
	date: "2024-05-02"
	revision: "1.1"

deferred class
	ETF_REDO_INTERFACE
inherit
	ETF_COMMAND
		-- Redefine the `make` routine to initialize the ETF redo command.
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(
		an_etf_cmd_name: STRING; 
		etf_cmd_args: TUPLE; 
		an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE
		)
			-- Initialize the ETF redo command with specified parameters.
		do
			Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
			etf_cmd_routine := agent redo
			etf_cmd_routine.set_operands(etf_cmd_args)
			if TRUE then
				out := "redo"
			else
				etf_cmd_error := True
			end
		end

feature -- Command 

	redo
		-- Deferred feature representing the implementation of the ETF redo command.
		deferred
	end
end
