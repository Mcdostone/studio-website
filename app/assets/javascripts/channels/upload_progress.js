App.upload_progress = App.cable.subscriptions.create("UploadProgressChannel", {
  
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
  	switch(data.task) {
  		case 's3': 
        desc.text('Traitement des images - Upload sur AWS S3')
  			break
  		case 'upload':
  			App.uploads().increaseNbFilesUploaded()
  			break
  		default:
				if(App.uploads.dropzone.getQueuedFiles().length > 0)
  					App.uploads().desc('Upload sur le serveur TN.net')
		}
  	
  	App.uploads.refresh()
  }

})