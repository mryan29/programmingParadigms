// Use the new operator to create objects from the Label and Button functions to
//		create a label and button that look the same as the previous assignment.
//  Modify changeText(args) so that it no longer gets the text as a parameter input,
//		and instead gets the text from an asynchronous GET to
//		ash.campus.nd.edu:40001/movies/32. The list args should be expected to be
//		args[0] = label. The args[0] label should be the Label object you created.

function changeText(args) {
	var xhr = new XMLHttpRequest();
	xhr.open("GET", "http://ash.campus.nd.edu:40001/movies/32", true);
	/*xhr.onload = function(e) {
		var res = xhr.responseText;
		args[0].setText(res); */
	xhr.onload = function(){
		l.setText(xhr.responseText);
	}
	xhr.onerror = function() { 
		console.error(xhr.statusText);
	}
	xhr.send(null);
}

Label.prototype = new Item();
theLabel = new Label();
theLabel.createLabel("who?", "theLabel");
theLabel.addToDocument();

args = ["Meg Ryan", theLabel];

Button.prototype = new Item();
theButton = new Button();
theButton.createButton("Click Here", "theButton");
theButton.addClickEventHandler(changeText, args);
theButton.addToDocument();




