<template>
  <div class="content">
    <div class="box">
      <b-field>
        <b-input
          placeholder="Search by movie title"
          v-model="searchQuery"
          icon="movie"
        />
      </b-field>
    </div>

    <div
      v-for="movie in movieResults"
      :key="movie.id"
      class="box"
    >
      <article class="media">
        <div class="media-left">
          <figure class="image is-64x64">
            <img :src="`https://image.tmdb.org/t/p/original${movie.poster_path}`" alt="Image">
          </figure>
        </div>
        <div class="media-content">
          <div class="content">
            <p>
              <strong>{{ movie.original_title }}</strong> <small v-if="movie.original_title !== movie.title">{{ movie.title }}</small>
              <br>
              {{ movie.overview }}
            </p>
            <div class="d-flex align-center">
              <IMDBLogo />
              &nbsp;{{ movie.vote_average }}
              <div class="flex-grow text-right">
                <b-button icon-left="content-save" button class="is-success">
                  Add
                </b-button>
              </div>
            </div>
          </div>
          <nav class="level is-mobile">
            <div class="level-left">
              <a class="level-item" aria-label="reply">
                <span class="icon is-small">
                  <i class="fas fa-reply" aria-hidden="true"></i>
                </span>
              </a>
              <a class="level-item" aria-label="retweet">
                <span class="icon is-small">
                  <i class="fas fa-retweet" aria-hidden="true"></i>
                </span>
              </a>
              <a class="level-item" aria-label="like">
                <span class="icon is-small">
                  <i class="fas fa-heart" aria-hidden="true"></i>
                </span>
              </a>
            </div>
          </nav>
        </div>
      </article>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MoviesPage',
  middleware: 'auth',
  data() {
    return {
      searchQuery: '',
      movieResults: []
    }
  },
  watch: {
    async searchQuery() {
      if (this.searchQuery.length) {
        const { data } = await this.$axios.get(`https://api.themoviedb.org/3/search/movie?query=${this.searchQuery}&api_key=${process.env.tmdbApiKey}`)
        this.movieResults = data.results
        console.log(this.movieResults)
      } else {
        this.movieResults = []
      }
    }
  }
}
</script>
