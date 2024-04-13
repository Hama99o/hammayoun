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

              <v-dialog max-width="500">
                <template v-slot:activator="{ props: activatorProps }">
                  <v-icon
                    v-bind="activatorProps"
                    color="dark"
                    icon="mdi mdi-plus-thick"
                    text="Open Dialog"
                    @click.prevent=""
                    variant="flat"
                  />
                </template>

                <template v-slot:default="{ isActive }">
                  <v-card title="Invite John to connect">
                    <v-card-text class="text-center">
                      Invite collaborators to your network and grow your connections.
                    </v-card-text>

                    <v-card-actions>
                      <v-card-text>
                        <v-autocomplete
                        v-model="role"
                        label="role"
                        :items="['viewer', 'contributor', 'administrator', 'owner']"
                      ></v-autocomplete>
                      </v-card-text>
                    </v-card-actions>
                    <v-text-field
                      v-model="email"
                      label="Email address"
                      placeholder="johndoe@gmail.com"
                      type="email"
                    ></v-text-field>

                    <v-card-actions class="flex justify-center item-center">
                      <v-btn
                        text="Add User"
                        @click="test(item.id)"

                      ></v-btn>
                    </v-card-actions>
                  </v-card>
                </template>
              </v-dialog>

            </div>
            </router-link>
          </td>
        </tr>
      </tbody>
    </v-table>
</div>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
  notes: { type: Array, default: () => [] },
});

const role = ref('viewer')
const email = ref('')
const isActive = ref(false)

const test = async(e) => {
  isActive.value = false
  console.log(email.value)
  console.log(role.value)
  console.log(e)
  console.log('hiiii')
};
</script>
