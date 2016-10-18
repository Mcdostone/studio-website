'use strict'


let toggleMenu = function(e) {
	var navList = document.querySelector('.nav');
//	alert("in togglemenu");
	document.querySelector('.nav').classList.toggle('hidden');
}

window.onload = function(e) {
	document.querySelector('.nav-container-hamburger').addEventListener('click', toggleMenu);
	document.addEventListener('turbolinks:click', function(e) {
		console.log(e)
		if(event.target.getAttribute('href').charAt(0) === '#') {
			e.preventDefault()
		}
	})
}