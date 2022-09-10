var app = getApp();
let interstitialAd = null

Page({
    data: {
        indicatorDots: !0,
        autoplay: !0,
        interval: 5e3,
        duration: 1e3,
        hdindex: 0,
        page: 1,
        ishot: 1,
        loading: 1
    },

    onLoad: function(t) {
        var that = this;
        app.getConfig(function(a) {
            that.setData({
                config: a
            })

            t.id && wx.navigateTo({
                url: "/pages/album/album?id=" + t.id
            })

            t.id || 1 != a.iscustom || wx.navigateTo({
                url: "/pages/album/album?id=" + a.aid
            })

            app.login(function(a) {
                that.setData({ user: a })
                that.indexAd()
                that.listData()
            });

            that.showChapinAd(app.Data.config.albumads);
        });

        // app.util.wxLogin();
    },

    onShow: function() {},

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

        // 2.让广告显示出来
        if (adUnitId) {
            interstitialAd.show().catch((err) => {
                console.log(err)
            })
        }
    },

    onPullDownRefresh: function() {
        this.setData({
            ishot: this.data.ishot,
            indexData: "",
            page: 1,
            noData: 0
        }), this.listData();
    },

    onReachBottom: function() {
        if (!this.data.config.review) {
            var a = ++this.data.page;
            this.setData({
                page: a
            }), this.data.noData || this.listData();
        }
    },

    onShareAppMessage: function(a) {
        var t = this;
        if ("button" === a.from) {
            var i = a.target.dataset.index, e = t.data.indexData[i].thumb, n = -1 != e.indexOf("http") ? e : t.data.config.url + e, s = (i = a.target.dataset.index,
            t.data.indexData[i]);
            return {
                title: s.title,
                imageUrl: n,
                path: "/pages/index/index?id=" + s.id + "&shared=1",
                success: function(a) {
                    console.log("成功");
                }
            };
        }

        return {
            title: t.data.config.sharetitle,
            imageUrl: t.data.config.shareimg,
            path: "/pages/index/index",
            success: function(a) {
                console.log("成功");
            }
        };
    },

    changeTab: function(a) {
        var t = a.currentTarget.dataset.ishot;
        this.setData({
            ishot: t,
            indexData: "",
            page: 1,
            loading: 1,
            noData: 0
        }), this.listData();
    },
    formSubmit: function(a) {
        app.upForm(a.detail.formId);
    },

    listData: function() {
        var s = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/indexdata",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                ishot: s.data.ishot,
                page: s.data.page
            },
            showLoading: !1,
            success: function(a) {
                if (wx.stopPullDownRefresh(), 0 < a.data.length) {
                    for (var t = s.data.indexData, i = a.data, e = 0; e < i.length; e++) i[e].thumb = -1 != i[e].thumb.indexOf("http") ? i[e].thumb : s.data.config.url + i[e].thumb;
                    var n = t ? t.concat(i) : i;
                    s.setData({
                        indexData: n,
                        loading: 0
                    });
                } else s.setData({
                    noData: 1,
                    loading: 0
                });
            }
        });
    },

    indexAd: function() {
        var t = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/indexad",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign
            },
            showLoading: !1,
            success: function(a) {
                t.setData({
                    inad: a.data.indexpf ? a.data.indexpf : "",
                    hd: a.data.hd
                });
            }
        });
    },

    gotoAlbum: function(a) {
        var t = a.currentTarget.dataset.id;
        wx.navigateTo({
            url: "/pages/album/album?id=" + t
        });
    },

    bindchange: function(a) {
        this.setData({
            hdindex: a.detail.current
        });
    },

    gotoApp: function() {
        var a = this.data.hd[this.data.hdindex];
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

    gotoJump: function() {
        var a = this.data.inad;
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
    }
});
