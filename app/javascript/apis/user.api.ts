import { useRouter } from 'vue-router';
import { http } from '@/services/http.service';
import AuthService from '@/services/auth.service';

class UserAPI {
  async fetchUsers(page = 1, search = '') {
    try {
      const res = await http.get(`/api/v1/users?page=${page}&search=${search}`);
      return res.data;
    } catch (error) {
      return error;
    }
  }
  async fetchUser(id: number) {
    try {
      const res = await http.get(`/api/v1/users/${id}`);
      return res.data;
    } catch (error) {
      if (error?.error === 'Signature has expired') {
        const router = useRouter();
        AuthService.logout().then(() => {
          router.push({ name: 'signin' });
        });
      }
    }
  }
  async updateUser(id: number, data: {}) {
    try {
      const headers = { 'Content-Type': 'multipart/form-data' };
      const res = await http.put(`/api/v1/users/${id}`, data, { headers });
      return res.data;
    } catch (error) {
      return error;
    }
  }
}

const instance = new UserAPI();

export default instance;
