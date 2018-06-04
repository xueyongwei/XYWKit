# XYWKit
薛永伟自用工具包，日常工作中抽象出来供其他项目使用。可能包括较多类，通过搜索关键字进行搜索，或根据目录索引。
[Tools](#tools)

    [FormatValidate](#formatvalidate) 格式验证工具。
    
    [PreferenceCenter](#PreferenceCenter) 偏好设置中心。
    
## Tools
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

 
