<template>
  <div>
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
      this.$router.push({ path: '/' })
    }
  },
}
</script>

<style lang="scss">
@import '~/assets/styles.scss';
</style>
