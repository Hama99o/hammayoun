import { defineStore } from 'pinia';
import UserAPI from '@/apis/user.api';

export const useUserStore = defineStore({
  id: 'user-store',
  state: () => ({
    user: {},
    currentUser: null,
    users: [],
    search: '',
    loading: true,
    pagination: {},
    page: 1,
  }),
  getters: {},
  actions: {
    async fetchUsers() {
      this.loading = true;
      const res = await UserAPI.fetchUsers(this.page, this.search);
      this.users = res?.users;
      this.pagination = {
        current_page: res.meta.pagy.page,
        total_pages: res.meta.pagy.pages,
        total_items: res.meta.total_count,
      };
      this.loading = false;
    },
    async fetchUser(id: number) {
      await this.resetStates();
      const res = await UserAPI.fetchUser(id);
      this.user = res.user;
      this.loading = false;
    },
    async fetchCurrentUser(id: number) {
      await this.resetStates();
      const res = await UserAPI.fetchUser(id);
      localStorage.setItem('user', JSON.stringify(res.user));
      this.currentUser = res.user;
    },
    async forgotPassword(email: string) {
      await UserAPI.forgotPassword(email)
    },
    async resetPassword(data: object) {
      await UserAPI.resetPassword(data)
    },
    async updateUser(id: number, data: {}) {
      const res = await UserAPI.updateUser(id, data);
      if (Number(id) === Number(this.currentUser.id)) {
        this.currentUser = res.user;
        localStorage.setItem('user', JSON.stringify(res.user));
      } else {
        this.user = res.user;
      }
    },
    async resetStates() {
      this.user = null;
      this.users = [];
      this.page = 1
      this.search = ''
      this.pagination = {};
      this.loading = true;
    },
  },
});
