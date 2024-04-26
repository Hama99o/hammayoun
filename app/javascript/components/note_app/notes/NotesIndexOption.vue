<template>
  <div>
    <note-table
      v-if="noteIndexType == 'table'"
      :notes="notes"
      note-index-type
      @open-invite-user-dialog="openInviteUserDialog"
      @open-tag-dialog="openTagDialog"
      @open-note-dialog="openNoteDialog"
      @destroy-note="destroyNote"
    />

    <note-card
      v-else
      :notes="notes"
      @open-invite-user-dialog="openInviteUserDialog"
      @open-tag-dialog="openTagDialog"
      @open-note-dialog="openNoteDialog"
      @destroy-note="destroyNote"
    />

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
import NoteCard from '@/components/note_app/notes/Card.vue';
import NoteTable from '@/components/note_app/notes/Table.vue';

const { inviteUserToggle, deleteNote, fetchNotes } = useNoteStore();
const { openPopUp, closePopUp } = usePopUpStore();

const props = defineProps({
  notes: { type: Array, default: () => [] },
  noteIndexType: { type: String },
});

const selectedNote = ref(null)
const selectedNoteForTag = ref(null)
const inviteUser = ref(null)
const isNoteOpened = ref(null)
const isTagDialogOpened = ref(null)

const openInviteUserDialog = (note) => {
  selectedNote.value = note
  inviteUser.value.isActive = true
}

const openTagDialog = (note) => {
  selectedNoteForTag.value = note
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
        try {
          await deleteNote(note.id)
          await fetchNotes()
          closePopUp();
          showToast(`${note.title} note delete successfully`, 'success');
        } catch (error) {
          // Assuming error.message contains the error message returned from the backend
          if (error.message.includes('not allowed')) {
            showToast(`Unable to delete "${note.title}". This note may be associated with other user and cannot be deleted.`, 'error');
          } else {
            showToast(`There was a problem deleting "${note.title}".`, 'error');
          }
        }
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
    await inviteUserToggle(selectedNote.value?.id, data)
    inviteUser.value.isActive = false
  } catch (errorMessage) {
    showToast(errorMessage.error, 'error');
  }
};

</script>
