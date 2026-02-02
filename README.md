# Description
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

