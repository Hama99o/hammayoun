<template>
  <v-row dense class="mt-10">
    <v-col v-for="(item, i) in notes" :key="i" cols="12" md="4">
      <v-card
        variant="elevated"
        class="mx-auto my-5"
        color="surface-variant"
        max-width="344"
        :title="item.title"
        @click="emit('open-note-dialog', item)"
        >
        <template v-slot:subtitle>
          <div class="w-full h-full whitespace-normal line-clamp-7">
            {{ item.description }}
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
const emit = defineEmits(['open-invite-user-dialog', 'open-tag-dialog', 'open-note-dialog', 'destroy-note']);

const props = defineProps({
  notes: { type: Array, default: () => [] },
});


</script>
