<template>
  <background-animation />
  <h2 class="text-center">You are visiting the {{ pageName }} page!</h2>
</template>

<script setup lang="ts">
import BackgroundAnimation from '@/layouts/website/BackgroundAnimation.vue'

const pageName = 'Index';
</script>
