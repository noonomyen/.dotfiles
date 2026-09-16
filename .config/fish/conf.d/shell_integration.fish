# Shell integration (OSC 133 for semantic prompt marking)
# Enables terminal jump-to-prompt, output selection, and command lifecycle tracking
if status is-interactive
    and test "$TERM" != "linux" -a "$TERM" != "dumb"

    # On first prompt draw, wrap fish_prompt to emit A/B around the actual prompt text.
    # This self-removes so subsequent prompts call the wrapped version directly.
    function __osc133_install --on-event fish_prompt
        functions --erase __osc133_install
        if functions -q fish_prompt
            functions --copy fish_prompt __osc133_orig_prompt
        else
            function __osc133_orig_prompt
                echo -n '> '
            end
        end
        function fish_prompt
            echo -en "\e]133;A\e\\"
            __osc133_orig_prompt
            echo -en "\e]133;B\e\\"
        end
    end

    function __osc133_command_executed --on-event fish_preexec
        echo -en "\e]133;C\e\\"
    end

    function __osc133_command_finished --on-event fish_postexec
        echo -en "\e]133;D;$status\e\\"
    end
end
