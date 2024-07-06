note
	description: "Defines an abstract user interface interface for managing ETF commands."
	author: "Saher"
	date: "2024-05-05"
	revision: "1.0"

deferred class
	ETF_ABSTRACT_UI_INTERFACE

feature {NONE} -- Initialization
	make
		-- Initializes the abstract UI interface by creating empty command storage and an event handler.
		do
			create commands.make_empty
			create on_change
		end

feature -- Queries
	commands: ARRAY[ETF_COMMAND_INTERFACE]
		-- Array to store commands of type ETF_COMMAND_INTERFACE.

	on_change: ETF_EVENT[TUPLE[ETF_COMMAND_INTERFACE]]
		-- Event triggered when a change occurs in the commands.

feature -- Insert Commands
	put(a_command: ETF_COMMAND_INTERFACE)
		-- Adds a command to the commands array.
		do
			commands.force(a_command, commands.count + 1)
		ensure
			commands.count = old commands.count + 1
			commands[commands.count] = a_command
		end

feature -- Execute Commands
	run_input_commands
		-- Executes each command in the commands array.
		do
			across commands as cmd loop
				cmd.item.etf_cmd_routine.apply
			end
		end
end
