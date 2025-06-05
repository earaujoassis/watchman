import { create } from 'zustand';
import type { User } from '@/types';

export interface UserStore {
  users: User[];
  selectedUser: User | null;
  setUsers: (users: User[]) => void;
  setSelectedUser: (user: User | null) => void;
  addUser: (user: User) => void;
}

export const useUserStore = create<UserStore>((set) => ({
  users: [],
  selectedUser: null,
  setUsers: (users) => set({ users }),
  setSelectedUser: (user) => set({ selectedUser: user }),
  addUser: (user) => set((state) => ({ users: [...state.users, user] })),
}));
