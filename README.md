# From IMDb to Insights: End-to-End Basic Data Engineering Project for Movie Analysis
## Architecture

![Drawing1](https://github.com/Serishko/data-enngineering-project/assets/58653229/e9261b46-a441-4ad7-88dc-15225ab4896e)

## Tools and Technologies

* Python
* Amazon S3
* Snowflake
* Tableau

## Overview

The top 250 IMDb movies are extracted from the IMDb website based on ratings using Beautiful Soup as the web scraping tool. The resulting data is stored as a JSON file, which is then uploaded to an AWS S3 bucket for storage. From the S3 bucket, the JSON file is retrieved and integrated into Snowflake, a cloud-based data warehousing platform. Utilizing SQL queries within Snowflake, the JSON data is transformed, resulting in the creation of a CSV file. This CSV file is subsequently downloaded to the local machine, where it can be accessed for further analysis and processing. Finally, the downloaded CSV file is imported into Tableau, a data visualization and analytics tool, enabling the creation of data-driven visualizations and interactive dashboard.

## Dashboard

![image](https://github.com/Serishko/data-enngineering-project/assets/58653229/6047cf2b-aa24-4ef4-8935-9d13796a2911)

