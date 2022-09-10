<?php

namespace App\Models;

/**
 * 皮肤分类表
 * Class AlbumSkinCate
 * @package App\Models
 */
class AlbumSkinCate extends Base
{
    protected $table = 'album_skincate';

    protected $fillable = [
        'id',
        'uniacid',
        'displayorder',
        'title',
    ];
}
