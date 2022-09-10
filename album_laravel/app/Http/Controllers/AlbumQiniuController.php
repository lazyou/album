<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AlbumQiniuController extends Controller
{
    public function token(Request $request)
    {
        $accessKey = env('QINIU_ACCESS_KEY');
        $secretKey = env('QINIU_SECRET_KEY');
        $bucket = env('QINIU_BUCKET');
        $key = $request->get('key', null); // 也就是文件名

        $date = date('Ymd');
        $microtime = microtime();
        $name = $request->get('name', '');
        $size = $request->get('size', 0);
        $type = $request->get('type', '');
        if (empty($key)) {
            $new = md5("{$microtime}{$name}");
            $pathArr = pathinfo($name);
            // TODO: 文件名若不带后缀则上传时也没有文件后缀
            $ext = $pathArr['extension'] ? ".{$pathArr['extension']}" : '';
            $key = "album/{$date}/{$new}{$ext}";
        }

        $auth = new \Qiniu\Auth($accessKey, $secretKey);
        $upToken = $auth->uploadToken($bucket, $key, 3600, null, true);
        $url = env('QINIU_DOMAIN') . $key; // 如果上传成功的文件访问地址

        return response()->json([
            'key' => $key,
            'url' => $url,
            'token' => $upToken,
        ], 200);
    }
}
