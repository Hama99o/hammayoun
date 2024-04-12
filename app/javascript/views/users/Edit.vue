<template>
  <div v-if="user" class="pt-[150px] flex justify-center items-center">
    <v-sheet
      border="md"
      class="pa-6 text-white mx-auto !rounded-md"
      color="rgb(8 47 73)"
      width="700"
      max-width="800"
    >
      <div class="flex justify-center my-5">
        <svn-profile
          app-variant="studio"
          :firstname="user?.firstname"
          :lastname="user?.lastname"
          :avatar="user?.avatar"
          :avatar-size="'2xl'"
          :edit="true"
          class="text-left !text-orange-300 sm:!text-center"
          @upload-file="uploadAvatar"
          @delete-picture="uploadAvatar(null)"
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

const uploadAvatar = async (data) => {
  try {
    await updateUser(route.params?.id, { photo: data });

    // snackbar.setBgColor('fakeBlack');
    // snackbar.setMsg('Avatar has been changed.');
    // snackbar.displaySnackBar();
  } catch (error) {
    console.log(error);
  }
};

</script>
