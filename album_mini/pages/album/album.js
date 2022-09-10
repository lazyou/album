var app = getApp(), innerAudioContext = wx.createInnerAudioContext();

let interstitialAd = null
innerAudioContext.autoplay = !0, innerAudioContext.loop = !0, innerAudioContext.obeyMuteSwitch = !1,
Page({
    data: {
        songhua: 0,
        picshow: 0,
        showphoto: 1,
        mushow: 0,
        music: 0,
        isShowYe: 0,
        isShowHua: 0,
        isShowDot: 0,
        isHD: 0,
        isXin: 0,
        isYun: 0,
        isXue: 0,
        isFy: 0,
        isCq: 0,
        isQT: 0,
        isHH: 0,
        isPGY: 0,
        cid: 0,
        showmob: 0,
        time1: "",
        maxlen: 22,
        num: 0
    },
    onLoad: function(t) {
        var n = this;
        app.getConfig(function(a) {
            n.setData({
                config: a,
                id: t.id,
                shared: t.shared ? 1 : 0
            }), app.login(function(a) {
                n.setData({
                    user: a
                });
            }), wx.getSystemInfo({
                success: function(a) {
                    var t = 750 / a.windowWidth, i = a.model;
                    console.log(i), n.setData({
                        winW: a.windowWidth * t,
                        winH: a.windowHeight * t,
                        ios: -1 < i.indexOf("iPhone") ? 1 : 0,
                        systemInfo: {
                            pixelRatio: 750 / a.windowWidth,
                            windowWidth: a.windowWidth,
                            windowHeight: a.windowHeight
                        }
                    });
                }
            }), n.albumData();

            console.log('albumconads:')
            console.log(app.Data.config.albumconads)
            n.showChapinAd(app.Data.config.albumconads);
        });
    },
    onReady: function() {},
    onShow: function() {
        var a = innerAudioContext.paused;
        this.data.albumData && a && (innerAudioContext.play(), this.setData({
            playing: 1
        }));
    },

    showChapinAd: function(adUnitId) {
        // 插屏广告
        if(wx.createInterstitialAd && adUnitId) {
            //1.创建广告实例
            interstitialAd = wx.createInterstitialAd({ adUnitId: adUnitId })

            //3.监听广告，广告显示出来以后你要做的操作
            interstitialAd.onLoad(() => {
                console.log('onLoad event emit')
            })

            //其实可以不用管这个onError，它的作用是如果广告拉取失败，就提示你
            interstitialAd.onError((err) => {
                console.log('onError event emit', err)
            })

            //广告关闭时，触发。
            interstitialAd.onClose((res) => {
                console.log('onClose event emit', res)
            })
        }

        if (adUnitId) {
            // 2.让广告显示出来
            interstitialAd.show().catch((err) => {
                console.log(err)
            })
        }
    },

    onHide: function() {
        innerAudioContext.pause(), this.setData({
            music: 0
        });
    },
    onUnload: function() {
        innerAudioContext.stop();
    },
    onShareAppMessage: function() {
        var a = this, t = a.data.albumData.thumb;
        return t = -1 != t.indexOf("http") ? t : a.data.config.url + t, 1 == this.data.config.ishared && wx.navigateTo({
            url: "/pages/web/web?url=" + escape(a.data.config.shareurl)
        }), {
            title: a.data.albumData.title,
            imageUrl: t,
            path: "/pages/index/index?id=" + a.data.id + "&shared=1",
            success: function(a) {
                console.log("成功");
            }
        };
    },
    playstate: function() {
        this.data.music ? (this.setData({
            music: 0
        }), innerAudioContext.pause()) : (innerAudioContext.src = this.data.albumData.music,
        innerAudioContext.play(), this.setData({
            music: 1
        }));
    },
    albumData: function() {
        var i = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/photodata",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                id: i.data.id
            },
            showLoading: !1,
            success: function(a) {
                if (a.data) {
                    var t = a.data.skinData;
                    a.data.albumData.imgdata ? (i.setData({
                        skinData: t,
                        albumData: a.data.albumData,
                        inputTitle: a.data.albumData.title,
                        ad1: a.data.ad1,
                        ad2: a.data.ad2,
                        selemusic: a.data.albumData.music
                    }), i.data.albumData.music && (i.setData({
                        music: 1
                    }), console.log("ok"), innerAudioContext.src = i.data.albumData.music, innerAudioContext.play()),
                    "ad" != t ? i.skinSet() : i.animationPlay(), setTimeout(function() {
                        i.clickdata();
                    }, 3e3)) : wx.switchTab({
                        url: "/pages/index/index"
                    });
                }
            }
        });
    },
    skinSet: function() {
        var a = this.data.skinData, t = [ "photosAni", "photosAni2", "photosAni3", "swing", "flipInY" ], i = [];
        i = "ani" + a.model == "ani1" ? t : "ani" + a.model == "ani2" ? [ "flipInX", "shengri", "swing", "bounceIn", "flipInY", "qingfeng" ] : "ani" + a.model == "ani3" ? [ "bounceIn", "flipInY", "qingfeng", "photosAni2", "shengri" ] : "ani" + a.model == "ani4" ? [ "swing", "flipInY", "photosAni3", "qingfeng", "bounceIn" ] : t,
        this.setData({
            photoani: i,
            isShowYe: 0 <= a.ani.indexOf("a"),
            isShowHua: 0 <= a.ani.indexOf("b"),
            isShowDot: 0 <= a.ani.indexOf("c"),
            isHD: 0 <= a.ani.indexOf("d"),
            isXin: 0 <= a.ani.indexOf("e"),
            isYun: 0 <= a.ani.indexOf("f"),
            isXue: 0 <= a.ani.indexOf("g"),
            isFy: 0 <= a.ani.indexOf("h"),
            isCq: 0 <= a.ani.indexOf("i"),
            isQT: 0 <= a.ani.indexOf("j"),
            isHH: 0 <= a.ani.indexOf("k"),
            isPGY: 0 <= a.ani.indexOf("l")
        }), this.animationPlay();
    },
    animationPlay: function() {
        var a = this, t = 0, i = 0;
        "ad" != this.data.skinData ? (this.step(t, i), t++, i++, a.data.time1 = setInterval(function() {
            t >= a.data.albumData.imgdata.length && (t = 0), i >= a.data.photoani.length && (i = 0),
            a.step(t, i), t++, i++, console.log(t + "  " + i);
        }, 9e3)) : (this.step(t, i), t++, i++, a.data.time1 = setInterval(function() {
            t >= a.data.albumData.imgdata.length && (t = 0), 9 <= i && (i = 0), a.step(t, i),
            t++, i++;
        }, 8e3));
    },
    step: function(a, t) {
        if ("ad" != this.data.skinData) {
            var i = this.data.photoani[t], n = -1 != (s = this.data.albumData.imgdata[a]).indexOf("http") ? s : this.data.config.url + s, e = this.data.albumData.txtdata[a] ? this.data.albumData.txtdata[a] : "";
            this.setData({
                img: n,
                text: e,
                currentAnimation: i
            });
        } else {
            var s;
            i = t, n = -1 != (s = this.data.albumData.imgdata[a]).indexOf("http") ? s : this.data.config.url + s,
            e = this.data.albumData.txtdata[a] ? this.data.albumData.txtdata[a] : "";
            this.setData({
                img: n,
                text: e,
                currentAnimation: i
            });
        }
    },
    loadImg: function(a) {
        a.detail.width < this.data.winW ? a.detail.width : (this.data.winW, this.data.compressionRatio);
        var t = 650 / a.detail.width * a.detail.height, i = (this.data.winH - t) / 2;
        a.detail.width < this.data.winW ? a.detail.width : (this.data.winW, this.data.compressionRatio),
        this.setData({
            imgW: 650,
            imgH: t,
            imgML: 50,
            imgT: i
        });
    },
    formSubmit: function(a) {
        app.upForm(a.detail.formId);
    },
    backhome: function() {
        0 == this.data.shared ? wx.navigateBack({
            delta: 1
        }) : wx.switchTab({
            url: "/pages/index/index"
        });
    },
    gotoIndex: function() {
        0 == this.data.shared ? wx.navigateBack({
            delta: 1
        }) : wx.switchTab({
            url: "/pages/index/index"
        });
    },
    createAlbum: function(a) {
        var t = this, i = a.detail.userInfo.nickName, n = a.detail.userInfo.avatarUrl, e = this.data.user.openid;
        t.data.user.avatar ? t.gotoupload() : (app.Sign(), app.util.request({
            url: "entry/wxapp/saveuser",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                nickname: i,
                openid: e,
                avatar: n
            },
            showLoading: !1,
            success: function(a) {
                t.setData({
                    "user.avatar": n,
                    "user.nickname": i
                }), t.gotoupload();
            }
        }));
    },
    clickdata: function() {
        app.Sign(), app.util.request({
            url: "entry/wxapp/clickdata",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                id: this.data.id
            },
            showLoading: !1,
            success: function(a) {}
        });
    },
    postHua: function() {
        var t = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/posthua",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                id: t.data.id
            },
            showLoading: !1,
            success: function(a) {
                t.setData({
                    songhua: 1
                }), setTimeout(function() {
                    t.setData({
                        songhua: 0
                    });
                }, 1500);
            }
        });
    },
    piaofu1: function() {
        var a = this.data.ad1;
        1 == a.istype ? wx.navigateTo({
            url: "/pages/web/web?url=" + escape(a.path)
        }) : wx.navigateToMiniProgram({
            appId: a.appid,
            path: a.path,
            extraData: {
                foo: "bar"
            },
            envVersion: "release",
            success: function(a) {}
        });
    },
    piaofu2: function() {
        var a = this.data.ad2;
        1 == a.istype ? wx.navigateTo({
            url: "/pages/web/web?url=" + escape(a.path)
        }) : wx.navigateToMiniProgram({
            appId: a.appid,
            path: a.path,
            extraData: {
                foo: "bar"
            },
            envVersion: "release",
            success: function(a) {}
        });
    },
    gotoupload: function() {
        let that = this;
        wx.hideLoading();
        wx.chooseImage({
            count: 9,
            sizeType: [ "original", "compressed" ],
            sourceType: [ "album", "camera" ],
            success: function(a) {
                that.setData({
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
        // console.log('tempPics:');
        // console.log(tempPics);

        let path = tempPics[num].path
        let size = tempPics[num].size

        app.Sign();
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
                    name: "file",
                    formData: {
                        key: key,
                        token: token,
                    },
                    complete: function(res) {
                        wx.showLoading({
                            title: "图片上传中 " + num + "/" + pics.length
                        });

                        if (res.statusCode === 200) {
                            pics.splice(num, 1, url);
                            that.setData({
                                num: num + 1,
                                pics: pics,
                            });
                        } else {
                            console.log('album.js 七牛图片上传失败：');
                            console.error(res.errMsg);
                        }

                        if (num === parseInt(pics.length - 1)) {
                            that.savePhotos()
                        } else {
                            that.uploadimgs();
                        }
                    }
                });
            },
            fail: function(res) {
                console.error('create.js uploadimgs uptoken fail');
                console.error(res);
            },
        });
    },
    touchmove: function() {},
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
                skin: i.data.albumData.skin,
                userid: i.data.user.openid,
                nickname: i.data.user.nickname,
                avatar: i.data.user.avatar
            },
            showLoading: !0,
            success: function(a) {
                var t = a.data.photoid;
                i.setData({
                    num: 0
                }), "false" != t && wx.redirectTo({
                    url: "/pages/create/create?id=" + t + "&shared=1"
                });
            }
        });
    },
    dopay: function() {
        0 == this.data.config.paytype ? wx.navigateTo({
            url: "/pages/pay/pay"
        }) : wx.navigateToMiniProgram({
            appId: this.data.config.payappid,
            path: this.data.config.paypath,
            extraData: {
                foo: "bar"
            },
            envVersion: "release",
            success: function(a) {}
        });
    }
});
