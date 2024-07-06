note
	description: "Interface for an ETF pass command."
	author: "Saher"
	date: "2024-07-02"
	revision: "1.1"

deferred class
	ETF_PASS_INTERFACE
inherit
	ETF_COMMAND
		-- Redefine make to implement ETF pass command.
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(
		an_etf_cmd_name: STRING; 
		etf_cmd_args: TUPLE; 
		an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE
		)
			-- Initialize ETF pass command with specified parameters.
		do
			Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
			etf_cmd_routine := agent pass
			etf_cmd_routine.set_operands(etf_cmd_args)
			if TRUE then
				out := "pass"
			else
				etf_cmd_error := True
			end
		end

feature -- Command

	pass
		-- Deferred feature for ETF pass command.
		deferred
	end
end
