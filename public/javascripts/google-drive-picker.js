var developerKey = 'AIzaSyCXoMWHBdKZL-Dci0XCGoGMEy_X83-n-Oc';
var clientId = "956580412485-bduqk76b51lv7nt9cs9dr98hff6evii4.apps.googleusercontent.com"
var appId = "1234567890";
var scope = ['https://www.googleapis.com/auth/drive'];
var acceptedFiles = "image/png,image/jpeg,image/jpg,image/gif,image/svg+xml,video/mp4,video/quicktime,video/x-ms-wmv,video/x-msvideo,video/x-flv,video/webm,video/mpeg,application/pdf"

var pickerApiLoaded = false;
var oauthToken;

// Use the Google API Loader script to load the google.picker script.
function loadPicker() {
	gapi.load('auth', {'callback': onAuthApiLoad});
	gapi.load('picker', {'callback': onPickerApiLoad});
	gapi.client.load('drive', 'v2', null);
}

function onAuthApiLoad() {
	window.gapi.auth.authorize(
	{
		'client_id': clientId,
		'scope': scope,
		'login_hint': email,
        'immediate': false
	},
	handleAuthResult);
}

function onPickerApiLoad() {
	pickerApiLoaded = true;
	createPicker();
}

function handleAuthResult(authResult) {
	if (authResult && !authResult.error) {
		oauthToken = authResult.access_token;
		createPicker();
    }
}

// Create and render a Picker object for searching images.
function createPicker() {
	if (pickerApiLoaded && oauthToken) {
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

var log = function(e) {
	console.log(e)
}

function pickerCallback(data) {
	if (data.action == google.picker.Action.PICKED) {		
		var media = [];
		for (let i = 0; i < data.docs.length; i++) {
			let medium = {}
			medium.id_file = data.docs[i].id
			console.log(data.docs[i].id)
			
			getInfosFile(medium, function(res) {
//				console.log(res)
				medium.thumbnail_url = res.thumbnailLink
				media.push(medium)
				if(i == data.docs.length - 1)
					sendData(media)
		})}
	}
}

function sendData(media) {
	console.log(media)
	$.ajax({
		type: "POST",
		url: '/admin/media',
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		data: {'media': JSON.stringify(media)},
		success: log,
		error: log,
		dataType: 'json'
	})
}

function getInfosFile(medium, callback) {
	var request = gapi.client.drive.files.get({
		'fileId': medium.id_file
	});
  	request.execute(callback)
}

function test() {
	loadPicker()
}