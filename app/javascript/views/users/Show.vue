
<template>
  <div>
    <p class="my-5 text-4xl leading-10 text-center">
      User

  </p>
  {{ user }}
  </div>

</template>

<script setup>
import { storeToRefs } from 'pinia';
import { useUserStore } from '@/stores/user.store';
import { onMounted } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const { fetchUser } = useUserStore();

const { user } = storeToRefs(useUserStore());

onMounted(async () => {
try {
  await fetchUser(route.params.id);
} catch (error) {
  console.log(error);
}
});
</script>
