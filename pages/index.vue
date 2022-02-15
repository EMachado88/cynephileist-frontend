<template>
  <section class="section">
    <div class="columns is-mobile">
      <div class="card column is-10 is-offset-1">
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
              <b-input v-model="password" type="password" password-reveal />
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
  middleware({ $strapi, redirect }) {
    if($strapi.user) {
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

        this.$router.push({ path: '/movies' })
      } catch (message) {
        this.$buefy.toast.open({
          duration: 5000,
          message,
          position: 'is-bottom',
          type: 'is-danger'
        })
      }
    },
  }
}
</script>
