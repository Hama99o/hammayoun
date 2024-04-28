<template>
  <v-row dense class="mt-10">
    <v-col v-for="(item, i) in notes" :key="i" cols="12" :md="cardmd">
      <v-card
        variant="elevated"
        class="mx-auto h-full my-5 h-full"
        color="surface-variant"
        :max-width="'700'"
        :title="item.title"
        @click="emit('open-note-dialog', item)"
      >
        <template v-slot:subtitle>
          <div class="whitespace-normal line-clamp-6">
            {{ item.description }}
          </div>

          <div class="flex flex-wrap mt-5">
            <div  v-for="tag in item.tags.filter((x) => item.tag_ids.includes(x.id))" :key="tag.id">
              <v-chip
                class="ma-1"
                closable
                @click:close="toggleTagToNote(item, tag)"
              >
                {{ tag.name }}
              </v-chip>
            </div>
          </div>


          <div class="flex flex-wrap">
            <div  v-for="user in item.shared_users" :key="user.id">
              <v-chip
                @click.stop="testing(user, item)"
                class="ma-2"
                link
                pill
              >
                <user-avatar
                  class="h-10 w-10 mr-1"
                  size="sm"
                  :avatar="user?.avatar"
                  :firstname="user?.lastname"
                  :lastname="user?.firstname"
                />

                {{ user.fullname }}
              </v-chip>
            </div>
          </div>
        </template>

        <template v-slot:actions>
          <v-menu >
            <template v-slot:activator="{ props }">
              <v-icon icon="mdi-dots-vertical" v-bind="props"></v-icon>
            </template>
            <v-list class="py-0">
              <div class="flex flex-col">
                <div
                  class="cursor-pointer hover:bg-grey px-5 py-2"
                  @click.prevent="emit('open-invite-user-dialog', item)"
                >
                  Invite User
                </div>

                <div
                  class="cursor-pointer hover:bg-grey px-5 py-2"
                  @click.prevent="emit('destroy-note', item)"
                >
                  Delete Note
                </div>

                <div
                  class="cursor-pointer hover:bg-grey px-5 py-2"
                  @click.prevent="emit('open-tag-dialog', item)"
                >
                  Change tags
                </div>
              </div>
            </v-list>
          </v-menu>
        </template>
      </v-card>
    </v-col>
  </v-row>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useNoteStore } from '@/stores/note_app/note.store';
import UserAvatar from '@/components/tools/Avatar.vue';
import { usePopUpStore } from "@/stores/pop-up.store";
import { showToast } from '@/utils/showToast';

const { openPopUp, closePopUp } = usePopUpStore();
const emit = defineEmits(['open-invite-user-dialog', 'open-tag-dialog', 'open-note-dialog', 'destroy-note']);
const test = ref(true)
const props = defineProps({
  notes: { type: Array, default: () => [] },
  noteIndexType: { type: String }
});

const { toggleTag } = useNoteStore();
const cardMaxWidth = computed(() => {
  if (props.noteIndexType == 'card_grid') {
    return '644'
  } else {
    return '344'
  }
})

const cardmd = computed(() => {
  if (props.noteIndexType == 'card_grid') {
    return '3'
  } else {
    return '12'
  }
})

const toggleTagToNote = async(note, tag) => {
  try {
    toggleTag(note.id, tag.id)
  } catch (error) {
    console.log(error);
  }
};

const testing = async(user, note) => {
  try {
    openPopUp({
      componentName: "pop-up-share-user-config",
      title: ("Collaborators"),
      user: user,
      note: note,
      textClose: "No, cancel",
      textConfirm: "Yes, delete this note",
      textLoading: "Deleting ...",
      icon: "mdi-trash-can-outline",
      color: "red",
      customClass: "w-[400px]",
      showClose: false,
      async confirm() {

        closePopUp();
        showToast(`${note.title} note delete successfully`, 'error');
      },
    });
  } catch (error) {
    console.log(error);
  }
};

</script>
