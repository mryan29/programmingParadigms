// function definitions for three objects: Label, Button, Item

function Item() {
	this.addToDocument = function() {
		document.body.appendChild(this.item);
	}
}

function Label() {
	this.createLabel = function(text, id) {
		this.item = document.createElement("p");
		var text = document.createTextNode(text);
		this.item.setAttribute("id", id);
		//this.item.appendChild(document.createTextNode(text));
		this.item.appendChild(text);
	},
	this.setText = function(text) {
		this.item.innerHTML = text;
	}	
}


function Button() {
	this.createButton = function(text, id) {
		this.item = document.createElement("button");
		this.item.setAttribute("id", id);
		//this.item.appendChild(document.createTextNode(text));
		this.item.innerHTML = text;
	},
	this.addClickEventHandler = function(handler, args) {
		this.item.onmouseup = function() {
			handler(args);
		};
	}
}

Button.prototype = new Item();
Label.prototype = new Item();

