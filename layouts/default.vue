<template>
  <div>
    <nav
      class="navbar header has-shadow is-primary"
      role="navigation"
      aria-label="main navigation"
    >
      <div class="navbar-brand">
        <a class="navbar-item" href="/">
          Cynophileist
        </a>

        <b-button @click="logout" v-if="user">Logout</b-button>
        
        <div class="navbar-burger">
          <span />
          <span />
          <span />
        </div>
      </div>
    </nav>

    <section class="main-content columns">
      <div class="container column is-10">
        <Nuxt />
      </div>
    </section>
  </div>
</template>

<script>
export default {
  name: 'DefaultLayout',
  data() {
    return {
      items: [
        {
          title: 'Home',
          icon: 'home',
          to: { name: 'index' },
        },
      ],
    }
  },
  computed: {
    user() {
      return this.$strapi.user
    },
  },
  methods: {
    async logout() {
      await this.$strapi.logout()
      this.$store.commit('auth/logout')
      this.$router.push({ path: '/' })
    }
  },
}
</script>

<style lang="scss">
@import '~/assets/styles.scss';
</style>
