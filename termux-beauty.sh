#!/usr/bin/env bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
BLACK='\033[1;30m'
GRAY='\033[0;37m'
RESET='\033[0m'

ETC_DIR="/data/data/com.termux/files/usr/etc"
MOTD_FILE="${ETC_DIR}/motd"
BASHRC_FILE="${ETC_DIR}/bash.bashrc"
BACKUP_MOTD="$HOME/.motd.backup"
BACKUP_BASHRC="$HOME/.bash.bashrc.backup"

LOGO="
                         .:   =#-:-----:
                           **%@#%@@@@@#*+==:
                       :=*%@@@@@@@@@@@@@@%#*=:
                    -*%@@@@@@@@@@@@@@@@@@@@@@@%#=.
                . -%@@@@@@@@@@@@@@@@@@@@@@@@%%%@@@#:
              .= *@@@@@@@@@@@@@@@@@@@@@@@@@@@%#*+*%%*.
             =%.#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+=+#:
            :%=+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%+.+.
            #@:%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%..
           .%@*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%.
           =@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
           +@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
           =@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-
           .%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
            #@@@@@@%####**+*%@@@@@@@@@@%*+**####%@@@@@@#
            -@@@@*:       .  -#@@@@@@#:  .       -#@@@%:
             *@@%#            -@@@@@@.            #@@@+
             .%@@#            +@@@@@@=            #@@#
              :@@*           =%@@@@@@%-           *@@:
              #@@%         .*@@@@#%@@@%+.         %@@+
              %@@@+      -#@@@@@* :%@@@@@*-      *@@@*
              *@@@@#++*#%@@@@@@+    #@@@@@@%#+++%@@@@=
               #@@@@@@@@@@@@@@        @@@@@@@@@@@@@@*
                =%@@@@@@@@@@@@* :#+ .#@@@@@@@@@@@@#-
                  .---@@@@@@@@@%@@@%%@@@@@@@@%:--.
                      #@@@@@@@@@@@@@@@@@@@@@@+
                       *@@@@@@@@@@@@@@@@@@@@+
                        +@@%*@@%@@@%%@%*@@%=
                         +%+ %%.+@%:-@* *%-
                          .  %# .%#  %+
                             :.  %+  :.
                                 -:"

show_help() {
    echo -e "${CYAN}Termux Beauty Script${RESET}"
    echo "Usage: $0 [OPTION]"
    echo "  --help, -h        Show this help"
    echo "  --motd            Change banner color and text"
    echo "  --prompt          Change command prompt"
    echo "  --reset           Restore to default"
    echo "  --menu            Interactive menu (default)"
}

backup_files() {
    [ -f "$MOTD_FILE" ] && cp "$MOTD_FILE" "$BACKUP_MOTD"
    [ -f "$BASHRC_FILE" ] && cp "$BASHRC_FILE" "$BACKUP_BASHRC"
    echo -e "${GREEN}[✓] Backup done${RESET}"
}

restore_default() {
    if [ -f "$BACKUP_MOTD" ]; then
        cp "$BACKUP_MOTD" "$MOTD_FILE"
        echo -e "${GREEN}[✓] MOTD restored${RESET}"
    else
        > "$MOTD_FILE"
    fi
    if [ -f "$BACKUP_BASHRC" ]; then
        cp "$BACKUP_BASHRC" "$BASHRC_FILE"
        echo -e "${GREEN}[✓] bash.bashrc restored${RESET}"
    else
        echo "PS1='\\[\\e[0;32m\\]\\w\\[\\e[0m\\] \\$ '" > "$BASHRC_FILE"
    fi
    echo -e "${CYAN}[*] Restart Termux to see changes${RESET}"
}

change_motd() {
    echo -e "${YELLOW}Logo color selection:${RESET}"
    echo "  1) ${BLACK}Black${RESET}"
    echo "  2) ${GRAY}Gray${RESET}"
    echo "  3) ${RED}Red${RESET}"
    echo "  4) ${GREEN}Green${RESET}"
    echo "  5) ${PURPLE}Purple${RESET}"

    local color_choice
    while true; do
        echo -en "${YELLOW}👉 Select logo color [1-5]: ${RESET}"
        read color_choice
        if [[ "$color_choice" =~ ^[1-5]$ ]]; then
            break
        else
            echo -e "${RED}Invalid choice${RESET}"
        fi
    done

    local logo_color
    case $color_choice in
        1) logo_color="$BLACK" ;;
        2) logo_color="$GRAY" ;;
        3) logo_color="$RED" ;;
        4) logo_color="$GREEN" ;;
        5) logo_color="$PURPLE" ;;
    esac

    echo -e "${CYAN}Enter your extra text (e.g., My Channel: t.me/Red_Rooted_Ghost):${RESET}"
    echo -en "${YELLOW} Text: ${RESET}"
    read extra_text

    echo -e "${YELLOW}Extra text color selection:${RESET}"
    echo "  1) ${BLACK}Black${RESET}"
    echo "  2) ${GRAY}Gray${RESET}"
    echo "  3) ${RED}Red${RESET}"
    echo "  4) ${GREEN}Green${RESET}"
    echo "  5) ${PURPLE}Purple${RESET}"
    echo "  6) ${CYAN}Cyan${RESET}"
    echo "  7) ${WHITE}White${RESET}"

    local text_color_choice
    while true; do
        echo -en "${YELLOW} Select text color [1-7]: ${RESET}"
        read text_color_choice
        if [[ "$text_color_choice" =~ ^[1-7]$ ]]; then
            break
        else
            echo -e "${RED}Invalid choice${RESET}"
        fi
    done

    local text_color
    case $text_color_choice in
        1) text_color="$BLACK" ;;
        2) text_color="$GRAY" ;;
        3) text_color="$RED" ;;
        4) text_color="$GREEN" ;;
        5) text_color="$PURPLE" ;;
        6) text_color="$CYAN" ;;
        7) text_color="$WHITE" ;;
    esac

    > "$MOTD_FILE"
    echo -e "${logo_color}${LOGO}${RESET}" >> "$MOTD_FILE"
    echo "" >> "$MOTD_FILE"

    if [ -n "$extra_text" ]; then
        echo -e "${text_color}${extra_text}${RESET}" >> "$MOTD_FILE"
    fi

    echo -e "${GREEN}[✓] MOTD updated successfully${RESET}"
    echo -e "${CYAN}Restart Termux to see the new banner${RESET}"
}

change_prompt() {
    echo -e "${CYAN}Customize your prompt:${RESET}\n"

    echo -en "${YELLOW}Enter emoji (default 💀): ${RESET}"
    read emoji
    [ -z "$emoji" ] && emoji="💀"

    echo -en "${YELLOW}Enter username (default Red ${USER}): ${RESET}"
    read username
    [ -z "$username" ] && username="$USER"

    echo -en "${YELLOW}Enter hostname (default ROOTED): ${RESET}"
    read hostname
    [ -z "$hostname" ] && hostname="ROOTED"

    echo -e "${YELLOW}Select prompt color:${RESET}"
    echo "  1) ${RED}Red${RESET}"
    echo "  2) ${GREEN}Green${RESET}"
    echo "  3) ${YELLOW}Yellow${RESET}"
    echo "  4) ${BLUE}Blue${RESET}"
    echo "  5) ${PURPLE}Purple${RESET}"
    echo "  6) ${CYAN}Cyan${RESET}"
    echo "  7) ${WHITE}White${RESET}"

    local color_choice
    while true; do
        echo -en "${YELLOW}  Select color [1-7]: ${RESET}"
        read color_choice
        if [[ "$color_choice" =~ ^[1-7]$ ]]; then
            break
        else
            echo -e "${RED}Invalid choice${RESET}"
        fi
    done

    local prompt_color
    case $color_choice in
        1) prompt_color="\\[\\e[1;31m\\]" ;;
        2) prompt_color="\\[\\e[1;32m\\]" ;;
        3) prompt_color="\\[\\e[1;33m\\]" ;;
        4) prompt_color="\\[\\e[1;34m\\]" ;;
        5) prompt_color="\\[\\e[1;35m\\]" ;;
        6) prompt_color="\\[\\e[1;36m\\]" ;;
        7) prompt_color="\\[\\e[1;37m\\]" ;;
    esac

    local ps1_line
    ps1_line="PS1='${prompt_color}┌─[${emoji} ${username}@${hostname}]─[\\[\\e[1;34m\\]\\w${prompt_color}]\\n${prompt_color}└──╼ \\[\\e[1;37m\\]#\\[\\e[0m\\] '"

    local tmpfile="${BASHRC_FILE}.tmp"
    cp "$BASHRC_FILE" "$tmpfile"
    sed -i '/^PS1=/d' "$BASHRC_FILE"
    echo "$ps1_line" >> "$BASHRC_FILE"
    rm "$tmpfile"

    echo -e "${GREEN}[✓] Prompt changed successfully${RESET}"
    echo -e "${CYAN}Restart Termux or run 'source $BASHRC_FILE' to see changes${RESET}"
}

main_menu() {
    while true; do
        echo -e "\n${CYAN}════════════════════════════════════${RESET}"
        echo -e "${YELLOW}   Termux Beauty  ${RESET}"
        echo -e "${CYAN}════════════════════════════════════${RESET}"
        echo "1) Change Banner (MOTD) - Logo + Text"
        echo "2) Change Prompt - Customize your prompt"
        echo "3) Reset to default"
        echo "4) Exit"
        echo -en "${YELLOW} Choose [1-4]: ${RESET}"
        read opt
        case $opt in
            1) backup_files; change_motd ;;
            2) backup_files; change_prompt ;;
            3) restore_default ;;
            4) echo -e "${GREEN}Goodbye!${RESET}"; break ;;
            *) echo -e "${RED}Invalid option${RESET}" ;;
        esac
    done
}

case "$1" in
    --help|-h) show_help ;;
    --motd) backup_files; change_motd ;;
    --prompt) backup_files; change_prompt ;;
    --reset) restore_default ;;
    --menu) main_menu ;;
    *) main_menu ;;
esac
