App({
    util: require("we7/util.js"),
    md5: require("we7/md5.js"),
    onLaunch: function() {},
    Data: {
        userInfo: null,
        ver: 6
    },
    Sign: function() {
        let timestamp = Math.round(new Date().getTime() / 1e3);
        let sign = this.md5("album@2020@JoynQaSjl6uePKkrPmpB0WZHBynRQHxDh7Z1vYUfA3P" + timestamp);
        this.Data.sign = sign;
        this.Data.timestamp = timestamp;
    },
    login: function(o) {
        let that = this;
        that.Sign();
        that.Data.userInfo ? "function" == typeof o && o(that.Data.userInfo) : wx.login({
            success: function(t) {
                var n = t.code;
                that.util.request({
                    url: "entry/wxapp/login",
                    method: "post",
                    dataType: "json",
                    data: {
                        code: n,
                        timestamp: that.Data.timestamp,
                        sign: that.Data.sign,
                    },
                    showLoading: !1,
                    success: function(t) {
                        that.Data.userInfo = t.data, "function" == typeof o && o(t.data);
                    }
                });
            }
        });
    },

    getConfig: function(n) {
        let that = this;
        that.Sign();
        that.Data.config ? "function" == typeof n && n(that.Data.config) : this.util.request({
            url: "entry/wxapp/config",
            method: "get",
            dataType: "json",
            showLoading: !1,
            data: {
                ver: that.Data.ver,
                timestamp: that.Data.timestamp,
                sign: that.Data.sign,
            },
            success: function(t) {
                that.Data.config = t.data, "function" == typeof n && n(that.Data.config);
            }
        });
    },

    upForm: function(t) {
    },
    siteInfo: require("siteinfo.js")
});
