<template>
  <v-app>
    <MainMenu v-if="shouldShowBaseLayout" />
    <router-view></router-view>
  </v-app>
  <Toast />
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import MainMenu from '@/components/layouts/MainMenu.vue';
import Toast from '@/components/Toast/Index.vue';

const route = useRoute();

const shouldShowBaseLayout = computed(() => {
  return ['about', 'login', 'signup', 'index', 'users'].some((x) => x === route.name )
});
</script>


<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

