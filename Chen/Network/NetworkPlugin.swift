//
//  NetworkPlugin.swift
//  Chen
//
//  Created by iOS on 2023/10/16.
//

import UIKit
import Moya
import PKHUD
import CryptoSwift

/*
 Moya默认有4个插件分别为：
 AccessTokenPlugin 管理AccessToken的插件
 CredentialsPlugin 管理认证的插件
 NetworkActivityPlugin 管理网络状态的插件
 NetworkLoggerPlugin 管理网络log的插件
 */
// 插件,实现pluginType可以实现在网络请求前转菊花，请求完成结束转菊花，或者写日志等功能
struct NetworkPlugin: PluginType {
    
    /// Called to modify a request before sending.
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }
    
    /// Called immediately before a request is sent over the network (or stubbed).（可进行网络等待，loading等）
    func willSend(_ request: RequestType, target: TargetType) {
        guard let t = target as? RequestAPI else { return }
        switch t {
        case .fetchUserInfo(let toast):
            if toast {
                DispatchQueue.main.async {
                }
                print("需要菊花")
            }else {
                print("不需要菊花")
            }
        default:
            break
        }
    }

    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.（loading结束等）
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        HUD.hide()
    }

    /// Called to modify a result before completion.
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return result
    }

}
