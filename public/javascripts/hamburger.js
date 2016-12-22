'use strict'

window.onload = function(e) {
	let nav = document.querySelector('.nav')
	let navParent = document.getElementsByTagName('nav')[0]
	let hamburger = document.querySelector('.nav-hamburger')

	hamburger.addEventListener('click', (e) => 
		nav.classList.toggle('hidden')
	)
	document.body.addEventListener('click', (e) => {
		if(!navParent.contains(e.target) || nav.contains(e.target))
			nav.classList.add('hidden')
	})
}