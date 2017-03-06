
var YouTubeIframeLoader = require('youtube-iframe')
require('jquery-countdown')

var player = undefined
var done = false

function onPlayerReady(event) {
  event.target.playVideo()
  $('body').trigger('click')
}

function add_image(url, classes) {
  var img = document.createElement('img')
  img.src = url
  img.classList.add('countdown-image')
  if(classes !== undefined) {
    classes.forEach(e => img.classList.add(e))
  }

  let ecart = Math.floor(Math.random() * 250 ) -  100;
  let top = Math.floor(Math.random() * window.innerHeight - 100)
  let left = Math.floor(Math.random() * window.innerWidth - 100)
  let rotate = Math.floor(Math.random() * 90) + -90;
  img.style.top = top + 'px'
  img.style.left =  left + 'px'
  img.style.transform =  'rotate(' + rotate +'deg)'
  let parent = document.getElementsByClassName('nothing')[0]
  parent.insertBefore(img, document.getElementsByClassName('iframe-overlay')[0])
}


function boom(event) {
  document.getElementById('cuming').classList.add('techno')
}

function random_color() {
  window.setInterval(function(){
    let hex = '#'+Math.random().toString(16).substr(-6);
    hex = hex.replace('#','');
    let r = parseInt(hex.substring(0,2), 16);
    let g = parseInt(hex.substring(2,4), 16);
    let b = parseInt(hex.substring(4,6), 16);
    document.getElementsByClassName('iframe-overlay')[0].style.background = 'rgba('+r+','+g+','+b+', 0.5)';
  }, 377.358491)
}


function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING && !done) {
    setTimeout(random_color, 21400)
    setTimeout(boom, 9650)
    setTimeout(() => add_image("/images/nothing5.gif"), 3000)
    setTimeout(() => add_image("/images/loading1.png", ['rotate-lol']), 4000)
    setTimeout(() => add_image("/images/loading3.png", ['animated', 'rotateOut', 'infinite']), 8000)
    setTimeout(() => add_image("/images/illuminabite.gif"), 8000)
    setTimeout(() => add_image("/images/loading4.gif", ['techno']), 2000)
    setTimeout(() => add_image("/images/loading5.gif"), 30000)
    setTimeout(() => add_image("/images/patou.jpg", ['animated', 'lightSpeedIn', 'infinite']), 10000)
    setTimeout(() => add_image("https://media.giphy.com/media/uudNRE0I3Ehyg/giphy.gif", ['techno']), 12000)
    setTimeout(() => add_image("/images/loading5.png", ['techno']), 15000)
    setTimeout(() => add_image("/images/etbanon.png", ['animated', 'zoomInDown', 'infinite']), 15000)
    setTimeout(() => add_image("/images/loading6.png", ['animated', 'flipInY', 'infinite']), 6000)
    setTimeout(() => add_image("/images/default-profile-picture.png", ['techno']), 6000)
    setTimeout(() => add_image("/images/loading7.gif"), 8000)
    setTimeout(() => add_image("/images/loading8.gif", ['techno']), 8000)
    setTimeout(() => add_image("/images/loading9.jpg", ['animated', 'zoomOutLeft', 'infinite']), 12000)
    setTimeout(() => add_image("/images/loading10.jpg", ['animated', 'fadeInLeft', 'infinite']), 13000)
    setTimeout(() => add_image("/images/loading11.gif"), 21000)
    setTimeout(() => add_image("/images/loading12.png", ['animated', 'flipInX', 'infinite']), 23000)
    setTimeout(() => add_image("/images/loading13.gif", ['techno']), 22000)

    done = true;
  }

  if(event.data == YT.PlayerState.ENDED)
    player.seekTo(0)

}

$(function() {

  $('body').on('click', function(e) {
    player.playVideo()
  })

  $('#cuming').countdown('2017/03/07 12:0:00', function(event) {
    $(this).html(event.strftime('%-D %!D:jour,jours; %H:%M:%S') + "<br><br>  Studio is coming !");
  });

  YouTubeIframeLoader.load(function(YT) {
    player = new YT.Player('player-countdown', {
      height: '390',
      width: '640',
      videoId: 'x537Cqg5nEI',
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange
      },
      playerVars: {
       'autoplay': 1,
       'showinfo': 0,
       'controls': 0,
       'rel' : 0
      }
    })
  })
})
