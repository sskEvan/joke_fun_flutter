# joke_fun_flutter

很久之前在掘金上看到[MZCretin](https://github.com/MZCretin)大佬在掘金上发的一篇文章：[想没想过自己做个APP？来，机会来了](https://juejin.cn/post/7088630212371415076?searchId=20231018161209E616E83F04F6E5AB328E)，
一直想找时间仿写他的段子乐app，但是一直没有付诸行动。前阵子借着想重温早下flutter的冲动，便用flutter仿写了段子乐app--joke_fun_flutter。 joke_fun_flutter数据源来自[MZCretin](https://github.com/MZCretin)大佬开放的接口，页面也很大程度参考了段子乐app，这里特别感谢[MZCretin](https://github.com/MZCretin)大佬！

项目整体基于GetX实现路由跳转、依赖注入、状态管理。网络请求基于Dio+Retrofit。目前基本的功能有：
* 段子推荐列表（纯文字、多图片、视频）
* 段子详情
* 段子发布
* 发现（仿抖音划一划功能）
* 搜索
* 登陆
* 个人详情、资料编辑、乐豆
* 关注、评论（支持楼中楼）
* 主题色切换
* ...

当然，有些功能也没有实现的很完善，例如编辑头像、发布段子包含视频或者图片，并不会真正上传到云，但是整个交互流程都已串通；
视频播放由于大部分链接无法播放，所以自己mock了一些在线视频链接用于测试。

### 运行效果图
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/gif-2.gif)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/gif-1.gif)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/登陆-1.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/登陆-2.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/首页-1.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/首页-2.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/首页-3.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/搜索-1.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/搜索-2.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/帖子详情-1.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/帖子详情-2.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/图片查看.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/发表评论.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/发布.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/发现.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/个人资料.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/关注.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/乐豆.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/上传头像.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/我的.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/我的-评论.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/我的-喜欢.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/主题切换.webp)
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/深夜模式.webp)

### 下载地址
![img](https://github.com/sskEvan/joke_fun_flutter/blob/master/screenshot/JokeFunQrcode.png)



