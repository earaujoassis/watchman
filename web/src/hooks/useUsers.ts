import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '@/services/api';
import type { User } from '@/types';
import { useUserStore } from '@/stores/userStore';

export const useUsers = () => {
  const { setUsers } = useUserStore();

  return useQuery({
    queryKey: ['users'],
    queryFn: async (): Promise<User[]> => {
      const response = await api.get('/users');
      setUsers(response.data);
      return response.data;
    },
  });
};

export const useCreateUser = () => {
  const queryClient = useQueryClient();
  const { addUser } = useUserStore();

  return useMutation({
    mutationFn: async (userData: Omit<User, 'id' | 'created_at' | 'updated_at'>) => {
      const response = await api.post('/users', { user: userData });
      return response.data;
    },
    onSuccess: (newUser) => {
      queryClient.invalidateQueries({ queryKey: ['users'] });
      addUser(newUser);
    },
  });
};
