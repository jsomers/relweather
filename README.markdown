It's hard to say exactly what "55 degrees" feels like. But everyone knows how hot or cold they felt yesterday. So rather than giving today's temperature in absolute units, **relweather** tells you how today is going to feel *relative to yesterday*.

## TODOs

1. Error handling: 
	* <del>Google doesn't return a result?</del>
	* <del>Their XML data is malformed?</del>
	* <del>User inputs a bizarre query?</del>

2. Restructure data a bit:
	* <del>Rather than highs & lows, just store current temperatures</del>
	* <del>These temperatures should be stored with a precise timestamp</del>
	* <del>When someone queries a valid city for which there are no values in the db, write to db.</del>

3. `rake` task (every hour):
	* Finds all the cities represented in the db
	* <del>For each, runs a query to add current forecast to db (different method than above, so that it writes *even if the city is already in the db*)</del>
	
4. <del>`diff` function should by default compare current temperature to yesterday's temperature *from the same time*</del>

5. Interface:
	* Basic diff on search gives temperature now compared to temperature yesterday *at this time*
	* Drop all the rest of yesterday's values as JSON on page
	* Present a range slider with 24 notches, one for each hour. Presets for morning, afternoon, and night. When someone selects a range, dynamically recalculates the diff using the average temperature for their selected range.