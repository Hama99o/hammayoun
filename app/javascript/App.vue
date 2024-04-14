<template>
  <v-app>
    <MainMenu/>
    <div class="md:container md:mx-auto mt-3">
      <router-view></router-view>
      <bkt-pop-up />
    </div>
  </v-app>
  <footer class="bg-gray-800 text-white py-4 fixed bottom-0 w-full">
    <div class="container mx-auto">
      <!-- Footer content goes here -->
      Footer Content
    </div>
  </footer>
  <Toast />
</template>

<script setup lang="ts">
import MainMenu from '@/components/layouts/MainMenu.vue';
import Toast from '@/components/Toast/Index.vue';
import BktPopUp from "@/components/popUpComponents/BktPopUp.vue";

</script>


<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

