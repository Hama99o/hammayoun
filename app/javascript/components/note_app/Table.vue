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
          class=" bg-zinc-50 hover:bg-zinc-200"
          v-for="item in notes"
          :key="item.id"
        >
          <td class="px-0 ">
            <router-link
              :to="{ name: 'note', params: {id: item.id } }"
              class="w-full h-full"
            >
            <div v-if="item?.title" class="w-[45px] h-full flex gap-2 items-center pl-4 whitespace-nowrap">
              {{ item.title }}
            </div>
            </router-link>
          </td>

          <td class="px-0">
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
          <td class="px-0">
            <router-link
              :to="{ name: 'note', params: {id: item.id } }"
              class="w-full h-full"
            >
            <div  class="w-[45px] h-full flex gap-1 items-center whitespace-nowrap">
              <v-icon
                color="dark"
                icon="mdi mdi-plus-thick"
                text="Open Dialog"
                @click.prevent="openInviteUserDialog(item.id)"
                variant="flat"
              />

            </div>
            </router-link>
          </td>
        </tr>
      </tbody>
    </v-table>
    <invite-user
      ref="inviteUser"
      @add-user="test"
    />
</div>
</template>

<script setup>
import { ref } from 'vue';
import { storeToRefs } from 'pinia';
import { useNoteStore } from '@/stores/note_app/note.store';
import InviteUser from '@/components/note_app/InviteUser.vue';
import { showToast } from '@/utils/showToast';

const { inviteUserToggle } = useNoteStore();

const props = defineProps({
  notes: { type: Array, default: () => [] },
});

const SelectednoteId = ref(null)
const inviteUser = ref(null)

const openInviteUserDialog = (id) => {
  SelectednoteId.value = id
  inviteUser.value.isActive = true
}

const test = async(role, email, UserAction) => {
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
