//
//  APICenter.swift
//  XYWKit
//
//  Created by 薛永伟 on 2018/6/4.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

/** APICenter
 ---- URL基础知识 ----
 scheme：通信协议，常用的有http、https、ftp、mailto等。
 host：主机域名或IP地址。
 port：端口号，可选。省略时使用协议的默认端口，如http默认端口为80。
 path：路径由零或多个"/"符号隔开的字符串组成，一般用来表示主机上的一个目录或文件地址。
 query：查询，可选。用于传递参数，可有多个参数，用"&"符号隔开，每个参数的名和值用"="符号隔开。
 ---- 运行环境 ----
 我们添加了对与运行环境的判断，一般的，我们认为有开发环境、灰度环境、生产环境。
 开发环境：测试用，一般运行于公司内网的服务器，内网的数据库。
 灰度环境：也叫金丝雀发布，进行A/B testing，。灰度环境是真实的生产环境数据，一部分用户使用某些功能，且会影响线上数据。
 生产环境：即正式对外界提供服务的环境。
 ---- 接口地址 ----
 默认的，我们将不同path的请求分开到不同的extension中，并以struct进行结构划分。
 然后在各struct中，写各接口的地址方法。层次清晰划分。
 即使用时：
 热点新闻地址：let urlStr = APICenter.News.hotNewsList()
 授权信息地址：let urlStr = APICenter.My.authInfo()
 ---- 接口扩展 ----
 每次新增接口，或新增接口分类（新path），只需新增扩展。
 例如新增收藏分类与相关增删改查接口。
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
 ---- 使用场景 ----
 此APICenter只是获取请求接口的url，而请求的的参数、header等信息设置，属于网络请求，不在此讨论范围内。
 
 Enjoy coding！
 **/

class APICenter: NSObject {
    /// 运行环境
    enum Environment:Int{
        case develop = 0    //开发环境
        case gray = 1       //灰度环境
        case release = 2    //生产环境
    }
    /// 当前运行环境
    static var currentEnvironment: Environment{
        let stateInt = PreferenceCenter.int.Environment.value
        //换成Evironment类型,默认release环境，保底显示线上数据
        let evironment = Environment.init(rawValue: stateInt) ?? .release
        return evironment
    }
    
    //可能有二级、三级域名的情况,需要特殊处理，详见Base_My_URL()
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
    
    /// 通用路径常用来作为参数，比如可以传当前app平台、版本等(https://114la.com//ios/5.3.0)
    fileprivate static func commonPath() -> String{
        let platform = "ios"
        let version = self.getAppVersion()
        // 返回样子："/ios/5.3.0"
        return "/\(platform)/\(version)"
    }
    
    
    /// 返回当前app的版本
    ///
    /// - Returns: 版本号
    fileprivate static func getAppVersion() -> String{
        guard let infoDictionary = Bundle.main.infoDictionary else { return "" }
        let majorVersion : AnyObject = infoDictionary["CFBundleShortVersionString"] as AnyObject
        guard let appversion = majorVersion as? String else { return "" }
        //如果小版本是以_分开，比如5.2.1_20180601
        let range=appversion.range(of: "_", options: NSString.CompareOptions())
        
        let strRange = (appversion.startIndex ..< ((range?.lowerBound) ?? appversion.endIndex))
        let version = String(appversion[strRange])
        return version
    }
}

//MARK: - Base_News_URL
extension APICenter{
    
    private static func Base_News_URL() -> String {
        return base_URL() + "/news/api" + commonPath()
    }
    
    struct News {
        //热点新闻列表
        static func hotNewsList() ->String{
            return APICenter.Base_News_URL() + "hotNewsList"
        }
        
        //使用方法：let urlStr = APICenter.News.hotNewsList()
        
    }
}

//MARK: - My_URL
extension APICenter {
    
    private static func My_URL() -> String {
        return "http://my.114la.com/news/api" + commonPath()
    }
    struct My {
        //认证信息
        static func authInfo() ->String{
            return APICenter.My_URL() + "authInfo"
        }
        
        //使用方法：let urlStr = APICenter.My.authInfo()
    }
}
