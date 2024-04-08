<template>
  <div class="container mx-auto px-4 py-8">
    <v-row justify="center">
      <v-col cols="12" md="8" lg="6">
        <v-card class="elevation-10">
          <v-card-title class="text-lg font-bold text-center mb-4">User Profile</v-card-title>
          <v-card-text>
            <div class="flex flex-col items-center my-5">
              <user-avatar
                class="h-10 w-10 my-4"
                size="2xl"
                :avatar="user?.avatar"
                :firstname="user?.lastname"
                :lastname="user?.firstname"
              />
              <div class="text-xl font-semibold my-3">{{ user?.fullname }}</div>
              <div class="text-gray-600  my-3">{{ user?.email }}</div>
              <div class="text-gray-600  my-3">{{ user?.phone || 'no phone number added yet' }}</div>
              <div class="text-gray-600  my-3">{{ user?.address || 'no address added yet' }}</div>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { useUserStore } from '@/stores/user.store';
import { onMounted } from 'vue';
import { useRoute } from 'vue-router';
import UserAvatar from '@/components/tools/Avatar.vue';

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
