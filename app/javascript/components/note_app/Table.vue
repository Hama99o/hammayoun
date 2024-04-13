<template>
  <div>
    <v-table>
      <thead>
        <tr>
          <th class="text-left">
            Titile
          </th>
          <th class="text-left">
            Description
          </th>
          <th class="text-left">
            Ower
          </th>
          <th class="text-left">
            Share count
          </th>
          <th class="text-left">
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="item in notes"
          :key="item.id"
        >
          <td class="truncate px-0">
            <router-link
              :to="{ name: 'note', params: {id: item.id } }"
              class="w-full h-full"
            >
            <div v-if="item?.title" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item.title }}
            </div>
            </router-link>
          </td>

          <td class="truncate px-0">
            <router-link
              :to="{ name: 'note', params: {id: item.id } }"
              class="w-full h-full"
            >
            <div v-if="item?.description" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item.description }}
            </div>
            </router-link>
          </td>

          <td class="px-0">
            <router-link
              :to="{ name: 'note', params: {id: item.id } }"
              class="w-full h-full"
            >
            <div v-if="item?.owner?.fullname" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item?.owner?.fullname }}
            </div>
            </router-link>
          </td>

          <td class="px-0">
            <router-link
              :to="{ name: 'note', params: {id: item.id } }"
              class="w-full h-full"
            >
            <div  class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item?.shared_count }}
            </div>
            </router-link>
          </td>
          <td class="!w-[50px] pa-0">
            <v-menu >
              <template v-slot:activator="{ props }">
                <v-icon icon="mdi-dots-vertical" v-bind="props"></v-icon>
              </template>
              <v-list class="py-0">
                <div class="flex flex-col">
                  <div
                    class="cursor-pointer hover:bg-grey px-5 py-2"
                    @click.prevent="openInviteUserDialog(item.id)"
                  >
                    Invite User
                  </div>

                  <div
                    class="cursor-pointer hover:bg-grey px-5 py-2"
                    @click.prevent="destroyNote(item.id)"
                  >
                    Delete Note
                  </div>
                </div>
              </v-list>
            </v-menu>
          </td>
        </tr>
      </tbody>
    </v-table>
    <invite-user
      ref="inviteUser"
      @add-user="inviteUserWithEmail"
    />
</div>
</template>

<script setup>
import { ref } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import InviteUser from '@/components/note_app/InviteUser.vue';
import { showToast } from '@/utils/showToast';

const { inviteUserToggle, deleteNote } = useNoteStore();

const props = defineProps({
  notes: { type: Array, default: () => [] },
});

const SelectednoteId = ref(null)
const inviteUser = ref(null)

const openInviteUserDialog = (id) => {
  SelectednoteId.value = id
  inviteUser.value.isActive = true
}

const destroyNote = async(id) => {
  await deleteNote(id)
}

const inviteUserWithEmail = async(role, email, UserAction) => {
  try {
    const data = {
      role: role,
      email: email,
      user_action: UserAction
    }
    await inviteUserToggle(SelectednoteId.value, data)
    inviteUser.value.isActive = false
  } catch (errorMessage) {
    showToast(errorMessage.error, 'error');
  }
};

</script>
