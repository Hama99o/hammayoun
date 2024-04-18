<template>
  <div>
    <v-dialog max-width="500" v-model="isActive">
      <template #default>

        <div class="w-full flex flex-col p-6 gap-8 bg-white">
          <!-- Icon and text -->
          <div class="flex flex-col items-center gap-4">
            <!-- icon -->
            <v-icon
              icon="mdi mdi-trash-can-outline"
              height="52"
              width="52"
            />

            <!-- Title & description -->
            <div class="flex flex-col items-center self-stretch gap-4">
              <p class="text-fakeBlack text-xl font-medium text-center">
              </p>
            </div>
          </div>

          <div
            class="flex flex-col items-center self-stretch gap-4"
            v-for="trashesNote in trashesNotes"
            :key="trashesNote.id"
          >
          <p>
            title: {{ trashesNote.title }}
          </p>
        </div>

          <!-- Buttons -->
          <div class="flex flex-col items-start gap-3 self-stretch lg:!flex-row">
            <v-btn
              variant="outlined"
              color="fakeBlack"
              class="normal-case text-xs w-full lg:!flex-1"
              text="cancel"
              @click="isActive = false"
            />

            <v-btn
              variant="flat"
              color="negativeRed"
              class="normal-case text-xs w-full lg:!w-1/2"
              text="Add User"
              @click="emit('add-user', role, email, 'add')"
            />
          </div>
        </div>
      </template>
    </v-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';

const { fetchTrashesNotes } = useNoteStore();
const { trashesNotes } = storeToRefs(useNoteStore());

const role = ref('')
const email = ref('')
const isActive = ref(false)
const emit = defineEmits(['add-user'])

onMounted(async() => {
  try {
    await fetchTrashesNotes()
  } catch (error) {
    console.log(error);
  }
});

defineExpose({
  isActive
})
</script>
