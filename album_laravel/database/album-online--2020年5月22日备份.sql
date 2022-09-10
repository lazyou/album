/*
 Navicat Premium Data Transfer

 Source Server         : album-online
 Source Server Type    : MySQL
 Source Server Version : 50616
 Source Host           : 47.107.112.48:3307
 Source Schema         : album

 Target Server Type    : MySQL
 Target Server Version : 50616
 File Encoding         : 65001

 Date: 22/05/2020 23:27:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for album_ads
-- ----------------------------
DROP TABLE IF EXISTS `album_ads`;
CREATE TABLE `album_ads`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NOT NULL DEFAULT 0,
  `displayorder` int(10) NOT NULL DEFAULT 0,
  `thumb` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `weizhi` tinyint(1) NULL DEFAULT 0,
  `istype` tinyint(1) NULL DEFAULT 0,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `indx_uniacid`(`uniacid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_ads
-- ----------------------------
INSERT INTO `album_ads` VALUES (1, 0, 0, 'http://xinxiangce.laizhouhao.com/images/68/2020/01/Vt3VL7THWvyDJzBuxMvl33vtQjWj7m.gif', '更多祝福', '', 'https://mp.weixin.qq.com/s/jMLcRRuM06OK5jYcywL2Gw', 2, 1, 'wx2c0fd16f834172da', '2020-05-11 13:49:31', '2020-05-11 13:49:34', NULL);
INSERT INTO `album_ads` VALUES (2, 0, 0, 'http://xinxiangce.laizhouhao.com/images/68/2019/03/t1xF7dkOfkfyDoKyo6f6XzBDkz9622.gif', '新消息', '', '', 3, 0, 'wxedec3ff2508aafa4', '2020-05-11 13:52:52', '2020-05-11 13:52:52', NULL);

-- ----------------------------
-- Table structure for album_clicklist
-- ----------------------------
DROP TABLE IF EXISTS `album_clicklist`;
CREATE TABLE `album_clicklist`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NOT NULL,
  `pid` int(10) NOT NULL,
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_uid`(`openid`) USING BTREE,
  INDEX `index_pid`(`pid`) USING BTREE,
  INDEX `index_uniacid`(`uniacid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for album_data
-- ----------------------------
DROP TABLE IF EXISTS `album_data`;
CREATE TABLE `album_data`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT 0 COMMENT '所属用户',
  `uniacid` int(10) NOT NULL,
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `skin` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `thumb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `imgdata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `txtdata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `music` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `click` int(10) NOT NULL,
  `share` int(10) NOT NULL,
  `best` int(10) NOT NULL DEFAULT 0,
  `private` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0公开，1私有',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常，1禁止',
  `ishot` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常，1推荐',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_uniacid`(`uniacid`) USING BTREE,
  INDEX `index_click`(`click`) USING BTREE,
  INDEX `index_best`(`best`) USING BTREE,
  INDEX `index_openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_data
-- ----------------------------
INSERT INTO `album_data` VALUES (1, 0, 0, 'oW6i_wuUbUZBnt9ICGKERUzQiId8', '我是蒲公英', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epgAoeb30RCHR2gJ7WhteSicKj7WD2c7qqTHicPicpibuVfYfBoiakjgkCtyBmVGavaJgKkLuYQ6Z5mO0A/132', '哈？', '65', 'http://album-static.raisedsun.com/album/images/61353ba161e7561223483868c9e55c69.jpg', 'http://album-static.raisedsun.com/album/images/61353ba161e7561223483868c9e55c69.jpg,http://tmp/wxf25d0c944f33a395.o6zAJs7kso3EPXcxFc_fUajUNkIE.f4J7SC1eTJMWeeb6b9fab1aaca47e83b32eed146d4bfundefined,http://album-static.raisedsun.com/album/images/baddcf8e84d0476a166ceb513115dde5.png', '赏,网页链接', 'http://album-static.raisedsun.com/images/album/music/3d50fb270754db0603ac15d8f3aeb1ba.mp3', 24, 0, 9, 0, 0, 1, '2020-05-14 07:48:46', '2020-05-21 07:00:42', NULL);
INSERT INTO `album_data` VALUES (3, 0, 0, 'oW6i_wuUbUZBnt9ICGKERUzQiId8', '我是蒲公英', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epgAoeb30RCHR2gJ7WhteSicKj7WD2c7qqTHicPicpibuVfYfBoiakjgkCtyBmVGavaJgKkLuYQ6Z5mO0A/132', '打开看看，这是我做的影集', '65', 'http://album-static.raisedsun.com/album/images/eb910c9c30baac20f2c68c7605e24da6.png', 'http://album-static.raisedsun.com/album/images/eb910c9c30baac20f2c68c7605e24da6.png,http://album-static.raisedsun.com/album/images/0b475828ff2c83bd98ec826e62487ab3.jpg', '', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 0, 0, 0, 0, 0, 0, '2020-05-14 12:49:41', '2020-05-14 12:49:41', NULL);
INSERT INTO `album_data` VALUES (5, 0, 0, 'oW6i_wuUbUZBnt9ICGKERUzQiId8', '我是蒲公英', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epgAoeb30RCHR2gJ7WhteSicKj7WD2c7qqTHicPicpibuVfYfBoiakjgkCtyBmVGavaJgKkLuYQ6Z5mO0A/132', '打开看看，这是我做的影集', '66', 'http://album-static.raisedsun.com/album/20200520/f1a153deca7a827d472a3d8914fb41bd.jpg', 'http://album-static.raisedsun.com/album/20200520/f1a153deca7a827d472a3d8914fb41bd.jpg,http://album-static.raisedsun.com/album/20200520/48c54718bcffae598e9398e93621983e.png', '', 'http://album-static.raisedsun.com/images/album/music/3d50fb270754db0603ac15d8f3aeb1ba.mp3', 0, 0, 0, 1, 0, 0, '2020-05-20 07:40:33', '2020-05-20 08:32:32', NULL);
INSERT INTO `album_data` VALUES (6, 0, 0, 'ortXc4nwruubrNQ-KqTAEbk1e-jo', 'lll😊🍰🆒💐', 'https://wx.qlogo.cn/mmopen/vi_32/BANibnl5Tc6NINibOicuUTE2P8S8HYot0H4iaOicvubO23OxtnsROiaqVwMrns855GhicIrOZvUBGhN4xd2Ojuf9QXqmA/132', '打开看看，这是我做的影集', '3', 'http://album-static.raisedsun.com/album/20200520/d99b8e111898355a1c1a3a822044a34f.jpg', 'http://album-static.raisedsun.com/album/20200520/d99b8e111898355a1c1a3a822044a34f.jpg,http://album-static.raisedsun.com/album/20200520/c124e9183ab9badf352173a0a3f0dc3d.jpg', '', 'http://album-static.raisedsun.com/images/album/music/772ec64997e10835a5c2d643e4de05d1.mp3', 0, 0, 0, 0, 0, 0, '2020-05-20 10:17:10', '2020-05-20 10:17:10', NULL);
INSERT INTO `album_data` VALUES (7, 0, 0, 'ortXc4nwruubrNQ-KqTAEbk1e-jo', 'lll😊🍰🆒💐', 'https://wx.qlogo.cn/mmopen/vi_32/BANibnl5Tc6NINibOicuUTE2P8S8HYot0H4iaOicvubO23OxtnsROiaqVwMrns855GhicIrOZvUBGhN4xd2Ojuf9QXqmA/132', '打开看看，这是我做的影集', '55', 'http://album-static.raisedsun.com/album/20200520/3d6bba05791552acedbbc515697d51f4.jpg', 'http://album-static.raisedsun.com/album/20200520/3d6bba05791552acedbbc515697d51f4.jpg,http://album-static.raisedsun.com/album/20200520/ef743b61711e6343f97586f1e0a03fd3.jpg,http://album-static.raisedsun.com/album/20200520/030620ece8ff2550bd2978c0cc9e79e0.jpg', '', 'http://album-static.raisedsun.com/images/album/music/85b296e07f6c27f03dad874147356c40.mp3', 10, 0, 15, 0, 0, 1, '2020-05-20 12:57:33', '2020-05-21 09:56:50', NULL);
INSERT INTO `album_data` VALUES (8, 0, 0, 'ortXc4m00qVIrx1JNvtFQ4tMtTrE', '不想你的', 'https://wx.qlogo.cn/mmopen/vi_32/CoQOvEiaxcciaQVOYzMgSMA73PTXfib9ZCF33aYmIVaBiaVWaVZa4RDdNzNCHOIuCpmgJPH6iaKvW2CNtUEicgfuXJUg/132', '打开看看，这是我做的影集', '2', 'wxfile://tmp_4da6753f954b4465c003a8b03cc945af.jpg', 'http://album-static.raisedsun.com/album/20200521/3d3ac3150cb31135f3027b33ea5a1ec5.jpg', '', 'http://album-static.raisedsun.com/images/album/music/ed6f974ba64949864704330bcad0b463.mp3', 0, 0, 0, 0, 0, 0, '2020-05-21 06:38:42', '2020-05-21 07:00:51', '2020-05-21 07:00:51');
INSERT INTO `album_data` VALUES (9, 0, 0, 'ortXc4m00qVIrx1JNvtFQ4tMtTrE', '不想你的', 'https://wx.qlogo.cn/mmopen/vi_32/CoQOvEiaxcciaQVOYzMgSMA73PTXfib9ZCF33aYmIVaBiaVWaVZa4RDdNzNCHOIuCpmgJPH6iaKvW2CNtUEicgfuXJUg/132', '打开看看，这是我做的影集', '3', 'http://album-static.raisedsun.com/album/20200521/52ce7cd785bec41d23c9c9e27714288a.jpg', 'http://album-static.raisedsun.com/album/20200521/52ce7cd785bec41d23c9c9e27714288a.jpg,http://album-static.raisedsun.com/album/20200521/b24466238f8ac64331eebf23808bae0e.jpg', '111111,222222', 'http://album-static.raisedsun.com/images/album/music/772ec64997e10835a5c2d643e4de05d1.mp3', 1, 0, 0, 0, 0, 0, '2020-05-21 06:51:44', '2020-05-21 07:01:07', NULL);
INSERT INTO `album_data` VALUES (10, 0, 0, 'ortXc4m00qVIrx1JNvtFQ4tMtTrE', '不想你的', 'https://wx.qlogo.cn/mmopen/vi_32/CoQOvEiaxcciaQVOYzMgSMA73PTXfib9ZCF33aYmIVaBiaVWaVZa4RDdNzNCHOIuCpmgJPH6iaKvW2CNtUEicgfuXJUg/132', '打开看看，这是我做的影集', '22', 'http://album-static.raisedsun.com/album/20200521/58830b5fb02a137c7be5d5379286e3f8.jpg', 'http://album-static.raisedsun.com/album/20200521/58830b5fb02a137c7be5d5379286e3f8.jpg', '', 'http://album-static.raisedsun.com/images/album/music/f2883bd9ac3276306dc726a5838788b8.mp3', 2, 0, 0, 0, 0, 0, '2020-05-21 07:02:48', '2020-05-22 11:56:14', NULL);
INSERT INTO `album_data` VALUES (11, 0, 0, 'ortXc4m00qVIrx1JNvtFQ4tMtTrE', '不想你的', 'https://wx.qlogo.cn/mmopen/vi_32/CoQOvEiaxcciaQVOYzMgSMA73PTXfib9ZCF33aYmIVaBiaVWaVZa4RDdNzNCHOIuCpmgJPH6iaKvW2CNtUEicgfuXJUg/132', '打开看看，这是我做的影集', '16', 'http://album-static.raisedsun.com/album/20200521/50534a4b8576fa04549d0e867f99c0ef.jpg', 'http://album-static.raisedsun.com/album/20200521/50534a4b8576fa04549d0e867f99c0ef.jpg,http://album-static.raisedsun.com/album/20200521/2bc4b7a7d27cb2defdec1949ff098ebc.jpg,http://album-static.raisedsun.com/album/20200521/1c96deb8d5f2dd92b97cd8e39b0e9cc2.jpg', '', 'http://album-static.raisedsun.com/images/album/music/a52be7fef784f0593ca5072afaad9ef7.mp3', 0, 0, 0, 0, 0, 0, '2020-05-21 07:03:03', '2020-05-21 07:03:16', NULL);
INSERT INTO `album_data` VALUES (12, 0, 0, 'ortXc4m00qVIrx1JNvtFQ4tMtTrE', '不想你的', 'https://wx.qlogo.cn/mmopen/vi_32/CoQOvEiaxcciaQVOYzMgSMA73PTXfib9ZCF33aYmIVaBiaVWaVZa4RDdNzNCHOIuCpmgJPH6iaKvW2CNtUEicgfuXJUg/132', '打开看看，这是我做的影集', '58', 'http://album-static.raisedsun.com/album/20200521/1aa330fccad6dd9af243137062248b45.jpg', 'http://album-static.raisedsun.com/album/20200521/1aa330fccad6dd9af243137062248b45.jpg,http://album-static.raisedsun.com/album/20200521/df2eee9535562f74a8d130f620d5498e.jpg', '', 'http://album-static.raisedsun.com/images/album/music/37c177de2734a2c4205b36d53c0d8a60.mp3', 0, 0, 0, 0, 0, 0, '2020-05-21 07:03:51', '2020-05-21 07:04:04', NULL);
INSERT INTO `album_data` VALUES (13, 0, 0, 'ortXc4mLSiHSmR9bJqljMdkCXkD8', '我是蒲公英', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqU3ZscDl6CSubbia8WlHdfZSeDZ8D00svbwmVWBbC4XXG1szMwoyR2iaKc1RwdK2lrUuVpdgUhck6A/132', '打开看看，这是我做的影集', '3', 'http://album-static.raisedsun.com/album/20200522/318a91e98bf334056204384a5eff7af1.jpg', 'http://album-static.raisedsun.com/album/20200522/318a91e98bf334056204384a5eff7af1.jpg', '', 'http://album-static.raisedsun.com/images/album/music/772ec64997e10835a5c2d643e4de05d1.mp3', 1, 0, 0, 0, 0, 0, '2020-05-22 07:14:50', '2020-05-22 12:01:53', NULL);
INSERT INTO `album_data` VALUES (14, 0, 0, 'ortXc4ieTL5ErUjReAicqqzucB3g', 'Tamas', 'https://wx.qlogo.cn/mmopen/vi_32/pxEyGhvFibSAqibjrPibZpKWD0O9n8tmicVhWkYI6FS8DpORyzEANZYoyKDepMa6ctubooCZh0cbey6kuGTKmeOcVA/132', '打开看看，这是我做的影集', '5', 'http://album-static.raisedsun.com/album/20200522/99660c79a1488022c9978e13c8a235ec.jpg', 'http://album-static.raisedsun.com/album/20200522/99660c79a1488022c9978e13c8a235ec.jpg,http://album-static.raisedsun.com/album/20200522/27a93129d467cec6c704c2b81943ba45.jpg', '', 'http://album-static.raisedsun.com/images/album/music/f85aaef3c754749d89d3e237c96e8148.mp3', 0, 0, 0, 0, 0, 0, '2020-05-22 11:38:44', '2020-05-22 11:38:44', NULL);

-- ----------------------------
-- Table structure for album_formdata
-- ----------------------------
DROP TABLE IF EXISTS `album_formdata`;
CREATE TABLE `album_formdata`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NULL DEFAULT 0,
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `formid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `indx_oid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64810 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for album_music
-- ----------------------------
DROP TABLE IF EXISTS `album_music`;
CREATE TABLE `album_music`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `music` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_music
-- ----------------------------
INSERT INTO `album_music` VALUES (1, 0, '龙凤呈祥', 'http://album-static.raisedsun.com/images/album/music/16fd9f794f9f06948cb66adda87dfe2c.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (2, 0, '终于到家', 'http://album-static.raisedsun.com/images/album/music/0dc12ef1cd61da29c758df0627fc9519.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (3, 0, '五谷丰登', 'http://album-static.raisedsun.com/images/album/music/9c1049b30dc02bdd3dd49562dd030226.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (4, 0, '生来成功', 'http://album-static.raisedsun.com/images/album/music/bd6676b1ecccd6e672b59c75b73c8db9.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (5, 0, '雨中漫步', 'http://album-static.raisedsun.com/images/album/music/533fca20be31da3d4b9e7b2b67d257fc.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (6, 0, '菊次郎的夏天', 'http://album-static.raisedsun.com/images/album/music/3d50fb270754db0603ac15d8f3aeb1ba.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (7, 0, '风铃', 'http://album-static.raisedsun.com/images/album/music/f5656e57a0952c31933ac82c9d8ee3f5.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (8, 0, '小苹果', 'http://album-static.raisedsun.com/images/album/music/9037cfae7c64405111e0e364401adb60.mp3', '2020-05-12 08:10:42', '2020-05-12 08:10:42', NULL);
INSERT INTO `album_music` VALUES (9, 0, '旧时光的好时光', 'http://album-static.raisedsun.com/images/album/music/e47226897bae2da4286289074b415545.mp3', '2020-05-12 08:10:43', '2020-05-12 08:10:43', NULL);
INSERT INTO `album_music` VALUES (10, 0, '看星星', 'http://album-static.raisedsun.com/images/album/music/92575db2bdb45b789c9a4e367e089e0c.mp3', '2020-05-12 08:10:43', '2020-05-12 08:10:43', NULL);
INSERT INTO `album_music` VALUES (11, 0, '海中捞月', 'http://album-static.raisedsun.com/images/album/music/543edae17896929b9dd3bafda21db69a.mp3', '2020-05-12 08:10:44', '2020-05-12 08:10:44', NULL);
INSERT INTO `album_music` VALUES (12, 0, '阖家欢乐', 'http://album-static.raisedsun.com/images/album/music/77d91f0ebb1886cc240201b3d2cbb1b5.mp3', '2020-05-12 08:10:45', '2020-05-12 08:10:45', NULL);
INSERT INTO `album_music` VALUES (13, 0, '霸王风月', 'http://album-static.raisedsun.com/images/album/music/3b45617133c1f7048281b6ccd65ad06a.mp3', '2020-05-12 08:10:45', '2020-05-12 08:10:45', NULL);
INSERT INTO `album_music` VALUES (14, 0, '富贵吉祥', 'http://album-static.raisedsun.com/images/album/music/a39f6526ff8f51e99e340c8fdf58de37.mp3', '2020-05-12 08:10:46', '2020-05-12 08:10:46', NULL);
INSERT INTO `album_music` VALUES (15, 0, '万家灯火', 'http://album-static.raisedsun.com/images/album/music/4d59420f0007c5870167cebf78254033.mp3', '2020-05-12 08:10:47', '2020-05-12 08:10:47', NULL);
INSERT INTO `album_music` VALUES (16, 0, '美丽天气', 'http://album-static.raisedsun.com/images/album/music/f2883bd9ac3276306dc726a5838788b8.mp3', '2020-05-12 08:10:47', '2020-05-12 08:10:47', NULL);
INSERT INTO `album_music` VALUES (17, 0, '轻松小调', 'http://album-static.raisedsun.com/images/album/music/f47d8455862413550bcaa8ba89137ca7.mp3', '2020-05-12 08:10:47', '2020-05-12 08:10:47', NULL);
INSERT INTO `album_music` VALUES (18, 0, '山间田野', 'http://album-static.raisedsun.com/images/album/music/85b296e07f6c27f03dad874147356c40.mp3', '2020-05-12 08:10:48', '2020-05-12 08:10:48', NULL);
INSERT INTO `album_music` VALUES (19, 0, '彩色糖纸', 'http://album-static.raisedsun.com/images/album/music/659550d3b290b2699ea3bbbaa1698aef.mp3', '2020-05-12 08:10:48', '2020-05-12 08:10:48', NULL);
INSERT INTO `album_music` VALUES (20, 0, '心事释怀', 'http://album-static.raisedsun.com/images/album/music/e8453a789d8532e8f839ebc989161173.mp3', '2020-05-12 08:10:48', '2020-05-12 08:10:48', NULL);
INSERT INTO `album_music` VALUES (21, 0, '浪漫月光', 'http://album-static.raisedsun.com/images/album/music/2346b970435a1d7cd3e25d37cb1fed53.mp3', '2020-05-12 08:10:49', '2020-05-12 08:10:49', NULL);
INSERT INTO `album_music` VALUES (22, 0, '愉悦假日', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', '2020-05-12 08:10:49', '2020-05-12 08:10:49', NULL);
INSERT INTO `album_music` VALUES (23, 0, '慵懒时光', 'http://album-static.raisedsun.com/images/album/music/573cf5a6b26d7c8f6617fcd4fe1c12fb.mp3', '2020-05-12 08:10:49', '2020-05-12 08:10:49', NULL);
INSERT INTO `album_music` VALUES (24, 0, '手心温度', 'http://album-static.raisedsun.com/images/album/music/6112f58af1ae0ffbcbfab35060958754.mp3', '2020-05-12 08:10:49', '2020-05-12 08:10:49', NULL);
INSERT INTO `album_music` VALUES (25, 0, '拨云见日', 'http://album-static.raisedsun.com/images/album/music/29197ac6f554c44451f7d51a6607138c.mp3', '2020-05-12 08:10:49', '2020-05-12 08:10:49', NULL);
INSERT INTO `album_music` VALUES (26, 0, '放松享受', 'http://album-static.raisedsun.com/images/album/music/30de7910d8d4858c3ea06f2d278e0551.mp3', '2020-05-12 08:10:49', '2020-05-12 08:10:49', NULL);
INSERT INTO `album_music` VALUES (27, 0, '旧日留声', 'http://album-static.raisedsun.com/images/album/music/f85aaef3c754749d89d3e237c96e8148.mp3', '2020-05-12 08:10:50', '2020-05-12 08:10:50', NULL);
INSERT INTO `album_music` VALUES (28, 0, '时间滴答', 'http://album-static.raisedsun.com/images/album/music/988dfd6578a1e2317624f608639f7624.mp3', '2020-05-12 08:10:51', '2020-05-12 08:10:51', NULL);
INSERT INTO `album_music` VALUES (29, 0, '春暖花开', 'http://album-static.raisedsun.com/images/album/music/a52be7fef784f0593ca5072afaad9ef7.mp3', '2020-05-12 08:10:51', '2020-05-12 08:10:51', NULL);
INSERT INTO `album_music` VALUES (30, 0, '森林雪花', 'http://album-static.raisedsun.com/images/album/music/772ec64997e10835a5c2d643e4de05d1.mp3', '2020-05-12 08:10:52', '2020-05-12 08:10:52', NULL);
INSERT INTO `album_music` VALUES (31, 0, '期盼未来', 'http://album-static.raisedsun.com/images/album/music/d0333e6e0efa4b80abe956746aa1d550.mp3', '2020-05-12 08:10:52', '2020-05-12 08:10:52', NULL);
INSERT INTO `album_music` VALUES (32, 0, '梦想天堂', 'http://album-static.raisedsun.com/images/album/music/2feb497887e09e426c5a9c317b1c0c48.mp3', '2020-05-12 08:10:53', '2020-05-12 08:10:53', NULL);
INSERT INTO `album_music` VALUES (33, 0, '每次呼吸', 'http://album-static.raisedsun.com/images/album/music/30ff970b06c0a09f61d465d0cd4ad3dc.mp3', '2020-05-12 08:10:54', '2020-05-12 08:10:54', NULL);
INSERT INTO `album_music` VALUES (34, 0, '温暖的心', 'http://album-static.raisedsun.com/images/album/music/ed6f974ba64949864704330bcad0b463.mp3', '2020-05-12 08:10:55', '2020-05-12 08:10:55', NULL);
INSERT INTO `album_music` VALUES (35, 0, '流金岁月', 'http://album-static.raisedsun.com/images/album/music/37c177de2734a2c4205b36d53c0d8a60.mp3', '2020-05-12 08:10:55', '2020-05-12 08:10:55', NULL);

-- ----------------------------
-- Table structure for album_paylog
-- ----------------------------
DROP TABLE IF EXISTS `album_paylog`;
CREATE TABLE `album_paylog`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) UNSIGNED NOT NULL,
  `out_trade_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'openid',
  `fee` decimal(10, 2) NOT NULL COMMENT '金额',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未支付，1已支付',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_uid`(`openid`) USING BTREE,
  INDEX `out_trade_no`(`out_trade_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for album_review
-- ----------------------------
DROP TABLE IF EXISTS `album_review`;
CREATE TABLE `album_review`  (
  `id` int(10) UNSIGNED NOT NULL,
  `uniacid` int(10) UNSIGNED NOT NULL,
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pid` int(10) NOT NULL,
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_uniacid`(`uniacid`) USING BTREE,
  INDEX `index_pid`(`pid`) USING BTREE,
  INDEX `index_opid`(`openid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for album_sended
-- ----------------------------
DROP TABLE IF EXISTS `album_sended`;
CREATE TABLE `album_sended`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NULL DEFAULT 0,
  `templateid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `rate` int(10) NULL DEFAULT 0,
  `send` int(10) NULL DEFAULT 0,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `indx_id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for album_sendlog
-- ----------------------------
DROP TABLE IF EXISTS `album_sendlog`;
CREATE TABLE `album_sendlog`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `msgid` int(10) NULL DEFAULT 0,
  `uniacid` int(10) NULL DEFAULT 0,
  `templateid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_templateid`(`templateid`) USING BTREE,
  INDEX `index_oids`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for album_setting
-- ----------------------------
DROP TABLE IF EXISTS `album_setting`;
CREATE TABLE `album_setting`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `phototitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `zimu` int(11) NOT NULL DEFAULT 0,
  `touxiang` int(11) NOT NULL DEFAULT 0,
  `sharetitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `shareimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `indexbtn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `flowerbtn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sharebtn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `savebtn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `editbtn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `addapp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `addapp1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `llads` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `userllads` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `albumllads` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `skinllads` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `albumads` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `albumconads` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_setting
-- ----------------------------
INSERT INTO `album_setting` VALUES (1, '相册制作图集精选', '相册制作图集精选', 1, 2, '打开看看，这是我做的影集', 'http://album-static.raisedsun.com/images/album/shareimg.png', 'http://album-static.raisedsun.com/images/album/jcyj.png', 'http://album-static.raisedsun.com/images/album/sh.png', 'http://album-static.raisedsun.com/images/album/share.png', 'http://album-static.raisedsun.com/images/album/save.png', 'http://album-static.raisedsun.com/images/album/editbtn.png', 'http://album-static.raisedsun.com/images/album/addapp.png', 'http://album-static.raisedsun.com/images/album/addapp1.png', 'adunit-df7028b8c39f5401', 'adunit-6be8575029546c83', 'adunit-747517af8e1f259c', 'adunit-81d522cb31b6de75', 'adunit-14ca8fc795d53620', 'adunit-14ca8fc795d53620', '2020-05-19 17:34:44', '2020-05-19 15:49:32', NULL);

-- ----------------------------
-- Table structure for album_skin
-- ----------------------------
DROP TABLE IF EXISTS `album_skin`;
CREATE TABLE `album_skin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NOT NULL,
  `cid` int(10) NOT NULL,
  `displayorder` int(10) NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `otitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `thumb` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '1,2,3,4',
  `ani` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `music` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bgimg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `frameimg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `def` int(10) NOT NULL DEFAULT 0,
  `remoted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未存储，1已存储',
  `ishide` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0显示，1不显示',
  `ishot` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0普通，1最新，2热门',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_uniacid`(`uniacid`) USING BTREE,
  INDEX `index_cid`(`cid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_skin
-- ----------------------------
INSERT INTO `album_skin` VALUES (1, 0, 2, 0, '迷人紫色', '', 'http://album-static.raisedsun.com/images/album/skin/1/thumb.jpg', '4', 'd', 'http://album-static.raisedsun.com/images/album/music/37c177de2734a2c4205b36d53c0d8a60.mp3', 'http://album-static.raisedsun.com/images/album/skin/1/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (2, 0, 2, 0, '乡村田野', '', 'http://album-static.raisedsun.com/images/album/skin/2/thumb.jpg', '3', 'c', 'http://album-static.raisedsun.com/images/album/music/ed6f974ba64949864704330bcad0b463.mp3', 'http://album-static.raisedsun.com/images/album/skin/2/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (3, 0, 4, 0, '相依相恋', '', 'http://album-static.raisedsun.com/images/album/skin/11/thumb.jpg', '2', 'c,e', 'http://album-static.raisedsun.com/images/album/music/772ec64997e10835a5c2d643e4de05d1.mp3', 'http://album-static.raisedsun.com/images/album/skin/11/bg.jpg', 'http://dxt-avatar.folkcat.com/images/album/skin/11/frame.png', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (4, 0, 4, 0, '相偎一生', '', 'http://album-static.raisedsun.com/images/album/skin/3/thumb.jpg', '3', 'e,c', 'http://album-static.raisedsun.com/images/album/music/988dfd6578a1e2317624f608639f7624.mp3', 'http://album-static.raisedsun.com/images/album/skin/3/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (5, 0, 2, 0, '乡间田野', '', 'http://album-static.raisedsun.com/images/album/skin/4/thumb.jpg', '2', 'b,l', 'http://album-static.raisedsun.com/images/album/music/f85aaef3c754749d89d3e237c96e8148.mp3', 'http://album-static.raisedsun.com/images/album/skin/4/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (6, 0, 4, 0, '新的一天', '', 'http://album-static.raisedsun.com/images/album/skin/5/thumb.jpg', '2', 'l', 'http://album-static.raisedsun.com/images/album/music/d0333e6e0efa4b80abe956746aa1d550.mp3', 'http://album-static.raisedsun.com/images/album/skin/5/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (7, 0, 2, 0, '大好河山', '', 'http://album-static.raisedsun.com/images/album/skin/6/thumb.jpg', '4', 'a', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/6/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (8, 0, 2, 0, '伊人景色', '', 'http://album-static.raisedsun.com/images/album/skin/7/thumb.jpg', '1', 'a', 'http://album-static.raisedsun.com/images/album/music/77d91f0ebb1886cc240201b3d2cbb1b5.mp3', 'http://album-static.raisedsun.com/images/album/skin/7/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (9, 0, 4, 0, '梦幻境界', '', 'http://album-static.raisedsun.com/images/album/skin/8/thumb.jpg', '1', 'e', 'http://album-static.raisedsun.com/images/album/music/29197ac6f554c44451f7d51a6607138c.mp3', 'http://album-static.raisedsun.com/images/album/skin/8/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (10, 0, 3, 0, '元宵佳节', '', 'http://album-static.raisedsun.com/images/album/skin/12/thumb.jpg', '1', 'e,g', 'http://album-static.raisedsun.com/images/album/music/16fd9f794f9f06948cb66adda87dfe2c.mp3', 'http://album-static.raisedsun.com/images/album/skin/12/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (11, 0, 3, 0, '元宵快乐', '', 'http://album-static.raisedsun.com/images/album/skin/13/thumb.jpg', '1', 'e,g', 'http://album-static.raisedsun.com/images/album/music/16fd9f794f9f06948cb66adda87dfe2c.mp3', 'http://album-static.raisedsun.com/images/album/skin/13/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (12, 0, 3, 0, '闹元宵', '', 'http://album-static.raisedsun.com/images/album/skin/14/thumb.jpg', '3', 'h', 'http://album-static.raisedsun.com/images/album/music/16fd9f794f9f06948cb66adda87dfe2c.mp3', 'http://album-static.raisedsun.com/images/album/skin/14/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (13, 0, 4, 0, '花香袭人', '', 'http://album-static.raisedsun.com/images/album/skin/15/thumb.jpg', '2', 'h', 'http://album-static.raisedsun.com/images/album/music/f47d8455862413550bcaa8ba89137ca7.mp3', 'http://album-static.raisedsun.com/images/album/skin/15/bg.jpg', 'http://dxt-avatar.folkcat.com/images/album/skin/15/frame.jpg', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (14, 0, 4, 0, '绚丽花海', '', 'http://album-static.raisedsun.com/images/album/skin/16/thumb.jpg', '2', 'f,d', 'http://album-static.raisedsun.com/images/album/music/f2883bd9ac3276306dc726a5838788b8.mp3', 'http://album-static.raisedsun.com/images/album/skin/16/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (15, 0, 2, 0, '静谧庄园', '', 'http://album-static.raisedsun.com/images/album/skin/17/thumb.jpg', '2', 'l,d', 'http://album-static.raisedsun.com/images/album/music/77d91f0ebb1886cc240201b3d2cbb1b5.mp3', 'http://album-static.raisedsun.com/images/album/skin/17/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (16, 0, 1, 0, '岁月静好', '', 'http://album-static.raisedsun.com/images/album/skin/18/thumb.jpg', '4', 'a', 'http://album-static.raisedsun.com/images/album/music/a52be7fef784f0593ca5072afaad9ef7.mp3', 'http://album-static.raisedsun.com/images/album/skin/18/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (17, 0, 2, 0, '春意盎然', '', 'http://album-static.raisedsun.com/images/album/skin/19/thumb.jpg', '4', 'b', 'http://album-static.raisedsun.com/images/album/music/30de7910d8d4858c3ea06f2d278e0551.mp3', 'http://album-static.raisedsun.com/images/album/skin/19/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (18, 0, 1, 0, '缤纷时节', '', 'http://album-static.raisedsun.com/images/album/skin/20/thumb.jpg', '4', 'a', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/20/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (19, 0, 2, 0, '春暖花开', '', 'http://album-static.raisedsun.com/images/album/skin/21/thumb.jpg', '4', 'b', 'http://album-static.raisedsun.com/images/album/music/6112f58af1ae0ffbcbfab35060958754.mp3', 'http://album-static.raisedsun.com/images/album/skin/21/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (20, 0, 2, 0, '早春盛开', '', 'http://album-static.raisedsun.com/images/album/skin/22/thumb.jpg', '4', 'b', 'http://album-static.raisedsun.com/images/album/music/ed6f974ba64949864704330bcad0b463.mp3', 'http://album-static.raisedsun.com/images/album/skin/22/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (21, 0, 2, 0, '水墨山水', '', 'http://album-static.raisedsun.com/images/album/skin/23/thumb.jpg', '4', 'h', 'http://album-static.raisedsun.com/images/album/music/2feb497887e09e426c5a9c317b1c0c48.mp3', 'http://album-static.raisedsun.com/images/album/skin/23/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (22, 0, 3, 0, '女神节', '', 'http://album-static.raisedsun.com/images/album/skin/24/thumb.jpg', '4', 'b', 'http://album-static.raisedsun.com/images/album/music/f2883bd9ac3276306dc726a5838788b8.mp3', 'http://album-static.raisedsun.com/images/album/skin/24/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (23, 0, 2, 0, '黄昏云海', '', 'http://album-static.raisedsun.com/images/album/skin/25/thumb.jpg', '2', 'f', 'http://album-static.raisedsun.com/images/album/music/30de7910d8d4858c3ea06f2d278e0551.mp3', 'http://album-static.raisedsun.com/images/album/skin/25/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (24, 0, 2, 0, '唯美山水', '', 'http://album-static.raisedsun.com/images/album/skin/26/thumb.jpg', '2', 'd', 'http://album-static.raisedsun.com/images/album/music/988dfd6578a1e2317624f608639f7624.mp3', 'http://album-static.raisedsun.com/images/album/skin/26/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (49, 0, 3, 0, '粉色心语', '', 'http://album-static.raisedsun.com/images/album/skin/27/thumb.jpg', '4', 'e', 'http://album-static.raisedsun.com/images/album/music/30de7910d8d4858c3ea06f2d278e0551.mp3', 'http://album-static.raisedsun.com/images/album/skin/27/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (50, 0, 1, 0, '深情玫瑰', '', 'http://album-static.raisedsun.com/images/album/skin/28/thumb.jpg', '3', 'e', 'http://album-static.raisedsun.com/images/album/music/2346b970435a1d7cd3e25d37cb1fed53.mp3', 'http://album-static.raisedsun.com/images/album/skin/28/bg.jpg', '', 0, 0, 0, 1, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (51, 0, 1, 0, '浓情玫瑰', '', 'http://album-static.raisedsun.com/images/album/skin/29/thumb.jpg', '2', 'c', 'http://album-static.raisedsun.com/images/album/music/659550d3b290b2699ea3bbbaa1698aef.mp3', 'http://album-static.raisedsun.com/images/album/skin/29/bg.jpg', '', 0, 0, 0, 2, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (52, 0, 2, 0, '你好春天', '', 'http://album-static.raisedsun.com/images/album/skin/30/thumb.jpg', '2', 'a', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/30/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (53, 0, 3, 0, '清明时节', '', 'http://album-static.raisedsun.com/images/album/skin/31/thumb.jpg', '2', 'h', 'http://album-static.raisedsun.com/images/album/music/f85aaef3c754749d89d3e237c96e8148.mp3', 'http://album-static.raisedsun.com/images/album/skin/31/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (54, 0, 1, 0, '赏春之行', '', 'http://album-static.raisedsun.com/images/album/skin/32/thumb.jpg', '2', 'f', 'http://album-static.raisedsun.com/images/album/music/29197ac6f554c44451f7d51a6607138c.mp3', 'http://album-static.raisedsun.com/images/album/skin/32/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (55, 0, 2, 0, '踏春而行', '', 'http://album-static.raisedsun.com/images/album/skin/33/thumb.jpg', '2', 'd', 'http://album-static.raisedsun.com/images/album/music/85b296e07f6c27f03dad874147356c40.mp3', 'http://album-static.raisedsun.com/images/album/skin/33/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (56, 0, 2, 0, '踏春赏花', '', 'http://album-static.raisedsun.com/images/album/skin/34/thumb.jpg', '2', 'k', 'http://album-static.raisedsun.com/images/album/music/30de7910d8d4858c3ea06f2d278e0551.mp3', 'http://album-static.raisedsun.com/images/album/skin/34/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (57, 0, 1, 0, '玫瑰印记', '', 'http://album-static.raisedsun.com/images/album/skin/35/thumb.jpg', '2', 'e', 'http://album-static.raisedsun.com/images/album/music/573cf5a6b26d7c8f6617fcd4fe1c12fb.mp3', 'http://album-static.raisedsun.com/images/album/skin/35/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (58, 0, 2, 0, '哈喽四月', '', 'http://album-static.raisedsun.com/images/album/skin/36/thumb.jpg', '2', 'e', 'http://album-static.raisedsun.com/images/album/music/ed6f974ba64949864704330bcad0b463.mp3', 'http://album-static.raisedsun.com/images/album/skin/36/bg.jpg', '', 0, 0, 0, 1, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (59, 0, 2, 0, '草原蓝天', '', 'http://album-static.raisedsun.com/images/album/skin/37/thumb.jpg', '3', 'e', 'http://album-static.raisedsun.com/images/album/music/d0333e6e0efa4b80abe956746aa1d550.mp3', 'http://album-static.raisedsun.com/images/album/skin/37/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (60, 0, 1, 0, '春至美景', '', 'http://album-static.raisedsun.com/images/album/skin/38/thumb.jpg', '2', 'f', 'http://album-static.raisedsun.com/images/album/music/30de7910d8d4858c3ea06f2d278e0551.mp3', 'http://album-static.raisedsun.com/images/album/skin/38/bg.jpg', '', 0, 0, 0, 2, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (61, 0, 1, 0, '海边相遇', '', 'http://album-static.raisedsun.com/images/album/skin/39/thumb.jpg', '2', 'e', 'http://album-static.raisedsun.com/images/album/music/6112f58af1ae0ffbcbfab35060958754.mp3', 'http://album-static.raisedsun.com/images/album/skin/39/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (62, 0, 1, 0, '快乐庆生', '', 'http://album-static.raisedsun.com/images/album/skin/40/thumb.jpg', '3', 'c', 'http://album-static.raisedsun.com/images/album/music/f2883bd9ac3276306dc726a5838788b8.mp3', 'http://album-static.raisedsun.com/images/album/skin/40/bg.jpg', '', 0, 0, 0, 1, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (63, 0, 1, 0, '浪漫热气球', '', 'http://album-static.raisedsun.com/images/album/skin/41/thumb.jpg', '2', 'e', 'http://album-static.raisedsun.com/images/album/music/659550d3b290b2699ea3bbbaa1698aef.mp3', 'http://album-static.raisedsun.com/images/album/skin/41/bg.jpg', '', 0, 0, 0, 2, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (64, 0, 1, 0, '美丽邂逅', '', 'http://album-static.raisedsun.com/images/album/skin/42/thumb.jpg', '2', 'k', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/42/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (65, 0, 3, 0, '保持童心', '', 'http://album-static.raisedsun.com/images/album/skin/43/thumb.jpg', '2', 'k', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/43/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (66, 0, 3, 0, '花样六一', '', 'http://album-static.raisedsun.com/images/album/skin/44/thumb.jpg', '4', 'f', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/44/bg.jpg', '', 0, 0, 0, 1, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (67, 0, 3, 0, '放飞梦想', '', 'http://album-static.raisedsun.com/images/album/skin/45/thumb.jpg', '3', 'k', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/45/bg.jpg', '', 0, 0, 0, 0, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (68, 0, 3, 0, '六一快乐', '', 'http://album-static.raisedsun.com/images/album/skin/46/thumb.jpg', '1', 'd', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/46/bg.jpg', '', 0, 0, 0, 2, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (69, 0, 3, 0, '童心童乐', '', 'http://album-static.raisedsun.com/images/album/skin/47/thumb.jpg', '2', 'c', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/47/bg.jpg', '', 0, 0, 0, 1, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);
INSERT INTO `album_skin` VALUES (70, 0, 3, 0, '萌趣童心', '', 'http://album-static.raisedsun.com/images/album/skin/48/thumb.jpg', '3', 'e', 'http://album-static.raisedsun.com/images/album/music/2774bee69770082b639701f40c742fef.mp3', 'http://album-static.raisedsun.com/images/album/skin/48/bg.jpg', '', 0, 0, 0, 2, '2020-05-11 09:16:28', '2020-05-12 09:12:37', NULL);

-- ----------------------------
-- Table structure for album_skincate
-- ----------------------------
DROP TABLE IF EXISTS `album_skincate`;
CREATE TABLE `album_skincate`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NOT NULL,
  `displayorder` int(10) NOT NULL,
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_skincate
-- ----------------------------
INSERT INTO `album_skincate` VALUES (1, 0, 0, '甜蜜', '2020-05-11 08:16:57', '2020-05-11 08:16:57', NULL);
INSERT INTO `album_skincate` VALUES (2, 0, 0, '唯美', '2020-05-11 08:16:57', '2020-05-11 08:16:57', NULL);
INSERT INTO `album_skincate` VALUES (3, 0, 0, '节日', '2020-05-11 08:16:57', '2020-05-11 08:16:57', NULL);
INSERT INTO `album_skincate` VALUES (4, 0, 0, '温馨', '2020-05-11 08:16:57', '2020-05-11 08:16:57', NULL);

-- ----------------------------
-- Table structure for album_user
-- ----------------------------
DROP TABLE IF EXISTS `album_user`;
CREATE TABLE `album_user`  (
  `uid` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) UNSIGNED NOT NULL,
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fee` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '金额',
  `souce` int(10) NOT NULL DEFAULT 0 COMMENT '积分',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0启用，1禁用',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `index_uniacid`(`uniacid`) USING BTREE,
  INDEX `index_openid`(`openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21823 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of album_user
-- ----------------------------
INSERT INTO `album_user` VALUES (21655, 0, 'oW6i_wuUbUZBnt9ICGKERUzQiId8', '我是蒲公英', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epgAoeb30RCHR2gJ7WhteSicKj7WD2c7qqTHicPicpibuVfYfBoiakjgkCtyBmVGavaJgKkLuYQ6Z5mO0A/132', 0.00, 0, 0, '2020-05-12 15:27:08', '2020-05-12 15:27:08', NULL);
INSERT INTO `album_user` VALUES (21819, 0, 'ortXc4nwruubrNQ-KqTAEbk1e-jo', 'lll😊🍰🆒💐', 'https://wx.qlogo.cn/mmopen/vi_32/BANibnl5Tc6NINibOicuUTE2P8S8HYot0H4iaOicvubO23OxtnsROiaqVwMrns855GhicIrOZvUBGhN4xd2Ojuf9QXqmA/132', 0.00, 0, 0, '2020-05-20 09:58:08', '2020-05-20 09:58:08', NULL);
INSERT INTO `album_user` VALUES (21820, 0, 'ortXc4mLSiHSmR9bJqljMdkCXkD8', '我是蒲公英', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqU3ZscDl6CSubbia8WlHdfZSeDZ8D00svbwmVWBbC4XXG1szMwoyR2iaKc1RwdK2lrUuVpdgUhck6A/132', 0.00, 0, 0, '2020-05-21 06:37:58', '2020-05-21 06:37:58', NULL);
INSERT INTO `album_user` VALUES (21821, 0, 'ortXc4m00qVIrx1JNvtFQ4tMtTrE', '不想你的', 'https://wx.qlogo.cn/mmopen/vi_32/CoQOvEiaxcciaQVOYzMgSMA73PTXfib9ZCF33aYmIVaBiaVWaVZa4RDdNzNCHOIuCpmgJPH6iaKvW2CNtUEicgfuXJUg/132', 0.00, 0, 0, '2020-05-21 06:38:36', '2020-05-21 06:38:36', NULL);
INSERT INTO `album_user` VALUES (21822, 0, 'ortXc4ieTL5ErUjReAicqqzucB3g', 'Tamas', 'https://wx.qlogo.cn/mmopen/vi_32/pxEyGhvFibSAqibjrPibZpKWD0O9n8tmicVhWkYI6FS8DpORyzEANZYoyKDepMa6ctubooCZh0cbey6kuGTKmeOcVA/132', 0.00, 0, 0, '2020-05-22 11:38:36', '2020-05-22 11:38:36', NULL);

-- ----------------------------
-- Table structure for album_zanlist
-- ----------------------------
DROP TABLE IF EXISTS `album_zanlist`;
CREATE TABLE `album_zanlist`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uniacid` int(10) NOT NULL,
  `pid` int(10) NOT NULL,
  `openid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_uid`(`openid`) USING BTREE,
  INDEX `index_pid`(`pid`) USING BTREE,
  INDEX `index_uniacid`(`uniacid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (4, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (5, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_05_19_091259_create_album_setting_table', 1);

SET FOREIGN_KEY_CHECKS = 1;
