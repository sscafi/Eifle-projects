"""
Deferred class for defining an ETF (Electronic Trading Framework) abort interface command.

Description:
    This class defines a deferred ETF abort interface command, inheriting from `ETF_COMMAND`.
    It provides a framework for implementing specific abort functionality in derived classes.

Author:
    [Saher]

Date:
    [2024-02-02]

Revision:
    [V2.3.1]

Features:
    - `make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)`: Initializes the ETF abort interface command.
    - `abort`: Deferred feature representing the abort operation, to be implemented in descendant classes.

Usage:
    - This class serves as a blueprint for creating specific ETF abort commands.
    - Derived classes must implement the `abort` feature according to specific requirements.

"""

deferred class
    ETF_ABORT_INTERFACE

inherit
    ETF_COMMAND
        redefine 
            make 
        end

feature {NONE} -- Initialization

    make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
        do
            Precursor(an_etf_cmd_name, etf_cmd_args, an_etf_cmd_container)
            etf_cmd_routine := agent abort
            etf_cmd_routine.set_operands(etf_cmd_args)
            if
                TRUE
            then
                out := "abort"
            else
                etf_cmd_error := True
            end
        end

feature -- Command 

    abort
        deferred
        end

end
