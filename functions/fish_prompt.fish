function fish_prompt
    # Colores
    set color_user green
    set color_at cyan
    set color_host green
    set color_path '#FFA500'  # Un naranja mate
    set color_status blue
    set color_normal normal
    set color_clean green
    set color_dirty red
    set symbol_git "📜"
    set symbol_energy "⚡"
    set symbol_pacman "👾"
    set git_clean "✔"
    set git_dirty "✘"
    set git_toc_commit "🚀"

    # Tiempo de inicio
    set -g __fish_prompt_start_time (date +%s)

    # Usuario, host y '@'
    echo -n -s (set_color $color_user)(whoami)(set_color $color_at)'@'(set_color $color_host)(hostname)(set_color $color_normal) ' '

    # Directorio actual con estilo truncado
    echo -n -s (set_color $color_path)(prompt_pwd) ' '

    # Información de Git
    set git_info (__fish_git_prompt)
    if test -n "$git_info"
        # Determinar el estado del repositorio y mostrar el símbolo correspondiente
        set git_status_symbol
        set git_status_color
        if string match -qr '^\*' "$git_info" # Cambios sin commit (dirty)
            set git_status_symbol $git_dirty
            set git_status_color $color_dirty
        else if string match -qr '^\+' "$git_info" # Cambios agregados pero sin commit (toc commit)
            set git_status_symbol $git_toc_commit
            set git_status_color $color_normal
        else
            set git_status_symbol $git_clean
            set git_status_color $color_clean
        end

        echo -n -s (set_color blue)$symbol_git $git_info (set_color $git_status_color)$git_status_symbol ' '
    end

    # Símbolo de energía y duración del comando
    set -l duration (math (date +%s) - $__fish_prompt_start_time)
    if test $duration -ge 5  # Poner aquí el tiempo en segundos para mostrar Pac-Man
        echo -n -s (set_color $color_status)$symbol_pacman
    end

    echo -n -s (set_color $color_status) $symbol_energy ' '
end

function fish_right_prompt
    # Duración del comando anterior
    set -l duration (math (date +%s) - $__fish_prompt_start_time)
    echo -n -s (set_color yellow)(string replace -r '..' '.' (string repeat -n $duration '.'))
end
