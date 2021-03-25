//
//  kakaoAPI.swift
//  KakaoSearch
//
//  Created by KEEN on 2021/03/17.
//

import Foundation
import Moya

enum KakaoApiType {
  case search(sort: SortType = .accuracy, page: Int = 1, size: Int = 80, query: String)
}

enum SortType {
  case accuracy
  case recency
}

extension KakaoApiType: TargetType {
  var baseURL: URL {
    return URL(string: "https://dapi.kakao.com")!
  }
  
  var path: String {
    switch self {
    case .search:
      return "/v2/search/image"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .search(let sort, let page, let size, let query):
      return .requestParameters(
        parameters: [
            "sort": "\(sort)",
            "page": "\(page)",
            "size": "\(size)",
            "query": query
        ],
        encoding: URLEncoding.default
      )
    }
  }
  
  var headers: [String : String]? {
    guard let apiKey = Constants.kakaoAPIKey else { return nil }
    return ["Authorization": "KakaoAK \(apiKey)"]
  }
}
