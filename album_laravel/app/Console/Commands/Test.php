<?php

namespace App\Console\Commands;

use App\Models\AlbumSkin;
use Illuminate\Console\Command;

/**
 * Class Test
 * @package App\Console\Commands
 * 各种测试用脚本
 */
class Test extends Command
{
    protected $signature = 'test';

    protected $description = '各种测试用脚本';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $this->info('test start:');
        $host = 'http://xinxiangce.laizhouhao.com/';
        $list = AlbumSkin::all();
        foreach ($list as $item) {
            $thumbURL = "{$host}{$item->thumb}";
            $bgimgURL = "{$host}{$item->bgimg}";
            $muiscURL = $item->music;

            $this->download($thumbURL);

        }
    }

    protected function download($url)
    {
        $arr = parse_url($url);
        $path = ".{$arr['path']}";
        $pathArr = pathinfo($path);
        $saveDir = $pathArr['dirname'];
        if (! file_exists($saveDir)) {
            mkdir($saveDir, 0777, true);
        }
dd($url, $path);
        $file = file_get_contents($url);
        $res = file_put_contents($path, $file);
        dd($res);

        exit();
    }
}
