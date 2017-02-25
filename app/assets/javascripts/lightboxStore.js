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

	next() {
		this.state.index = (this.state.index == this.state.medias.length - 1) ? 0 : this.state.index + 1
	}

	previous() {
		this.state.index = (this.state.index == 0) ? this.state.medias.length - 1 : this.state.index - 1
	}
}

export default new LightboxStore()
