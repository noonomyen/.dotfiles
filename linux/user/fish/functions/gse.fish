function gse --description 'Explain the Git status icons in the current prompt'
    # Check if inside git repo
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo (set_color red)"Not in a Git repository."
        return
    end

    # Run git status --porcelain to parse local changes
    set -l status_lines (git status --porcelain 2>/dev/null)
    
    # Initialize flags
    set -l has_conflicts false
    set -l has_deleted false
    set -l has_modified false
    set -l has_typechanged false
    set -l has_staged false
    set -l has_untracked false
    set -l has_renamed false

    for line in $status_lines
        set -l x (string sub --start 1 --length 1 "$line")
        set -l y (string sub --start 2 --length 1 "$line")

        # Conflicts: DD, AU, UD, UA, DU, AA, UU
        if string match -r "DD|AU|UD|UA|DU|AA|UU" "$x$y" >/dev/null
            set has_conflicts true
        else
            # Staged: any change in the index (first column x)
            if string match -r "A|M|D|R|C" "$x" >/dev/null
                set has_staged true
            end
            
            # Untracked: ??
            if test "$x$y" = "??"
                set has_untracked true
            end

            # Modified in work tree (second column y)
            if test "$y" = "M"
                set has_modified true
            end

            # Typechanged in work tree or index
            if test "$x" = "T"; or test "$y" = "T"
                set has_typechanged true
            end

            # Deleted in work tree or index
            if test "$x" = "D"; or test "$y" = "D"
                set has_deleted true
            end

            # Renamed in index
            if test "$x" = "R"
                set has_renamed true
            end
        end
    end

    # Check stash
    set -l has_stashed false
    if git stash list >/dev/null 2>&1
        if test (git stash list | count) -gt 0
            set has_stashed true
        end
    end

    # Check ahead/behind
    set -l has_ahead false
    set -l has_behind false
    set -l has_diverged false
    
    # Get upstream branch
    set -l upstream (git rev-parse --abbrev-ref @{u} 2>/dev/null)
    if test -n "$upstream"
        # Check counts
        set -l counts (git rev-list --left-right --count HEAD...@{u} 2>/dev/null)
        if test -n "$counts"
            set -l count_list (string match -ra '\d+' "$counts")
            if test (count $count_list) -ge 2
                set -l ahead $count_list[1]
                set -l behind $count_list[2]
                
                if test "$ahead" -gt 0; and test "$behind" -gt 0
                    set has_diverged true
                else if test "$ahead" -gt 0
                    set has_ahead true
                else if test "$behind" -gt 0
                    set has_behind true
                end
            end
        end
    end

    # Check Git States (Rebase, Merge, Bisect, Cherry-pick, Revert)
    set -l git_dir (git rev-parse --git-dir 2>/dev/null)
    set -l is_rebasing false
    set -l is_merging false
    set -l is_bisecting false
    set -l is_cherry_picking false
    set -l is_reverting false

    if test -n "$git_dir"
        if test -d "$git_dir/rebase-merge"; or test -d "$git_dir/rebase-apply"
            set is_rebasing true
        end
        if test -f "$git_dir/MERGE_HEAD"
            set is_merging true
        end
        if test -f "$git_dir/BISECT_LOG"
            set is_bisecting true
        end
        if test -f "$git_dir/CHERRY_PICK_HEAD"
            set is_cherry_picking true
        end
        if test -f "$git_dir/REVERT_HEAD"
            set is_reverting true
        end
    end

    # Determine if Up-to-date
    set -l is_up_to_date true
    if $has_conflicts; or $has_deleted; or $has_modified; or $has_typechanged; or $has_staged; or $has_untracked; or $has_renamed; or $has_stashed; or $has_diverged; or $has_ahead; or $has_behind; or $is_rebasing; or $is_merging; or $is_bisecting; or $is_cherry_picking; or $is_reverting
        set is_up_to_date false
    end

    # Define temporary printing helper function
    function _gse_print -a icon label active bg fg
        if test "$active" = "true"
            set_color -b $bg -o $fg
            printf "  %-1s : %-15s" $icon $label
            set_color normal
            printf "\n"
        else
            set_color 5c6370
            printf "  %-1s : %-15s" $icon $label
            set_color normal
            printf "\n"
        end
    end

    # Print all possible states
    _gse_print "" "Conflicted" $has_conflicts "E06C75" "282C34"
    _gse_print "" "Deleted" $has_deleted "E06C75" "282C34"
    _gse_print "" "Modified" $has_modified "98C379" "282C34"
    _gse_print "󰜱" "Typechanged" $has_typechanged "98C379" "282C34"
    _gse_print "" "Staged" $has_staged "98C379" "282C34"
    _gse_print "" "Untracked" $has_untracked "98C379" "282C34"
    _gse_print "󰑕" "Renamed" $has_renamed "98C379" "282C34"
    _gse_print "" "Stashed" $has_stashed "61AFEF" "282C34"
    _gse_print "⇕" "Diverged" $has_diverged "E06C75" "282C34"
    _gse_print "⇡" "Ahead" $has_ahead "61AFEF" "282C34"
    _gse_print "⇣" "Behind" $has_behind "61AFEF" "282C34"
    _gse_print "" "Rebasing" $is_rebasing "C678DD" "282C34"
    _gse_print "" "Merging" $is_merging "C678DD" "282C34"
    _gse_print "" "Bisecting" $is_bisecting "C678DD" "282C34"
    _gse_print "" "Cherry-picking" $is_cherry_picking "C678DD" "282C34"
    _gse_print "" "Reverting" $is_reverting "C678DD" "282C34"
    _gse_print "" "Up-to-date" $is_up_to_date "98C379" "282C34"

    # Clean up helper function
    functions -e _gse_print
end
