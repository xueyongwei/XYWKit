# XYWKit
薛永伟自用工具包，日常工作中抽象出来供其他项目使用。相比YYKit通用性，主要是添加了些特殊但又常见的情况会用到的东西。文档只简略说明，具体请参考代码，代码里有相对详细的注释等。
可能包括较多类，根据目录索引快速了解。
* [XYWTools](#xywtools)
  * [FormatValidate](#formatvalidate) - 格式验证工具，如手机，邮箱，车牌，URL等。
  * [PreferenceCenter](#preferencecenter) - 偏好设置中心，严谨的分类不容易出错。
  * [APICenter](#apicenter) - 随心、易读、易扩展又可靠的API集中管理器。
* [XYWUI](#xywui)
  * [EZAlertViewController](#ezalertviewcontroller) - 通过block的方式使用UiAlertContoller。
  * [SinglePxLine](#singlepxline) - 单像素的分割线，亦有效避免cell上分割线消失的问题。
  
** Talk is cheap.Show me your code. **
## XYWTools
### FormatValidate
格式验证工具。通过正则表达式对字符串进行验证，是否是正确的格式。
使用示例：
```
if FormatValidate.email("xueyongwei@foxmail.com").isRight == false{
    debugPrint("邮箱格式错误！")
}
```
### PreferenceCenter
偏好设置中心。通过集中管理Userdefaults，有效避免到处直接使用UserDefaults造成的混乱。
使用示例：
```
//判断一个布尔值
if PreferenceCenter.bool.understandPreferenceCenter.isTrue{
  debugPrint("PreferenceCenter？了然！")
}
//判断一个字符串
if PreferenceCenter.string.lastUserToken.isEmpty(){
  debugPrint("没有上一个用户信息！")
}
//获取用户信息
if let userInfo = PreferenceCenter.dictionary.userSettingInfo.value {
    debugPrint("用户信息：\(userInfo)")
}
```
### APICenter
APICenter是集中处理接口地址的类。本类使用了extension和struct来进行严谨划分，避免api的接口散乱、错误等问题的出现。
通过配合PreferenceCenter，加入了运行环境的判断区别对待，让对API请求随心随性，又安全可靠。
```
fileprivate static func base_URL() -> String {
        switch self.currentEnvironment {
        case .develop:
            return "http://114larc.com"
        case .gray:
            return "https://114la.com"
        case .release:
            return "https://114la.com"
        }
  }
```
默认的，我们将不同path的请求分开到不同的extension中，并以struct进行结构划分。
每次新增接口，或新增接口分类（新path），只需新增扩展，写个struct，然后添加方法即可。
例如新增收藏分类与相关增删改查接口:
```
 //MARK: - Base_Fav_URL
 extension APICenter{
    private static func Base_Fav_URL() -> String {
        return base_URL() + "/Fav/api" + commonPath()
    }
    struct Fav {
        //我的收藏
        static func favList() ->String{
            return APICenter.Base_News_URL() + "favList"
        }
        static func delFav() ->String{
            return APICenter.Base_News_URL() + "delFav"
        }
    }
 }
 ```
即使用API时,我们像阅读一样取出想要的url地址：
热点新闻地址：
```let urlStr = APICenter.News.hotNewsList()```
授权信息地址：
```let urlStr = APICenter.My.authInfo()```

## XYWUI
### EZAlertViewController
Easy to use UiAlertContoller，通过block的方式使用，更简单。
使用示例：
```
EZAlertController.alert("标题", message: "详细信息", buttons: ["取消","确定"]) { (action, index) in
    if index == 1{
        debugPrint("点击了确定")
    }
}
```
### SinglePxLine

SinglePxHLine：单像素横线

SinglePxVLine：单像素竖线

这两个类保证分割是单像素的分割线，支持代码和IB创建，任意布局方式。

释疑：继承自UIImageView，且不是通过backgroundColor设置背景色，是因为一般都是在cell中使用分割线，但是cell在选中状态会清空子view的背景色，导致分割线“消失”。故使用了一个带颜色的图片来替代背景色，防止cell选中状态分割线消失的情况发生。

使用方法：

1. 通过xib或storyboard直接拖拽，使用autoLayout布局。
2. 通过代码创建，使用frame或autoLayout布局。

结果：相应的高或宽被无视，固定地显示为1.0/(UIScreen.main.scale)

 
