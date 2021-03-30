//
//  Constants.swift
//  KakaoSearch
//
//  Created by 홍경표 on 2021/03/23.
//

import Foundation

enum Constants {
    
    static var kakaoAPIKey: String? {
        // APIKey.plist 파일에 'KAKAO_API_KEY'를 키로 하고, value는 발급 받은 REST API 키를 넣어주세요.
        if let path = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
           let nsDictionary = NSDictionary(contentsOfFile: path) {
            return nsDictionary[Keys.apiKey] as? String
        }
        return nil
    }
    
    private enum Keys {
        static let apiKey = "KAKAO_API_KEY"
    }
    
    static let segueMainToDetail = "showDetail"
    
}
