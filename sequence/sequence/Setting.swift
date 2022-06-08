//
//  Setting.swift
//  sequence
//
//  Created by 윤소희 on 2022/05/17.


import UIKit
import Foundation

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
}


struct Config {
    static var appURL: String {
        (Bundle.main.infoDictionary?["API_URL"] as? String) ?? ""
    }
    static var kakaoKey: String {
        (Bundle.main.infoDictionary?["KAKAO_SDK_KEY"] as? String) ?? ""
    }
    static var webviewURL: String{
        (Bundle.main.infoDictionary?["WEBVIEW_URL"] as? String) ?? ""
    }
}
