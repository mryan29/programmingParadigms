// javascript milestone


/* function definitions */
function Item() {
	this.addToDocument = function() {
		document.body.appendChild(this.item);
	}
}

function Label() {
	this.createLabel = function(text, id) {
		this.item = document.createElement("p");
		this.item.setAttribute("id", id);
		this.item.appendChild(document.createTextNode(text));
	},
	this.setText = function(text) {
		this.item.innerHTML = text;
	}	
}


function Button() {
	this.createButton = function(text, id) {
		this.item = document.createElement("button");
		this.item.setAttribute("id", id);
		this.item.appendChild(document.createTextNode(text));
	},
	this.addClickEventHandler = function(handler, args) {
		this.item.onmouseup = function() {
			handler(args);
		}
	}
}

function Image() {
	this.createImage = function(src, id) {
		this.item = document.createElement("img");
		this.item.setAttribute("id", id);
		this.item.setAttribute("src", src);
	},
	this.setImage = function(src) {
		this.item.setAttribute("src", "https://www3.nd.edu/~cmc/teaching/cse30332/images/" + src);	
	}
}

function Division() {
	this.createDiv = function(id) {
		this.item = document.createElement("div");
		this.item.setAttribute("id", id);
	},
	this.appendLabel = function(Label) {
		this.item.appendChild(Label.item);
	},
	this.appendButton = function(Button) {
		this.item.appendChild(Button.item);
	}, 
	this.appendImage = function(Image) {
		this.appendChild(Image.item);
	}
}

/* prototypes */

Button.prototype 	= new Item();
Label.prototype 	= new Item();
Image.prototype 	= new Item();
Division.prototype 	= new Item();
