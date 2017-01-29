App.upload_progress = App.cable.subscriptions.create("UploadProgressChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
  	switch(data.task) {
  		case 's3': 
			desc.text('Traitement des images - Upload sur AWS S3')
  			break
  		case 'upload':
  			filesUploaded++
  			break
  			default:
				if(studioDropzone.getQueuedFiles().length > 0)
  					desc.text('Upload sur le serveur TN.net')
		}
  	
  	this.refresh()
  },

  refresh: function() {
  	p1 = Math.floor((100 * filesUploaded / nbFiles) / 2)
	p2 = Math.floor(percentUpload/ 2)
	
	percentValue = p1 + p2 > 100 ? 100 : p1 + p2 
	progressBar.css('right', (100 - percentValue) + '%')
	percent.text(percentValue + '%')
  }

})
