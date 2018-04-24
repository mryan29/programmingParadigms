// JS script should:
//		create 3 objects: Item, Label, Button
//		Item:
//			addToDocument()							adds a member variable this.item to the doc
//		Label:		inherits from Item
//			createLabel(text, id)					creates a member variable this.item that is a doc element 
//													of tag p w the attribute id set to 'id' and w the text set to 'text'
//			addClickEventHandler(handler, args)		connects the onmouseup event to the given event handler handler
//													The event handler takes a list as a parameter named args
//		use the label and button objects to create a label and button that look the same as previous assignment
//		adds a func changeText(args) that changes the laels text to your name when the button is clicked
//			the list args should be expected to be args[0] = text and args[1] = label. The args[1] label should be the Label object you created

var Item = {

	addToDocument : function() {	// adds member variable this.item to the doc
		document.body.appendChild(this.item);
	}
};

var Label = {
	
	createLabel : function(text, id) {
		this.item = document.createElement("p");
		this.item.setAttribute("id", id);
		this.item.appendChild(document.createTextNode(text));
		//this.item = document.getElementById(id);
		//this.item = text;
	},	
	setText : function(text) {
		this.item.innerHTML = text; 
	}
	
};

var Button = {
	createButton : function(text, id) {
		this.item = document.createElement("button");
		this.item.setAttribute("id", id);
		this.item.appendChild(document.createTextNode(text));
	}, 
	addClickEventHandler : function(handler, args) {
		this.item.onmouseup = function() {
			handler(args);
		};
	}

};

function changeText(args) {
	//document.getElementById("p").innerHTML = "Meg Ryan";
	args[1].setText(args[0]);
}


Button.__proto__ = Item;
Button.createButton("Click Here", "theButton");
args = [ "Meg Ryan", Label ];
Button.addClickEventHandler(changeText, args);
Button.addToDocument();
Label.__proto__ = Item;
Label.createLabel("guess who", "theLabel");
Label.addToDocument();

