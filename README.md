# XYWKit
薛永伟自用工具包，日常工作中抽象出来供其他项目使用。

#### FormatValidate
格式验证工具。通过正则表达式对字符串进行验证，是否是正确的格式。
使用示例：
```
if FormatValidate.email("xueyongwei@foxmail.com").isRight == false{
    debugPrint("邮箱格式错误！")
}
```
#### PreferenceCenter
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
