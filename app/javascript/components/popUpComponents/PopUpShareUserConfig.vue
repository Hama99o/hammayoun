<template>
  <v-dialog max-width="800" v-model="data.open">
    <template #default>

      <div class="w-full flex flex-col p-6 gap-8 bg-white">
        <!-- Icon and text -->

        <div class="flex justify-between  align-center mb-5">
          <p></p>
          <p
            v-for="text in title"
            :key="text"
            class="text-center font-medium text-xl"
          >
            {{ $t(text) }}
          </p>
          <v-icon
            color="black"
            class="text-xl hover:bg-red-200 p-3"
            icon="mdi mdi-close"
            @click="closePopUp"
          />
        </div>

        <div v-for="user in data?.note.shared_users" :key="user.id">
          <div class="flex justify-between hover:bg-grey">
            <user-avatar
              class="h-10 w-10 mr-1"
              size="sm"
              :avatar="user?.avatar"
              :firstname="user?.lastname"
              :lastname="user?.firstname"
            />

            <p>
              {{ user.fullname }}
            </p>

            <p>
              {{ user.email }}
            </p>

            <p>
              {{ user.note_role }}
            </p>

            <v-icon
              color="black"
              class="text-xl hover:bg-red-200 p-3 mx-5"
              icon="mdi mdi-close"
              @click="removeCollaborator(user)"
            />
           </div>
        </div>
      </div>
    </template>
  </v-dialog>
</template>

<script setup>
import { storeToRefs } from "pinia";
import { usePopUpStore } from "@/stores/pop-up.store";
import PopUpSkeleton from "./PopUpSkeleton.vue";
import UserAvatar from '@/components/tools/Avatar.vue';
import { useNoteStore } from '@/stores/note_app/note.store';

const { inviteUserToggle } = useNoteStore();
const { data } = storeToRefs(usePopUpStore());
const { closePopUp } = usePopUpStore();

const title = data.value.title.split("<br/>")
const subtitle = data.value.subtitle?.split("<br/>")
const removeCollaborator = async(user) => {
  try {
    const params = {
      email: user?.email,
      user_action: 'remove'
    }
    await inviteUserToggle(data.value?.note?.id, params)
    data.value.note.shared_users = data.value?.note?.shared_users.filter((shared_user) => shared_user.id !== user.id)
  } catch (errorMessage) {
    showToast(errorMessage.error, 'error');
  }
}
</script>
