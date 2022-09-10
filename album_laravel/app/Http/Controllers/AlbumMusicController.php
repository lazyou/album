<?php

namespace App\Http\Controllers;

use App\Models\AlbumMusic;
use Illuminate\Http\Request;

class AlbumMusicController extends Controller
{
    public function index()
    {
        $list = paginate(AlbumMusic::class);

        return response()->json($list);
    }

    public function update(Request $request)
    {
        $id = $request->get('id');
        $data = $request->only(['title', 'music']);
        $data['uniacid'] = 0;
        if ($id) {
            $item = AlbumMusic::find($id);
            if ($item) {
                $item->update($data);
            } else {
                return $this->failure(self::FailureNotExist);
            }
        } else {
            $item = AlbumMusic::create($data);
            return $this->json($item);
        }
    }

    public function delete($id)
    {
        $item = AlbumMusic::find($id);
        if ($item) {
            $item->delete();
            return $this->success();
        } else {
            return $this->failure(self::FailureNotExist);
        }
    }
}

