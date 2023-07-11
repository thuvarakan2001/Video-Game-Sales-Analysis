-- 1.The ten best-selling video games
-- Selecting all information for the top ten best-selling games
-- Ordering the results from best-selling game down to tenth best-selling
SELECT * 
FROM game_sales 
ORDER BY games_sold DESC 
LIMIT 10; 


-- 2. Missing review scores
-- Joining games_sales and reviews
-- Selecting a count of the number of games where both critic_score and user_score are null
SELECT COUNT(g.game)
FROM game_sales g
LEFT JOIN reviews r
    ON g.game = r.game
    WHERE critic_score IS NULL AND user_score IS NULL; 
    
    
-- 3. Years that video game critics loved   
-- Selecting the release year and average critic score for each year, rounded and aliased
-- Joining the game_sales and reviews tables
-- Grouping by release year
-- Ordering the data from highest to lowest avg_critic_score and limit to 10 results
SELECT g.year, ROUND(AVG(r.critic_score),2) as avg_critic_score
FROM game_sales g
LEFT JOIN reviews r 
    ON g.game = r.game 
GROUP BY g.year 
ORDER BY avg_critic_score DESC
LIMIT 10;     


--4. Was 1982 really that great?
-- Updating previous Query to add a count of games released in each year called num_games
-- Updating the query so that it only returns years that have more than four reviewed games
SELECT g.year,COUNT(g.game) AS num_games, ROUND(AVG(r.critic_score),2) as avg_critic_score
FROM game_sales g
LEFT JOIN reviews r 
    ON g.game = r.game 
GROUP BY g.year 
HAVING COUNT(g.game) > 4  
ORDER BY avg_critic_score DESC
LIMIT 10; 


-- 5. Years that dropped off the critics' favorites list
-- Selecting the year and avg_critic_score for those years that dropped off the list of critic favorites 
-- Ordering the results from highest to lowest avg_critic_score
SELECT year, avg_critic_score 
FROM top_critic_years 
EXCEPT 
SELECT year, avg_critic_score 
FROM top_critic_years_more_than_four_games 
ORDER BY avg_critic_score DESC; 


-- 6. Years video game players loved
-- Selecting year, an average of user_score, and a count of games released in a given year, aliased and rounded
-- Including only years with more than four reviewed games; group data by year
-- Ordering data by avg_user_score, and limit to ten results
SELECT g.year, COUNT(g.game) AS num_games ,ROUND(AVG(r.user_score),2) AS avg_user_score
FROM game_sales g
INNER JOIN reviews r
ON g.game = r.game
GROUP BY g.year
HAVING COUNT(g.game) > 4
ORDER BY avg_user_score DESC
LIMIT 10;


-- 7. Years that both players and critics loved
-- Selecting the year results that appear on both tables
SELECT year 
FROM top_user_years_more_than_four_games
INTERSECT 
SELECT year 
FROM top_critic_years_more_than_four_games


-- 8. Sales in the best video game years
-- Selecting year and sum of games_sold, aliased as total_games_sold; order results by total_games_sold descending
-- Filtering game_sales based on whether each year is in the list
SELECT g.year, SUM(g.games_sold) AS total_games_sold 
FROM game_sales g 
WHERE g.year IN (SELECT year
FROM top_user_years_more_than_four_games
INTERSECT 
SELECT year 
FROM top_critic_years_more_than_four_games)
GROUP BY g.year 
ORDER BY total_games_sold DESC;









 










