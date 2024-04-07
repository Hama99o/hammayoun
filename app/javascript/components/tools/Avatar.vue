<template>
  <v-avatar
    v-if="display_avatar"
    :image="avatar"
    :size="sizeList[size]"
  />

  <v-avatar
    v-else-if="firstname"
    :color="
      colors[
        firstname.charAt(0).toUpperCase() === firstname.charAt(0)
          ? firstname.charCodeAt(0) - 65
          : firstname.charCodeAt(0) - 97
      ]
    "
    :size="sizeList[size]"
    class="select-none"
  >
    <span :class="fontSizeList[size]">
      {{ firstname?.substring(0, 1) + lastname?.substring(0, 1) }}
    </span>
  </v-avatar>
</template>
<script setup>
import { ref, watch } from "vue";
import checkImageStatus from "@/tools/imageStatus.js";

const display_avatar = ref(true);

const props = defineProps({
  avatar: { type: String, default: null },
  firstname: { type: String, default: null },
  lastname: { type: String, default: null },
  size: { type: String, default: null },
  alt: { type: String, default: "User profile avatar" },
});

checkImageStatus(props.avatar, (exists) => {
  display_avatar.value = exists;
});

watch(
  () => props.avatar,
  () => {
    checkImageStatus(props.avatar, (exists) => {
      display_avatar.value = exists;
    });
  }
);

const sizeList = ref({
  xs: 16,
  '20': 20,
  sm: 24,
  md: 32,
  lg: 40,
  xl: 64,
  '2xl': 88
})

const fontSizeList = ref({
  xs: 'text-[9px]',
  sm: 'text-[12px]',
  md: 'text-[14px]',
  lg: 'text-[16px]',
  xl: 'text-[24px]',
  '2xl': 'text-[32px]',
})

const colors = [
  "red lighten-1", // A
  "pink lighten-1", // B
  "purple lighten-1", // C
  "deep-purple lighten-1", // D
  "indigo lighten-1", // E
  "blue lighten-1", // F
  "light-blue lighten-1", // G
  "cyan lighten-1", // H
  "teal lighten-1", // I
  "green lighten-1", // J
  "light-green lighten-1", // K
  "lime lighten-1", // L
  "yellow lighten-1", // M
  "amber lighten-1", // N
  "orange lighten-1", // O
  "deep-orange lighten-1", // P
  "brown lighten-1", // Q
  "blue-grey lighten-1", // R
  "red lighten-1", // S
  "pink lighten-1", // T
  "purple lighten-1", // U
  "deep-purple lighten-1", // V
  "indigo lighten-1", // W
  "blue lighten-1", // X
  "light-blue lighten-1", // Y
  "cyan lighten-1", // Z
];
</script>
