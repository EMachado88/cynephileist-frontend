<template>
  <div class="app d-flex flex-column">
    <b-navbar class="is-primary">
        <template #brand>
            <b-navbar-item tag="router-link" :to="{ path: '/' }">
                Cynephileist
            </b-navbar-item>
        </template>

        <template #end>
            <b-navbar-item tag="div">
                <div class="buttons">
                    <b-button @click="logout" v-if="user">Logout</b-button>
                </div>
            </b-navbar-item>
        </template>
    </b-navbar>

    <section class="main-content flex-grow">
      <div class="container column is-10">
        <Nuxt />
      </div>
    </section>

    <footer class="footer">
      <div class="content has-text-centered">
        <p>
          ©️ 2022 Emanuel Machado. All Rights reserved.
        </p>
        <p>
          Made with ❤ in Lisbon.
        </p>
      </div>
    </footer>
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
      try {
        await this.$strapi.logout()
        this.$router.push({ path: '/' })
      } catch (message) {
        this.$buefy.toast.open({
          duration: 5000,
          message,
          position: 'is-bottom',
          type: 'is-danger'
        })
      }
    }
  },
}
</script>

<style lang="scss">
@import '~/assets/styles.scss';

.app {
  height: 100vh;
  overflow: auto;
}
</style>
