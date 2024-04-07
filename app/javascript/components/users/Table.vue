<template>
  <v-table>
    <thead>
      <tr>
        <th class="text-left">
          Name
        </th>
        <th class="text-left">
          Access level
        </th>
        <th class="text-left">
          Email
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
        <td>{{ item.email }}</td>

      </tr>
    </tbody>
  </v-table>
</template>

<script setup>

const props = defineProps({
  users: { type: Array, default: () => [] },
});

</script>
