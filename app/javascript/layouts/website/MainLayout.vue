<template>
  <BaseLayout>
    <div>
      <div v-if="shouldShowBaseLayout"  class="header-bar">
        <MainMenu />
      </div>

      <div class="container mt-15">
        <router-view />
      </div>
    </div>
  </BaseLayout>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import BaseLayout from '../BaseLayout.vue';
import MainMenu from './MainMenu.vue';

const route = useRoute();

const shouldShowBaseLayout = computed(() => {
  return route.name !== 'portfolio';
});
</script>
