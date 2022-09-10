<?php

namespace App\Http\Controllers;

use App\Models\AlbumSkin;
use Illuminate\Http\Request;

class AlbumSkinController extends Controller
{
    public function index()
    {
        $map = [
            'ishot',
            'title' => 'like',
        ];
        $list = paginate(AlbumSkin::with('cate'), $map);

        return response()->json($list);
    }

    public function options()
    {
        $list = AlbumSkin::orderBy('displayorder')->get(['id', 'title'])->toArray();
        foreach ($list as &$item) {
            $item['id'] = (string) $item['id'];
        }

        return $this->json($list);
    }

    public function detail($id)
    {
        $item = AlbumSkin::find($id);
        if ($item) {
            $item->ani = explode(',', $item->ani);
            return $this->json($item);
        }

        return $this->failure(self::FailureNotExist);
    }

    public function update(Request $request, $id)
    {
        sleep(4);
        $input = $request->only([
            'cid',
            'displayorder',
            'title',
            'thumb',
            'model',
            'ani',
            'music',
            'bgimg',
            'frameimg',
            'ishide',
            'ishot',
        ]);

        $input['uniacid'] = 0;
        $input['otitle'] = '';
        $input['def'] = 0;
        $input['remoted'] = 0;

        if (is_array($input['ani'])) {
            $input['ani'] = implode(',', $input['ani']);
        }

        if (is_null($input['frameimg'])) {
            $input['frameimg'] = '';
        }

        if ($id) {
            $item = AlbumSkin::find($id);
            if (is_null($item)) {
                return $this->failure(self::FailureNotExist);
            }

            $item->update($input);
        } else {
            AlbumSkin::create($input);
        }

        return $this->success();
    }
}
