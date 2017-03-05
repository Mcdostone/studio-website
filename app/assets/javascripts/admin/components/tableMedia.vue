<template>
  <table class="striped bordered highlight" id="table-media">
    <thead>
      <tr>
        <th>ID</th>
        <th>Thumbnail</th>
        <th class="useless-column">Type</th>
        <th class="useless-column">Album</th>
        <th class="useless-column">Upload</th>
        <th class="useless-column">Visible</th>
        <th class="useless-column">Mis à jour</th>
        <th></th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="medium in media">
        <td>{{medium.id}}</td>

        <td>
          <a :href="'/admin/media/' + medium.id + '/edit'">
            <img :src="medium.file.thumb.url" alt="" class="table-medium">
          </a>
        </td>

        <td class="useless-column">
          <p v-if="medium.type != undefined">
            {{medium.type.name}}
          </p>
        </td>

        <td class="useless-column">
          <p v-if="medium.album != undefined">
            {{medium.album.name}}
          </p>
        </td>

        <td class="useless-column">
          <p v-if="medium.upload != undefined">
            <a :href="'/admin/uploads/' + medium.upload">{{medium.upload.id}}</a>
          </p>
        </td>
        <td class="useless-column">
          <p v-if="!medium.visible">
            non
          </p>
        </td>

        <td class="useless-column">
          {{medium.updated_at}}
        </td>

        <td>
          <a :href="'/admin/media/' + medium.id + '/edit'">Modifier</a>
        </td>

        <td>
          <a :href="'/admin/media/' + medium.id" method="delete" data-confirm="Voulez vous supprimer ce média ?">Supprimer</a>
        </td>
      </tr>
    </tbody>
    <div id="trigger-loading" infinite-scroll-distance="50" infinite-scroll-listen-for-event v-infinite-scroll="loadMore"></div>

</table>

</template>

<script>
export default {
	data() {
		return {
			media: [],
			page: 1,
			fetchData: false,
		}
	},
	methods: {
		loadMore() {
			if(this.fetchData == false && this.page != -1) {
				this.fetchData = true
				let url = '/api' + window.location.pathname + '?page=' + this.page
				console.log('want more -> ' + url)
				this.$http.get(url).then(response => {
					if(response.body.length === 0)
						this.page = -1
					else {
						this.media = this.media.concat(response.body)
						this.page++
						this.fetchData = false
					}
				}, response => console.log(response)
				)
			}
		}
	}
}
</script>
