# Netflix-Analysis-using-Python-and-SQL

## Project Overview
This project explores and analyzes Netflix titles using SQL and Python (Jupyter Notebook). The analysis focuses on gaining insights into Netflix's catalog, including content distribution, genre trends, release patterns, and more. The main objective is to extract meaningful information about the data that can drive business decisions and enhance the user experience on the platform.

### Key Objectives:
1. Analyze the distribution of content across genres.
2. Study content release patterns over the years.
3. Examine the correlation between content rating and release years.
4. Determine the top actors, directors, and other contributors on Netflix.
5. Use SQL to query the dataset and obtain relevant insights.

## Questions for Data Analysis in SQL
-  For each Director Count the no. of movies and Tv Shows created by them in seperate columns for directors who have created tv shows and movies both.
-  Which Country has higher no. of Comedy Movies?
-  For each year (as per date added to netflix), which director has the maximum number of movies released .
-  What is the avverage duration of movies in each genre?
-  Find the list of directors who have created horror and comedy movies both, Display director names along with number of comedy and horror movies directed by them

## Dataset
The dataset used for this analysis is `netflix_titles.csv`. It includes the following features:
- `show_id`: Unique identifier for each show.
- `type`: Type of content (Movie/TV Show).
- `title`: Title of the content.
- `director`: Director of the content.
- `cast`: Main cast members.
- `country`: Country where the content was produced.
- `date_added`: Date when the content was added to Netflix.
- `release_year`: Year the content was released.
- `rating`: Content rating (e.g., PG-13, R).
- `duration`: Duration of the content (minutes for movies or number of seasons for TV shows).
- `listed_in`: Genres/categories the content falls into.
- `description`: A brief description of the content.

## Files in the Project
- **`Netflix Analysis SQL.sql`**: Contains SQL queries used to analyze the Netflix dataset. It includes queries for summarizing and filtering the data by various categories such as type, country, and release year.
  
- **`Netflix Analysis.ipynb`**: A Jupyter Notebook with Python code for data analysis. It includes:
  - Data cleaning steps.
  - Exploratory Data Analysis (EDA) without visualizations.
  
- **`netflix_titles.csv`**: The raw dataset that includes information about Netflix titles up until the time of data collection.

## Setup Instructions
### Prerequisites:
- Python 3.x
- Jupyter Notebook
- Libraries:
  - `pandas`
  - `sqlite3` (or any SQL environment to run SQL queries)

### Steps to Run:
1. Clone the repository or download the project files.
2. Install the required libraries by running the following command in your environment:
   ```bash
   pip install pandas
   ```
3. Open `Netflix Analysis.ipynb` in Jupyter Notebook.
4. Run all the cells to perform the analysis.

### SQL Analysis:
To run the SQL queries from `Netflix Analysis SQL.sql`:
1. Set up a local SQL environment (e.g., SQLite or MySQL).
2. Import the `netflix_titles.csv` dataset into a table within your database.
3. Execute the queries in `Netflix Analysis SQL.sql` to obtain the insights.

## Insights and Results
- **Content Distribution**: The majority of content on Netflix falls under the genres of Drama, Comedy, and Documentary.
- **Yearly Release Patterns**: There has been a significant increase in the number of titles added to Netflix in recent years.
- **Country-Wise Analysis**: The US and India contribute to a substantial portion of Netflix’s content library.
- **Content Duration**: TV shows often span multiple seasons, while the majority of movies have a runtime of around 90 to 120 minutes.

## Conclusion
This analysis offers a detailed understanding of Netflix's content library and its trends. The results can help Netflix make data-driven decisions about content acquisition, user recommendations, and content distribution strategies.


## Contributors
- **Shreyas Jadhav** - Data Analyst  
(Contact: shreyasjadhav8104@gmail.com)

## License
This project is licensed under the MIT License.
