//
//  NetworkManager.swift
//  KakaoSearch
//
//  Created by 홍경표 on 2021/03/22.
//

import Foundation
import Moya

fileprivate protocol KakaoSearchable {
  var provider: MoyaProvider<KakaoApiType> { get }
  func search<T: Decodable>(sort: SortType, page: Int, size: Int, query: String, completion: ((_ response: T) -> Void)?)
}

final class KakaoSearcher: KakaoSearchable {
    
    static let shared = KakaoSearcher()
    private init() {}

    let provider = MoyaProvider<KakaoApiType>()
    
    func search<T: Decodable>(sort: SortType = .accuracy, page: Int = 1, size: Int = 80, query: String, completion: ((_ response: T) -> Void)?) {
        provider.request(.search(sort: sort, page: page, size: size, query: query)) { (result) in
            switch result {
            case .success(let response):
                guard let searchResponse = try? JSONDecoder().decode(T.self, from: response.data) else {
                    print("KakaoSearcher:", "Decode Error!")
                    return
                }
                completion?(searchResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
