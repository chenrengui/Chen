//
//  NetworkResult.swift
//  Chen
//
//  Created by iOS on 2023/10/16.
//

import Foundation
import Moya
import HandyJSON

struct NetworkResult<T: HandyJSON> {
    
    var data: T?
    var info: String?
    var code: Int
    
    init(json: [String: Any]) {
        /**
         json的字段("code","msg","data")根据服务器具体返回的字段为准,替换成对应的字段就行,这里只是举个例子
         */
        code = json["code"] as? Int ?? -1
        info = json["msg"] as? String
        
        //转换成对应的模型
        data = T.deserialize(from: json["data"] as? [String : Any])
    }
    
    init(errorMsg: String?) {
        code = -1
        info = errorMsg
    }
}

//MARK: 给Result增加一个扩展方法
extension Result where Success: Response, Failure == MoyaError {
    func mapNetworkResult<T>(_ type: T.Type) -> NetworkResult<T> where T: HandyJSON {
        switch self {
        case .success(let response):
            do {
                guard let json = try response.mapJSON() as? [String: Any] else {
                    // 不是JSON数据
                    return NetworkResult(errorMsg: "服务器返回的不是JSON数据")
                }
                //直接打印json字符串就行,打印JSON太占地方了
                print("result=:\(String(describing: try? response.mapString()))")
                return NetworkResult(json: json)
            } catch {
                // 解析出错
                return NetworkResult(errorMsg: error.localizedDescription)
            }
        case .failure(let error):
            // 请求出错
            return NetworkResult(errorMsg: error.errorDescription)
        }
    }
}

