## **DriverEpoch** 「iOS」行车服务app 

> - 最近开发了一个行车服务项目，iOS客户端采用`Objective-C`编写， 后端采用`PHP`搭建，部署在`阿里云`，操作系统为`Linux CentOS 7.3`，数据库`MySQL`，服务器为`Apache`，是比较基础的`LAMP`组合。
- iOS端代码部分我会讲述整体的开发思路，一些有意思的功能点也会详细说说。
- 后端代码比较简单，想要自己尝试开发`API`的iOS开发者可以参考。

首先上整体的效果图：
![show.gif](http://upload-images.jianshu.io/upload_images/3587644-885a443c5380c5b9.gif?imageMogr2/auto-orient/strip)

*在POI检索结果页面，地图控件显示为空白，是因为模拟器运行的原因，真机效果良好*

##### 这里是 **[iOS项目地址](https://github.com/halohily/DriverEpoch)**、**[后端项目地址](https://github.com/halohily/DriverEpoch-Server)** 。如果有帮助，希望点一下`Star`以示鼓励，感谢~

简单介绍：项目UI整体尽量保持了`饿了么`的蓝色风格，其中某些页面参考了`高德地图`、`饿了么`、`Max+`的设计风格。
### 项目功能点
- 账户、用户资料管理
- 参照`饿了么`UI的定位、天气模块
- 基于`高德地图API`开发的`POI`检索，同时界面也加入了一些和`高德地图`app类似的特性
- 自定义交互逻辑的预定及结果通知功能
- 简单参照`Max+`app的资讯模块
- 用户历史足迹、历史事件维护

### 项目使用到的API及第三方库
- `高德地图API`
- `和风天气API`
- `自己搭建的后端相关接口`
- `AFNetworking 3.0`
- `SDWebImage`
- `MBProgressHUD`
- **项目内的`Icon`大量使用阿里巴巴的`iconfont`图标，极力推荐**

### 项目涉及的技术点
- `高德地图API`的相关使用。包括`地图`、`POI检索`、`导航`等功能。
- `GCD`的使用示例。包括耗时操作的后台执行、UI更新相关操作等。
- `NSUserDefaults`维护账户信息。这里是为使用方便，仅供参考。
- `Core Animation`的使用。由于`TableView`加载时采用`HUD`的用户体验不是很友善，我自己封装了`Loading`页面。



#### **关于项目的开发思路，我在简书发布了一篇文章，有需要的同学可以看一下。 [开发思路介绍](http://www.jianshu.com/p/264961e62de7)**