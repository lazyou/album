<?php

namespace App\Http\Controllers;

use App\Models\AlbumAd;
use Illuminate\Http\Request;

class AlbumAdController extends Controller
{
    public function index()
    {
        $map = [
            'weizhi',
        ];
        $list = paginate(AlbumAd::class, $map);

        return $this->json($list);
    }

    public function detail($id)
    {
        $item = AlbumAd::find($id);
        if ($item) {
            return $this->json($item);
        }

        return $this->failure(self::FailureNotExist);
    }

    public function update($id, Request $request)
    {
        $input = $request->only([
            'displayorder',
            'thumb',
            'title',
            'text',
            'path',
            'weizhi',
            'istype',
            'appid',
        ]);

        $weizhiOptions = [
            0 => '小程序列表' ,
            1 => '首页漂浮' ,
            2 => '影集页面漂浮1' ,
            3 => '影集页面漂浮2' ,
            4 => '首页幻灯片(可多个)' ,
        ];

        if ($id) {
            $item = AlbumAd::find($id);
            $item->update($input);
        } else {
            $weizhi = $request->get('weizhi');
            if (in_array($weizhi, [1, 2, 3])) {
                $exist = AlbumAd::where('weizhi', $weizhi)->first();
                if ($exist) {
                    return $this->failure("$weizhiOptions[$weizhi] 只能创建一个广告");
                }
            }

            AlbumAd::create($input);
        }

        return $this->success();
    }

    public function delete($id)
    {
        $item = AlbumAd::find($id);
        if ($item) {
            $item->delete();
            return $this->success();
        }

        return $this->failure(self::FailureNotExist);
    }
}
