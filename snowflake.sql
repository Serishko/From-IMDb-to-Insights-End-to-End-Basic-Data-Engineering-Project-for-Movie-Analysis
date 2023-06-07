-- Create or replace temporary stage imdb_stage
-- Define file format as JSON
-- Specify AWS credentials
create or replace temporary stage imdb_stage
file_format = (type = json)
credentials = (
aws_key_id = '',
aws_secret_key = ''
)
url = 's3://imdb-json-data/imdb.json'

-- Create or replace table movies
-- Extract the 'Movies' data from imdb_stage
create or replace table movies as
select index, movie.value as Movies
from
(select $1 data
from @imdb_stage) 
imdb, 
lateral flatten(input=>imdb.data['Movies']) as movie

-- Create or replace table dates
-- Extract the 'Release_dates' data from imdb_stage
create or replace table dates as
select index, date.value as Release_dates
from
(select $1 data
from @imdb_stage) 
imdb,
lateral flatten(input=>imdb.data['Release dates']) as date

-- Create or replace table ratings
-- Extract the 'Ratings' data from imdb_stage
create or replace table ratings as
select index, rating.value as Ratings
from
(select $1 data
from @imdb_stage) 
imdb,
lateral flatten(input=>imdb.data['Ratings']) as rating

-- Create or replace table reviews
-- Extract the 'Reviews' data from imdb_stage
create or replace table reviews as
select index, replace(review.value,',', '') as Reviews
from
(select $1 data
from @imdb_stage) 
imdb,
lateral flatten(input=>imdb.data['Reviews']) as review

-- Perform calculations and retrieve required data
select m.Movies, to_varchar(d.release_dates) as Release_dates, cast(r.Ratings as float) as Ratings, cast(re.Reviews as int) as Reviews, (Reviews*0.4+ Ratings*0.6) as Weighted_average
from movies m
join dates d
on m.index = d.index
join ratings r
on m.index = r.index
join reviews re
on m.index = re.index
