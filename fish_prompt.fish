function fish_prompt
    set -l status_copy $status

    if set branch_name (git_branch_name)
        set -l git_color black green
        set -l git_glyph ""

        if git_is_staged
            set git_color black yellow

            if git_is_dirty
                set git_color $git_color white red
            end

        else if git_is_dirty
            set git_color white red

        else if git_is_touched
            set git_color white red
        end

        if git_is_detached_head
            set git_glyph "➤"

        else if git_is_stashed
            set git_glyph "╍╍"
        end

        set -l prompt
        set -l git_ahead (git_ahead "+ " "- " "+- ")

        if test "$branch_name" = master
            set prompt " $git_glyph $git_ahead"
        else
            set prompt " $git_glyph $branch_name $git_ahead"
        end

        if set -q git_color[3]
            segment "$git_color[3]" "$git_color[4]" "$prompt"
            segment black black
            segment "$git_color[1]" "$git_color[2]" " $git_glyph "
        else
            segment "$git_color[1]" "$git_color[2]" "$prompt"
        end
    end

    segment black yellow " $PWD "
    segment white red " $USER "

    segment_close
    printf "\n"
    date "+%H:%M:%S > "
end
