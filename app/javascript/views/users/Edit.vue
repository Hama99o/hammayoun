<template>
  <div v-if="user" class="pt-[150px] flex justify-center items-center">
    <v-sheet
      border="md"
      class="pa-6 text-white mx-auto !rounded-md"
      color="#141518"
      width="700"
      max-width="800"
    >
      <div class="flex justify-center my-5">
        <user-avatar
          class="h-10 w-10 my-4"
          size="2xl"
          :avatar="user?.avatar"
          :firstname="user?.lastname"
          :lastname="user?.firstname"
        />
      </div>

      <v-form fast-fail @submit.prevent="submit">
        <v-text-field
          v-model="user.firstname"
          type="text"
          label="First Name"
        ></v-text-field>

        <v-text-field
          v-model="user.lastname"
          type="text"
          label="Last Name"
        ></v-text-field>

        <v-text-field
          v-model="user.birth_date"
          type="date"
          label="Birth date"
        ></v-text-field>

        <v-text-field
          v-model="user.email"
          type="email"
          label="Email"
        ></v-text-field>

        <v-btn class="mt-2" type="submit" block>Save</v-btn>
      </v-form>
    </v-sheet>
  </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { useUserStore } from '@/stores/user.store';
import { onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import UserAvatar from '@/components/tools/Avatar.vue';

const route = useRoute();
const router = useRouter();

const { fetchUser, updateUser } = useUserStore();

const { user } = storeToRefs(useUserStore());

onMounted(async () => {
try {
  await fetchUser(route.params.id);
} catch (error) {
  console.log(error);
}
});

const submit = async() => {
  try {
    await updateUser(route.params.id, user.value)
    router
      .push({
        name: 'user',
        params: { id: route.params.id }
      })
  } catch (error) {
    console.log(error);
  }
};
</script>
