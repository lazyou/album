<?php

namespace App\Http\Controllers;

use App\Models\AlbumSkinCate;
use Illuminate\Http\Request;

class AlbumCateController extends Controller
{
    public function index()
    {
        $list = AlbumSkinCate::orderBy('displayorder')->get();

        return response()->json($list);
    }

    public function update(Request $request)
    {
        $id = $request->get('id');
        $data = $request->only(['displayorder', 'title']);
        $data['uniacid'] = 0;
        if ($id) {
            $item = AlbumSkinCate::find($id);
            if ($item) {
                $item->update($data);
            } else {
                return $this->failure(self::FailureNotExist);
            }
        } else {
            $item = AlbumSkinCate::create($data);
            return $this->json($item);
        }
    }

    public function delete($id)
    {
        $item = AlbumSkinCate::find($id);
        if ($item) {
            $item->delete();
            return $this->success();
        } else {
            return $this->failure(self::FailureNotExist);
        }
    }
}
