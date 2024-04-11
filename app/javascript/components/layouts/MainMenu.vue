<template>
  <v-toolbar app>
    <v-navigation-drawer  class="!flex md:!hidden" v-model="sidebar" app>
      <v-list lines="one">
        <v-list-item
        v-for="item in menuItems"
        :key="item.title"
        :to="item.routeName"

        >
        <v-list-tile-action>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-tile-action>
        <v-list-tile-content class="ml-2">{{ item.title }}</v-list-tile-content>

      </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <!-- for mobile -->
    <span class="!flex md:!hidden">
      <v-app-bar-nav-icon @click="sidebar = !sidebar"></v-app-bar-nav-icon>
    </span>

    <v-toolbar-title>
      <router-link to="/" tag="span" style="cursor: pointer" class="text-black no-underline d-flex align-center w-fit hover:bg-stone-300 p-5">
        <img alt="" style="width: 30px;" src="@/assets/logos/image.png" class="mr-3"/>

        {{ appTitle }}
      </router-link>
    </v-toolbar-title>
    <v-spacer></v-spacer>

  <!-- for desktop -->

  <v-toolbar-items class="!hidden md:!flex mr-5">
    <v-btn
        class="d-flex align-center"
        flat
        v-for="item in menuItems"
        :key="item.title"
        :to="{
          name: item.routeName,
        }">
        <v-icon
          color="dark"
          :icon="item.icon"
        />
        {{ item.title }}
      </v-btn>
    </v-toolbar-items>
    <div>
      <Dropdown>
        <template #activator>
          <user-avatar
            class="h-10 w-10 cursor-pointer mr-5"
            size="lg"
            :avatar="currentUser?.avatar"
            :firstname="currentUser?.lastname"
            :lastname="currentUser?.firstname"
          />
        </template>

        <template #dropdown>
          <div class="w-full flex flex-col py-2 gap-2 border">
            <div class="flex flex-col gap-2">
              <!-- User Firstname & Lastname -->
              <p class="px-4">
                {{ currentUser?.lastname }}

                <span class="text-xl uppercase">
                  {{ currentUser?.firstname }}
                </span>
              </p>

              <!-- User email -->
              <p class="text-xs px-4 pb-2">
                {{ currentUser?.email }}
              </p>
            </div>

            <v-divider color="black" class="opacity-100 mx-4" />

            <!-- Buttons -->
            <div class="flex flex-col">
              <!-- Profile-->
              <div
                class="flex justify-center items-center gap-2 h-[35px] px-4 hover:bg-[#CDCDCD] cursor-pointer"
                @click="goToProfile"
              >
                <div>
                  <Icon icon="mdi:person-outline" width="16" height="16" class="text-fakeBlack" />
                </div>

                <p class="!w-full text-xs">
                  {{ 'Profile' }}
                </p>
              </div>

              <!-- Log out -->
              <div
                class="flex justify-center items-center gap-2 h-[35px] px-4 hover:bg-[#CDCDCD] cursor-pointer"
                @click="signOut"
              >
                <div>
                  <Icon icon="mdi:logout" width="16" height="16" class="text-fakeBlack" />
                </div>

                <p class="!w-full text-xs">
                  {{ 'Logout' }}
                </p>
              </div>
            </div>
          </div>
        </template>
      </Dropdown>
    </div>

  </v-toolbar>

</template>

<script setup lang="ts">
import { useAuthStore } from '@/stores/auth.store';
import { ref, computed, onMounted } from 'vue';
import AuthService from '@/services/auth.service';
import { storeToRefs } from 'pinia';
import { useRoute, useRouter } from 'vue-router';
import { useUserStore } from '@/stores/user.store';
import UserAvatar from '@/components/tools/Avatar.vue';
import Dropdown from '@/components/button/Dropdown.vue';

const { fetchCurrentUser, fetchUser } = useUserStore();
const { currentUser } = storeToRefs(useUserStore());

onMounted(async () => {
  try {
    if (AuthService.getUser()?.id) {
      await fetchCurrentUser(AuthService.getUser()?.id);
      localStorage.setItem('user', JSON.stringify(currentUser?.value));

      menuLogInItems.value = menuLogInItems.value.map((item) => {
        if (item.title == 'Users') {
          item.allow = AuthService?.isSuperAdmin()
          return item
        } else {
          return item
        }
      })
    }
  } catch (error) {
    console.log(error);
  }
});
const router = useRouter();

const menuLogInItems = ref([
  { title: 'Index', routeName: 'index', icon: "mdi-home-circle", allow: true },
  { title: 'About', routeName: 'about', icon: "mdi-face-man-shimmer-outline", allow: true },
  { title: 'Users', routeName: 'users', icon: "mdi-account-group", allow: false },

]);

const menuLogOutItems = ref([
  { title: 'Index', routeName: 'index', icon: "mdi-home-circle", allow: true },
  { title: 'About', routeName: 'about', icon: "mdi-face-man-shimmer-outline", allow: true },
  { title: 'Sign in', routeName: 'login', icon: " mdi-login", allow: true },
  { title: 'Sign up', routeName: 'signup', icon: "mdi-account-plus-outline", allow: true },

]);

const appTitle = ref('Multi Magic')
const sidebar = ref(false)

const authStore = useAuthStore();

const menuItems = computed(() => {
  if (isUserLogIn.value) {
    return menuLogInItems.value.filter((item) => item.allow)
  } else {
    return menuLogOutItems.value.filter((item) => item.allow)
  }
});

const logout = () => {
  authStore.logout();
};

const isUserLogIn = computed(() => {
  return AuthService?.getUser() && AuthService?.getToken()
});

const goToProfile = async() => {
  await fetchUser(currentUser.value?.id);
  router.push(
    {
      name: 'user',
      params: { id: currentUser.value?.id }
    }
  )
};

const signOut = async () => {
  try {
    logout();
  } catch (error) {
    console.log(error);
  }
};
</script>

<style>
@import 'vuetify/styles';
@import '@/assets/css/style.css';

</style>

