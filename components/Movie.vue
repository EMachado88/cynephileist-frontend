<template>
  <div class="box movie">
    <article class="media">
      <a
        :href="`https://www.imdb.com/find?q=${movie.title.toLowerCase().replace(' ', '+')}`"
        target="_blank" 
        class="media-left"
      >
        <figure class="image is-64x64">
          <img v-if="movie.poster_path" :src="`https://image.tmdb.org/t/p/original${movie.poster_path}`" alt="Image">
        </figure>
      </a>
      <div class="media-content">
        <div class="content">
          <a
            :href="`https://www.imdb.com/find?q=${movie.title.toLowerCase().replace(' ', '+')}`"
            target="_blank" 
          >
            <p>
              <strong>{{ movie.original_title }}</strong> <small v-if="movie.original_title !== movie.title">{{ movie.title }}</small>
              <br>
              {{ movie.overview }}
            </p>
          </a>
          <div class="d-flex align-center">
            <a
              :href="`https://www.imdb.com/find?q=${movie.title.toLowerCase().replace(' ', '+')}`"
              target="_blank"
              class="d-flex align-center"
            >
              <IMDBLogo />
              &nbsp;{{ movie.vote_average }}
            </a>
            <div class="flex-grow text-right">
              <b-button
                v-if="add"
                icon-left="content-save"
                class="is-success"
                @click="addMovie(movie)"
              >
                Add
              </b-button>

              <b-button
                v-else
                icon-left="delete"
                class="is-danger"
                @click="removeMovie(movie)"
              >
                Remove
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
</template>

<script>
export default {
  name: 'MovieComponent',
  props: {
    movie: {
      type: Object,
      default: {},
    },
    add: {
      type: Boolean,
      defaul: false,
    },
    addMovie: {
      type: Function,
      default: () => {},
    },
    removeMovie: {
      type: Function,
      default: () => {},
    }
  },
}
</script>

<style lang="scss">
.movie a {
  color: #363636;

  &:hover {
    color: #7957d5;
  }
}
</style>
