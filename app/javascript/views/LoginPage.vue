<template>
  <div class="pt-[150px] flex justify-center items-center">
    <v-sheet v-if="!loggedIn"
      border="md"
      class="pa-6 text-white mx-auto !rounded-md"
      color="#141518"
      width="700"
      max-width="800"
    >
      <div class="text-center">
        <h2>Welcome, User!</h2>
        <p class="my-4">Please log in</p>
      </div>
      <v-form fast-fail @submit.prevent="submit">
        <v-text-field
          v-model="user.email"
          type="email"
          label="Email"
        ></v-text-field>

        <v-text-field
          v-model="user.password"
          type="password"
          label="Password"
        ></v-text-field>

        <v-btn class="mt-2" type="submit" block>Continue</v-btn>

        <p class="message my-5 text-blue underline" @click="resetPassword" style="cursor: pointer"> Forgot password</p>
        <p class="message">
          Not registered?
          <router-link to="/signup" tag="span" style="cursor: pointer" class="text-blue underline" >
            Create an account
          </router-link>
        </p>
      </v-form>
    </v-sheet>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted, computed } from 'vue';
import { useAuthStore } from '@/stores/auth.store';
import { IUserLogin } from '@/types/general';
import { showToast } from '@/utils/showToast';
import { useRouter } from 'vue-router';

const router = useRouter();
const authStore = useAuthStore();

const user = reactive<IUserLogin>({
  email: '',
  password: '',
});

const redirectToPanel = () => {
  window.location.href = '/';
};
const showMessage = ref(false);

const loggedIn = computed(() => authStore.isAuthenticated);

onMounted(() => {
  if (loggedIn.value) {
    redirectToPanel();
  }
});

const resetPassword = () => {
  router.push({ name: 'forget_password' });
};

const submit = () => {
  authStore
    .login(user)
    .then(() => {
      redirectToPanel();
    })
    .catch((error) => {
      showToast(error, 'error');
    });
};
</script>
