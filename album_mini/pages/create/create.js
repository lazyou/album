var app = getApp(), innerAudioContext = wx.createInnerAudioContext();

innerAudioContext.autoplay = !0, innerAudioContext.loop = !0, innerAudioContext.obeyMuteSwitch = !1,
Page({
    data: {
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
        maxlen: 40,
        num: 0
    },
    onLoad: function(t) {
        var i = this;
        app.getConfig(function(a) {
            i.setData({
                config: a,
                id: t.id,
                shared: 1 == t.shared ? 1 : 0
            }), app.login(function(a) {
                i.setData({
                    user: a
                }), t.openid && i.setData({
                    "user.openid": t.openid,
                    his: 1
                });
            }), wx.getSystemInfo({
                success: function(a) {
                    var t = 750 / a.windowWidth;
                    i.setData({
                        winW: a.windowWidth * t,
                        winH: a.windowHeight * t,
                        systemInfo: {
                            pixelRatio: 750 / a.windowWidth,
                            windowWidth: a.windowWidth,
                            windowHeight: a.windowHeight
                        }
                    });
                }
            }), i.albumData();
        });
    },
    onReady: function() {},
    onShow: function() {
        var a = innerAudioContext.paused;
        this.data.albumData && a && (innerAudioContext.play(), this.setData({
            playing: 1
        }));
    },
    onHide: function() {
        innerAudioContext.pause(), this.setData({
            music: 0
        });
    },
    onUnload: function() {
        innerAudioContext.stop();
    },
    onShareAppMessage: function(a) {
        var t = this;
        t.data.config.url, t.data.albumData.thumb;
        if ("button" === a.from) {
            if (1 == a.target.dataset.edit) var i = "/pages/create/create?id=" + t.data.id + "&openid=" + t.data.albumData.openid, s = "我是" + t.data.user.nickname + "，邀您制作我们的回忆！！"; else i = "/pages/index/index?id=" + t.data.id + "&shared=1",
            s = "我是" + t.data.albumData.nickname + "，快来看看我的音乐影集!!";
            return {
                title: s,
                imageUrl: t.data.config.shareimg,
                path: i,
                success: function(a) {
                    console.log("成功");
                }
            };
        }
        return {
            title: "我是" + t.data.albumData.nickname + "，快来看看我的音乐影集!!",
            // imageUrl: t.data.config.shareimg,
            imageUrl: t.data.config.shareimg,
            path: "/pages/album/album?id=" + t.data.id + "&shared=1",
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
                    mobCate: a.data.skincate,
                    mobData: a.data.skindata
                });
            }
        });
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
                    i.setData({
                        skinData: t,
                        albumData: a.data.albumData,
                        inputTitle: a.data.albumData.title,
                        selemusic: a.data.albumData.music
                    }), i.data.albumData.music && (i.setData({
                        music: 1
                    }), innerAudioContext.src = i.data.albumData.music, innerAudioContext.play()), "ad" != t ? i.skinSet() : i.animationPlay();
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
            t++, i++, console.log(t + "  " + i);
        }, 5e3));
    },
    step: function(a, t) {
        if ("ad" != this.data.skinData) {
            var i = this.data.photoani[t], s = -1 != (n = this.data.albumData.imgdata[a]).indexOf("http") ? n : this.data.config.url + n, e = this.data.albumData.txtdata[a] ? this.data.albumData.txtdata[a] : "";
            this.setData({
                img: s,
                text: e,
                currentAnimation: i
            });
        } else {
            var n;
            i = t, s = -1 != (n = this.data.albumData.imgdata[a]).indexOf("http") ? n : this.data.config.url + n,
            e = this.data.albumData.txtdata[a] ? this.data.albumData.txtdata[a] : "";
            this.setData({
                img: s,
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
    backhome: function() {
        1 == this.data.his || 1 == this.data.shared ? wx.switchTab({
            url: "/pages/index/index"
        }) : wx.navigateBack({
            delta: 1
        });
    },
    changecate: function(a) {
        this.setData({
            cid: a.target.dataset.cid
        });
    },
    showAddpic: function() {
        this.setData({
            picshow: 1,
            showphoto: 0
        });
    },
    showmu: function() {
        this.setData({
            mushow: 1,
            showphoto: 0
        }), this.getMulist();
    },
    showmob: function() {
        this.setData({
            showmob: 1,
            showphoto: 0
        }), this.skinData();
    },
    closepics: function() {
        this.setData({
            picshow: 0,
            showphoto: 1,
            titlehide: 0
        });
    },
    closeMu: function() {
        this.setData({
            mushow: 0,
            showphoto: 1,
            selemusic: this.data.albumData.music
        }), innerAudioContext.src = this.data.albumData.music, innerAudioContext.play();
    },
    closeMob: function() {
        this.setData({
            showmob: 0,
            showphoto: 1
        });
    },
    getMulist: function() {
        var t = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/music",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign
            },
            showLoading: !0,
            success: function(a) {
                a.data ? t.setData({
                    mulist: a.data
                }) : console.log("出错");
            }
        });
    },
    seMusic: function(a) {
        var t = a.currentTarget.dataset.music, i = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/upmusic",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                music: t,
                userid: i.data.user.openid,
                id: i.data.id
            },
            showLoading: !0,
            success: function(a) {
                "success" == a.data.status ? i.setData({
                    mushow: 0,
                    "albumData.music": t,
                    showphoto: 1
                }) : wx.showToast({
                    title: "选择音乐出错",
                    icon: "none",
                    duration: 2e3
                });
            }
        });
    },
    chooseThis: function(a) {
        var t = a.currentTarget.dataset.skinid, i = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/upskin",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                skin: t,
                userid: i.data.user.openid,
                id: i.data.id
            },
            showLoading: !0,
            success: function(a) {
                a.data ? (clearInterval(i.data.time1), i.setData({
                    skinData: a.data,
                    "albumData.skin": t,
                    showphoto: 1,
                    showmob: 0
                }), innerAudioContext.stop(), innerAudioContext.src = i.data.skinData.music, innerAudioContext.play(),
                i.skinSet()) : console.log("出错");
            }
        });
    },
    up: function(a) {
        var t = a.currentTarget.dataset.i, i = this.data.albumData.imgdata;
        console.log(t), i[t] = i.splice(t - 1, 1, i[t])[0], this.setData({
            "albumData.imgdata": i
        }), this.saveImg();
    },
    down: function(a) {
        var t = a.currentTarget.dataset.i, i = this.data.albumData.imgdata;
        i[t] = i.splice(t + 1, 1, i[t])[0], this.setData({
            "albumData.imgdata": i
        }), this.saveImg();
    },
    saveImg: function(a) {
        app.Sign(), app.util.request({
            url: "entry/wxapp/saveimg",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                imgdata: this.data.albumData.imgdata,
                txtdata: this.data.albumData.txtdata,
                id: this.data.id,
                userid: this.data.user.openid,
                oldimg: a || ""
            },
            showLoading: !1,
            success: function(a) {}
        });
    },

    addpics: function() {
        let that = this;
        wx.hideLoading();
        wx.chooseImage({
            count: 9,
            sizeType: [ "original", "compressed" ],
            sourceType: [ "album", "camera" ],
            success: function(a) {
                that.setData({
                    num: 0,
                    newpics: a.tempFilePaths,
                    tempPics: a.tempFiles,
                });
                that.compimg();
                wx.showLoading({ title: "正在压缩图片" });
            }
        });
    },
    gotoUser: function() {
        wx.switchTab({
            url: "/pages/user/user"
        });
    },
    compimg: function() {
        var t = this, i = t.data.newpics, s = t.data.num;
        wx.compressImage({
            src: i[s],
            quality: 60,
            success: function(a) {
                i.splice(s, 1, a.tempFilePath), t.setData({
                    newpics: i
                }), s == parseInt(i.length - 1) ? (t.setData({
                    num: 0
                }), t.uploadimgs()) : (t.setData({
                    num: s + 1
                }), t.compimg());
            }
        });
    },

    uploadimgs: function() {
        let that = this;
        let num = that.data.num;
        let newpics = that.data.newpics;
        let tempPics = that.data.tempPics;
        // console.log('tempPics:');
        // console.log(tempPics);

        let path = tempPics[num].path
        let size = tempPics[num].size

        // 1. 获取七牛 uptoken (并设置key--文件名)
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
                            title: "图片上传中 " + num + "/" + newpics.length
                        });

                        if (res.statusCode === 200) {
                            newpics[num] = url

                            that.setData({
                                num: num + 1,
                                newpics: newpics
                            });
                        } else {
                            console.log('create.js 七牛图片上传失败：');
                            console.error(res.errMsg);
                        }

                        if (num === newpics.length - 1) {
                            let imgdata = that.data.albumData.imgdata;
                            imgdata.push.apply(imgdata, that.data.newpics);
                            that.setData({
                                "albumData.imgdata": imgdata,
                            });
                            that.saveImg();
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
    playMusic: function(a) {
        this.setData({
            selemusic: a.currentTarget.dataset.music
        }), innerAudioContext.src = a.currentTarget.dataset.music, innerAudioContext.play();
    },
    deletePic: function(a) {
        var t = a.currentTarget.dataset.i, i = this.data.albumData.imgdata, s = this.data.albumData.txtdata, e = i[t];
        i.splice(t, 1);
        s[t];
        s.splice(t, 1), this.setData({
            "albumData.imgdata": i,
            "albumData.txtdata": s
        }), this.saveImg(e);
    },
    writetxt: function(a) {
        var t = parseInt(a.currentTarget.dataset.ti), i = a.detail.value, s = this.data.albumData.txtdata;
        s[t] = i, this.setData({
            txtdata: s
        });
    },
    touchmove: function() {},
    blurtxt: function() {
        var t = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/savetxt",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                id: t.data.id,
                userid: t.data.user.openid,
                txtdata: t.data.txtdata
            },
            showLoading: !1,
            success: function(a) {
                t.setData({
                    "albumData.txtdata": t.data.txtdata
                });
            }
        });
    },
    focusTitle: function(a) {
        var t = a.detail.value.length;
        this.setData({
            lens: t,
            titlehide: 1
        });
    },
    writeTitle: function(a) {
        var t = a.detail.value.length;
        this.setData({
            inputTitle: a.detail.value,
            lens: t
        });
    },
    blurIput: function() {
        var t = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/savetitle",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                id: t.data.id,
                userid: t.data.user.openid,
                title: t.data.inputTitle
            },
            showLoading: !1,
            success: function(a) {
                t.setData({
                    "albumData.title": t.data.inputTitle
                });
            }
        });
    }
});
