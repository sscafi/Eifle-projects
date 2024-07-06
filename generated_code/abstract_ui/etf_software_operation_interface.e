note
	description: "Defines an interface for operating an abstract user interface within ETF software."
	author: "Saher"
	date: "2024-07-01"
	revision: "1.0"

deferred class
	ETF_SOFTWARE_OPERATION_INTERFACE

feature {NONE} -- Initialization

	make
			-- Initializes the input, output, and user interface attributes.
		do
			initialize_attributes
		end

	initialize_attributes
			-- Initializes attributes including the user interface, input handler, and output handler.
		do
			create output.make
			create ui.make -- Creates and initializes the user interface.
			create input.make_without_running(dummy_command, ui)
		end

feature -- Attributes
	ui				: ETF_ABSTRACT_UI
		-- Represents the user interface used in the ETF software.

	input			: ETF_INPUT_HANDLER
		-- Handles input for the ETF software.

	output			: ETF_CMD_LINE_OUTPUT_HANDLER
		-- Handles output for command line interactions in the ETF software.

	dummy_command	: STRING = ""
		-- Dummy command used during initialization.

	error			: BOOLEAN
		-- Flag indicating if there are errors encountered.

feature -- Commands

	execute(cmds: STRING; is_init: BOOLEAN)
			-- Parses input string `cmds` as a list of commands.
			-- If no input errors,
			-- 		then executes commands and logs to 'output'.
			-- 		If `is_init` is true, logs the initial state.
			-- If errors,
			-- 		then reports errors to 'output'.
		do
			initialize_attributes

			-- Attach output handler for command logging.
			ui.on_change.attach(agent output.log_command)

			-- Create an input parser and attach error output handler.
			create input.make_without_running(cmds, ui)
			input.on_error.attach(agent output.log_error)

			-- Parse and validate input.
			input.parse_and_validate_input_string
			if not input.etf_error then
				if is_init then
					output.log_model_state
				end
				ui.run_input_commands
			else
				error := input.etf_error
			end
		end

	execute_without_log(cmds: STRING)
			-- Parses input string `cmds` as a list of commands.
			-- If no input errors,
			-- 		then executes commands without writing to a log.
			-- If errors,
			-- 		then reports errors to 'output'.
		do
			initialize_attributes

			-- Attach output handler for empty logging.
			ui.on_change.attach(agent output.log_empty)

			-- Create an input parser and attach error output handler.
			create input.make_without_running(cmds, ui)
			input.on_error.attach(agent output.log_error)

			-- Parse and validate input.
			input.parse_and_validate_input_string
			if not input.etf_error then
				ui.run_input_commands
			else
				error := input.etf_error
			end
		end
end
