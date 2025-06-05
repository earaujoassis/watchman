import React from 'react';
import { useUsers } from '@/hooks/useUsers';
import { useUserStore } from '@/stores/userStore';
import type { User } from '@/types';

const UserList: React.FC = () => {
  const { data: users, isLoading, error } = useUsers();
  const { selectedUser, setSelectedUser } = useUserStore();

  if (isLoading) return <div>Carregando...</div>;
  if (error) return <div>Erro ao carregar usuários</div>;

  return (
    <div>
      <h2>Lista de Usuários</h2>
      <ul>
        {users?.map((user: User) => (
          <li
            key={user.id}
            onClick={() => setSelectedUser(user)}
            style={{
              cursor: 'pointer',
              backgroundColor: selectedUser?.id === user.id ? '#e0e0e0' : 'transparent'
            }}
          >
            {user.name} - {user.email}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default UserList;
