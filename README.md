**MovieMate App**

MovieMate App is an iOS application designed to enhance your movie-watching experience by providing easy navigation through a variety of films categorized by genre, allowing users to search, add movies to a watchlist, and view detailed information about each film.

**Features**

Home Screen:

	•	Categories: Displays various movie categories such as Action, Comedy, Drama, Fantasy, and Romance.
	•	Top Movies: Showcases top movies at the top of the screen.
	•	Genres: The central section displays different genres.
	•	Movie Details: Clicking on a movie reveals details such as the title, description, and trailer presented in a collection view.

Search Screen:

	•	Search Functionality: Users can search for movies by name or category. A search bar is at the top, and search results are displayed below.
	•	Filtered Results: Filters and displays movies based on user input.

Watchlist:

	•	Add to Watchlist: Users can add desired movies to their watchlist. The watchlist is managed using Core Data, ensuring movies are saved for later viewing.
	•	View Watchlist: Users can view their saved movies and click on them to see more information.
	•	Delete from Watchlist: Users have the option to remove movies from their watchlist.

Technical Details:

	•	Data Handling: Movies and their categories are loaded from a JSON file.
	•	Design: The application’s design and layout are created using Figma.
	•	Persistent Storage: Core Data is used to manage and store user-selected watchlist items.

How to Use:

	1.	Home Screen: Browse movies by category or view the top movies.
	2.	Search: Use the search bar to find movies by name or category.
	3.	Watchlist: Add movies to your watchlist for easy access and manage your saved movies through the watchlist screen.

Development:

	•	The app is developed in Swift using Xcode.
	•	It leverages UIKit for the interface and Core Data for persistent storage.
	•	JSON is used to populate the movie data.
