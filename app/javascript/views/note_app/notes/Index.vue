
<template>
  <div>
    <div class="flex  justify-between py-5">
      <h1>Notes</h1>
      <v-icon @click="createNewNote" icon="mdi mdi-plus  hover:!bg-very-light-grey " class="cursor-pointer create-note-btn"/>
    </div>
    <div class="flex ">
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
      <v-btn class="bg-red-500 hover:bg-red-100 ml-4" dark @click="handleClick">
        <span class="mdi mdi-trash-can-outline"></span>
      </v-btn>
      <v-btn @click="toggleView" dark class="bg-red-500 hover:bg-red-100 ml-4" >
        <v-icon size="32" :icon=" listViewColor"/>
      </v-btn>
    </div>
  </div>

  <notes-index-option :notes="notes" :note-index-type="currentUser?.note_index_type" />
  <!-- <note-card :notes="notes" /> -->
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
  />

  <note-trashes
    ref="isNoteTrashesDialogOpened"
  />
</template>

<script setup>
import NotesIndexOption from '@/components/note_app/notes/NotesIndexOption.vue';
import NoteCard from '@/components/note_app/notes/Card.vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import { onMounted, ref, computed } from 'vue';
import OpenNote from '@/components/note_app/notes/OpenNote.vue';
import NoteTrashes from '@/components/note_app/notes/NoteTrashes.vue';
import { useRoute, useRouter } from 'vue-router';
import { useUserStore } from '@/stores/user.store';

const { fetchNotes, fetchTrashesNotes, resetStates, createNote, fetchNote } = useNoteStore();
const {  updateUser } = useUserStore();

const { notes, pagination, page, search } = storeToRefs(useNoteStore());
const { currentUser } = storeToRefs(useUserStore());

const route = useRoute()
const router = useRouter()

const selectedNote = ref(null)
const isNoteOpened = ref(null)
const isNoteTrashesDialogOpened = ref(null)

onMounted(async () => {
  try {
    await resetStates()
    await fetchNotes();
    await fetchTrashesNotes();

    if (route?.query?.note_id) {
      const note = await fetchNote(route?.query?.note_id)
      openNoteDialog(note)
    }

  } catch (error) {
    console.log(error);
  }
});

const listViewColor = computed(() => {
  if (currentUser.value?.note_index_type == 'card_grid') {
    return 'mdi-view-module'
  } else if (currentUser.value?.note_index_type == 'card_list') {
    return 'mdi-view-list'
  } else {
    return 'mdi-table'
  }
})

const openNoteDialog = (note) => {
  selectedNote.value = note
  isNoteOpened.value.isOpen = true
}

const handleClick = () => {
  isNoteTrashesDialogOpened.value.isActive = true
}

const toggleView = async() => {
  try {
    let type = 'table'
    if (currentUser.value?.note_index_type == 'card_grid') {
      type = 'card_list'
    } else if (currentUser.value?.note_index_type == 'card_list') {
      type = 'table'
    } else {
      type = 'card_grid'
    }
    await updateUser(currentUser.value.id, { note_index_type: type });
  } catch (error) {
    console.log(error);
  }
};


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
