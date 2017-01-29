let AUTH_TOKEN = $('meta[name="csrf-token"]').attr('content')

let form = $('form')
let action = form.attr('action')
let nbFiles = 0
let submit = $('.button')
let parallelUploads = 5


submit.addClass('disabled')
submit.attr('disabled', 'disabled')
Dropzone.autoDiscover = false

Dropzone.prototype.getActiveFiles = function() {
	var file, _i, _len, _ref, _results;
	_ref = this.files;
	_results = [];
	for (_i = 0, _len = _ref.length; _i < _len; _i++) {
		file = _ref[_i];
		_results.push(file);
	}
	return _results;
}      

form.off('submit')


let progressBarContainer = $('<div/>')

progressBarInfos.addClass('progress-bar-content')
//let progressBar = $('<div/>')

//let percent = $('<p/>')
let close = $('<div/>').text('Fermer').addClass('button button-close').toggleClass('invisible')
progressBarInfos.append(percent)
progressBarInfos.append(desc)
progressBarInfos.append(close)
progressBar.addClass('progress-bar')
progressBarContainer.addClass('progress-bar-container')
progressBarContainer.append(progressBar)
progressBarContainer.append(progressBarInfos)
progressBarContainer.hide()
progressBarContainer.insertAfter(document.body)

studioDropzone = new Dropzone('div#studio-dropzone', { 
	url: action,
	autoProcessQueue: false,
	uploadMultiple: true,
	dictDefaultMessage: 'Uploader des media',
	paramName: 'admin_upload[media]',
	addRemoveLinks: true,
	parallelUploads: parallelUploads,
	acceptedFiles: 'image/*,audio/*,application/pdf,.CR2',
	maxFilesize: 100,
	params:{
		'authenticity_token':  AUTH_TOKEN
	},
	init: function() {
		this.on("sending", (file, xhr, formData) => {
		 		formData.append('admin_upload[event]', $('#admin_upload_event').val())
		 		formData.append('admin_upload[type]', $('#admin_upload_type').val())
			}
		)},
	successmultiple: (data,response) => {}
})



studioDropzone.on('completemultiple', function(files) {
	if(studioDropzone.getQueuedFiles().length > 0)
		studioDropzone.processQueue()
})

studioDropzone.on('successmultiple', function(file, res) {
	filesUploaded+= res.nbUploaded
})

studioDropzone.on('addedfile', function(file) {
	if(studioDropzone.getQueuedFiles().length + 1 > 0) {
		submit.removeClass('disabled')
		submit.removeAttr('disabled')
	}
})

studioDropzone.on('removedfile', function(file) {
	if(studioDropzone.getQueuedFiles().length  == 0) {
		submit.addClass('disabled')
		submit.attr('disabled', 'disabled')
	}
})

studioDropzone.on('queuecomplete', function() {
	console.log('finished')
	studioDropzone.removeAllFiles()
	progressBarContainer.removeClass('fadeIn')
	close.toggleClass('invisible')
	close.on('click', e => progressBarContainer.fadeOut(300, () => progressBarContainer.hide()))
})

studioDropzone.on('totaluploadprogress', (per, r, a) => {
	percentUpload = per
	console.log(percentUpload)
	App.upload_progress.refresh()
})

form.submit(e => {
	if(studioDropzone.getQueuedFiles().length > 0) {
		nbFiles = studioDropzone.getActiveFiles().length
		progressBarContainer.show()
		progressBarContainer.fadeIn(500)
		desc.text('Upload sur le serveur TN.net')
		close.addClass('invisible')
		e.preventDefault()
		studioDropzone.processQueue()
	}
})
