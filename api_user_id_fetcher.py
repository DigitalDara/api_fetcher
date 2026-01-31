""" A script that will fetch information from an API """
"""
    Description
        - This script will allow the user to extract/parse the data from an API. The script will ask the 
        user to ender a User ID of the available users listed, once enterd the script will display all the
        post or information tying into that specific User ID. 

    Author:
        -Name: Dara Pok
        -Date: 2025-04-13
    
    Assumptions:
        - API Request: The API request is valid and will be able to request the data. If their is an issue 
        with the request it will display and error.
        - Fecthing Data: The data will be extracted with the proper User ID 
        - Menu: The menu will display all the available users and ask the user to input a User ID from 1-10
        - Results: Extracted data will be listed within the terminal based on the specific User ID. 
    
    Pseudo Code:
        - Import 'requests' and 'json'
        - Create a globabl var for the API
        - Define a function called 'fetch_users' and 'fetch_posts' and create a response to 
        fetch the data. If failed display an error message 
        - Define a main function
        - Create a var for users that is equal to fetch_users to call for the data - this will extract how many users
        - Create a var for post that is equal to fetch_posts to call for the data - this will extract the post made by the user
        - Make a input that will ask the user to enter the User ID - has an exit feature.
        - Display the extract information depending on the User ID that was inputed. 


"""

# api_user_id_fetcher.py

import requests
import json

# API URL 
API_URL = "https://jsonplaceholder.typicode.com"

# Fetches all users
def fetch_users():
    try:
        response = requests.get(f"{API_URL}/users")
        response.raise_for_status()  # Raises error for HTTP issues
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching users: {e}")
        return None

# Fetch posts for a specific user
def fetch_posts(user_id):
    try:
        response = requests.get(f"{API_URL}/posts", params={"userId": user_id})
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching posts: {e}")
        return None

# Main function
def main():
    users = fetch_users()
    if not users:
        return
    
    # Extracts and display user IDs
    user_ids = [user["id"] for user in users]
    print("\nAvailable User IDs:", user_ids)
    
    while True:
        user_input = input("Enter a user ID (1-10) or type 'exit' to quit: ").strip().lower()
        
        if user_input == "exit":
            print("Exiting program. Goodbye!")
            return
        
        try:
            user_id = int(user_input)
            if user_id in user_ids:
                break
            else:
                print("Invalid ID. Please select from the available IDs listed.")
        except ValueError:
            print("Invalid input. Please enter a number.")

    # Fetches and display posts
    posts = fetch_posts(user_id)
    if posts:
        print(f"\nPosts by User {user_id}:")
        for post in posts:
            print(f"\nPost ID: {post['id']}\nTitle: {post['title']}\nBody: {post['body']}\n{'-'*47}")
    else:
        print(f"No posts found for user {user_id}.")

if __name__ == "__main__":
    main()