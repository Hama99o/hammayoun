<template>
  <v-app>
    <MainMenu/>
    <div class="md:container md:mx-auto">
    <router-view></router-view>
    </div>
  </v-app>
  <Toast />
</template>

<script setup lang="ts">
import MainMenu from '@/components/layouts/MainMenu.vue';
import Toast from '@/components/Toast/Index.vue';

</script>


<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

