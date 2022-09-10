<?php

namespace App\Http\Controllers;

use App\Models\AlbumAd;
use App\Models\AlbumData;
use App\Models\AlbumMusic;
use App\Models\AlbumSetting;
use App\Models\AlbumSkin;
use App\Models\AlbumSkinCate;
use App\Models\AlbumUser;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Storage;

class AlbumController extends Controller
{
    public function do(Request $request)
    {
        $do = $request->get('do');
        if (method_exists($this, $do)) {
            return $this->$do($request);
        } else {
            return response()->json(['err' => "do({$do}) not exist!"], 400);
        }
    }

    public function config(Request $request)
    {
        $setting = AlbumSetting::first();
        $data = [
            "appname" => $setting->appname,
            "phototitle" => $setting->phototitle,
            "shareimg" => $setting->shareimg,
            "sharetitle" => $setting->sharetitle,
//            "url" => "http://xinxiangce.laizhouhao.com/",
            // url: 此配置在小程序的图片地址等地方有用到
//            "url" => "http://www.album.test/",
//            "url" => env('QINIU_DOMAIN'),
            "qiniuurl" => env('QINIU_DOMAIN'),
            "isvideo" => 1,
            "zimu" => $setting->zimu,
            "albumads" => $setting->albumads,
            "albumconads" => $setting->albumconads,
            "ispay" => 0,
            "isios" => 0,
            "monimg" => $setting->monimg,
            "paytype" => 0,
            "payappid" => "",
            "paypath" => "",
            "paycon" => "",
            "fee" => [
                "", "", "", "", "", ""
            ],
            "monbtn" => $setting->monbtn,
            "kfopen" => 0,
            "weburl" => $setting->weurl,
            "webbtn" => $setting->webbtn,
            "albumurl" => $setting->albumurl,
            "editbtn" => $setting->editbtn,
            "jubaobtn" => "",
            "sharebtn" => $setting->sharebtn,
            "flowerbtn" => $setting->flowerbtn,
            "indexbtn" => $setting->indexbtn,
            "llads" => $setting->llads,
            "iscustom" => 0,
            "aid" => $setting->aid,
            "addapp" => $setting->addapp,
            "addapp1" => $setting->addapp1,
            "savebtn" => $setting->savebtn,
            "ishared" => "0",
            "shareurl" => $setting->shareurl,
            "userllads" => $setting->userllads,
            "albumllads" => $setting->albumllads,
            "skinllads" => $setting->skinllads,
            "touxiang" => $setting->touxiang,
        ];

        return response()->json($data);
    }

    // 根据code获取openid
    public function login(Request $request)
    {
        return $this->openid($request);
    }

    // TODO: 首页广告
    public function indexad(Request $request)
    {
        $data = [];

        // 位置： 精彩影集 -- 居中靠右图片 -- 新消息
        $indexpf = AlbumAd::where('weizhi', 1)->first();
        if ($indexpf) {
            $data['indexpf'] = $indexpf;
        }

        // 位置： 精彩影集 -- 轮播图广告。 appid 必须在 小程序的 tominiprogram 里
        $hd = AlbumAd::where('weizhi', 4)->orderBy('displayorder')->get()->toArray();
        if ($hd) {
            $data['hd'] = $hd;
        }

        return response()->json($data);
    }

    public function skindata(Request $request)
    {
        $skincate = AlbumSkinCate::orderBy('displayorder')->get(['id', 'title'])->toArray();
        $skindata = AlbumSkin::where('ishide', 0)
            ->orderBy('ishot', 'DESC')
            ->orderBy('id', 'DESC')
            ->get(['id', 'cid', 'thumb', 'title', 'ishot'])
            ->toArray();
        $data = [
            'skincate' => $skincate,
            'skindata' => $skindata,
        ];

        return response()->json($data);
    }

    // 首页 -- 精彩影集
    public function indexdata(Request $request)
    {
        $fields = [
            'avatar',
            'nickname',
            'title',
            'thumb',
            'id',
            'click',
            'best',
        ];
        $limit = 5;
        $page = $request->get('page', 1);
        $ishot = $request->get('ishot', 0);
        $offset = ($page - 1) * $limit;
        $where = [
            'status' => 0,
            'private' => 0,
        ];
        if ($ishot) {
            $where['ishot'] = $ishot;
        }

        $list = AlbumData::where($where)
            ->offset($offset)
            ->limit($limit)
            ->orderBy('created_at', 'DESC')
            ->get($fields)
            ->toArray();

        return response()->json($list);
    }

    // 相册送花统计
    public function posthua(Request $request)
    {
        $id = $request->get('id', 0);
        $item = AlbumData::find($id);
        if ($item) {
            $item->best++;
            $item->save();
        }
    }

    // 相册点播统计
    public function clickdata(Request $request)
    {
        $id = $request->get('id', 0);
        $item = AlbumData::find($id);
        if ($item) {
            $item->click++;
            $item->save();
        }
    }

    // TODO: 前端应该还有个分享统计

    public function upform(Request $request)
    {
        $data = [
            'err' => '小程序bug： the formId is no longer available in develop or trial version of this mini program',
        ];
        return response()->json($data, 400);
    }

    // 获取七牛token
    public function uptoken(Request $request)
    {
        $accessKey = env('QINIU_ACCESS_KEY');
        $secretKey = env('QINIU_SECRET_KEY');
        $bucket = env('QINIU_BUCKET');
        $key = $request->get('key', null); // 也就是文件名

        $date = date('Ymd');
        $microtime = microtime();
        $name = $request->get('name', '');
        $size = $request->get('size', 0);
        $type = $request->get('type', '');
        if (empty($key)) {
            $new = md5("{$microtime}{$name}");
            $pathArr = pathinfo($name);
            // TODO: 文件名若不带后缀则上传时也没有文件后缀
            $ext = $pathArr['extension'] ? ".{$pathArr['extension']}" : '';
            $key = "album/{$date}/{$new}{$ext}";
        }

        $auth = new \Qiniu\Auth($accessKey, $secretKey);
        $upToken = $auth->uploadToken($bucket, $key, 3600, null, true);
        $url = env('QINIU_DOMAIN') . $key; // 如果上传成功的文件访问地址

        return response()->json([
            'key' => $key,
            'url' => $url,
            'token' => $upToken,
        ], 200);
    }

    // 相册图片上传
    public function upimgRename(Request $request)
    {
        $url = "";
        if ($request->hasFile('file') && $request->file('file')->isValid()) {
            $file = $request->file('file');
            $nameMD5 = md5($file->getClientOriginalName());
            $extension = $file->extension();
            $todayDate = date('Ymd');

            $dir = "public/images/$todayDate";
            $filename = "{$nameMD5}.{$extension}";
            $path = $file->storeAs($dir, $filename);
            $path = Storage::url($path);
            $url = url($path);
        }

        return $url;
    }

    public function savephotos(Request $request)
    {
        $thumb = '';
        $imgdataArr = explode(',', $request->get('imgdata'));
        if ($imgdataArr) {
            $thumb = $imgdataArr[0];
        }

        $music = '';
        $skinItem = AlbumSkin::find($request->get('skin', 0));
        if ($skinItem) {
            $music = $skinItem->music;
        }

        $item = AlbumData::create([
            'uniacid' => 0,
            'openid' => $request->get('userid'),
            'title' => '打开看看，这是我做的影集',
            'txtdata' => '',
            'music' => $music,
            'click' => 0,
            'share' => 0,
            'thumb' => $thumb,
            "imgdata" => $request->get('imgdata'),
            "skin" => $request->get('skin'),
            "nickname" => $request->get('nickname'),
            "avatar" => $request->get('avatar'),
        ]);

        return response()->json([
            'photoid' => $item->id,
        ]);
    }

    // 影集私密与公开设置
    public function setprivate(Request $request)
    {
        $id = $request->get('id', 0);
        $uid = $request->get('uid', 0);
        $private = (int)$request->get('private', 0);
        $private = ($private == 0) ? 1 : 0;
        $item = AlbumData::where('openid', $uid)->find($id);
        if ($item) {
            $item->private = $private;
            $item->save();

            $data = [
                "status" => 1,
                "private" => (int) $item->private,
            ];

            return response()->json($data);
        }
    }

    // 删除影集
    public function delalbum(Request $request)
    {
        $id = $request->get('id', 0);
        $uid = $request->get('uid', 0);
        $item = AlbumData::where('openid', $uid)->find($id);
        if ($item) {
            $item->delete();
            $data = [
                "status" => 1,
            ];

            return response()->json($data);
        }
    }

    public function saveuser(Request $request)
    {
        $data = [
            'status' => 1,
        ];
        $nickname = $request->get('nickname', '');
        $openid = $request->get('openid', '');
        $avatar = $request->get('avatar', '');
        if ($openid && $nickname && $avatar) {
            $user = AlbumUser::where('openid', $openid)->first();
            if ($user) {
                $user->nickname = $nickname;
                $user->avatar = $avatar;
                $user->save();
            } else {
                $user = AlbumUser::create([
                    'uniacid' => 0,
                    'openid' => $openid,
                    'nickname' => $nickname,
                    'avatar' => $avatar,
                    'fee' => 0,
                    'souce' => 0,
                    'status' => 0,
                ]);
            }

            $data['status'] = $user->status;
        }

        return response()->json($data);
    }

    // 影集改标题
    public function savetitle(Request $request)
    {
        $id = $request->get('id', 0);
        $uid = $request->get('uid', 0);
        $title = $request->get('title', '');
        $item = AlbumData::where('openid', $uid)->find($id);
        if ($item) {
            $item->title = $title;
            $item->save();
        }
    }

    // 影集图片顺序调整
    public function saveimg(Request $request)
    {
        $id = $request->get('id', 0);
        $uid = $request->get('uid', 0);
        $imgdata = $request->get('imgdata', '');
        $item = AlbumData::where('openid', $uid)->find($id);
        if ($item) {
            $item->imgdata = $imgdata;
            $item->save();
        }
    }

    // 影集照片名称编辑
    public function savetxt(Request $request)
    {
        $id = $request->get('id', 0);
        $uid = $request->get('uid', 0);
        $txtdata = $request->get('txtdata', '');
        $item = AlbumData::where('openid', $uid)->find($id);
        if ($item) {
            $item->txtdata = $txtdata;
            $item->save();
        }
    }
    // 影集配置信息
    public function photodata(Request $request)
    {
        $ad1 = [];
        $ad2 = [];
        $skinID = 0;
        $albumData = [];
        $skinData = [];

        $ad1Item = AlbumAd::where('weizhi', 2)->first();
        if ($ad1Item) {
            $ad1 = $ad1Item;
        }

        $ad2Item = AlbumAd::where('weizhi', 3)->first();
        if ($ad2Item) {
            $ad2 = $ad2Item;
        }

        $uid = $request->get('uid', 0);
        $albumDataItem = AlbumData::where('openid', $uid)->find($request->get('id', 0));
        if ($albumDataItem) {
            $albumData = [
                'openid' => $albumDataItem->openid,
                'avatar' => $albumDataItem->avatar,
                'nickname' => $albumDataItem->nickname,
                'skin' => $albumDataItem->skin,
                'music' => $albumDataItem->music,
                'thumb' => $albumDataItem->thumb,
                'imgdata' => explode(',', $albumDataItem->imgdata),
                'title' => $albumDataItem->title,
                'txtdata' => explode(',', $albumDataItem->txtdata),
                'best' => $albumDataItem->best,
                'click' => $albumDataItem->click,
                'share' => $albumDataItem->share,
                'status' => $albumDataItem->status,
                'addtime' => strtotime($albumDataItem->created_at),
            ];

            $skinID = $albumDataItem->skin;
        }

        $skinDataItem = AlbumSkin::find($skinID);
        if ($skinDataItem) {
            $skinData = [
                'ani' => $skinDataItem->ani,
                'bgimg' => $skinDataItem->bgimg,
                'frameimg' => $skinDataItem->frameimg,
                'model' => $skinDataItem->model,
                'music' => $skinDataItem->music,
                'remoted' => $skinDataItem->remoted,
            ];
        }

        $data = [
            'ad1' => $ad1,
            'ad2' => $ad2,
            'albumData' => $albumData,
            'skinData' => $skinData,
        ];

        return response()->json($data);
    }

    // 影集换模板
    public function upskin(Request $request)
    {
        $id = $request->get('id', 0);
        $uid = $request->get('uid', 0);
        $skin = $request->get('skin', 0);
        $item = AlbumData::where('openid', $uid)->find($id);
        $skinItem = AlbumSkin::find($skin);
        if ($item && $skinItem) {
            $item->skin = $skin;
            $item->save();

            $data = [
                'ani' => $skinItem->ani,
                'bgimg' => $skinItem->bgimg,
                'frameimg' => $skinItem->frameimg,
                'model' => $skinItem->model,
                'music' => $skinItem->music,
                'remoted' => $skinItem->remoted,
            ];

            return response()->json($data);
        }
    }

    // 影集换音乐
    public function upmusic(Request $request)
    {
        $id = $request->get('id', 0);
        $uid = $request->get('uid', 0);
        $music = $request->get('music', '');
        $item = AlbumData::where('openid', $uid)->find($id);
        if ($item) {
            $item->music = $music;
            $item->save();

            return response()->json([
                "status" => "success",
            ]);
        }
    }

    // 音乐列表
    public function music(Request $request)
    {
        $data = AlbumMusic::all(['title', 'music'])->toArray();

        return response()->json($data);
    }

    // 我的影集 和 公开影集.
    public function userdata(Request $request)
    {
        $uid = $request->get('uid', 0); // 实际就是 openid
        $page = $request->get('page', 1);
        $all = $request->get('all', 1);

        $where = [
            'openid' => $uid,
        ];
        if ($all) {
            $where['private'] = 0; // 私有
        }

        $fields = [
            'avatar',
            'nickname',
            'title',
            'thumb',
            'id',
            'click',
            'best',
            'private',
        ];
        $limit = 5;
        $offset = ($page - 1) * $limit;
        $list = AlbumData::where($where)->offset($offset)->limit($limit)->orderBy('created_at', 'DESC')->get($fields)->toArray();
        return response()->json($list);
    }

    // 更多好玩: 来自后台广告设置(小程序列表)
    public function applist(Request $request)
    {
        $applist = AlbumAd::where('weizhi', 0)->get();

        return response()->json($applist);
    }

    // 小程序 code 换取 openid
    public function openid(Request $request)
    {
        $code = $request->get('code');
        if ($code) {
            $queryStr = http_build_query([
                "appid" => env('ALBUM_MINI_APPID'),
                "secret" => env('ALBUM_MINI_SECRET'),
                "js_code" => $code,
                "grant_type" => "authorization_code",
            ]);
            $url = "https://api.weixin.qq.com/sns/jscode2session?{$queryStr}";

            $client = new Client();
            $res = $client->request('GET', $url);
            if ($res->getStatusCode() == 200) {
                $data = json_decode($res->getBody()->getContents(), true);
                if (isset($data['errcode'])) {
                    return response()->json([
                        'err' => "openid 获取失败: {$data['errmsg']}",
                    ], 400);
                }

                return response()->json([
                    'openid' => $data['openid'],
                ], 200);
            } else {
                return response()->json([
                    'err' => 'openid 请求失败',
                ], 400);
            }
        }

        return response()->json([
            'err' => 'code 不能为空',
        ], 400);
    }
}
