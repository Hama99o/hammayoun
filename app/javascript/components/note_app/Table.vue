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
        </tr>
      </tbody>
    </v-table>
</div>
</template>

<script setup>

const props = defineProps({
  notes: { type: Array, default: () => [] },
});

</script>
