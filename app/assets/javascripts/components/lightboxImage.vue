<template>
	<div @click.stop >
		<img :src="src"  :key="src" :style="style"/>
	</div>
</template>


<script>

export default {
	data() {
		return {
			src: false,
			style: {}
		}
	},
	props: {
		image: ''
	},
	mounted() {
		let m = new window.Image()
		this.resizeEvent = () =>  this.resize(m)

		this.loadingIcon = 'loading' + Math.floor((Math.random() * 3) + 1)
		m.onload = () => {
			this.src = m.src
			this.resize(m)
		}
		m.src = this.image.file.url
		window.addEventListener('resize', this.resizeEvent)
	},
	destroyed() {
		window.removeEventListener('resize', this.resizeEvent)
	},
	methods: {
		resize(m) {
			let width = m.width
			let height = m.height
			if(width > window.innerWidth || height >  window.innerHeight) {
				let ratioWindow = window.innerWidth / window.innerHeight
				let ratioMedium = width / height
				if(ratioMedium > ratioWindow) {
					width = window.innerWidth
					height = width / ratioMedium
				}
				else {
					height = window.innerHeight
					width = height * ratioMedium
				}
			}
			this.style = {
				width: width + 'px',
				height: height + 'px',
				top: ((window.innerHeight - height) * 0.5)  + 'px',
				left: ((window.innerWidth - width) * 0.5)  + 'px'
			}
		}
	}
}
</script>
