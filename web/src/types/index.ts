export interface User {
  id: string;
  iid: number;
  active: boolean;
  public_id: string;
  created_at: string;
  updated_at: string;
}

export interface ApiResponse<T> {
  data?: T;
  error?: string;
}
