import { http } from '@/services/http.service';

class NoteAPI {
  async fetchNotes(page = 1, search = '') {
    try {
      const res = await http.get(`/api/v1/note_app/notes?page=${page}&search=${search}`);
      return res.data;
    } catch (error) {
      return error;
    }
  }
  async fetchNote(id: number) {
    try {
      const res = await http.get(`/api/v1/note_app/notes/${id}`);
      return res.data;
    } catch (error) {
      return error;
    }
  }
  async updateNote(id: number, data: {}) {
    try {
      const headers = { 'Content-Type': 'multipart/form-data' };
      const res = await http.put(`/api/v1/note_app/notes/${id}`, data, { headers });
      return res.data;
    } catch (error) {
      return error;
    }
  }
  async createNote(data: {}) {
    try {
      const headers = { 'Content-Type': 'multipart/form-data' };
      const res = await http.post('/api/v1/note_app/notes/', data, { headers });
      return res.data;
    } catch (error) {
      return error;
    }
  }
  async deleteNote(id: number) {
    try {
      const headers = { 'Content-Type': 'multipart/form-data' };
      const res = await http.delete(`/api/v1/note_app/notes/${id}`);
      return res.data;
    } catch (error) {
      return error;
    }
  }
  async inviteUserToggle(id: number, data: {}) {
    const headers = { 'Content-Type': 'multipart/form-data' };
    const res = await http.put(`/api/v1/note_app/notes/${id}/invite_user_toggle`, data, { headers });
    return res.data;
  }
  async fetchTags(search = '') {
    const headers = { 'Content-Type': 'multipart/form-data' };
    const res = await http.get(`/api/v1/note_app/notes/tags?search=${search}`, { headers });
    return res.data;
  }
  async toggleTag(id: number, data: {}) {
    const headers = { 'Content-Type': 'multipart/form-data' };
    const res = await http.put(`/api/v1/note_app/notes/${id}/toggle_tag`, data, { headers });
    return res.data;
  }
  async createTag(id: number, data: {}) {
    const headers = { 'Content-Type': 'multipart/form-data' };
    const res = await http.post(`/api/v1/note_app/notes/${id}/create_and_assign_tag`, data, { headers });
    return res.data;
  }
}

const instance = new NoteAPI();

export default instance;
