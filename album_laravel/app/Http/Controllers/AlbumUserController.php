<?php

namespace App\Http\Controllers;

use App\Models\AlbumUser;
use Illuminate\Http\Request;

class AlbumUserController extends Controller
{
    public function index(Request $request)
    {
        $map = [
            'uid',
            'status',
            'nickname' => 'like',
        ];

        $list = paginate(AlbumUser::class, $map);

        return response()->json($list);
    }

    public function update(Request $request)
    {
        $uid = $request->get('uid');
        $user = AlbumUser::find($uid);
        if ($user) {
            $user->status = $request->get('status');
            $user->save();
            return $this->success();
        }
    }
}
