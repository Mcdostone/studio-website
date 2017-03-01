require('materialize-css')
var Dropzone = require('dropzone')
Dropzone.autoDiscover = false
let AUTH_TOKEN = $('meta[name="csrf-token"]').attr('content')

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

var uploads = (function() {
	let form = $('#media form')
	let action = form.attr('action')
	let nbFiles = 0
	let submit = $('#media .btn')
	let progressBarContainer = ''
	let parallelUploads = 100
	let filesUploaded = 0
	let percentUpload = 0
	let progressBar = $('<div/>')
	let percent = $('<p/>')
	let progressBarInfos = $('<div/>')
	let desc = $('<span/>')
	let studioDropzone = undefined

	let initDropzone = function() {
		studioDropzone = new Dropzone('div#studio-dropzone', {
			url: action,
			autoProcessQueue: false,
			uploadMultiple: true,
			maxFiles: parallelUploads,
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
		 			formData.append('admin_upload[type_id]', $('#upload_type_id').val())
		 			formData.append('admin_upload[album_id]', $('#upload_album_id').val())
				}
			)},
			successmultiple: (data,response) => {}
		})
	}

	return {
		getDropzone: function() {
			return studioDropzone
		},

		refresh: function() {
  			let p1 = Math.floor((100 * filesUploaded / nbFiles) / 2)
    		let p2 = Math.floor(percentUpload/ 2)

    		let percentValue = p1 + p2 > 100 ? 100 : p1 + p2
    		uploads.setProgressBar(percentValue)
    		percent.text(percentValue + '%')
    		if(nbFiles == filesUploaded)
      			desc.text('Upload terminé')
  		},

		nbFiles: function() {
			return nbFiles
		},

		percentUpload: function() {
			return percentUpload
		},
		setProgressBar: function(percent) {
			progressBar.css('right', (100 - percent) + '%')
			return progressBar
		},

		percent: function() {
			return percent
		},

		desc: function(msg) {
			desc.text(msg)
		},

		increaseNbFilesUploaded: function() {
			filesUploaded++
		},

		init: function() {
			submit.addClass('disabled')
			submit.attr('disabled', 'disabled')
			Dropzone.autoDiscover = false
			form.off('submit')
			progressBarContainer = $('<div/>')
			progressBarInfos.addClass('progress-bar-content')
			let close = $('<div/>').text('Fermer').addClass('btn').toggleClass('invisible')
			progressBarInfos.append(percent)
			progressBarInfos.append(desc)
			progressBarInfos.append(close)
			progressBar.addClass('progress-bar')
			progressBarContainer.addClass('progress-bar-container')
			progressBarContainer.append(progressBar)
			progressBarContainer.append(progressBarInfos)
			progressBarContainer.hide()
			progressBarContainer.insertAfter(document.body)

			initDropzone()

			studioDropzone.on('completemultiple', function(files) {
				if(studioDropzone.getQueuedFiles().length > 0)
					studioDropzone.processQueue()
			})

			//studioDropzone.on('successmultiple', function(file, res) {})

			studioDropzone.on('addedfile', function(file) {
				if(studioDropzone.getQueuedFiles().length + 1 > 0) {
					submit.removeClass('disabled')
					submit.removeAttr('disabled')
				}
			})

			studioDropzone.on('removedfile', function(file) {
				if(studioDropzone.getActiveFiles().length  == 0) {
					submit.addClass('disabled')
					submit.attr('disabled', 'disabled')
				}
			})

			studioDropzone.on('maxfilesexceeded', function(file) {
				this.removeFile(file)
			})

			studioDropzone.on('queuecomplete', function() {

				studioDropzone.removeAllFiles()
				progressBarContainer.removeClass('fadeIn')
				uploads.refresh(true)
				desc.text('En attente de réponse du serveur @TN.net')
			})

			studioDropzone.on('totaluploadprogress', (per, r, a) => {
				percentUpload = per
				uploads.refresh()
			})

			form.submit(e => {
				if(studioDropzone.getActiveFiles().length  > 0) {
					nbFiles = studioDropzone.getActiveFiles().length
					progressBarContainer.show()
					progressBarContainer.fadeIn(500)
					desc.text('Upload sur le serveur TN.net')
					close.addClass('invisible')
					e.preventDefault()
					studioDropzone.processQueue()
					console.log(form)
				}
			})
		}
	}
})()


$(function() {
	$('select').material_select();
	uploads.init()
	var channel = require('../channels/upload_progress')
	channel.init(uploads)
})
