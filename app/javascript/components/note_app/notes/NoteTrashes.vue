<template>
  <div>
    <v-dialog max-width="600" v-model="isActive">
      <template #default>

        <div class="w-full flex flex-col p-6 gap-8 bg-white">
          <!-- Icon and text -->
          <div class="flex flex-col items-center gap-4 mb-5">
            <!-- icon -->
            <v-icon
              icon="mdi mdi-trash-can-outline"
              height="52"
              width="52"
            />

            <div class="flex flex-grow justify-center ml-6">
              <p
                class="font-medium text-xl text-fakeBlack line-clamp-1"
              >
                Deleted Notes
              </p>
            </div>
          </div>

          <div
            class="flex gap-3 flex-row justify-between border-b text-fake-black text-sm items-center cursor-pointer hover:bg-[#F6F6F6]"
            v-for="trashesNote in trashesNotes"
            :key="trashesNote.id"
          >
            <p class="ml-1 flex basis-1/3 truncate">
              Title: {{ trashesNote.title }}
            </p>
            <p
              class="min-w-[92px]"
            >
              Deleted at: {{ moment(trashesNote.deleted_at, "YYYY-MM-DD HH:mm:ss [UTC]").format("dddd Do MMMM, h:mm a") }}
            </p>
            <v-tooltip text="Restore note" location="top">
              <template v-slot:activator="{ props }">
                <v-icon v-bind="props" icon="mdi mdi-restore" @click="trashNoteRestore(trashesNote.id)"></v-icon>
              </template>
            </v-tooltip>

            <v-tooltip text="Delete permanently note" location="top">
              <template v-slot:activator="{ props }">
                <v-icon v-bind="props" icon="mdi mdi-delete" @click="trashNoteDeletePermanently(trashesNote.id)"></v-icon>
              </template>
            </v-tooltip>
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
          </div>
        </div>
      </template>
    </v-dialog>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import moment from 'moment';
const { openPopUp, closePopUp } = usePopUpStore();
import { usePopUpStore } from "@/stores/pop-up.store";

const { trashesNotes } = storeToRefs(useNoteStore());
const {  noteRestore, noteDeletePermanently } = useNoteStore();

const role = ref('')
const email = ref('')
const isActive = ref(false)
const emit = defineEmits(['add-user'])

const trashNoteRestore = async(id) => {
  await noteRestore(id)
}

const trashNoteDeletePermanently = async(id) => {
  try {
    openPopUp({
      componentName: "pop-up-validation",
      title: ("Are you sure you want to delete permanently this note ?"),
      textClose: "No, cancel",
      textConfirm: "Yes, delete this note",
      textLoading: "Deleting ...",
      icon: "mdi-trash-can-outline",
      color: "red",
      customClass: "w-[400px]",
      showClose: false,
      async confirm() {
        await noteDeletePermanently(id)
        closePopUp();
      },
    });
  } catch (error) {
    console.log(error);
  }
};

defineExpose({
  isActive
})
</script>
