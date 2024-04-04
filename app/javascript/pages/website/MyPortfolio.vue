<template>
  <background-animation />
  <b-container fluid>
    <b-row>
      <b-col offset-md="2">
        <moon-or-sun-menu :theme="theme" :hasNightMood="hasNightMood" />
      </b-col>
    </b-row>
    <b-row align-h="center">
      <b-col cols="6" md="2" class="my-4">
        <my-photo/>
      </b-col>
      <b-col cols="12" md="10">
        <div class="mb-4">
          <ul class="nav nav-pills">
            <li class="nav-item m-1" v-for="(text, routeName, index) in  $t('message.heading')" >
              <!-- <router-link class="nav-link" :class="linkClassForTabs(index)" :to="{ name: routeName }">
                <code @click="clickOnMenu(index)">{{text}}</code>
              </router-link> -->
            </li>
          </ul>
        </div>
        <!-- <router-view> </router-view> -->
      </b-col>
    </b-row>
  </b-container>
</template>

<script setup lang="ts">
import { defineProps, watch, ref, onMounted } from 'vue';
import BackgroundAnimation from '@/layouts/website/BackgroundAnimation.vue'
import MyPhoto from '@/components/portfolio/MyPhoto.vue';
import MoonOrSunMenu from '@/components/portfolio/MoonOrSunMenu.vue';
import { useRouter } from 'vue-router';

const props = defineProps({
  menuList: {
    type: Object,
    default: () => ({
      'PersonalProfile':  0,
      'ExperienceAndEducation': 1,
      "Skill": 2,
      'Contact': 3
    })
  }
});

const router = useRouter();
const hasNightMood = ref(false);
const tabIndex = ref(0);

const clickOnMenu = (id) => {
  tabIndex.value = id;
};

const theme = () => {
  const body = document.querySelector('body');
  body.classList.toggle('nightmode');
  hasNightMood.value = !hasNightMood.value;
  localStorage.hasNightMood = hasNightMood.value;
};

const linkClassForTabs = (idx) => {
  const linkClass = [];
  if (!hasNightMood.value) {
    tabIndex.value === idx ? linkClass.push('bg-dark', 'text-white') : linkClass.push('text-dark');
  } else {
    tabIndex.value === idx ? linkClass.push('text-dark', 'bg-white') : linkClass.push('bg-dark', 'text-white');
  }
  return linkClass;
};

onMounted(() => {
  const body = document.querySelector('body');
  if (localStorage.hasNightMood && JSON.parse(localStorage.hasNightMood)) {
    body.classList.add('nightmode');
    hasNightMood.value = true;
  }
});

// watchEffect(() => {
//   const routeName = router.currentRoute.value.name;
//   tabIndex.value = props.menuList[routeName];
// });
</script>


<style>

.nightmode {
  background: #292b2c;
  color: #eee;
}

* {
  position: relative;
}

</style>

