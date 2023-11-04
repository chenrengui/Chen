//
//  NetworkManager.swift
//  Chen
//
//  Created by iOS on 2023/10/16.
//

import UIKit
import Moya
import HandyJSON
import PKHUD

/// 超时时长,单位秒
private let ktimeOut_znsd: Double = 30.0

/// 请求成功的code
private let ksuccessCode_znsd = 200

//这个closure存放了一些moya进行网络请求前的一些数据,可以在闭包中设置公共headers
private let endpointClosure = { (target: RequestAPI) -> Endpoint in
     var endpoint: Endpoint = MoyaProvider.defaultEndpointMapping(for: target)
//     endpoint = endpoint.adding(newHTTPHeaderFields: ["platform": "iOS", "version" : "1.0"])
     return endpoint
 }

//这个闭包是moya提供给我们对网络请求开始前最后一次机会对请求进行修改，比如设置超时时间（默认是60s），禁用cookie等
private let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<RequestAPI>.RequestResultClosure) -> Void in
    do {
        var request = try endpoint.urlRequest()
        // 设置请求时长
        request.timeoutInterval = ktimeOut_znsd
        
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

struct NetworkManager<T: HandyJSON> {
    /// progress的回调
    typealias NetworkProgress = (CGFloat) -> Void
    
    /// 请求完成的回调
    typealias NetworkCompletion = (NetworkResult<T>) -> Void
    
    //@discardableResult关键字是为了消除不接收返回值的警告
    @discardableResult
    static func request(_ target: RequestAPI,_ type: T.Type, progress: NetworkProgress? = nil, completion: @escaping NetworkCompletion) -> Cancellable {
        
        //创建MoyaProvider对象
        let networkProvider = MoyaProvider<RequestAPI>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: [NetworkPlugin()])
        
        //调用请求方法
        let task = networkProvider.request(target, callbackQueue: DispatchQueue.main) { progressResponse in
            
            //进度,比如上传和下载的接口
            progress?(CGFloat(progressResponse.progress))
            
        } completion: { result in
            
            //result转为NetworkResult结构体
            let networkResult = result.mapNetworkResult(T.self)
            
            //错误信息处理
            handleError(target,networkResult)
            
            //回调
            completion(networkResult)
        }
        return task
    }
    
    /**
     用了async关键字,async/wait,要用到Task,但是目前Task的内存管理问题还没有好的解决办法
     */
    @available(iOS 13.0, *)
    static func request_async(_ target: RequestAPI,_ type: T.Type) async -> T? {
        var model: T?
        
        //创建MoyaProvider对象
        let networkProvider = MoyaProvider<RequestAPI>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: [NetworkPlugin()])
        
        //调用请求方法
        let _ = networkProvider.request(target, callbackQueue: DispatchQueue.main) { result in
            
            //result转为NetworkResult结构体
            let networkResult = result.mapNetworkResult(T.self)
            
            //错误信息处理
            handleError(target,networkResult)
            
            model = networkResult.data
        }
        return model
    }
}

extension NetworkManager {
    /**
     请求结果错误信息处理
     @Parameters:
     - target:具体某个请求
     - result:请求结果
     */
    private static func handleError (_ target: RequestAPI,_ result: NetworkResult<T>) -> Void {
        guard result.code != ksuccessCode_znsd else { return }
        print("errorCode=\(result.code)" + "\n" + "errorInfo=\(result.info!)")
        HUD.flash(.labeledError(title: result.info, subtitle: nil),delay: 2.0)
    }
}
