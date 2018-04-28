// Use the new operator to create objects from the Label and Button functions to
//		create a label and button that look the same as the previous assignment.
//  Modify changeText(args) so that it no longer gets the text as a parameter input,
//		and instead gets the text from an asynchronous GET to
//		ash.campus.nd.edu:40001/movies/32. The list args should be expected to be
//		args[0] = label. The args[0] label should be the Label object you created.


mid = 56	// preassigned mid
uid = 15	// assigned arbitrarily

/* function definitions */

function changeText(args) {
	var xhr1 = new XMLHttpRequest();
	xhr1.open("GET", "http://ash.campus.nd.edu:40001/movies/" + mid, true);
	xhr1.onload = function(){
		args[0].setText(xhr.responseText);
	}
	xhr1.onerror = function() { 
		console.error(xhr.statusText);
	}
	xhr1.send(null);
	
	var xhr2 = new XMLHttpRequest();
	xhr2.open("GET", "http://ash.campus.nd.edu:40001/ratings/" + mid, true);
	xhr2.onload = function(){
		args[0].setText(xhr.responseText);
	}
	xhr2.onerror = function() { 
		console.error(xhr.statusText);
	}
	xhr2.send(null);
}

function sendVote(voteArgs) {
	var xhr3 = new XMLHttpRequest();
	xhr3.open("PUT", "http://ash.campus.nd.edu:40001/recommendations/" + uid, true);
	xhr3.send(JSON.stringify({
		"movie_id": mid, 
		"rating":voteArgs[2].getSelected(), 
		"apikey":"q902dt4F2X"
	}));
	xhr3.onload = function() {
		changeText([voteArgs[0], voteArgs[1]]);
	};
}

// movie label
movieLabel = new Label();
movieLabel.createLabel("Which movie?", "movieLabel");
movieLabel.addToDocument();

// ratings label
ratingLabel = new Label();
ratingLabel.createLabel("", "ratingLabel");
ratingLabel.addToDocument();

// dropdown
theDropdown = new Dropdown();
rating = {
	1:"Just plain bad", 
	2:"Not so good", 
	3:"OK I guess", 
	4:"Pretty good", 
	5:"Awesome"
};
theDropdown.createDropdown(rating, "theDropdown", 3);
theDropdown.addToDocument();

// vote button
voteButton = new Button();
voteButton.createButton("Vote", "voteButton");
voteButton.addClickEventHandler(sendVote, [args[0], args[1], theDropdown]);
voteButton.addToDocument();


//Label.prototype = new Item();
theLabel = new Label();
theLabel.createLabel("who?", "theLabel");
theLabel.addToDocument();

//args = ["Meg Ryan", theLabel];
args = [movieLabel, ratingLabel];

//Button.prototype = new Item();
theButton = new Button();
theButton.createButton("Click Here", "theButton");
theButton.addClickEventHandler(changeText, args);
theButton.addToDocument();




