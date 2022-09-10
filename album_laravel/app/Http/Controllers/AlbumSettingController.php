<?php

namespace App\Http\Controllers;

use App\Models\AlbumSetting;
use Illuminate\Http\Request;

class AlbumSettingController extends Controller
{
    public function index()
    {
        $item = AlbumSetting::first();

        return response()->json($item);
    }

    public function update(Request $request)
    {
        $id = $request->get('id', 0);
        $item = AlbumSetting::find($id);
        $input = $request->all();
        if ($item) {
            $item->update($input);
            return $this->success();
        } else {
            AlbumSetting::create($input);
            return $this->success();
        }
    }
}
