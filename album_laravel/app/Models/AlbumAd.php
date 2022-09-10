<?php

namespace App\Models;

/**
 * 广告表
 * Class AlbumAd
 * @package App\Models
 */
class AlbumAd extends Base
{
    protected $table = 'album_ads';

    protected $fillable = [
        'uniacid',
        'displayorder',
        'thumb',
        'title',
        'text',
        'path',
        'weizhi',
        'istype',
        'appid',
    ];
}
