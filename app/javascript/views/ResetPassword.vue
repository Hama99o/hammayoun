<template>
  <div class="pt-[150px] flex justify-center items-center">
    <v-sheet
      border="md"
      class="pa-6 text-white mx-auto !rounded-md"
      color="#141518"
      width="700"
      max-width="800"
    >
      <div class="text-center">
        <h2>Reset Password</h2>
        <p class="my-4">Enter your new password</p>
      </div>
      <v-form @submit.prevent="submit">
        <v-text-field
          v-model="user.password"
          type="password"
          label="New Password"
          :rules="[v => !!v || 'Password is required', v => (v && v.length >= 8) || 'Password must be at least 8 characters']"
        ></v-text-field>

        <v-text-field
          v-model="user.confirmPassword"
          type="password"
          label="Confirm Password"
          :rules="[v => !!v || 'Confirm password is required', v => user.password === v || 'Passwords do not match']"
        ></v-text-field>

        <v-btn class="mt-2" type="submit" block>Reset Password</v-btn>
      </v-form>
    </v-sheet>
  </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue';
import { IUserResetPassword } from '@/types/general';
import { showToast } from '@/utils/showToast';
import { useAuthStore } from '@/stores/auth.store';

const authStore = useAuthStore();

const user = reactive<IUserResetPassword>({
  password: '',
  confirmPassword: '',
});

const submit = () => {
  authStore
    .resetPassword(user)
    .then(() => {
      showToast('Password successfully reset!', 'success');
    })
    .catch((error) => {
      showToast(error, 'error');
    });
};
</script>
