// function definitions for three objects: Label, Button, Item
// add Dropdown function which inherits from Item, with two functions:
//		createDropdown(dict, id, selected) where dict is a dictionary with the value/text
//			pairs, id is the id attribute of the dropdown, and selected is the value of the default
//			selected option.
//		getSelected() which returns the value of the currently selected option in the dropdown
//			box.


/* function definitions */
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

function Dropdown() {
	this.createDropdown = function(dict, id, selected) {
		this.item = document.createElement("select");
		for (var key in dict) {
			opt = document.createElement("option");
			opt.value = key;
			opt.textContent = dict[key];
			if (key == selected) {
				opt.selected = "selected";
			}
			this.item.appendChild(opt);
		};
		this.item.setAttribute("id", id);
	},
	this.getSelected = function() {
		return this.item.value
	}
}

Button.prototype = new Item();
Label.prototype = new Item();
Dropdown.prototype = new Item();

