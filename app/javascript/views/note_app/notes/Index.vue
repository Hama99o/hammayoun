
<template>
  <div>
    <div class="flex  justify-between py-5">
      <h1>Notes</h1>
      <v-icon @click="createNewNote" icon="mdi mdi-plus  hover:!bg-very-light-grey " class="cursor-pointer create-note-btn"/>
    </div>
    <v-text-field
      v-model="search"
      color="primary"
      class="w-full text-darkGrey md:w-[258px]"
      variant="outlined"
      density="compact"
      hide-details
      prepend-inner-icon="mdi-magnify"
      :label="'Search'"
      @update:model-value="searchNote"
      />
  </div>

  <note-table :notes="notes" />
  <v-pagination
    v-if="pagination"
    :model-value="pagination.current_page"
    :length="pagination.total_pages"
    :total-visible="6"
    theme="primary"
    variant="text"
    class="mt-16 !list-none"
    @update:model-value="fetchNewPage"
  />

  <open-note
    ref="isNoteOpened"
    :note="selectedNote"
    @add-user="inviteUserWithEmail"
  />
</template>

<script setup>
import NoteTable from '@/components/note_app/note/Table.vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import { onMounted, ref } from 'vue';
import OpenNote from '@/components/note_app/note/OpenNote.vue';

const { fetchNotes, resetStates, createNote } = useNoteStore();

const { notes, pagination, page, search } = storeToRefs(useNoteStore());


const selectedNote = ref(null)
const isNoteOpened = ref(null)

onMounted(async () => {
  try {
    await resetStates()
    await fetchNotes();
  } catch (error) {
    console.log(error);
  }
});

const openNoteDialog = (note) => {
  selectedNote.value = note
  isNoteOpened.value.isOpen = true
}

const fetchNewPage = async(e) => {
  try {
    page.value = e
    await fetchNotes();
  } catch (error) {
    console.log(error);
  }
};

const createNewNote = async() => {
  try {
    const data = {
      title: '',
      description: ''
    }
    const note = await createNote(data);
    notes.value.unshift(note)
    openNoteDialog(note)
  } catch (error) {
    console.log(error);
  }
};

const searchNote = async(e) => {
  try {
    search.value = e
    await fetchNotes();
  } catch (error) {
    console.log(error);
  }
};
</script>
