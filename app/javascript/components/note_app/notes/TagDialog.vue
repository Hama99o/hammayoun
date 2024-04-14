<template>
  <div>
    <v-dialog max-width="500" v-model="isActive">
      <template #default>

        <div class="w-full flex flex-col p-6 gap-8 bg-white">
          <div>
            <v-autocomplete
              :items="tags"
              :autofocus="true"
              item-value="id"
              item-text="name"
              label="Tags"
              multiple
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
                  @update:model-value="test(item.raw)"
                ></v-checkbox>
              </v-list-item-content>



              <!-- <v-list-item-action>
                <v-checkbox v-model="item.selected" />
              </v-list-item-action> -->
            </v-autocomplete>
          </div>

        </div>
      </template>
    </v-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import { usePopUpStore } from "@/stores/pop-up.store";

const { fetchTags, toggleTag } = useNoteStore();
const { openPopUp, closePopUp } = usePopUpStore();
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

const test = async(x) => {
  try {
    console.log(props.note)
    console.log(x)
    toggleTag(props.note.id, x.id)
  } catch (error) {
    console.log(error);
  }
};
</script>
