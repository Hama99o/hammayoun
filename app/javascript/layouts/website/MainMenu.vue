<template>
  <v-toolbar app>
    <!-- for mobile -->
    <span class="flex sm:hidden">
      <v-toolbar-side-icon @click="sidebar = !sidebar">
      </v-toolbar-side-icon>
    </span>

    <v-toolbar-title>
      <router-link to="/" tag="span" style="cursor: pointer" class="text-black no-underline	">
        {{ appTitle }}
      </router-link>
    </v-toolbar-title>
    <v-spacer></v-spacer>

  <!-- for destop -->

  <v-toolbar-items class="hidden sm:flex">
    <v-btn
        flat
        v-for="item in menuItems"
        :key="item.title"
        :to="{
          name: item.routeName,
        }">
        <v-icon
          color="dark"
          :icon="item.icon"
        />
        {{ item.title }}
      </v-btn>
    </v-toolbar-items>
  </v-toolbar>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const menuItems = [
  { title: 'Index', routeName: 'index', icon: "mdi-home-circle" },
  { title: 'About', routeName: 'about', icon: "mdi-face-man-shimmer-outline" },
  { title: 'Sign in', routeName: 'login', icon: " mdi-login" },
  { title: 'Sign up', routeName: 'signup', icon: "mdi-account-plus-outline" },
];

const appTitle = ref('Awesome App')
const sidebar = ref(false)

</script>

<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

