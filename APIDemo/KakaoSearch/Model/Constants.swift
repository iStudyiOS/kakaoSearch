//
//  Constants.swift
//  KakaoSearch
//
//  Created by 홍경표 on 2021/03/23.
//

import Foundation

enum Constants {
    
    static var kakaoAPIKey: String? {
        Bundle.main.infoDictionary?[Keys.apiKey] as? String
    }
    
    private enum Keys {
        static let apiKey = "KAKAO_API_KEY"
    }
    
}
