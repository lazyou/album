<?php

namespace App\Models;

/**
 * 相册数据表
 * Class AlbumData
 * @package App\Models
 */
class AlbumData extends Base
{
    protected $table = 'album_data';

    protected $fillable = [
        'uniacid',
        'openid',
        'nickname',
        'avatar',
        'title',
        'skin',
        'thumb',
        'imgdata',
        'txtdata',
        'music',
        'click',
        'share',
        'best',
        'private',
        'status',
        'ishot',
    ];
}
