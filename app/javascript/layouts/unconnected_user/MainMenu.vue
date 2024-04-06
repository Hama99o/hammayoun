<template>
  <v-toolbar app>
    <v-navigation-drawer  class="!flex md:!hidden" v-model="sidebar" app>
      <v-list lines="one">
        <v-list-item
        v-for="item in menuItems"
        :key="item.title"
        :to="item.routeName"

        >
        <v-list-tile-action>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content class="ml-2">{{ item.title }}</v-list-tile-content>

      </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <!-- for mobile -->
    <span class="!flex md:!hidden">
      <v-app-bar-nav-icon @click="sidebar = !sidebar"></v-app-bar-nav-icon>
    </span>

    <v-toolbar-title>
      <router-link to="/" tag="span" style="cursor: pointer" class="text-black no-underline	">
        {{ appTitle }}
      </router-link>
    </v-toolbar-title>
    <v-spacer></v-spacer>

  <!-- for desktop -->

  <v-toolbar-items class="!hidden md:!flex">
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
  { title: 'Indxex', routeName: 'index', icon: "mdi-home-circle" },
  { title: 'About', routeName: 'about', icon: "mdi-face-man-shimmer-outline" },
  { title: 'Sign in', routeName: 'login', icon: " mdi-login" },
  { title: 'Sign up', routeName: 'signup', icon: "mdi-account-plus-outline" },
];

const appTitle = ref('Multi Magic')
const sidebar = ref(false)

</script>

<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

