note
	description: "Interface for an ETF fire command."
	author: "saher"
	date: "2024-07-06"
	revision: "1.0"

deferred class
	ETF_FIRE_INTERFACE
inherit
	ETF_COMMAND
		-- Redefine make to implement ETF fire command.
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(
		an_etf_cmd_name: STRING; 
		etf_cmd_args: TUPLE; 
		an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE
		)
			-- Initialize ETF fire command with specified parameters.
		do
			Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
			etf_cmd_routine := agent fire
			etf_cmd_routine.set_operands(etf_cmd_args)
			if TRUE then
				out := "fire"
			else
				etf_cmd_error := True
			end
		end

feature -- Command

	fire
		-- Deferred feature for ETF fire command.
		deferred
	end
end
