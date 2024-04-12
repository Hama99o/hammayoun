<template>
  <div>
    <h1>Create New Note</h1>
    <form @submit.prevent="creatNeweNote">
      <div>
        <label for="title">Title:</label>
        <input type="text" id="title" v-model="title" />
      </div>
      <div>
        <label for="description">Description:</label>
        <textarea id="description" v-model="description"></textarea>
      </div>
      <button type="submit">Save Note</button>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useNoteStore } from '@/stores/note_app/note.store';

const router = useRouter();
const { createNote } = useNoteStore();
const title = ref('');
const description = ref('');

const creatNeweNote = async () => {
  try {
    const note = await createNote({
      title: title.value,
      description: description.value,
    });
    router.push({ name: 'note', params: { id: note.id} });
  } catch (error) {
    console.error('Error creating note:', error);
  }
};
</script>
