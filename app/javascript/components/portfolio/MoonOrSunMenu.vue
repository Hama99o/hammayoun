<template>
  <div>
    <div class="d-flex justify-content-between text-align-center">
      <span @click="theme">
        <span v-if="!hasNightMood" class="btn moon-or-sun">🌙</span>
        <span v-else class="btn moon-or-sun">☀️</span>
      </span>

      <select-locale class="align-self-center" />
    </div>

    <hr class="my-4"/>
  </div>
</template>

<script setup>
import SelectLocale from '@/components/portfolio/SelectLocale.vue';

const props = defineProps(['theme', 'hasNightMood']);
</script>

<style lang="css" scoped>
.moon-or-sun {
  font-size: 40px;
}

@media only screen and (max-width: 900px) {
  .moon-or-sun {
    font-size: 20px;
  }
}
</style>
