import { defineStore } from 'pinia';
import NoteAPI from '@/apis/note_app/note.api';

export const useNoteStore = defineStore({
  id: 'note-store',
  state: () => ({
    note: {},
    notes: [],
    search: '',
    loading: true,
    pagination: {},
    page: 1,
  }),
  getters: {},
  actions: {
    async fetchNotes() {
      this.loading = true;
      const res = await NoteAPI.fetchNotes(this.page, this.search);
      this.notes = res?.notes;
      this.pagination = {
        current_page: res.meta.pagy.page,
        total_pages: res.meta.pagy.pages,
        total_items: res.meta.total_count,
      };
      this.loading = false;
    },
    async fetchNote(id: number) {
      await this.resetStates();
      const res = await NoteAPI.fetchNote(id);
      this.note = res.note;
      this.loading = false;
    },
    async updateNote(id: number, data: {}) {
      const res = await NoteAPI.updateNote(id, data);
      this.note = res.note;
    },
    async createNote(data: {}) {
      const res = await NoteAPI.createNote(data);
      this.note = res.note;
      return res.note
    },
    async deleteNote(id: number) {
      await NoteAPI.deleteNote(id);
    },
    async resetStates() {
      this.note = {};
      this.notes = [];
      this.page = 1
      this.search = ''
      this.pagination = {};
      this.loading = true;
    },
  },
});
