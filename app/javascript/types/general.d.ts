export interface IUserLogin {
  firstname: string,
  lastname: string,
  birth_date: string,
  email: string,
  password: string,
  password_confirmation: string,
  is_agree: boolean
}

export interface IRegisterUser extends IUserLogin {
  password_confirmation: string;
}

export interface ICurrentUser {
  id: number;
}
