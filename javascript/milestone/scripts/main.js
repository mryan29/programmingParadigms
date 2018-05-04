// javascript milestone
//  Display a movie recommendation for a given user, including the title, poster image, and score for that movie.

mid = 56	// preassigned mid
uid = 15	// assigned arbitrarily

/* function definitions */

// An “up” button which submits a vote of 5 for the movie.
function onUp() {
	var recom = { "movie_id" : mid.toString(), "rating" : "5" };
	console.log("Send PUT request: " + mid.toString())
	recom = JSON.stringify(recom);

	var xhr = new XMLHttpRequest();
	xhr.open("PUT", "http://ash.campus.nd.edu:40001/recommendations/" + uid.toString(), true);

	xhr.onload = function(e) {
		console.log(xhr.responseText);
		getNextMovie();
	}
	xhr.onerror = function(e) {
		console.error(xhr.statusText);
	}
	xhr.send(recom);
}

//  A “down” button which submits a vote of 1 for the movie.
function onDown() {
	var recom = { "movie_id" : mid.toString(), "rating" : "1" }
	console.log("Send PUT request: " + mid.toString());
	recom = JSON.stringify(recom);

	var xhr = new XMLHttpRequest();
	xhr.open("PUT", "http://ash.campus.nd.edu:40001/recommendations/" + uid.toString(), true);

	xhr.onload = function(e) {
		console.log(xhr.responseText);
		getNextMovie();
	}
	xhr.onerror = function(e) {
		console.error(xhr.statusText);
	}
	xhr.send(recom);
}

function getNextMovie() {
	var rec;
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "http://ash.campus.nd.edu:40001/recommendations/" + uid.toString(), true);

	xhr.onload = function(e) {
		var res = JSON.parse(xhr.responseText);
		mid = res["movie_id"];
		setMovie();
		setRecommendation();	
	}
	xhr.onerror = function(e) {
		console.error(xhr.statusText);
	}
	xhr.send(null);
}


function setMovie() {
	
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "http://ash.campus.nd.edu:40001/movies/" + mid.toString(), true);
	
	xhr.onload = function(e) {
		var res = JSON.parse(xhr.responseText);
		title.setText(res["title"]);
		movieImage.setImage(res["img"]);
	}
	xhr.onerror = function(e) {
		console.error(xhr.statusText);
	}
	xhr.send(null);	
}


function setRecommendation() {
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "http://ash.campus.nd.edu:40001/ratings/" + mid.toString(), true);
	xhr.onload = function(e) {
		var res = JSON.parse(xhr.responseText);
		//res.toFixed(3);
		rating.setText(res["rating"].toFixed(3));	// .toFixed sets decimal places
	}
	xhr.onerror = function(e) {
		console.error(xhr.statusText);
	}
	xhr.send(null);	
}


// create objects and add to doc
title = new Label();
title.createLabel("title", "title");
title.addToDocument();

rating = new Label();
rating.createLabel("rating", "rating");
rating.addToDocument();

movieImage = new Image();
movieImage.createImage("movieImage");
movieImage.addToDocument();

upButton = new Button();
upButton.createButton("UP", "up");
upButton.addToDocument();

downButton = new Button();
downButton.createButton("DOWN", "down");
downButton.addToDocument();

getNextMovie();
args = []
upButton.addClickEventHandler(onUp, args);
downButton.addClickEventHandler(onDown, args);

divTitle = new Division();
divTitle.createDiv("divTitle");
divTitle.addToDocument();
divTitle.appendLabel(title);

divRating = new Division();
divRating.createDiv("divRating");
divRating.addToDocument();
divRating.appendLabel(rating);




