//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

let filesUploaded = 0
let percentUpload = 0
let progressBar = $('<div/>')
let percent = $('<p/>')
let progressBarInfos = $('<div/>')
let desc = $('<span/>')
let studioDropzone = undefined