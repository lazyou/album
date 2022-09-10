<?php

namespace App\Models;

/**
 * 设置表
 * Class AlbumSetting
 * @package App\Models
 */
class AlbumSetting extends Base
{
    protected $table = 'album_setting';

    protected $fillable = [
        'appname',
        'phototitle',
        'zimu',
        'touxiang',
        'sharetitle',
        'shareimg',
        'indexbtn',
        'flowerbtn',
        'sharebtn',
        'savebtn',
        'editbtn',
        'addapp',
        'addapp1',
        'llads',
        'userllads',
        'albumllads',
        'skinllads',
        'albumads',
        'albumconads',
    ];
}
