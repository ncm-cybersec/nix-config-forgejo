#!/usr/bin/env zsh

# Make sure we are in a git repository
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

# Extract file paths safely
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
    
    # Ask if user wants to stage and commit
    printf "Stage and commit this file? [y/N/q(uit)] "
    read -k 1 action
    printf "\n"
    
    if [[ "$action" == "q" || "$action" == "Q" ]]; then
        printf "Exiting...\n"
        break
    elif [[ "$action" == "y" || "$action" == "Y" ]]; then
        git add "$file"
        
        # Read the commit message
        printf "\nEnter detailed message (will be appended to '%s'): " "$prefix"
        read msg
        
        # If user provides a message, append it. Otherwise, just use the prefix + update
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
