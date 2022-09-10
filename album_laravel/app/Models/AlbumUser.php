<?php

namespace App\Models;

/**
 * 用户表
 * Class AlbumUser
 * @package App\Models
 */
class AlbumUser extends Base
{
    protected $table = 'album_user';

    protected $primaryKey = 'uid';

    protected $fillable = [
        'uniacid',
        'openid',
        'nickname',
        'avatar',
        'fee',
        'souce',
        'status',
    ];
}
