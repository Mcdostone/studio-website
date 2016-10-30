'use strict';

var developerKey = 'AIzaSyA8_QjUyHp0NE4R2_5onUuelT3WbzM8EhQ'
var clientId 	= "956580412485-bduqk76b51lv7nt9cs9dr98hff6evii4.apps.googleusercontent.com"
var scope 		= ['https://www.googleapis.com/auth/drive.readonly','https://www.googleapis.com/auth/drive']
var appId		= "956580412485"


var pickerApiLoaded = false
var oauthToken

// Use the API Loader script to load google.picker and gapi.auth.
function onApiLoad() {
	gapi.load('auth', {'callback': onAuthApiLoad})
	gapi.load('picker', {'callback': onPickerApiLoad})
}

function onAuthApiLoad() {
window.gapi.auth.authorize({
	'client_id': clientId,
	'scope': scope,
	'login_hint': email,
	'immediate': false },
	handleAuthResult)
}

function onPickerApiLoad() {
	pickerApiLoaded = true
	createPicker()
}

function handleAuthResult(authResult) {
	if (authResult && !authResult.error) {
		oauthToken = authResult.access_token
		createPicker()
	}
}

// Create and render a Picker object for picking user Photos.
function createPicker() {
	if (pickerApiLoaded && oauthToken) {
		let acceptedFiles = "image/png,image/jpeg,image/jpg,image/gif,image/svg+xml"
		acceptedFiles = acceptedFiles + "video/mp4,video/quicktime,video/x-ms-wmv,video/x-msvideo,video/x-flv,video/webm,video/mpeg,application/pdf"
		var view = new google.picker.DocsView().setIncludeFolders(true)
		.setOwnedByMe(true)
		.setSelectFolderEnabled(true)
		//stud folder
		.setParent("0B3RcUBU3GDgbSXpwc3haZi0wU0k")
		.setMimeTypes(acceptedFiles)
		
		
		var picker = new google.picker.PickerBuilder()
		.addView(view)
		.enableFeature(google.picker.Feature.NAV_HIDDEN)
		.enableFeature(google.picker.Feature.MULTISELECT_ENABLED)
		.setOAuthToken(oauthToken)
		.setDeveloperKey(developerKey)
		.setCallback(pickerCallback)
		.build()
		
		picker.setVisible(true)
	}
}

function pickerCallback(data) {
	if (data[google.picker.Response.ACTION] == google.picker.Action.PICKED) {
		sendMedias(data.docs)
		picker.setVisible(false)
	}
}

function sendMedias(picked) {
	var xhr = new XMLHttpRequest()
	var token = document.querySelector("meta[name='csrf-token']").content;
	xhr.open('POST', '/media', true)
	xhr.setRequestHeader("X-CSRF-Token", token)
	xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8')

	xhr.onreadystatechange = function() {
		if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0))
			callbackServer(xhr.responseXML)
	}

	picked = {media: picked}
	xhr.send(JSON.stringify(picked))
}


function callbackServer(response) {
	console.log(response)
}

function openDrive() {
	onApiLoad()
}