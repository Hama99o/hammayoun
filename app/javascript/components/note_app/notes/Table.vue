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
            tags
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

          <td class="truncate px-0">
            <div
              @click="openNoteDialog(item)"
              class="w-full h-full cursor-pointer"
            >
              <div v-if="item?.owner?.fullname" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
                {{ item?.owner?.fullname }}
              </div>
            </div>
          </td>

          <td class="truncate px-0">
            <div
              @click="openNoteDialog(item)"
              class="w-full h-full cursor-pointer"
            >
            <div  class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item?.shared_count }}
            </div>
            </div>
          </td>

          <td class="truncate px-0 ">
            <div
              @click="openNoteDialog(item)"
              class="w-full h-full cursor-pointer flex align-center"
            >
              <div  v-for="tag in item.tags.slice(0, 2)" :key="tag.id" class=" inline-block flex flex-nowrap rounded-full px-2  bg-grey">
                #{{ tag.name }}
              </div>
              <span v-if="item.tags.length > 2">
                ...
              </span>
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
                    @click.prevent="destroyNote(item)"
                  >
                    Delete Note
                  </div>

                  <div
                    class="cursor-pointer hover:bg-grey px-5 py-2"
                    @click.prevent="openTagDialog(item)"
                  >
                    Change tags
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
      ref="isNoteOpened"
      :note="selectedNote"
      @add-user="inviteUserWithEmail"
    />

    <tag-dialog
      ref="isTagDialogOpened"
      :note="selectedNoteForTag"
    />
</div>
</template>

<script setup>
import { ref } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import InviteUser from '@/components/note_app/notes/InviteUser.vue';
import TagDialog from '@/components/note_app/notes/TagDialog.vue';
import { showToast } from '@/utils/showToast';
import OpenNote from '@/components/note_app/notes/OpenNote.vue';
import { usePopUpStore } from "@/stores/pop-up.store";

const { inviteUserToggle, deleteNote, fetchNotes } = useNoteStore();
const { openPopUp, closePopUp } = usePopUpStore();

const props = defineProps({
  notes: { type: Array, default: () => [] },
});

const selectedNote = ref(null)
const selectedNoteForTag = ref(null)
const inviteUser = ref(null)
const isNoteOpened = ref(null)
const isTagDialogOpened = ref(null)

const openInviteUserDialog = (id) => {
  selectedNote.value = id
  inviteUser.value.isActive = true
}

const openTagDialog = (id) => {
  selectedNoteForTag.value = id
  isTagDialogOpened.value.isActive = true
}

const openNoteDialog = (note) => {
  selectedNote.value = note
  isNoteOpened.value.isOpen = true
}

const destroyNote = async(note) => {
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
        await deleteNote(note.id)
        await fetchNotes()
        closePopUp();
        showToast(`${note.title} note delete successfully`, 'error');
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
