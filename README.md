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
偏好设置中心。通过集中管理userdefaults，有效避免混乱。
使用示例：
```
if PreferenceCenter.string.lastUserToken.isEmpty(){
  debugPrint("没有上一个用户信息！")
}
if PreferenceCenter.bool.understandPreferenceCenter.isTrue{
  debugPrint("PreferenceCenter？了然！")
}
```
