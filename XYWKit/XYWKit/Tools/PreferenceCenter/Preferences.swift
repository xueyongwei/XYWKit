//
//  Preferences.swift
//  Browser
//
//  Created by 薛永伟 on 2018/5/9.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

/*
 这个稍显复杂的类，仅仅是为了更规范，并无高阶用法。

 默认情况下，直接需要在各种类型的扩展中，添加想要的UserDefaults的key即可。
 使用示例：PreferenceCenter.bool.understandPreferenceCenter.isTrue
 
 如需特殊方法，参阅辅助方法，添加自己的方法即可。不同类型，不同方法，更清晰。
 */

import UIKit


/// 偏好设置中心：统一管理偏好设置，清晰的类别与层次，有效防止UserDefaults使用混乱.\n 不用主动调用synchronize同步，请自行调用PreferenceCenter.synchronize()
struct PreferenceCenter:CustomStringConvertible {
    var description: String{
        return "偏好设置中心：统一管理偏好设置，清晰的类别与层次，有效防止UserDefaults使用混乱.\n 不用主动调用synchronize同步，请自行调用PreferenceCenter.synchronize()"
    }
    
    /// 同步UserDefaults信息到磁盘
    func synchronize(){
        UserDefaults.standard.synchronize()
    }
    
    /// 使用小例
    func usageSimple(){
        if PreferenceCenter.bool.understandPreferenceCenter.isTrue == false {
            debugPrint("开始阅读..阅读完毕，更新设置")
            PreferenceCenter.bool.understandPreferenceCenter.setValue(true)
        }
        if PreferenceCenter.string.lastUserToken.isEmpty(){
            debugPrint("没有上一个用户的token")
        }
    }
}


//MARK: - 布尔
extension PreferenceCenter {
    /// 布尔配置
    enum bool:String {
        /// 是否已经了解了PreferenceCenter使用方法
        case understandPreferenceCenter = "understandPreferenceCenter"
        
        //*** 在此添加更多的key即可直接使用。
    }
}


//MARK: - 字符串
extension PreferenceCenter {
    /// 字符串配置
    enum string:String {
        case lastUserToken = "P_lastUserToken"
        //*** 在此添加更多的key即可直接使用。
        
    }
}


//MARK: - 字典
extension PreferenceCenter {
    enum dictionary:String {
        case userSettingInfo = "P_userSettingInfo"
        //*** 在此添加更多的key即可直接使用。
    }
}

//MARK: - 数组
extension PreferenceCenter{
    enum array:String{
        case supportList = "P_supportList"
        //*** 在此添加更多的key即可直接使用。
    }
}

//MARK: - 数组
extension PreferenceCenter{
    enum int:String{
        case testInt = "testInt"
        //*** 在此添加更多的key即可直接使用。
    }
}

//MARK: - 数组
extension PreferenceCenter{
    enum float:String{
        case testFloat = "testFloat"
        //*** 在此添加更多的key即可直接使用。
    }
}


//MARK: - ===================





















/*
以下是添加了基本的set get方法，可自行添加针对某中类型的preference添加特殊的方法。
 比如给string添加个 is115Host()->Bool 方法
 */

//MARK: - 扩展辅助方法
extension PreferenceCenter.bool{
    /// 是否是真的
    var isTrue:Bool{
        return UserDefaults.standard.bool(forKey: self.rawValue)
    }
    
    func setValue(_ value:Bool){
        UserDefaults.standard.set(value, forKey: self.rawValue)
    }
}

extension PreferenceCenter.string{
    var value:String?{
        return UserDefaults.standard.string(forKey: self.rawValue)
    }
    func setValue(_ string:String){
        UserDefaults.standard.set(string, forKey: self.rawValue)
    }
    
    /// 是否是空的
    ///
    /// - Returns: true：nil或空串
    func isEmpty() ->Bool{
        if let value = self.value,value.count > 0 {
            return true
        }else{
            return false
        }
    }
    
}
extension PreferenceCenter.dictionary{
    
    var value:Dictionary<String, Any>?{
        return UserDefaults.standard.dictionary(forKey: self.rawValue)
    }
    func setValue(_ dictionary:Dictionary<String,Any>?){
        UserDefaults.standard.set(dictionary, forKey: self.rawValue)
    }
}

extension PreferenceCenter.array{
    
    var value:Array<Any>?{
        return UserDefaults.standard.array(forKey: self.rawValue)
    }
    func setValue(_ array:Array<Any>?){
        UserDefaults.standard.set(array, forKey: self.rawValue)
    }
}

extension PreferenceCenter.int{
    
    var value:Int{
        return UserDefaults.standard.integer(forKey: self.rawValue)
    }
    
    func setValue(_ int:Int){
        UserDefaults.standard.set(array, forKey: self.rawValue)
    }
}

extension PreferenceCenter.float{
    
    var value:Float{
        return UserDefaults.standard.float(forKey: self.rawValue)
    }
    func setValue(_ int:Int){
        UserDefaults.standard.set(array, forKey: self.rawValue)
    }
}
