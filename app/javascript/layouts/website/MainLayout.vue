<template>
  <BaseLayout>
    <v-app>
      <MainMenu v-if="shouldShowBaseLayout" />
      <router-view></router-view>
    </v-app>
  </BaseLayout>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import BaseLayout from '../BaseLayout.vue';
import MainMenu from './MainMenu.vue';

const route = useRoute();

const shouldShowBaseLayout = computed(() => {
  return ['about', 'login', 'signup', 'index'].some((x) => x === route.name )
});
</script>
