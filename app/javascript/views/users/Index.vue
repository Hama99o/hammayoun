
<template>
  <user-table :users="users" />
  <v-pagination
    v-if="pagination"
    :model-value="pagination.current_page"
    :length="pagination.total_pages"
    :total-visible="6"
    theme="primary"
    variant="text"
    class="mt-16 !list-none"
    @update:model-value="fetchNewPage"
  />
</template>

<script setup>
import UserTable from '@/components/users/Table.vue';
import { storeToRefs } from 'pinia';
import { useUserStore } from '@/stores/user.store';
import { onMounted } from 'vue';

const { fetchUsers } = useUserStore();

const { users, pagination, page } = storeToRefs(useUserStore());

onMounted(async () => {
try {
  await fetchUsers();
} catch (error) {
  console.log(error);
}
});


const fetchNewPage = async(e) => {
  page.value = e
  await fetchUsers();
};
</script>
