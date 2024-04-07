<template>
  <v-table>
    <thead>
      <tr>
        <th class="text-left">
          Name
        </th>
        <th class="text-left">
          Calories
        </th>
      </tr>
    </thead>
    <tbody>
      <tr
        v-for="item in users"
        :key="item.name"
      >
        <td>{{ item.fullname }}</td>
        <td>{{ item.access_level }}</td>
      </tr>
    </tbody>
  </v-table>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { useUserStore } from '@/stores/user.store';
import { ref, onMounted } from 'vue';

const { fetchUsers } = useUserStore();

const { users } = storeToRefs(useUserStore());

onMounted(async () => {
  try {
    await fetchUsers();
  } catch (error) {
    console.log(error);
  }
});

</script>
