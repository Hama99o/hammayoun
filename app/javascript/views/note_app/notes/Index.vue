
<template>
  <div>
    <p class="my-5 text-4xl leading-10 text-center">
      Notes
  </p>
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
</template>

<script setup>
import NoteTable from '@/components/note_app/Table.vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import { onMounted } from 'vue';

const { fetchNotes, resetStates } = useNoteStore();

const { notes, pagination, page, search } = storeToRefs(useNoteStore());

onMounted(async () => {
  console.log('hiiiii')
try {
  await resetStates()
  await fetchNotes();
} catch (error) {
  console.log(error);
}
});


const fetchNewPage = async(e) => {
  page.value = e
  await fetchNotes();
};

const searchNote = async(e) => {
  search.value = e
  await fetchNotes();
};
</script>
