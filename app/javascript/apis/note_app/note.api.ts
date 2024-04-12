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
}

const instance = new NoteAPI();

export default instance;
