<template>
  <div>
    <v-dialog max-width="500" v-model="isOpen">
      <template #default>

        <div class="w-full flex flex-col p-6 gap-8 bg-white">

          <div>
            <v-text-field
              v-model="title"
              label="title"
              placeholder="blablaablaa"
              type="email"
              @update:model-value="updateCurrentNote"
            ></v-text-field>
          </div>

          <div>

            <v-textarea
              v-model="description"
              label="Description"
              @update:model-value="updateCurrentNote"
            ></v-textarea>
          </div>

          <!-- Buttons -->
          <div class="flex  !justify-between">
            <v-menu >
              <template v-slot:activator="{ props }">
                <v-icon icon="mdi-dots-vertical" v-bind="props"></v-icon>
              </template>
              <v-list class="py-0">
                <div class="flex flex-col">
                  <div
                    class="cursor-pointer hover:bg-grey px-5 py-2"
                    @click.prevent="openInviteUserDialog(note.id)"
                  >
                    Invite User
                  </div>

                  <div
                    class="cursor-pointer hover:bg-grey px-5 py-2"
                    @click.prevent="destroyNote(note.id)"
                  >
                    Delete Note
                  </div>
                </div>
              </v-list>
            </v-menu>
            <v-icon
              color="fakeBlack"
              class="text-xl hover:bg-red-200 p-3"
              icon="mdi mdi-close"
              @click="isOpen = false"

            />
          </div>
        </div>
      </template>
    </v-dialog>
    <invite-user
      ref="inviteUser"
      @add-user="inviteUserWithEmail"
    />
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import InviteUser from '@/components/note_app/InviteUser.vue';
import { useNoteStore } from '@/stores/note_app/note.store';
import {debounce} from "lodash";
import { showToast } from '@/utils/showToast';
import { storeToRefs } from 'pinia';

const props = defineProps({
  note: { type: Object, default: () => {} },
});

const { updateNote, deleteNote, inviteUserToggle } = useNoteStore();
const { notes } = storeToRefs(useNoteStore());

const inviteUser = ref(null)
const title = ref('')
const description = ref('')

const isOpen = ref(false)
const emit = defineEmits(['add-user'])

defineExpose({
  isOpen
})

const openInviteUserDialog = (id) => {
  props.note = id
  inviteUser.value.isActive = true
}

const destroyNote = async(id) => {
  await deleteNote(id)
  isOpen.value = false
  notes.value = notes.value.filter((n) => n.id !== id)
}

const updateCurrentNote = debounce(async() => {
  await updateNote(props.note.id, { title: title.value, description: description.value })
  notes.value.forEach((n) => {
    if (n.id === props.note.id) {
      n.title = title.value
      n.description = description.value
    }
  })

}, 200)

watch(props, (newNote, oldNote) => {
  if (newNote) {
    title.value = newNote.note.title
    description.value = newNote.note.description
  }
});

const inviteUserWithEmail = async(role, email, UserAction) => {
  try {
    const data = {
      role: role,
      email: email,
      user_action: UserAction
    }
    await inviteUserToggle(props.note.id, data)
    inviteUser.value.isActive = false
  } catch (errorMessage) {
    showToast(errorMessage.error, 'error');
  }
};
</script>
