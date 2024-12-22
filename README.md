# Netflix Data Analysis SQL Project

This project explores Netflix's dataset to uncover insights into its diverse content library. SQL queries are used to analyze content types, ratings, genres, and trends.

## Dataset Overview
The dataset includes:
- **show_id**: Unique identifier.
- **type**: "Movie" or "TV Show."
- **title**, **director**, **casts**, **country**, **date_added**, **release_year**, **rating**, **duration**, **listed_in**, **description**.

## Key Queries & Insights
1. **Movies vs TV Shows**: Counted using `GROUP BY`.
2. **Most Common Ratings**: Identified using `RANK() OVER` in a `WITH` clause.
3. **Movies from 2020**: Filtered with `WHERE release_year = 2020`.
4. **Top 5 Content-Producing Countries**: Analyzed with `STRING_TO_ARRAY` and `UNNEST`.
5. **Longest Movie**: Ordered by `SPLIT_PART(duration, ' ', 1)::INT`.
6. **Content in the Last 5 Years**: Filtered with `TO_DATE` and date functions.
7. **Content by Rajiv Chilaka**: Filtered using `UNNEST` for directors.
8. **TV Shows with >5 Seasons**: Filtered by splitting `duration`.
9. **Genre Distribution**: Counted with `STRING_TO_ARRAY` and `UNNEST`.
10. **Documentaries**: Filtered using `LIKE`.
11. **Content Without Directors**: Found with `WHERE director IS NULL`.
12. **Salman Khan Movies (Last 10 Years)**: Filtered with `LIKE` and `release_year`.
13. **Top 10 Actors in Indian Movies**: Ranked using `UNNEST` and `GROUP BY`.

## Tools & Techniques
- **SQL Functions**: Aggregation (`COUNT`), ranking (`RANK()`), string operations (`SPLIT_PART`, `STRING_TO_ARRAY`), and filtering (`WHERE`, `LIKE`).
- **Data Handling**: Null values, multi-value fields (e.g., directors, casts).

## Key Insights
- **Content Distribution**: Mix of Movies and TV Shows.
- **Common Ratings**: Popular ratings differ by type.
- **Geographical Trends**: India and USA lead in content production.
- **Actor/Director Analysis**: Highlighted key contributors like Salman Khan and Rajiv Chilaka.
- **Recent Trends**: Significant content added in the last 5 years.

## Setup
1. Load the dataset into your database (e.g., PostgreSQL/MySQL).
2. Run the SQL queries to extract insights.

## Conclusion
This project highlights SQL's power for analyzing real-world datasets, offering actionable insights into Netflix's content distribution and audience preferences.
