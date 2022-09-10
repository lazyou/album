var app = getApp();

Page({
    data: {},
    onLoad: function(t) {
        var n = this;
        app.getConfig(function(t) {
            n.setData({
                config: t
            }), app.login(function(t) {
                n.setData({
                    user: t
                });
            });
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
            title: this.data.config.appname,
            path: "/pages/index/index",
            success: function(t) {
                console.log("成功");
            }
        };
    },
    goback: function() {
        wx.navigateBack({
            delta: 1
        });
    },
    dopay: function(t) {
        var a = this, n = t.currentTarget.dataset.num;
        console.log(n), n && (this.setData({
            money: n
        }), app.util.request({
            url: "entry/wxapp/pay",
            data: {
                openid: a.data.user.openid,
                cost: a.data.money
            },
            success: function(n) {
                n.data && wx.requestPayment({
                    timeStamp: n.data.timeStamp,
                    nonceStr: n.data.nonceStr,
                    package: n.data.package,
                    signType: "MD5",
                    paySign: n.data.paySign,
                    success: function(t) {
                        a.tosave(n.data.package, n.data.out_trade_no), wx.showToast({
                            title: "支付成功",
                            icon: "none",
                            duration: 3e3,
                            success: function() {}
                        });
                    },
                    fail: function(t) {
                        wx.showToast({
                            title: "支付失败",
                            icon: "none",
                            duration: 2e3,
                            success: function() {}
                        });
                    }
                });
            },
            fail: function(t) {
                wx.showModal({
                    title: "系统提示",
                    content: "支付出错",
                    showCancel: !1,
                    success: function(t) {
                        t.confirm;
                    }
                });
            }
        }));
    },
    tosave: function(t, n) {
        var a = this.data.uid;
        app.util.request({
            url: "entry/wxapp/payresult",
            method: "post",
            dataType: "json",
            data: {
                openid: a,
                trade_no: n,
                payid: t
            },
            success: function(t) {
                wx.showToast({
                    title: "打赏成功",
                    icon: "none",
                    duration: 3e3,
                    success: function() {
                        wx.navigateBack({
                            delta: 1
                        });
                    }
                });
            }
        });
    }
});