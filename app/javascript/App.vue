<template>
  <v-app>
    <MainMenu/>
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

</script>


<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

