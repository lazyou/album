<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

/**
 * 后台接口用户认证
 * Class AlbumAuthController
 * @package App\Http\Controllers
 */
class AlbumAuthController extends Controller
{
    public function login(Request $request)
    {
        $email = $request->get('email');
        $password = $request->get('password');
        if (empty($email) || empty($password)) {
            return $this->failure('请输入账号或密码');
        }

        $user = User::where('email', $request->email)->first();
        if (!$user || !Hash::check($request->password, $user->password)) {
            return $this->failure('账号或密码错误');
        }

        $token = $user->createToken('album-token')->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];

        return $this->json($response);
    }

    public function logout()
    {
        Auth::logout();

        return $this->success('注销成功');
    }

    public function info()
    {
        $user = $this->adminUser();
        $user->roles = ['admin'];
        return $this->json($user);
    }
}
