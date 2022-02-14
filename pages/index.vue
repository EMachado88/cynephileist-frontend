<template>
  <section class="section">
    <div class="columns is-mobile">
      <div class="card">
        <header class="card-header">
          <p class="card-header-title">
            Login
          </p>
        </header>

        <div class="card-content">
          <form @submit="handleLogin">
            <b-field label="Email">
              <b-input v-model="identifier" type="email" />
            </b-field>

            <b-field label="Password">
              <b-input v-model="password" type="password" />
            </b-field>

            <b-button native-type="submit" type="is-primary">Submit</b-button>
          </form>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'IndexPage',
  data() {
    return {
      identifier: '',
      password: ''
    }
  },
  middleware({ store, redirect }) {
    if(store.state.auth.loggedIn) {
      return redirect('/movies')
    }
  },
  methods: {
    async handleLogin(event) {
      event.preventDefault()

      const { identifier, password } = this
      
      try {
        await this.$strapi.login({
          identifier,
          password
        })

        this.$store.commit('auth/login')

        this.$router.push({ path: '/movies' })
      } catch (error) {
        alert(error)
      }
    },
  }
}
</script>
