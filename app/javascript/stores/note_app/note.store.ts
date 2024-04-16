import { defineStore } from 'pinia';
import NoteAPI from '@/apis/note_app/note.api';

export const useNoteStore = defineStore({
  id: 'note-store',
  state: () => ({
    note: {},
    notes: [],
    trashesNotes: [],
    tags: [],
    search: '',
    loading: true,
    pagination: {},
    trashesNotesPagination: {},
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
    async fetchTrashesNotes() {
      this.loading = true;
      const res = await NoteAPI.fetchTrashesNotes(this.page, this.search);
      this.trashesNotes = res?.notes;
      this.trashesNotesPagination = {
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
    async noteRestore(id: number) {
      await NoteAPI.noteRestore(id);
    },
    async noteDeletePermanently(id: number) {
      await NoteAPI.noteDeletePermanently(id);
    },
    async inviteUserToggle(id: number, data: {}) {
      await NoteAPI.inviteUserToggle(id, data);
      await this.fetchNotes()
    },
    async fetchTags(search = '') {
      const res = await NoteAPI.fetchTags(search);
      this.tags = res.tags
      return res.tags
    },
    async toggleTag(noteId: number, tagId: number) {
      const res = await NoteAPI.toggleTag(noteId, { tag_id: tagId });
      this.fetchNotes()
      return res.tag
    },
    async createTag(noteId: number, text: string) {
      const res = await NoteAPI.createTag(noteId, { text: text });
      this.fetchNotes()
      this.fetchTags()
      return res.tag
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
