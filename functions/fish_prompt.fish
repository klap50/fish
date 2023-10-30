function fish_prompt
    # Colores en formato hexadecimal
    set color_user '#008000'  # Verde
    set color_at '#00FFFF'    # Cian
    set color_host '#008000'  # Verde
    set color_path '#FFA500'  # Naranja mate
    set color_status '#0000FF'  # Azul
    set color_normal '#FFFFFF'  # Blanco (normal)
    set color_clean '#008000'  # Verde
    set color_dirty '#FF0000'  # Rojo
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

        echo -n -s (set_color '#0000FF')$symbol_git $git_info (set_color $git_status_color)$git_status_symbol ' '
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
    echo -n -s (set_color '#FFFF00')(string replace -r '..' '.' (string repeat -n $duration '.'))
end

# apt-get coloreado
# function apt-get
#     command apt-get $argv | pv -p > /dev/null
# end

# function apt-get
#     # Ejecutar el comando real 'apt-get' y capturar su salida
#     command apt-get $argv 2>&1 | while read -l line
#         switch $line
#             # Aquí se procesaría cada línea para buscar información del progreso
#             # y se imprimiría la barra de progreso correspondiente.
#             # Este es un ejemplo muy básico y probablemente necesites ajustarlo:
#             case '*%*'
#                 set -l percent (string match -r -o '\d+%' -- $line)
#                 set -l clean_percent (string replace '%' '' -- $percent)
#                 set -l length (math $clean_percent / 4) # Ajustar la longitud de la barra
#                 set -l bar (string repeat -n $length "=")
#                 # Borrar la línea actual y mostrar la barra de progreso
#                 printf "\r[%-25s] %s%%" $bar $clean_percent
#             case '*'
#                 # Para cualquier otra línea, simplemente imprimir como está
#                 echo $line
#         end
#     end
#     echo
# end
