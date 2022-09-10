var app = getApp();

Page({
    data: {},
    onLoad: function(a) {
        var t = this;
        app.getConfig(function(a) {
            t.setData({
                config: a,
                llads: app.Data.config.llads ? app.Data.config.llads : ""
            }), t.getAppList();
        });
    },
    onReady: function() {},
    onShow: function() {},
    onHide: function() {},
    onUnload: function() {},
    onPullDownRefresh: function() {},
    onReachBottom: function() {},
    onShareAppMessage: function() {
        return {
            title: that.data.config.sharetitle,
            imageUrl: that.data.config.shareimg,
            path: "/pages/index/index",
            success: function(a) {}
        };
    },
    getAppList: function() {
        var t = this;
        app.Sign(), app.util.request({
            url: "entry/wxapp/applist",
            method: "post",
            dataType: "json",
            data: {
                timestamp: app.Data.timestamp,
                sign: app.Data.sign
            },
            showLoading: !1,
            success: function(a) {
                t.setData({
                    appList: a.data
                });
            }
        });
    },
    gotoapp: function(a) {
        var t = this.data.appList[a.currentTarget.dataset.index];
        "1" == t.istype ? wx.navigateTo({
            url: "/pages/web/web?url=" + escape(t.path)
        }) : wx.navigateToMiniProgram({
            appId: t.appid,
            path: t.path,
            extraData: {
                foo: "bar"
            },
            envVersion: "develop",
            success: function(a) {}
        });
    }
});