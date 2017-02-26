var ActionCable = require('actioncable')

module.exports = (function() {
  let finished = false
  let url = ''
  let App = {}

  return {
    isFinished: function() {
      return finished
    },

    getUrl: function() {
      return url
    },

    init: function(uploads) {
      App.cable = ActionCable.createConsumer();
      App.cable.subscriptions.create("UploadProgressChannel", {
        connected: function() {
        },

        disconnected: function() {
        },

        received: function(data) {
          switch(data.task) {
            case 's3':
              uploads.desc('Traitement des images - Upload sur AWS S3')
              break
            case 'upload':
              uploads.increaseNbFilesUploaded()
              break
            case 'end':
              if(uploads.getDropzone().getQueuedFiles().length > 0)
                loads.desc('Upload sur le serveur TN.net')
              else {
                finished = true
                window.location = data.url;
              }
              break
          }
          uploads.refresh()
        }
      })
    }
  }
})()
