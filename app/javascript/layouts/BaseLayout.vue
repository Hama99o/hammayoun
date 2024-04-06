<template>
  <slot></slot>
  <Toast />
</template>

<script setup lang="ts">
import Toast from '@/components/Toast/Index.vue';
</script>

<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

