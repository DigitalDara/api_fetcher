#!/bin/bash

: <<'EOF'
 Synopsis
    A script that will fetch information from an API.

 Description
    This script will allow the user to extract/parse the data from an API. The script will ask the 
    user to ender a User ID of the available users listed, once enterd the script will display all the
    post or information tying into that specific User ID.

 Author:
   - Name: Dara Pok
   - Date: 2025-04-13

 Assumptions:
   - API Request: The API request is valid and will be able to request the data. If their is an issue 
    with the request it will display and error.
   - Fecthing Data: The data will be extracted with the proper User ID
   - Menu: The menu will display all the available users and ask the user to input a User ID from 1-10
   - Results: Extracted data will be listed within the terminal based on the specific User ID.

 Pseudo Code:
    - Create a globabl var for the API
    - Define a function called 'fetch_users' and 'fetch_posts' and create a response to 
    fetch the data. If failed display an error message 
    - Define a main function
    - Create a var for users that is equal to fetch_users to call for the data - this will extract how many users
    - Create a var for post that is equal to fetch_posts to call for the data - this will extract the post made by the user
    - Make a input that will ask the user to enter the User ID - has an exit feature.
    - Display the extract information depending on the User ID that was inputed. 

EOF

# Your script content goes here

API_URL="https://jsonplaceholder.typicode.com"

# Function to check API connectivity
check_api() {
    if ! curl -s --head "$API_URL" >/dev/null 2>&1; then
        echo "ERROR: Cannot connect to API at $API_URL"
        echo "Please check your internet connection and try again."
        exit 1
    fi
}

display_posts() {
    local user_id=$1
    echo -e "\nPosts for User $user_id:\n"
    
    # Add error handling for the posts request
    posts=$(curl -s --fail "$API_URL/posts?userId=$user_id")
    if [[ $? -ne 0 ]]; then
        echo "ERROR: Failed to fetch posts for user $user_id"
        echo "Please try again later."
        return 1
    fi
    
    formatted_posts=$(echo "$posts" | jq -r '
        .[] | 
        "Post ID: \(.id)\nTitle: \(.title)\nBody: \(.body)\n" +
        "-------------------------------"')
    
    if [[ -z "$formatted_posts" ]]; then
        echo "No posts found for this user."
    else
        echo "$formatted_posts"
    fi
}

main() {
    check_api  # Verify API connection first
    
    echo "Available User IDs: 1 2 3 4 5 6 7 8 9 10"
    echo ""

    while true; do
        read -p "Enter User ID (1-10) or 'exit': " input
        
        # Case-insensitive exit
        if [[ "$(echo "$input" | tr '[:upper:]' '[:lower:]')" == "exit" ]]; then
            echo -e "\nGoodbye!"
            exit 0
        fi
        
        # Empty input
        if [[ -z "$input" ]]; then
            echo "ERROR: Please enter a value"
            echo ""
            continue
        fi
        
        # Non-numeric input
        if ! [[ "$input" =~ ^[0-9]+$ ]]; then
            echo "ERROR: '$input' is not a valid number"
            echo ""
            continue
        fi
        
        # Out of range
        if (( input < 1 || input > 10 )); then
            echo "ERROR: $input is not a valid User ID (must be 1-10)"
            echo ""
            continue
        fi
        
        # Valid input - show posts
        if ! display_posts "$input"; then
            exit 1  # Exit if post fetching failed
        fi
        break
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi