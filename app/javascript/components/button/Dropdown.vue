<template>
  <v-menu :close-on-content-click="closeOnContentCLick">
    <template #activator="{ props }">
      <div v-bind="props">
        <slot name="activator">
          <svn-button />
        </slot>
      </div>
    </template>

    <v-list class="pa-0">
      <slot name="dropdown">
        <v-list-item
          v-for="(item, index) in items"
          :key="item?.id"
          :value="item"
          @click="item?.onClick"
        >
          <v-list-item-title>
            {{ item?.title }}
          </v-list-item-title>
        </v-list-item>
      </slot>
    </v-list>
  </v-menu>
</template>

<script setup>
import SvnButton from "@/components/button/Button.vue";

const props = defineProps({
  items: { type: Array, default: () => [] },
  closeOnContentCLick: { type: Boolean, default: true },
})
</script>