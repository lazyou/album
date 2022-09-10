<?php

namespace App\Http\Middleware;

use Closure;

/**
 * Class CheckMiniSign
 * @package App\Http\Middleware
 * 小程序签名验证: 加盐 env('ALBUM_MINI_SLAT'), 时间不得超过10秒
 */
class CheckMiniSign
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // 参数必须
        $sign = $request->get('sign');
        $timestamp = $request->get('timestamp');
        if (empty($sign) || empty($timestamp)) {
            return response()->json([
                'err' => 'sign || timestamp can\'t empty!',
            ], 401);
        }

        // 时间有效
        $now = time();
        $startTime = $now - 5;
        $endTime = $now + 10;
        $isValidTime = ($timestamp >= $startTime && $timestamp <= $endTime);
        if (!$isValidTime) {
            return response()->json([
                'err' => 'timestamp invalid!',
            ], 401);
        }

        // 签名一致
        $salt = env('ALBUM_MINI_SLAT');
        $serviceSign = md5("{$salt}{$timestamp}");
        if ($sign !== $serviceSign) {
            return response()->json([
                'err' => 'sign invalid!',
            ], 401);
        }

        return $next($request);
    }
}
