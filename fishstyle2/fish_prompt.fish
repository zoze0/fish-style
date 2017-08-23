function fish_prompt
	and set retc green; or set retc red
    tty|string match -q -r tty; and set tty tty; or set tty pts

    set_color $retc
    if [ $tty = tty ]
        echo -n .-
    else
        echo -n '┬─'
    end
    set_color  green
    echo -n [
    if test $USER = root -o $USER = toor
        set_color -o red
    else
        set_color yellow
    end
    echo -n $USER
    
    #set_color  
    echo -n '@'
    if [ -z "$SSH_CLIENT" ]
        set_color blue
    else
        set_color -o cyan
    end
    echo -n (hostname)
    set_color $fish_color_sky
    #echo -n :(prompt_pwd)
    echo -n :(pwd|sed "s=$HOME=~=")
    set_color green
    echo -n ']'
    set_color normal
    set_color $fish_color_sky
    if [ $tty = tty ]
        echo -n '-'
    else
        echo -n '↣ '
    end
    set_color green
    echo -n '['
    set_color normal
    set_color $retc
    echo -n (date +%X)
    set_color green
    echo -n ]
    
    if type -q acpi
		if [ (acpi -a 2> /dev/null | string match -r off) ]
			echo -n '─['
			set_color -o red
			echo -n (acpi -b|cut -d' ' -f 4-)
			set_color -o green
			echo -n ']'
		end
	end
    echo
    set_color normal
    for job in (jobs)
        set_color $retc
        if [ $tty = tty ]
            echo -n '; '
        else
            echo -n '│ '
        end
        set_color brown
        echo $job
    end
    set_color normal
    set_color $retc
    if [ $tty = tty ]
        echo -n "'->"
    else
        echo -n '╰─'
    end
    set_color $fish_color_sky
    echo -n '➤ '
    #set_color normal
end
