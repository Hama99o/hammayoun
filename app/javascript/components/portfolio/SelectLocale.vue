<template>
  <div>
    <select v-model="$i18n.locale" @change="getLang($event)" :class="getClass('darkBgInDark')">
      <option
        v-for="(langAndFlag, i) in langsAndFlags"
        :key="`lang-${i}`"
        :value="langAndFlag.lang">
        {{ langAndFlag.flag }}
      </option>
    </select>
  </div>
</template>

<script setup>
// import { mapGetters, mapState } from 'vuex'
import { ref, computed } from "vue";
import { storeToRefs } from 'pinia';
import { usePortfolioStore } from '@/stores/portfolio.store';

const { lightDarkClasses, getTheme } = storeToRefs(usePortfolioStore());

const langsAndFlags = ref([
  { lang: 'en', flag: '🇺🇸'},
  { lang: 'fr', flag:  '🇫🇷'}
])

const getClass = (attribute) => {
  return lightDarkClasses.value[attribute][getTheme.value]
}

const getLang = (lang) => {
  localStorage.locale = lang.target.value
}

</script>

<style scoped>
  select:focus {
    outline: none;
  }

  select {
    border: 0;
  }
</style>
