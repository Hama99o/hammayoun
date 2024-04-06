<template>
  <v-sheet v-if="!loggedIn" class="mx-auto" width="300">
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
    </v-form>
  </v-sheet>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted, computed } from 'vue';
import { useAuthStore } from '@/stores/auth.store';
import { IUserLogin } from '@/types/general';
import { showToast } from '@/utils/showToast';

const authStore = useAuthStore();

const user = reactive<IUserLogin>({
  email: '',
  password: '',
});

const emailRules = (value) => {
  if (value?.length > 3) return true

  return 'email and password must be at least 3 characters.'
};

const redirectToPanel = () => {
  window.location.href = '/panel/';
};
const showMessage = ref(false);

const loggedIn = computed(() => authStore.isAuthenticated);

onMounted(() => {
  if (loggedIn.value) {
    redirectToPanel();
  }
});

const submit = () => {
  console.log('hiii')
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
