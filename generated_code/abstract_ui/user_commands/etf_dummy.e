note
	description: "An ETF dummy command."
	author: "Saher"
	date: "2024-07-06"
	revision: "1.0"

class
	ETF_DUMMY
inherit
	ETF_COMMAND
		-- Redefine make to implement ETF dummy command
		redefine
			make
		end
create
	make

feature {NONE} -- Initialization

	make(
		an_etf_cmd_name: STRING; 
		etf_cmd_args: TUPLE; 
		an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE
		)
			-- Initialize ETF dummy command with specified parameters.
		do
			Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
			etf_cmd_routine := agent etf_dummy
			etf_cmd_routine.set_operands(etf_cmd_args)
			out := "etf_dummy"
		end

feature -- Routine

	etf_dummy
		-- Perform ETF dummy routine.
	do
		etf_cmd_container.on_change.notify([Current])
	end
