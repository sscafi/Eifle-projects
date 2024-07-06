note
	description: "Defines an abstract interface for an ETF undo command."
	author: "Saher"
	date: "2024-05-12"
	revision: "1.2"

deferred class
	ETF_UNDO_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		-- Initialize the undo command with specified arguments.
		do
			Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
			etf_cmd_routine := agent undo
			etf_cmd_routine.set_operands(etf_cmd_args)
			if TRUE then
				out := "undo"
			else
				etf_cmd_error := True
			end
		end

feature -- Command
	undo
    	-- Placeholder for the undo command routine.
    	deferred
    	end
end
