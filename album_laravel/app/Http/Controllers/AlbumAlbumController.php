<?php

namespace App\Http\Controllers;

use App\Models\AlbumData;
use App\Models\AlbumSkin;
use App\Models\AlbumUser;
use Illuminate\Http\Request;

class AlbumAlbumController extends Controller
{
    public function index()
    {
        $map = [
            'status',
            'ishot',
            'title' => 'like',
        ];
        $list = paginate(AlbumData::class, $map);

        return $this->json($list);
    }

    public function detail($id)
    {
        $item = AlbumData::find($id);
        if ($item) {
            $item->imgdataArr = explode(',', $item->imgdata);
            return $this->json($item);
        }

        return $this->failure(self::FailureNotExist);
    }

    public function update(Request $request, $id)
    {
        $input = $request->only([
            'uid',
            'title',
            'avatar',
            'nickname',
            'skin',
            'ishot',
            'status',
            'music',
            'thumb',
            'txtdata',
            'click',
            'best',
        ]);

        $input['uniacid'] = 0;
        $input['share'] = 0;
        $input['openid'] = '';
        $imgdataArr = $request->get('imgdataArr', []);
        if (is_array($imgdataArr)) {
            $input['imgdata'] = implode(',', $imgdataArr);
        }

        // 没有填写音乐地址则优先从皮肤获取
        if (empty($input['music']) && (int) $input['skin']) {
            $skin = AlbumSkin::find($input['skin']);
            if ($skin) {
                $input['music'] = $skin['music'];
            }
        }

        if ($id) {
            unset($input['uid']);
            $item = AlbumData::find($id);
            $item->update($input);
        } else {
            if ($input['uid']) {
                $user = AlbumUser::find($input['uid']);
                if ($user) {
                    $input['avatar'] = $user->avatar;
                    $input['nickname'] = $user->nickname;
                }
            }

            AlbumData::create($input);
        }

        return $this->success();
    }
}
