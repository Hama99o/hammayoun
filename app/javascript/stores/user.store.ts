import { defineStore } from 'pinia';
import UserAPI from '@/apis/user.api';

export const useUserStore = defineStore({
  id: 'user-store',
  state: () => ({
    currentUser: null,
    users: [],
    search: '',
    loading: true,
    pagination: {},
    page: 1,
  }),
  getters: {},
  actions: {
    async fetchUsers(page = 1, search = '') {
      this.loading = true;
      const res = await UserAPI.fetchUsers(page, search);
      this.users = res?.users;
      this.pagination = {
        current_page: res.meta.pagy.page,
        total_pages: res.meta.pagy.pages,
        total_items: res.meta.total_count,
      };
      this.loading = false;
    }
  },
});
