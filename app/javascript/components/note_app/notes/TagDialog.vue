<template>
  <div>
    <v-dialog max-width="500" v-model="isActive">
      <template #default>
        <div class="w-full flex flex-col p-6 gap-8 bg-white">
          <div>
            <v-autocomplete
              :items="tags"
              :autofocus="true"
              no-filter
              variant="outlined"
              multiple
              hide-details
              menu-icon=""
              density="compact"
              item-value="id"
              :clear-on-select="true"
              item-text="name"
              label="Tags"
              @click:clear="clear"
              @update:search="searchTag"
              v-slot:item="{ item }"
            >
              <v-list-item-content>
                <v-checkbox
                  v-model="note.tag_ids"
                  color="info"
                  :label="item.raw.name"
                  hide-details
                  :value="item.raw?.id"
                  @click.stop
                  @update:model-value="toggleTagToNote(item.raw)"
                ></v-checkbox>
              </v-list-item-content>
            </v-autocomplete>
          </div>
        </div>
      </template>
    </v-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import {debounce} from "lodash";

const { fetchTags, toggleTag } = useNoteStore();
const { tags } = storeToRefs(useNoteStore());

const emit = defineEmits(['add-user'])

const props = defineProps({
  note: { type: Object, default: () => {} },
});

const isActive = ref(false)
const searchText = ref('')
const isSelected = ref([])
const selectedTag = ref('')
const editedTags = ref([])

defineExpose({
  isActive
})

const clear = () => {
  searchText.value = ''
}

onMounted(async () => {
  try {
    console.log(tags.value)
    await fetchTags();
  } catch (error) {
    console.log(error);
  }
});

const searchTag = async(x) => {
  try {
    await fetchTags(x);
  } catch (error) {
    console.log(error);
  }
};

const toggleTagToNote = async(tag) => {
  try {
    toggleTag(props.note.id, tag.id)
  } catch (error) {
    console.log(error);
  }
};
</script>
