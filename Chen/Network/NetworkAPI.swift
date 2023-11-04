//
//  NetworkAPI.swift
//  Chen
//
//  Created by iOS on 2023/10/16.
//

import Foundation
import Moya

enum RequestAPI {
    /**
        所有请求接口都有默认参数toast,指的是是否需要loading,默认都是false,不需要
     */
    
    /**
     登录接口
     @Parameters:
     - phone:手机号
     - pwd   :密码
     */
    case login(_ parameters: [String: Any],_ toast: Bool = false)
    
    ///获取用户信息
    case fetchUserInfo(_ toast: Bool = false)
    
    case getLatestFireworeVersion(_ parameters: [String: Any])
    
    case bindDevice
}


extension RequestAPI: TargetType {
    var baseURL: URL { URL(string: "https://test.znsdkj.com:8443/sportWatch")! }
    
    var path: String { fetchPath() }
    
    var method: Moya.Method { fetchHttpMethods() }
    
    var task: Moya.Task {
        let parameters = fetchParameters()
    
        // 打印请求参数
        print("url====:" + "\(baseURL.absoluteString)" + "\(path)" + "\n" + "method=:\(method.rawValue)" + "\n" + "params=:\(parameters)")
        
        //参数编码方式
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        var headers: [String : String] = [:]
        headers["Content-type"] = "application/json;charset=utf-8"
        headers["token"] = "fz~d^fbG!goUhQCh4$n#"
        headers["access-token"] = "10LiWoqnBqHcDKnSY3jWLDJtGzO9dDKBpHwZKaxLKeHOVj1xKbpc5zCVzA7UsQah"
        print("header=:\(headers)")
        return headers
    }
}

//MARK: private func
extension RequestAPI {
    /**
     获取每个接口的url
     */
    private func fetchPath() -> String {
        //每个接口长短不一样,path长短不一样,一行不一定显示的下,为了统一美观,就另起一行,不接在case后面了
        switch self {
        case .login(_,_):
            return "/v2/user/login"
        case .fetchUserInfo(_):
            return "/v2/user/getUserInfo"
        case .getLatestFireworeVersion(_):
            return "/device/getLatestFirmware"
        case .bindDevice:
            return ""
        }
    }
    
    /**
     获取每个接口的请求方法
     */
    private func fetchHttpMethods() -> Moya.Method {
        /**
         ---------swift是默认每个case后面有break的,所以想要case穿透,就用关键字fallthrough
         ---------或者一个case,然后用逗号(,)隔开,比如case .a,.b,.c:
         ---------这里为了美观就用关键字fallthrough
         */
        var method: Moya.Method = .get
        switch self {
        case .bindDevice: fallthrough
            
        case .login(_,_):
            method = .post
            
        //虽然默认是.get,但是还是把每个get的接口列出来,方便一眼看出哪些接口是get请求
        case .fetchUserInfo(_): fallthrough
            
        case .getLatestFireworeVersion(_):
            method = .get
        }
        return method
    }
    
    /**
     获取每个接口的参数
     */
    private func fetchParameters() -> [String: Any] {
        switch self {
        case .login(let param,_): return param
        case .fetchUserInfo(_): return [:]
        case .getLatestFireworeVersion(let param):return param
        case .bindDevice: return [:]
        }
    }
}
