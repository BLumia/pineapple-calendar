# Pineapple Calendar

写这玩意儿的目的主要是为了解决我们，好吧，我，没法在 KDE 下直接看农历的问题。于是目前的主要目标就是能提供一套比较通用的代码（比如以库的形式）以便于能写一个 Plasmoid 给 Plasma 5 桌面环境来显示中国农历，并且还能同时用于开发一个简单的独立的应用程序来做测试和便于后续做一些额外的功能。

尽管这个项目目前只打算提供简体中文农历支持，但我还是希望我的这套玩意儿可以比较灵活/可扩展，以便于实现其它日历系统的支持。

不过我其实压根不怎么懂什么日期时间之类的玩意儿，尤其是还要处理不同的地域习俗啊日期啊之类的问题，所以如果这里提到的东西如果有错，烦请您务必指正。我也会尽可能提供有必要的链接。

## 预期产出

### 当前目标

 - [x] 一个用于 KDE Plasma 5 的 Plasmoid （桌面插件，Applet 小程序），能...
   - [x] 将 *Gregorian 日历（格列高利历、公历）* 作为主日历.
   - [x] 能够显示简体中文农历作为备用日历.
 - [ ] 将相关需求试图向 KDE 推进
   - [KDE bugzilla 中所汇报的特性请求](https://bugs.kde.org/show_bug.cgi?id=429892)
   - [关于我的一些想法的谷歌文档页面链接](https://docs.google.com/document/d/1iwEwwK9w34ZKOegb8xcecO4u2Pjgv2e7ifXMFKox62Q/edit?usp=sharing)
   - 如你也有意向，欢迎一起讨论想法！
 - [ ] 一个独立的 Qt 应用程序，能...
   - [ ] 将 *Gregorian 日历* 作为主日历，能选择并设置通过应用提供的插件系统载入的日历作为备用日历.
   - [ ] 自带一个简体中文农历插件.
   - [ ] 尽可能多的和 Plasmoid 插件共用代码.

### 非目标，但或许会考虑支持

 - 支持日历事件.
   - 支持通过日历事件来支持节气显示.
   - 支持 ics 格式.

## 构建

目前的程度，已经有了一个可在目前较新的 Plasma 桌面环境下使用的 Plasma 小程序（Applet），若有意向尝试，请看下方的构建说明。

默认情况下，此应用只会构建（用于测试的）独立应用。若未明确启用 `BUILD_PLASMOID` 这个 CMake 选项，则 Plasmoid（Plasma 小程序 / Applet）并不会构建。另请注意，此小程序仅包含（硬编码的）简体中文农历日历作为替代日历显示。

### 构建和测试此 Plasmoid

请确保你构建时传递了 `-DBUILD_PLASMOID=ON` 选项，然后在构建成功后执行 `sudo make install` 进行安装即可。

安装完毕后，你可以通过右键“数字时钟”组件，选择替换方案并选择“时间和日历”组件。若你不希望替换正在所用的组件而只是想看看长什么样的话，也可以使用 `plasmoidviewer` 工具:

``` shell
$ plasmoidviewer -a net.blumia.pineapple.calendar -l topedge -f horizontal
```

*注意: 我还不清楚 Plasma 如何加载指定位置的 C++ 原生插件，故如果你也不知道的话，不建议在安装时通过自定义 DESTDIR 来修改安装位置，如果你知道的话，请告诉我= =||*

## 其它东西

`/plasmoid/package/contents/ui/calendar/` 下的文件派生自 `plasma-framework` 项目，对应路径 `/src/declarativeimports/calendar/qml/` 以及提交哈希值 `431d4cc0d4507ff8dc6b64fc039817635b600e65`。

`/app/declarativeimports/net/blumia/pineapple/calendar/` 下的 `.cpp` 和 `.h` 文件派生自 `plasma-framework` 项目，对应路径 `/src/declarativeimports/calendar/` 以及提交哈希值 `ec417349696d4950d0a9aa9367ee35b388046522`，首次 checkin 的提交仅更改了 `calendarplugin.cpp` 中的一处 `Q_ASSERT`，未进行其它任何更改。

若你对目前的实现有任何建议，或是有意愿推进 KDE 来支持此特性，可以通过开 Issue，或者在 [KDE 的特性请求汇报]((https://bugs.kde.org/show_bug.cgi?id=429892) 或 [包含我的想法的谷歌文档页面](https://docs.google.com/document/d/1iwEwwK9w34ZKOegb8xcecO4u2Pjgv2e7ifXMFKox62Q/edit?usp=sharing) 评论，或者向 [**plasma-devel** 邮件列表](https://mail.kde.org/mailman/listinfo/plasma-devel) 进行讨论！

### 许可协议？

还没定，但一定会是自由软件。
