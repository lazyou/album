<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\Auth;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    const FailureNotExist = '数据不存在';

    // api json 数据响应
    public function json($data)
    {
        return response()->json($data);
    }

    // api 操作成功通用响应
    public function success($message = '操作成功')
    {
        return response()->json([
            'message' => $message,
        ], 200);
    }

    // api 操作失败通用响应
    public function failure($message = '操作失败')
    {
        return response()->json([
            'message' => $message,
        ], 400);
    }

    public function adminUser()
    {
        // Auth::user()
        return Auth::guard('sanctum')->user();
    }
}
