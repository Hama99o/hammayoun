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
        <h2>Create Account</h2>
        <p class="my-4">
          Already have an account?
          <router-link to="/login" tag="span" style="cursor: pointer" class="text-blue underline" >
            Sign In
          </router-link>
        </p>
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
          label="Last Name"
        ></v-text-field>

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

        <v-text-field
          v-model="user.password_confirmation"
          type="password"
          label="Verify Password"
        ></v-text-field>

        <v-btn class="mt-2" type="submit" block>Continue</v-btn>

        <v-checkbox
          class="mt-5"
          v-model="user.agreed_to_terms"
          label="I have read and agree to the "
        >
          <template v-slot:label>
            <p>
              I have read and agree to
              <span @click.prevent="renderToTerms" style="cursor: pointer" class="text-blue underline">
                the Terms of Service
              </span>
            </p>
          </template>
        </v-checkbox>
      </v-form>
    </v-sheet>
  </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '@/stores/auth.store';
import { IRegisterUser } from '@/types/general';
import { showToast } from '@/utils/showToast';
import DatePicker from '@/components/tools/DatePicker.vue';

const router = useRouter();

const authStore = useAuthStore();

const user = reactive<IRegisterUser>({
  firstname: '',
  lastname: '',
  birth_date: '',
  email: '',
  password: '',
  password_confirmation: '',
  agreed_to_terms: false
});

const submit = () => {
  authStore.register(user).then(
    () => {
      router.push({ name: 'login' });
    },
    (error) => {
      showToast(error, 'error');
    },
  );
};

const renderToTerms = () => {
  console.log('we are in renderToTerms')
  // authStore.register(user).then(
  //   () => {
  //     router.push({ name: 'login' });
  //   },
  //   (error) => {
  //     showToast(error, 'error');
  //   },
  // );
};
</script>
