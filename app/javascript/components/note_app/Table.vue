<template>
  <div>
    <v-table>
      <thead>
        <tr>
          <th class="text-left">
            Titile
          </th>
          <th class="text-left">
            Description
          </th>
          <th class="text-left">
            Ower
          </th>
          <th class="text-left">
            Share count
          </th>
          <th class="text-left">
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="item in notes"
          :key="item.id"
        >
          <td class="truncate px-0">
            <div
              @click="openNoteDialog(item)"
              class="w-full h-full cursor-pointer"
            >
            <div v-if="item?.title" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item.title }}
            </div>
          </div>
          </td>

          <td class="truncate px-0">
            <div
              @click="openNoteDialog(item)"
              class="w-full h-full cursor-pointer"
            >
            <div v-if="item?.description" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item.description }}
            </div>
            </div>
          </td>

          <td class="px-0">
            <div
              @click="openNoteDialog(item)"
              class="w-full h-full cursor-pointer"
            >
              <div v-if="item?.owner?.fullname" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
                {{ item?.owner?.fullname }}
              </div>
            </div>
          </td>

          <td class="px-0">
            <div
              @click="openNoteDialog(item)"
              class="w-full h-full cursor-pointer"
            >
            <div  class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item?.shared_count }}
            </div>
            </div>
          </td>
          <td class="!w-[50px] pa-0 cursor-pointer">
            <v-menu >
              <template v-slot:activator="{ props }">
                <v-icon icon="mdi-dots-vertical" v-bind="props"></v-icon>
              </template>
              <v-list class="py-0">
                <div class="flex flex-col">
                  <div
                    class="cursor-pointer hover:bg-grey px-5 py-2"
                    @click.prevent="openInviteUserDialog(item.id)"
                  >
                    Invite User
                  </div>

                  <div
                    class="cursor-pointer hover:bg-grey px-5 py-2"
                    @click.prevent="destroyNote(item.id)"
                  >
                    Delete Note
                  </div>
                </div>
              </v-list>
            </v-menu>
          </td>
        </tr>
      </tbody>
    </v-table>
    <invite-user
      ref="inviteUser"
      @add-user="inviteUserWithEmail"
    />

    <open-note
      ref="IsNoteOpened"
      :note="SelectedNote"
      @add-user="inviteUserWithEmail"
    />
</div>
</template>

<script setup>
import { ref } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import InviteUser from '@/components/note_app/InviteUser.vue';
import { showToast } from '@/utils/showToast';
import OpenNote from '@/components/note_app/OpenNote.vue';
import { usePopUpStore } from "@/stores/pop-up.store";

const { inviteUserToggle, deleteNote, fetchNotes } = useNoteStore();
const { openPopUp, closePopUp } = usePopUpStore();

const props = defineProps({
  notes: { type: Array, default: () => [] },
});

const SelectedNote = ref(null)
const inviteUser = ref(null)
const IsNoteOpened = ref(null)

const openInviteUserDialog = (id) => {
  SelectedNote.value = id
  inviteUser.value.isActive = true
}

const openNoteDialog = (note) => {
  SelectedNote.value = note
  IsNoteOpened.value.isOpen = true
}



const destroyNote = async(id) => {
  try {
    openPopUp({
      componentName: "pop-up-validation",
      title: ("Are you sure you want to delete this note ?"),
      textClose: "No, cancel",
      textConfirm: "Yes, delete this note",
      textLoading: "Deleting ...",
      icon: "mdi-trash-can-outline",
      color: "red",
      customClass: "w-[400px]",
      showClose: false,
      async confirm() {
        console.log('hiiiiiii')
        await deleteNote(id)
        await fetchNotes()
        closePopUp();
      },
    });
  } catch (error) {
    console.log(error);
  }
};

const inviteUserWithEmail = async(role, email, UserAction) => {
  try {
    const data = {
      role: role,
      email: email,
      user_action: UserAction
    }
    await inviteUserToggle(SelectednoteId.value, data)
    inviteUser.value.isActive = false
  } catch (errorMessage) {
    showToast(errorMessage.error, 'error');
  }
};

</script>
