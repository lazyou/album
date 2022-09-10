var app = getApp();

Page({
    data: {
        page: 1,
        tab: 0,
        loading: 1
    },
    onLoad: function(a) {
        var t = this;
        app.getConfig(function(a) {
            t.setData({
                config: a
            });
        });

        // app.util.wxLogin();
    },
    onReady: function() {},
    onShow: function() {
        var t = this;
        app.login(function(a) {
            t.setData({
                user: a,
                page: 1,
                noData: 0,
                loading: 1,
                indexData: ""
            }), t.getuserData();
        });
    },
    onHide: function() {},
    onUnload: function() {},
    onReachBottom: function() {
        var a = ++this.data.page;
        this.setData({
            page: a
        }), this.data.noData || this.getuserData();
    },
    onShareAppMessage: function(a) {
        var t = this;
        if ("button" === a.from) {
            var e = a.target.dataset.index, n = t.data.indexData[e];
            return {
                title: n.title,
                imageUrl: n.thumb,
                path: "/pages/index/index?id=" + n.id + "&shared=1",
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
        var t = a.currentTarget.dataset.tab;
        this.setData({
            tab: t,
            indexData: "",
            page: 1,
            loading: 1,
            noData: 0
        }), this.getuserData();
    },
    getuserData: function() {
        var s = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/userdata",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                uid: s.data.user.openid,
                all: s.data.tab,
                page: s.data.page
            },
            showLoading: !1,
            success: function(a) {
                if (0 < a.data.length) {
                    for (var t = s.data.indexData, e = a.data, n = 0; n < e.length; n++) e[n].thumb = -1 != e[n].thumb.indexOf("http") ? e[n].thumb : s.data.config.url + e[n].thumb;
                    var i = t ? t.concat(e) : e;
                    s.setData({
                        indexData: i,
                        loading: 0
                    });
                } else s.setData({
                    noData: 1,
                    loading: 0
                });
            }
        });
    },
    delalbum: function(a) {
        var t = a.currentTarget.dataset.index, e = this, n = this.data.indexData, i = n[t];
        wx.showModal({
            content: "删除相册无法恢复",
            success: function(a) {
                a.confirm ? (app.Sign(), app.util.request({
                    url: "entry/wxapp/delalbum",
                    method: "post",
                    dataType: "json",
                    data: {
                        timestamp: app.Data.timestamp,
                        sign: app.Data.sign,
                        uid: e.data.user.openid,
                        id: i.id
                    },
                    showLoading: !1,
                    success: function(a) {
                        1 == a.data.status && (n.splice(t, 1), e.setData({
                            indexData: n
                        }), wx.showToast({
                            title: "删除成功",
                            icon: "none",
                            duration: 2e3
                        }));
                    }
                })) : a.cancel && console.log("用户点击取消");
            }
        });
    },

    doPrivate: function(a) {
        var t = a.currentTarget.dataset.index, e = this.data.indexData, n = e[t].id, i = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/setprivate",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                uid: i.data.user.openid,
                id: n,
                private: e[t].private
            },
            showLoading: !1,
            success: function(a) {
                1 == a.data.status && (e[t].private = a.data.private, i.setData({
                    indexData: e
                }), wx.showToast({
                    title: "设置成功",
                    icon: "none",
                    duration: 2e3
                }));
            }
        });
    },

    gotoAlbum: function(a) {
        var t = a.currentTarget.dataset.id;
        wx.navigateTo({
            url: "/pages/create/create?id=" + t
        });
    },

    updateUserInfo: function(a) {
        var t = a.detail.userInfo.nickName;
        var e = a.detail.userInfo.avatarUrl;
        var n = this.data.user.openid;
        var i = this;

        app.Sign();
        app.util.request({
            url: "entry/wxapp/saveuser",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign,
                nickname: t,
                openid: n,
                avatar: e
            },
            showLoading: !1,
            success: function(a) {
                i.setData({
                    "user.avatar": e,
                    "user.nickname": t
                }), wx.showToast({
                    title: "登录成功",
                    icon: "none",
                    duration: 2e3
                });
            }
        });
    }
});
