<?php

namespace App\Models;

/**
 * 音乐表
 * Class AlbumMusic
 * @package App\Models
 */
class AlbumMusic extends Base
{
    protected $table = 'album_music';

    protected $fillable = [
        'uniacid',
        'title',
        'music',
    ];
}
