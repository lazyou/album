<?php

namespace App\Console\Commands;

use App\Models\AlbumSkin;
use Illuminate\Console\Command;

class AlbumSkinImport extends Command
{
    protected $signature = 'album:skin_import';

    protected $description = '影集皮肤导入';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $skins = [
            [
                "id" => 65,
                "cid" => 3,
                "thumb" => "images/album/skin/43/thumb.jpg",
                "bgimg" => "images/album/skin/43/bg.jpg",
                "frameimg" => "",
                "title" => "保持童心",
                "ishot" => 0,
                "model" => "2",
                "ani" => "k",
            ],
            [
                "id" => 69,
                "cid" => 3,
                "thumb" => "images/album/skin/47/thumb.jpg",
                "bgimg" => "images/album/skin/47/bg.jpg",
                "frameimg" => "",
                "title" => "童心童乐",
                "ishot" => 0,
                "model" => "2",
                "ani" => "c",
            ],
            [
                "id" => 68,
                "cid" => 3,
                "thumb" => "images/album/skin/46/thumb.jpg",
                "bgimg" => "images/album/skin/46/bg.jpg",
                "frameimg" => "",
                "title" => "六一快乐",
                "ishot" => 0,
                "model" => "1",
                "ani" => "d",
            ],
            [
                "id" => 67,
                "cid" => 3,
                "thumb" => "images/album/skin/45/thumb.jpg",
                "bgimg" => "images/album/skin/45/bg.jpg",
                "frameimg" => "",
                "title" => "放飞梦想",
                "ishot" => 0,
                "model" => "3",
                "ani" => "k",
            ],
            [
                "id" => 66,
                "cid" => 3,
                "thumb" => "images/album/skin/44/thumb.jpg",
                "bgimg" => "images/album/skin/44/bg.jpg",
                "frameimg" => "",
                "title" => "花样六一",
                "ishot" => 0,
                "model" => "4",
                "ani" => "f",
            ],
            [
                "id" => 70,
                "cid" => 3,
                "thumb" => "images/album/skin/48/thumb.jpg",
                "bgimg" => "images/album/skin/48/bg.jpg",
                "frameimg" => "",
                "title" => "萌趣童心",
                "ishot" => 0,
                "model" => "3",
                "ani" => "e",
            ],
            [
                "id" => 59,
                "cid" => 2,
                "thumb" => "images/album/skin/37/thumb.jpg",
                "bgimg" => "images/album/skin/37/bg.jpg",
                "frameimg" => "",
                "title" => "草原蓝天",
                "ishot" => 0,
                "model" => "3",
                "ani" => "e",
            ],
            [
                "id" => 58,
                "cid" => 2,
                "thumb" => "images/album/skin/36/thumb.jpg",
                "bgimg" => "images/album/skin/36/bg.jpg",
                "frameimg" => "",
                "title" => "哈喽四月",
                "ishot" => 0,
                "model" => "2",
                "ani" => "e",
            ],
            [
                "id" => 60,
                "cid" => 1,
                "thumb" => "images/album/skin/38/thumb.jpg",
                "bgimg" => "images/album/skin/38/bg.jpg",
                "frameimg" => "",
                "title" => "春至美景",
                "ishot" => 0,
                "model" => "2",
                "ani" => "f",
            ],
            [
                "id" => 61,
                "cid" => 1,
                "thumb" => "images/album/skin/39/thumb.jpg",
                "bgimg" => "images/album/skin/39/bg.jpg",
                "frameimg" => "",
                "title" => "海边相遇",
                "ishot" => 0,
                "model" => "2",
                "ani" => "e",
            ],
            [
                "id" => 62,
                "cid" => 1,
                "thumb" => "images/album/skin/40/thumb.jpg",
                "bgimg" => "images/album/skin/40/bg.jpg",
                "frameimg" => "",
                "title" => "快乐庆生",
                "ishot" => 0,
                "model" => "3",
                "ani" => "c",
            ],
            [
                "id" => 63,
                "cid" => 1,
                "thumb" => "images/album/skin/41/thumb.jpg",
                "bgimg" => "images/album/skin/41/bg.jpg",
                "frameimg" => "",
                "title" => "浪漫热气球",
                "ishot" => 0,
                "model" => "2",
                "ani" => "e",
            ],
            [
                "id" => 64,
                "cid" => 1,
                "thumb" => "images/album/skin/42/thumb.jpg",
                "bgimg" => "images/album/skin/42/bg.jpg",
                "frameimg" => "",
                "title" => "美丽邂逅",
                "ishot" => 0,
                "model" => "2",
                "ani" => "k",
            ],
            [
                "id" => 50,
                "cid" => 1,
                "thumb" => "images/album/skin/28/thumb.jpg",
                "bgimg" => "images/album/skin/28/bg.jpg",
                "frameimg" => "",
                "title" => "深情玫瑰",
                "ishot" => 0,
                "model" => "3",
                "ani" => "e",
            ],
            [
                "id" => 51,
                "cid" => 1,
                "thumb" => "images/album/skin/29/thumb.jpg",
                "bgimg" => "images/album/skin/29/bg.jpg",
                "frameimg" => "",
                "title" => "浓情玫瑰",
                "ishot" => 0,
                "model" => "2",
                "ani" => "c",
            ],
            [
                "id" => 52,
                "cid" => 2,
                "thumb" => "images/album/skin/30/thumb.jpg",
                "bgimg" => "images/album/skin/30/bg.jpg",
                "frameimg" => "",
                "title" => "你好春天",
                "ishot" => 0,
                "model" => "2",
                "ani" => "a",
            ],
            [
                "id" => 53,
                "cid" => 3,
                "thumb" => "images/album/skin/31/thumb.jpg",
                "bgimg" => "images/album/skin/31/bg.jpg",
                "frameimg" => "",
                "title" => "清明时节",
                "ishot" => 0,
                "model" => "2",
                "ani" => "h",
            ],
            [
                "id" => 54,
                "cid" => 1,
                "thumb" => "images/album/skin/32/thumb.jpg",
                "bgimg" => "images/album/skin/32/bg.jpg",
                "frameimg" => "",
                "title" => "赏春之行",
                "ishot" => 0,
                "model" => "2",
                "ani" => "f",
            ],
            [
                "id" => 55,
                "cid" => 2,
                "thumb" => "images/album/skin/33/thumb.jpg",
                "bgimg" => "images/album/skin/33/bg.jpg",
                "frameimg" => "",
                "title" => "踏春而行",
                "ishot" => 0,
                "model" => "2",
                "ani" => "d",
            ],
            [
                "id" => 56,
                "cid" => 2,
                "thumb" => "images/album/skin/34/thumb.jpg",
                "bgimg" => "images/album/skin/34/bg.jpg",
                "frameimg" => "",
                "title" => "踏春赏花",
                "ishot" => 0,
                "model" => "2",
                "ani" => "k",
            ],
            [
                "id" => 57,
                "cid" => 1,
                "thumb" => "images/album/skin/35/thumb.jpg",
                "bgimg" => "images/album/skin/35/bg.jpg",
                "frameimg" => "",
                "title" => "玫瑰印记",
                "ishot" => 0,
                "model" => "2",
                "ani" => "e",
            ],
            [
                "id" => 49,
                "cid" => 3,
                "thumb" => "images/album/skin/27/thumb.jpg",
                "bgimg" => "images/album/skin/27/bg.jpg",
                "frameimg" => "",
                "title" => "粉色心语",
                "ishot" => 0,
                "model" => "4",
                "ani" => "e",
            ],
            [
                "id" => 19,
                "cid" => 2,
                "thumb" => "images/album/skin/21/thumb.jpg",
                "bgimg" => "images/album/skin/21/bg.jpg",
                "frameimg" => "",
                "title" => "春暖花开",
                "ishot" => 0,
                "model" => "4",
                "ani" => "b",
            ],
            [
                "id" => 6,
                "cid" => 4,
                "thumb" => "images/album/skin/5/thumb.jpg",
                "bgimg" => "images/album/skin/5/bg.jpg",
                "frameimg" => "",
                "title" => "新的一天",
                "ishot" => 0,
                "model" => "2",
                "ani" => "l",
            ],
            [
                "id" => 24,
                "cid" => 2,
                "thumb" => "images/album/skin/26/thumb.jpg",
                "bgimg" => "images/album/skin/26/bg.jpg",
                "frameimg" => "",
                "title" => "唯美山水",
                "ishot" => 0,
                "model" => "2",
                "ani" => "d",
            ],
            [
                "id" => 11,
                "cid" => 3,
                "thumb" => "images/album/skin/13/thumb.jpg",
                "bgimg" => "images/album/skin/13/bg.jpg",
                "frameimg" => "",
                "title" => "元宵快乐",
                "ishot" => 0,
                "model" => "1",
                "ani" => "e,g",
            ],
            [
                "id" => 10,
                "cid" => 3,
                "thumb" => "images/album/skin/12/thumb.jpg",
                "bgimg" => "images/album/skin/12/bg.jpg",
                "frameimg" => "",
                "title" => "元宵佳节",
                "ishot" => 0,
                "model" => "1",
                "ani" => "e,g",
            ],
            [
                "id" => 9,
                "cid" => 4,
                "thumb" => "images/album/skin/8/thumb.jpg",
                "bgimg" => "images/album/skin/8/bg.jpg",
                "frameimg" => "",
                "title" => "梦幻境界",
                "ishot" => 0,
                "model" => "1",
                "ani" => "e",
            ],
            [
                "id" => 8,
                "cid" => 2,
                "thumb" => "images/album/skin/7/thumb.jpg",
                "bgimg" => "images/album/skin/7/bg.jpg",
                "frameimg" => "",
                "title" => "伊人景色",
                "ishot" => 0,
                "model" => "1",
                "ani" => "a",
            ],
            [
                "id" => 7,
                "cid" => 2,
                "thumb" => "images/album/skin/6/thumb.jpg",
                "bgimg" => "images/album/skin/6/bg.jpg",
                "frameimg" => "",
                "title" => "大好河山",
                "ishot" => 0,
                "model" => "4",
                "ani" => "a",
            ],
            [
                "id" => 5,
                "cid" => 2,
                "thumb" => "images/album/skin/4/thumb.jpg",
                "bgimg" => "images/album/skin/4/bg.jpg",
                "frameimg" => "",
                "title" => "乡间田野",
                "ishot" => 0,
                "model" => "2",
                "ani" => "b,l",
            ],
            [
                "id" => 4,
                "cid" => 4,
                "thumb" => "images/album/skin/3/thumb.jpg",
                "bgimg" => "images/album/skin/3/bg.jpg",
                "frameimg" => "",
                "title" => "相偎一生",
                "ishot" => 0,
                "model" => "3",
                "ani" => "e,c",
            ],
            [
                "id" => 3,
                "cid" => 4,
                "thumb" => "images/album/skin/11/thumb.jpg",
                "bgimg" => "images/album/skin/11/bg.jpg",
                "frameimg" => "images/album/skin/11/frame.png",
                "title" => "相依相恋",
                "ishot" => 0,
                "model" => "2",
                "ani" => "c,e",
            ],
            [
                "id" => 2,
                "cid" => 2,
                "thumb" => "images/album/skin/2/thumb.jpg",
                "bgimg" => "images/album/skin/2/bg.jpg",
                "frameimg" => "",
                "title" => "乡村田野",
                "ishot" => 0,
                "model" => "3",
                "ani" => "c",
            ],
            [
                "id" => 12,
                "cid" => 3,
                "thumb" => "images/album/skin/14/thumb.jpg",
                "bgimg" => "images/album/skin/14/bg.jpg",
                "frameimg" => "",
                "title" => "闹元宵",
                "ishot" => 0,
                "model" => "3",
                "ani" => "h",
            ],
            [
                "id" => 13,
                "cid" => 4,
                "thumb" => "images/album/skin/15/thumb.jpg",
                "bgimg" => "images/album/skin/15/bg.jpg",
                "frameimg" => "images/album/skin/15/frame.jpg",
                "title" => "花香袭人",
                "ishot" => 0,
                "model" => "2",
                "ani" => "h",
            ],
            [
                "id" => 23,
                "cid" => 2,
                "thumb" => "images/album/skin/25/thumb.jpg",
                "bgimg" => "images/album/skin/25/bg.jpg",
                "frameimg" => "",
                "title" => "黄昏云海",
                "ishot" => 0,
                "model" => "2",
                "ani" => "f",
            ],
            [
                "id" => 22,
                "cid" => 3,
                "thumb" => "images/album/skin/24/thumb.jpg",
                "bgimg" => "images/album/skin/24/bg.jpg",
                "frameimg" => "",
                "title" => "女神节",
                "ishot" => 0,
                "model" => "4",
                "ani" => "b",
            ],
            [
                "id" => 21,
                "cid" => 2,
                "thumb" => "images/album/skin/23/thumb.jpg",
                "bgimg" => "images/album/skin/23/bg.jpg",
                "frameimg" => "",
                "title" => "水墨山水",
                "ishot" => 0,
                "model" => "4",
                "ani" => "h",
            ],
            [
                "id" => 20,
                "cid" => 2,
                "thumb" => "images/album/skin/22/thumb.jpg",
                "bgimg" => "images/album/skin/22/bg.jpg",
                "frameimg" => "",
                "title" => "早春盛开",
                "ishot" => 0,
                "model" => "4",
                "ani" => "b",
            ],
            [
                "id" => 18,
                "cid" => 1,
                "thumb" => "images/album/skin/20/thumb.jpg",
                "bgimg" => "images/album/skin/20/bg.jpg",
                "frameimg" => "",
                "title" => "缤纷时节",
                "ishot" => 0,
                "model" => "4",
                "ani" => "a",
            ],
            [
                "id" => 17,
                "cid" => 2,
                "thumb" => "images/album/skin/19/thumb.jpg",
                "bgimg" => "images/album/skin/19/bg.jpg",
                "frameimg" => "",
                "title" => "春意盎然",
                "ishot" => 0,
                "model" => "4",
                "ani" => "b",
            ],
            [
                "id" => 16,
                "cid" => 1,
                "thumb" => "images/album/skin/18/thumb.jpg",
                "bgimg" => "images/album/skin/18/bg.jpg",
                "frameimg" => "",
                "title" => "岁月静好",
                "ishot" => 0,
                "model" => "4",
                "ani" => "a",
            ],
            [
                "id" => 15,
                "cid" => 2,
                "thumb" => "images/album/skin/17/thumb.jpg",
                "bgimg" => "images/album/skin/17/bg.jpg",
                "frameimg" => "",
                "title" => "静谧庄园",
                "ishot" => 0,
                "model" => "2",
                "ani" => "l,d",
            ],
            [
                "id" => 14,
                "cid" => 4,
                "thumb" => "images/album/skin/16/thumb.jpg",
                "bgimg" => "images/album/skin/16/bg.jpg",
                "frameimg" => "",
                "title" => "绚丽花海",
                "ishot" => 0,
                "model" => "2",
                "ani" => "f,d",
            ],
            [
                "id" => 1,
                "cid" => 2,
                "thumb" => "images/album/skin/1/thumb.jpg",
                "bgimg" => "images/album/skin/1/bg.jpg",
                "frameimg" => "",
                "title" => "迷人紫色",
                "ishot" => 0,
                "model" => "4",
                "ani" => "d",
            ],
        ];

        foreach ($skins as $skin) {
            $item = AlbumSkin::find($skin['id']);
            if ($item) {
                $this->error("已存在皮肤： {$item->title}");
                continue;
            }

            $skin['uniacid'] = 0;
            $skin['displayorder'] = 0;
            $skin['otitle'] = '';
            // TODO: 音乐地址已经失效
            $skin['music'] = '';
            $item = AlbumSkin::create($skin);
            if ($item) {
                $this->info("创建皮肤： {$item->title}");
                continue;
            }
        }
    }
}
