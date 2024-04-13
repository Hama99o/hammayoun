<template>
  <div class="note-container">
    <div class="note-content">
      <h1 v-if="!isEditing">{{ note.title }}</h1>
      <input v-model="note.title" v-if="isEditing" class="input-field" />

      <p v-if="!isEditing">{{ note.description }}</p>
      <textarea v-model="note.description" v-if="isEditing" class="input-field"></textarea>

      <button @click="toggleEdit" class="edit-button">{{ isEditing ? 'Save' : 'Edit' }}</button>
    </div>

    <button @click="destroyNote" class="delete-button">Delete</button>
  </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import { onMounted,ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const { fetchNote, updateNote, deleteNote } = useNoteStore();

const { note } = storeToRefs(useNoteStore());
const isEditing = ref(false)

onMounted(async() => {
try {
  await fetchNote(route.params.id);
} catch (error) {
  console.log(error);
}
});

const toggleEdit = async() => {
  try {
    if (isEditing.value) {
      await updateNote(note.value.id, { title: note.value.title, description: note.value.description })
    }
    isEditing.value = !isEditing.value
  } catch (error) {
    console.log(error);
  }
};

const destroyNote = async() => {
  try {
    await deleteNote(note.value.id)
    router.push({
      name: 'notes'
    })
  } catch (error) {
    console.log(error);
  }
};
</script>
