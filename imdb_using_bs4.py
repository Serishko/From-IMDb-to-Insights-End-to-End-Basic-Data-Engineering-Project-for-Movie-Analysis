from bs4 import BeautifulSoup
import requests
import json

# Import the required libraries

page = requests.get('https://www.imdb.com/chart/top/?ref_=nv_mv_250')
# Send a GET request to the IMDb website's top 250 movies page

html = BeautifulSoup(page.content, 'html.parser')
# Create a BeautifulSoup object to parse the HTML content of the page

movies_list = html.find_all(class_='titleColumn')
# Find all elements with the class 'titleColumn', which represent the movie titles and release dates

movies = [movie.find('a').get_text() for movie in movies_list]
# Extract the movie titles from the 'a' tags within the 'titleColumn' elements

dates = [movie.find('span').get_text().strip('()') for movie in movies_list]
# Extract the release dates from the 'span' tags within the 'titleColumn' elements and remove parentheses

rating_list = html.find_all(class_='ratingColumn imdbRating')
# Find all elements with the class 'ratingColumn imdbRating', which represent the movie ratings

ratings_titles = [rating.find('strong')['title'] for rating in rating_list]
# Extract the rating titles from the 'strong' tags within the 'ratingColumn imdbRating' elements

ratings = [rating[:3] for rating in ratings_titles]
# Extract the first three characters from each rating title, representing the movie's rating

reviews = [review[13:-13] for review in ratings_titles]
# Extract the review count from each rating title, removing the leading and trailing characters

file = {
    'Movies' : movies,
    'Release dates' : dates,
    'Ratings' : ratings,
    'Reviews' : reviews
}
# Create a dictionary with movie-related information

json_file = json.dumps(file)
# Convert the dictionary to a JSON string

with open(r"C:\Users\sapan\OneDrive\Desktop\json_file\imdb.json", 'w') as file:
    file.write(json_file)
# Write the JSON string to a file named 'imdb.json'

