class LightboxStore {

	constructor() {
		this.state = {
			medias: [],
			index: false,
			cache: []
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

	getNextIndex() {
		return (this.state.index == this.state.medias.length - 1) ? 0 : this.state.index + 1
	}

	addToCache(id, toCache) {
			this.state.cache['/api/media/' + id] = toCache
			console.log(this.state.cache)
	}

	isCached(url) {
		return this.state.cache[url] != undefined
	}

	getMediaFromCache(url) {
		if(this.isCached(url))
			return this.state.cache[url]
	}
}

export default new LightboxStore()
