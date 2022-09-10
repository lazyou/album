<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// album 后台接口.
Route::prefix('/admin')->group(function () {
    // 登录 注销
    Route::post('/auth/login', 'AlbumAuthController@login');
    Route::post('/auth/logout', 'AlbumAuthController@logout');

    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/auth/info', 'AlbumAuthController@info');

        // 七牛token
        Route::post('/qiniu/token', 'AlbumQiniuController@token');

        // 参数设置
        Route::get('/setting', 'AlbumSettingController@index');
        Route::post('/setting', 'AlbumSettingController@update');

        // 用户管理
        Route::get('/user', 'AlbumUserController@index');
        Route::post('/user', 'AlbumUserController@update');

        // 影集管理
        Route::get('/album', 'AlbumAlbumController@index');
        Route::get('/album/{id}', 'AlbumAlbumController@detail');
        Route::post('/album/{id}', 'AlbumAlbumController@update');

        // 音乐管理
        Route::get('/music', 'AlbumMusicController@index');
        Route::post('/music', 'AlbumMusicController@update');
        Route::delete('/music/{id}', 'AlbumMusicController@delete');

        // 模板分类管理
        Route::get('/cate', 'AlbumCateController@index');
        Route::post('/cate', 'AlbumCateController@update');
        Route::delete('/cate/{id}', 'AlbumCateController@delete');

        // 模板管理
        Route::get('/skin', 'AlbumSkinController@index');
        Route::get('/skin_options', 'AlbumSkinController@options');
        Route::get('/skin/{id}', 'AlbumSkinController@detail');
        Route::post('/skin/{id}', 'AlbumSkinController@update');

        // 广告管理
        Route::get('/ad', 'AlbumAdController@index');
        Route::get('/ad/{id}', 'AlbumAdController@detail');
        Route::post('/ad/{id}', 'AlbumAdController@update');
        Route::delete('/ad/{id}', 'AlbumAdController@delete');
    });

});

// album 前台接口. 兼容原有前端逻辑（url参数等）
Route::any('/album', 'AlbumController@do')->middleware('checkMiniSign');
