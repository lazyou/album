<?php

namespace App\Console\Commands;

use App\Models\AlbumSkinCate;
use Illuminate\Console\Command;

class AlbumSkinCateImport extends Command
{
    protected $signature = 'album:skin_cate_import';

    protected $description = '影集皮肤分类导入';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $cates = [
            [
                'id' => 1,
                'title' => '甜蜜',
            ],
            [
                'id' => 2,
                'title' => '唯美',
            ],
            [
                'id' => 3,
                'title' => '节日',
            ],
            [
                'id' => 4,
                'title' => '温馨',
            ],
        ];

        foreach ($cates as $cate) {
            $item = AlbumSkinCate::find($cate['id']);
            if ($item) {
                $this->error("已存在： {$item->id} -- {$item->title}");
                continue;
            }

            $item = AlbumSkinCate::create([
                'id' => $cate['id'],
                'title' => $cate['title'],
                'uniacid' => 0,
                'displayorder' => 0,
            ]);
            if ($item) {
                $this->info("创建成功： {$item->id} -- {$item->title}");
                continue;
            }
        }
    }
}
