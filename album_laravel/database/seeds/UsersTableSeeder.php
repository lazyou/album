<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $users = [
            [
                'name' => 'admin',
                'email' => 'admin@qq.com',
                'password' => Hash::make('admin123qwer'),
            ],
            [
                'name' => 'test',
                'email' => 'test@qq.com',
                'password' => Hash::make('test123qwer'),
            ],
        ];

        foreach ($users as $user) {
            $item = User::where('name', $user['name'])->first();
            if (is_null($item)) {
                User::create($user);
            }
        }
    }
}
