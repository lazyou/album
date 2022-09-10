var app = getApp();

Page({
    data: {
        cid: 0,
        showimg: 0,
        num: 0
    },
    onLoad: function(a) {
        var t = this;
        app.getConfig(function(a) {
            t.setData({
                config: a
            }), app.login(function(a) {
                t.setData({
                    user: a
                });
            }), t.skinData();
        });

        // app.util.wxLogin();
    },
    onReady: function() {},
    onShow: function() {},
    onHide: function() {},
    onUnload: function() {},
    onPullDownRefresh: function() {},
    onReachBottom: function() {},
    onShareAppMessage: function() {},
    touchnone: function() {},
    maskclose: function() {
        this.setData({
            showimg: 0
        });
    },
    showimgbox: function() {
        this.setData({
            showimg: 1
        });
    },
    changecate: function(a) {
        this.setData({
            cid: a.target.dataset.cid
        });
    },
    skinData: function() {
        var t = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/skindata",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign
            },
            showLoading: !0,
            success: function(a) {
                t.setData({
                    skinCate: a.data.skincate,
                    skinData: a.data.skindata
                });
            }
        });
    },
    updateUserInfo: function(a) {
        var t = this, i = a.detail.userInfo.nickName, n = a.detail.userInfo.avatarUrl, s = this.data.user.openid, e = a.currentTarget.dataset.skinid;
        (t = this).data.user.avatar ? t.chooseimg(e) : (app.Sign(), app.util.request({
            url: "entry/wxapp/saveuser",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                nickname: i,
                openid: s,
                avatar: n
            },
            showLoading: !1,
            success: function(a) {
                t.setData({
                    "user.avatar": n,
                    "user.nickname": i
                }), t.chooseimg(e);
            }
        }));
    },
    chooseimg: function(t) {
        let that = this;
        wx.hideLoading();
        wx.chooseImage({
            count: 9,
            sizeType: [ "original", "compressed" ],
            sourceType: [ "album", "camera" ],
            success: function(a) {
                that.setData({
                    skin: t,
                    num: 0,
                    pics: a.tempFilePaths,
                    tempPics: a.tempFiles,
                });
                that.compimg();
                wx.showLoading({ title: "正在压缩图片" });
            }
        });
    },
    compimg: function() {
        var t = this, i = t.data.pics, n = t.data.num;
        console.log(i[n]), wx.compressImage({
            src: i[n],
            quality: 60,
            success: function(a) {
                i.splice(n, 1, a.tempFilePath), t.setData({
                    pics: i
                }), n == parseInt(i.length - 1) ? (t.setData({
                    num: 0
                }), t.uploadimgs()) : (t.setData({
                    num: n + 1
                }), t.compimg());
            }
        });
    },

    uploadimgs: function() {
        let that = this;
        let num = that.data.num;
        let pics = that.data.pics;
        let tempPics = that.data.tempPics;
        // TODO: 如何拿到文件的 type?
        let path = tempPics[num].path
        let size = tempPics[num].size

        app.Sign();
        // 1. 获取七牛 uptoken (并设置key--文件名)
        app.util.request({
            url: "entry/wxapp/uptoken",
            method: "post",
            dataType: "json",
            showLoading: !1,
            data: {
                name: path,
                size: size,
                openid: app.Data.userInfo.openid,
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
            },
            success: function(res) {
                let url = res.data.url;
                let key = res.data.key;
                let token = res.data.token;

                wx.uploadFile({
                    url: 'https://up-z2.qiniup.com',
                    filePath: path,
                    name: 'file',
                    formData: {
                        key: key,
                        token: token,
                    },
                    complete: function(res) {
                        wx.showLoading({
                            title: "图片上传中 " + num + "/" + pics.length
                        });

                        if (res.statusCode === 200) {
                            pics[num] = url
                            that.setData({
                                num: num + 1,
                                pics: pics
                            });
                        } else {
                            console.log('skin.js 七牛图片上传失败：');
                            console.error(res.errMsg);
                        }

                        if (num === pics.length - 1) {
                            that.savePhotos();
                        } else {
                            that.uploadimgs(); // 递归上传图片
                        }
                    }
                });
            },
            fail: function(res) {
                console.error('skin.js uploadimgs uptoken fail');
                console.error(res);
            },
        });
    },

    formSubmit: function(a) {
        app.upForm(a.detail.formId);
    },

    savePhotos: function(a, t) {
        var i = this;
        app.Sign(), wx.hideLoading(), console.log(a), app.util.request({
            url: "entry/wxapp/savephotos",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                imgdata: i.data.pics,
                skin: i.data.skin,
                userid: i.data.user.openid,
                nickname: i.data.user.nickname,
                avatar: i.data.user.avatar
            },
            showLoading: !0,
            success: function(a) {
                var t = a.data.photoid;
                i.setData({
                    num: 0,
                    cid: 0
                }), "false" != t && wx.navigateTo({
                    url: "/pages/create/create?id=" + t
                });
            }
        });
    }
});
