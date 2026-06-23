#!/usr/bin/env zsh

# ==========================================================================
# Git Stage & Commit 
# By N1x_Cybersec
#
# - ZSH script to help automate the process of staging and committing 
#   changes to the nix-config repository.
# - Shows a preview/diff of the file(s) that have been modified (including any 
#   untracked/newly added files/directories)
# - Script will automatically determine where the root of the git repo is
# - Standard usage: make changes to any file(s) in ~/nix-config/, run the
#   script using "y" to stage each file, then enter a commit message for each
#   file, or hit enter to use the default commit message.
# - Script includes getopts argument parsing to allow for full automation via 
#   flags. Run "./scripts/git-stage-commit.zsh -y -m" to stage and commit all 
#   changed files with the default message.
# - Script is defined system-wide in /modules/system/packages/scripts using 
#   pkgs.writeShellScriptBin.
# ==========================================================================


# Parse command line flags
auto_stage=0
auto_msg=0
while getopts "ymh" opt; do
  case ${opt} in
    y )
      auto_stage=1
      ;;
    m )
      auto_msg=1
      ;;
    h )
      printf "Usage: %s [-y] [-m]\n" "$0"
      printf "  -y  Automatically answer 'y' to stage all changed files\n"
      printf "  -m  Automatically use the default commit message\n"
      exit 0
      ;;
    \? )
      printf "Invalid option. Use -h for help.\n" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Ensure we are located in the nix-config directory
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf "Error: Not inside a git repository.\n"
    exit 1
fi

# Go to the root of the git repository to ensure paths match
cd "$(git rev-parse --show-toplevel)"

# Get list of modified, added, or deleted files
local files_raw
files_raw=$(git status --porcelain)

if [[ -z "$files_raw" ]]; then
    printf "No changes to stage or commit.\n"
    exit 0
fi

# Safely extract file paths 
local files
files=("${(@f)$(echo "$files_raw" | sed 's/^...//' | sed 's/^"//' | sed 's/"$//')}")

printf "Found %d changed file(s).\n" "${#files[@]}"

for file in "${files[@]}"; do
    printf "\n========================================================\n"
    
    # Determine context and default commit prefix based on your structure
    local prefix=""
    if [[ "$file" == "configuration.nix" || "$file" == "home.nix" || "$file" == "flake.nix" || "$file" == "flake.lock" ]]; then
        prefix="${file%.*}: "
    elif [[ "$file" =~ ^modules/(system|user)/([^/]+)/default\.nix$ ]]; then
        prefix="${match[1]}(${match[2]}): "
    elif [[ "$file" =~ ^modules/(system|user)/([^/]+)/(.*)$ ]]; then
        prefix="${match[1]}(${match[2]}): "
    elif [[ "$file" =~ ^modules/(system|user)/default\.nix$ ]]; then
        prefix="${match[1]}: "
    else
        prefix="$(basename "$file"): "
    fi

    printf "File: \033[1;36m%s\033[0m\n" "$file"
    printf "Suggested prefix: \033[1;33m%s\033[0m\n" "$prefix"
    printf "--------------------------------------------------------\n"
    
    # Show concise diff for context
    if [[ -f "$file" ]] && ! git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
        printf "\033[1;32m(Untracked file)\033[0m\n"
        head -n 15 "$file"
        if [[ $(wc -l < "$file" 2>/dev/null | awk '{print $1}') -gt 15 ]]; then
            printf "...\n"
        fi
    else
        git diff --color=always HEAD -- "$file" | head -n 15
        if [[ $(git diff HEAD -- "$file" | wc -l) -gt 15 ]]; then
            printf "...\n"
        fi
    fi
    printf "--------------------------------------------------------\n"
    
    # Prompt to stage and commit changed file(s)
    if (( auto_stage )); then
        action="y"
        printf "Auto-staging file...\n"
    else
        printf "Stage and commit this file? [y/N/q(uit)] "
        if [[ ! -t 0 ]]; then
            read action
        else
            read -k 1 action
            printf "\n"
        fi
    fi
    
    if [[ "$action" == "q" || "$action" == "Q" ]]; then
        printf "Exiting...\n"
        break
    elif [[ "$action" == "y" || "$action" == "Y" ]]; then
        git add "$file"
        
        # Read the commit message
        local msg=""
        if (( auto_msg )); then
            printf "Auto-accepting default message.\n"
        else
            printf "\nEnter detailed message (will be appended to '%s'): " "$prefix"
            read msg
        fi
        
        # If a message is provided, append it. Otherwise, just use the prefix + update
        local full_msg=""
        if [[ -n "$msg" ]]; then
            full_msg="${prefix}${msg}"
        else
            full_msg="${prefix}update"
        fi
        
        git commit -m "$full_msg"
        printf "\033[1;32mCommitted:\033[0m %s\n" "$full_msg"
    else
        printf "Skipping \033[1;36m%s\033[0m\n" "$file"
    fi
done

printf "\nDone!\n"
