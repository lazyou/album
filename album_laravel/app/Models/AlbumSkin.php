<?php

namespace App\Models;

/**
 * 皮肤表
 * Class AlbumSkin
 * @package App\Models
 */
class AlbumSkin extends Base
{
    protected $table = 'album_skin';

    protected $fillable = [
        'id',
        'uniacid',
        'cid',
        'displayorder',
        'title',
        'otitle',
        'thumb',
        'model',
        'ani',
        'music',
        'bgimg',
        'frameimg',
        'def',
        'remoted',
        'ishide',
        'ishot',
    ];

    // 一对一: 所属分类
    public function cate()
    {
        return $this->hasOne(AlbumSkinCate::class, 'id', 'cid');
    }
}
