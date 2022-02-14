<template>
  <div class="content">
    <div class="box">
      <b-field>
        <b-input
          placeholder="Search by movie title"
          v-model="searchQuery"
          icon="movie"
          :icon-right="searchQuery && 'close-box'"
          icon-right-clickable
          @icon-right-click="clearQuery"
        />
      </b-field>
    </div>

    <Movie
      v-for="movie in movieResults"
      :key="movie.id"
      :movie="movie"
      :add="!Boolean(savedMovies.find(savedMovie => savedMovie.title === movie.title))"
      :addMovie="addMovie"
      :removeMovie="removeMovie"
    />

    <Movie
      v-for="movie in savedMovies"
      :key="movie.id"
      :movie="movie"
      :addMovie="addMovie"
      :removeMovie="removeMovie"
    />

    <h1 v-if="!savedMovies.length && !movieResults.length" class="text-center">
      Add your first movie or search
    </h1>
  </div>
</template>

<script>
export default {
  name: 'MoviesPage',
  middleware: 'auth',
  data() {
    return {
      searchQuery: '',
      movieResults: [],
      savedMovies: [],
    }
  },
  watch: {
    async searchQuery() {
      if (this.searchQuery.length) {
        const { data } = await this.$axios.get(`https://api.themoviedb.org/3/search/movie?query=${this.searchQuery}&api_key=${process.env.tmdbApiKey}`)
        this.movieResults = data.results
      } else {
        this.movieResults = []
      }
    }
  },
  created() {
    this.fetchSavedMovies()  
  },
  methods: {
    async fetchSavedMovies() {
      try {
        const movies = await this.$strapi.$movies.find()
        this.savedMovies = movies
      } catch (error) {
        alert(error)
      }
    },
    async addMovie(movie) {
      const { title, original_title, overview, poster_path, vote_average } = movie

      try {
        await this.$strapi.$movies.create({
          title,
          original_title,
          overview,
          poster_path,
          vote_average,
        })
        this.fetchSavedMovies()
      } catch (error) {
        alert(error)
      }
    },

    async removeMovie(movie) {
      const savedMovie = this.savedMovies.find(savedMovie => savedMovie.title === movie.title)

      try {
        await this.$strapi.$movies.delete(savedMovie.id)
        this.fetchSavedMovies()
      } catch (error) {
        alert(error)
      }
    },

    clearQuery() {
      this.searchQuery = ''
    },
  },
}
</script>
