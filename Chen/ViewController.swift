//
//  ViewController.swift
//  Chen
//
//  Created by iOS on 2023/10/13.
//

import UIKit
import SnapKit

@objc enum WeekDay: Int {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let s = Weaks(0)
        switch s {
        case WeaksSun:
            print("")
        default:
            print("")
        }
//        Task {
//            let model = await NetworkManager.request_async(.fetchUserInfo(), LoginModel.self)
//            print("model=\(model ?? LoginModel())")
//        }
        
//        NetworkManager.request(.fetchUserInfo(true),LoginModel.self) { result in
//
//        }
//        
//        let loginPatam = ["phoneNumber": "13528796047","password": "123456","areaCode": "0086","phoneSystem": "2","type": "1", "phoneId": ""]
//        NetworkManager.request(.login(loginPatam), LoginModel.self) { result in
//
//        }
        
//        let _ = NetworkManager.request(.getLatestFireworeVersion(["configId":"35","currentVersion":"1.0.4"]),VersionModel.self) {result in
////            guard let m = result.data else {return}
//        }
        
        let l = UILabel()
        l.snp.makeConstraints { make in
            
        }
        
        if #available(iOS 16.0, *) {
            print("---\([1,3,2,5].contains([1,2]))")
        } else {
            // Fallback on earlier versions
        }

        var array = [1,2,3,5,1,1,1,1]
        array.removeElements(1)
        print("===\(array)")
        
        var string = "12345"
        print("---\(string[1..<5])")
        
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
    }
}

