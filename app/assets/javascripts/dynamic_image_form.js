App.dynamicImage = (function() {
	return {

	setBindingImage: function(src, UpdatedElemImg) {
			src.bind('change', function(e) {
				//console.log(e)
				if(e.target.files[0]) {
					if(e.target.files[0].type.startsWith('image/')) {
						var reader = new FileReader()
						reader.onload = function () {
							UpdatedElemImg.fadeOut(200, function() {
 								$(this).attr('src',reader.result).bind('onreadystatechange load', function(){
         							if (this.complete) 
         								$(this).fadeIn(500);
      							})
							})
        				}
						reader.readAsDataURL(e.target.files[0])
					}
					else {
						App.flash.warning("C'est Martinez le hacker ?", 'Seules les images sont autorisées !')
						$(src).val('');
					}
				}
			})
		},
	}
})()