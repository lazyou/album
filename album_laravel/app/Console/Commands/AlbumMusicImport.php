<?php

namespace App\Console\Commands;

use App\Models\AlbumMusic;
use App\Models\AlbumSkin;
use GuzzleHttp\Client;
use Illuminate\Console\Command;

class AlbumMusicImport extends Command
{
    protected $signature = 'album:music_import';

    protected $description = '相册音乐下载并导入到数据库';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $this->mapSkinMusic();
        dd();

        $dir = './public/images/album/music/';
        $dbDir = 'images/album/music/';
        if (! file_exists($dir)) {
            mkdir($dir, 0777, true);
        }

        $client = new Client();
        $list = $this->getData();
        foreach ($list as $item) {
            $title = trim($item['title']);
            $m = AlbumMusic::where('title', $title)->first();
            if ($m) {
                $this->error("已存在: {$title}");
            } else {
                $md5 = md5($title);
                $filename = "{$dir}{$md5}.mp3";
                $dbFilename = "{$dbDir}{$md5}.mp3";
                $client->request('GET', $item['music'], ['save_to' => $filename]);
                AlbumMusic::create([
                    'uniacid' => 0,
                    'title' => $title,
                    'music' => $dbFilename,
                ]);

                $this->error("新增: {$title}");
            }
        }
    }

    protected function getData()
    {
        return [
            [
                'title' => '龙凤呈祥',
                'music' => 'http://res2.eqh5.com/store/0d264de7ec22117fbd52dff8933afb55.mp3',
            ],
            [
                'title' => '终于到家',
                'music' => 'http://res2.eqh5.com/store/59cfe6dff7b099c668df4485a2a268e4.mp3',
            ],
            [
                'title' => '五谷丰登',
                'music' => 'http://res2.eqh5.com/store/87a1fecc8dae96e41d914b8481766168.mp3',
            ],
            [
                'title' => '生来成功',
                'music' => 'http://res2.eqh5.com/store/3848035e092e9e652b5fa7c1c8ff5c0d.mp3',
            ],
            [
                'title' => '雨中漫步',
                'music' => 'http://res2.eqh5.com/group1/M00/49/68/yq0KA1TTMLWAEOaEAAIu5SAL7lc430.mp3',
            ],
            [
                'title' => '菊次郎的夏天',
                'music' => 'http://res2.eqh5.com/group3/M00/7E/E0/yq0KZVXS7naAUz2AAAarwAcCdyw250.mp3',
            ],
            [
                'title' => '风铃',
                'music' => 'http://res2.eqh5.com/group1/M00/49/64/yq0KA1TTMJGAZMQhAAGAeC0BwTw501.mp3',
            ],
            [
                'title' => '小苹果',
                'music' => 'http://res2.eqh5.com/group1/M00/49/68/yq0KA1TTMLSAfDEOAAJmzpuRWDQ644.mp3',
            ],
            [
                'title' => '旧时光的好时光',
                'music' => 'http://res2.eqh5.com/store/68534298637474cf0c45dc92ee301d84.mp3',
            ],
            [
                'title' => '看星星',
                'music' => 'http://res2.eqh5.com/store/6ca96de740f6f79cb3224a29e8da24bc.mp3',
            ],
            [
                'title' => '海中捞月',
                'music' => 'http://res1.eqh5.com/store/c1029ece9565c484c74c921dea2d9c95.mp3',
            ],
            [
                'title' => '阖家欢乐',
                'music' => 'http://res1.eqh5.com/store/242fb3fd426bec98ccbcadad5526be2a.mp3',
            ],
            [
                'title' => '霸王风月',
                'music' => 'http://res1.eqh5.com/store/a22fff5ddcbb39d645213ff6de7ecfca.mp3',
            ],
            [
                'title' => '富贵吉祥',
                'music' => 'http://res1.eqh5.com/store/803f4449d34b12f9882a2ce0466807f2.mp3',
            ],
            [
                'title' => '万家灯火',
                'music' => 'http://res1.eqh5.com/store/a93f63f447dbbadad0a5172050df396b.mp3',
            ],
            [
                'title' => '美丽天气',
                'music' => 'http://res1.eqh5.com/store/a93f63f447dbbadad0a5172050df396b.mp3',
            ],
            [
                'title' => '轻松小调',
                'music' => 'http://res1.eqh5.com/store/2ac731fc0eae66f77292ed2c4e34b0b5.mp3',
            ],
            [
                'title' => '山间田野',
                'music' => 'http://res1.eqh5.com/store/81f534acf41f9f90b85cc8e30810ab46.mp3',
            ],
            [
                'title' => '彩色糖纸',
                'music' => 'http://res1.eqh5.com/store/7200fa0eafcf79e1106ed3c3aa30c609.mp3',
            ],
            [
                'title' => '心事释怀',
                'music' => 'http://res1.eqh5.com/store/922cd6dbefb8d220a2dc7a1b76e3f31a.mp3',
            ],
            [
                'title' => '浪漫月光',
                'music' => 'http://res1.eqh5.com/store/59c1dff220f9b392504a1e0e304710e0.mp3',
            ],
            [
                'title' => '愉悦假日',
                'music' => 'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            ],
            [
                'title' => '慵懒时光',
                'music' => 'http://res1.eqh5.com/store/81b23eb661cfdd6c7ae0a66a5fb30822.mp3',
            ],
            [
                'title' => '手心温度',
                'music' => 'http://res1.eqh5.com/store/feaa77591388ae2ccccbd72399c72679.mp3',
            ],
            [
                'title' => '拨云见日',
                'music' => 'http://res1.eqh5.com/store/808addbdbeb5742583e45a5833e7218b.mp3',
            ],
            [
                'title' => '放松享受',
                'music' => 'http://res1.eqh5.com/store/535e90b4c011807800225792f24f9a5c.mp3',
            ],
            [
                'title' => '旧日留声',
                'music' => 'http://res1.eqh5.com/store/a7e14dcae1eeab5eb51efcb301857fe0.mp3',
            ],
            [
                'title' => '时间滴答',
                'music' => 'http://res1.eqh5.com/store/789d51840d3683a5dfee5fc59c3627ba.mp3',
            ],
            [
                'title' => '春暖花开',
                'music' => 'http://res1.eqh5.com/store/d48205de3e143d53f2c1997be6dfffbd.mp3',
            ],
            [
                'title' => '森林雪花',
                'music' => 'http://res1.eqh5.com/store/c48e3399fd189287faf95e9b6a1f0024.mp3',
            ],
            [
                'title' => '期盼未来',
                'music' => 'http://res1.eqh5.com/store/c631c78215c6902cea41080211bca7b9.mp3',
            ],
            [
                'title' => '梦想天堂',
                'music' => 'http://res1.eqh5.com/store/c02b13e61434aa53bc3655b1a3c0c494.mp3',
            ],
            [
                'title' => '每次呼吸',
                'music' => 'http://res1.eqh5.com/store/a91940dda4e935b2ba55ff8611de4a96.mp3',
            ],
            [
                'title' => '温暖的心',
                'music' => 'http://res1.eqh5.com/store/db31435eef88c44cd1290a7c67193006.mp3',
            ],
            [
                'title' => '流金岁月',
                'music' => 'http://res1.eqh5.com/store/200d3ab205bc82e6fe76edf2abc9d291.mp3',
            ],
        ];
    }

    // 映射导入的主题与音乐（音乐一般是从上面下载的）
    protected function mapSkinMusic()
    {
        $skinMusicMap = [
            '迷人紫色' =>	'http://res1.eqh5.com/store/200d3ab205bc82e6fe76edf2abc9d291.mp3',
            '乡村田野' =>	'http://res1.eqh5.com/store/db31435eef88c44cd1290a7c67193006.mp3',
            '相依相恋' =>	'http://res1.eqh5.com/store/c48e3399fd189287faf95e9b6a1f0024.mp3',
            '相偎一生' =>	'http://res1.eqh5.com/store/789d51840d3683a5dfee5fc59c3627ba.mp3',
            '乡间田野' =>	'http://res1.eqh5.com/store/a7e14dcae1eeab5eb51efcb301857fe0.mp3',
            '新的一天' =>	'http://res1.eqh5.com/store/c631c78215c6902cea41080211bca7b9.mp3',
            '大好河山' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '伊人景色' =>	'http://res1.eqh5.com/store/242fb3fd426bec98ccbcadad5526be2a.mp3',
            '梦幻境界' =>	'http://res1.eqh5.com/store/808addbdbeb5742583e45a5833e7218b.mp3',
            '元宵佳节' =>	'http://res2.eqh5.com/store/0d264de7ec22117fbd52dff8933afb55.mp3',
            '元宵快乐' =>	'http://res2.eqh5.com/store/0d264de7ec22117fbd52dff8933afb55.mp3',
            '闹元宵' =>	'http://res2.eqh5.com/store/0d264de7ec22117fbd52dff8933afb55.mp3',
            '花香袭人' =>	'http://res1.eqh5.com/store/2ac731fc0eae66f77292ed2c4e34b0b5.mp3',
            '绚丽花海' =>	'http://res1.eqh5.com/store/a93f63f447dbbadad0a5172050df396b.mp3',
            '静谧庄园' =>	'http://res1.eqh5.com/store/242fb3fd426bec98ccbcadad5526be2a.mp3',
            '岁月静好' =>	'http://res1.eqh5.com/store/d48205de3e143d53f2c1997be6dfffbd.mp3',
            '春意盎然' =>	'http://res1.eqh5.com/store/535e90b4c011807800225792f24f9a5c.mp3',
            '缤纷时节' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '春暖花开' =>	'http://res1.eqh5.com/store/feaa77591388ae2ccccbd72399c72679.mp3',
            '早春盛开' =>	'http://res1.eqh5.com/store/db31435eef88c44cd1290a7c67193006.mp3',
            '水墨山水' =>	'http://res1.eqh5.com/store/c02b13e61434aa53bc3655b1a3c0c494.mp3',
            '女神节' =>	'http://res1.eqh5.com/store/a93f63f447dbbadad0a5172050df396b.mp3',
            '黄昏云海' =>	'http://res1.eqh5.com/store/535e90b4c011807800225792f24f9a5c.mp3',
            '唯美山水' =>	'http://res1.eqh5.com/store/789d51840d3683a5dfee5fc59c3627ba.mp3',
            '粉色心语' =>	'http://res1.eqh5.com/store/535e90b4c011807800225792f24f9a5c.mp3',
            '深情玫瑰' =>	'http://res1.eqh5.com/store/59c1dff220f9b392504a1e0e304710e0.mp3',
            '浓情玫瑰' =>	'http://res1.eqh5.com/store/7200fa0eafcf79e1106ed3c3aa30c609.mp3',
            '你好春天' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '清明时节' =>	'http://res1.eqh5.com/store/a7e14dcae1eeab5eb51efcb301857fe0.mp3',
            '赏春之行' =>	'http://res1.eqh5.com/store/808addbdbeb5742583e45a5833e7218b.mp3',
            '踏春而行' =>	'http://res1.eqh5.com/store/81f534acf41f9f90b85cc8e30810ab46.mp3',
            '踏春赏花' =>	'http://res1.eqh5.com/store/535e90b4c011807800225792f24f9a5c.mp3',
            '玫瑰印记' =>	'http://res1.eqh5.com/store/81b23eb661cfdd6c7ae0a66a5fb30822.mp3',
            '哈喽四月' =>	'http://res1.eqh5.com/store/db31435eef88c44cd1290a7c67193006.mp3',
            '草原蓝天' =>	'http://res1.eqh5.com/store/c631c78215c6902cea41080211bca7b9.mp3',
            '春至美景' =>	'http://res1.eqh5.com/store/535e90b4c011807800225792f24f9a5c.mp3',
            '海边相遇' =>	'http://res1.eqh5.com/store/feaa77591388ae2ccccbd72399c72679.mp3',
            '快乐庆生' =>	'http://res1.eqh5.com/store/a93f63f447dbbadad0a5172050df396b.mp3',
            '浪漫热气球' =>	'http://res1.eqh5.com/store/7200fa0eafcf79e1106ed3c3aa30c609.mp3',
            '美丽邂逅' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '保持童心' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '花样六一' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '放飞梦想' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '六一快乐' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '童心童乐' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
            '萌趣童心' =>	'http://res1.eqh5.com/store/7abad475fdbed6a6669f7ca76472991b.mp3',
        ];

        $data = $this->getData();
        $musicMap = [];
        foreach ($data as $item) {
            $musicMap[$item['music']] = $item['title'];
        }

        $dbDir = 'images/album/music/';
        foreach ($skinMusicMap as $skinName => $mp3) {
            if (isset($musicMap[$mp3])) {
                $title = $musicMap[$mp3];
                $md5 = md5($title);
                $dbFilename = "{$dbDir}{$md5}.mp3";
                $this->info("找到音乐： 皮肤{$skinName}");
                AlbumSkin::where('title', $skinName)->update([
                    'music' => $dbFilename
                ]);
            } else {
                $this->error("未找到音乐： 皮肤{$skinName}");
            }
        }
    }
}
