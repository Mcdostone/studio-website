class LightboxStore {

	constructor() {
		this.state = {
			medias: [],
			index: false
		}
	}

	addMedia(url) {
		return this.state.medias.push(url)
	}

	load(i) {
		this.state.index = i
	}

	remove(m) {
		this.state.medias = this.state.images.filter(medium => medium  !== m)
	}

	close() {
		this.state.index = false
	}
}


export default new LightboxStore()
