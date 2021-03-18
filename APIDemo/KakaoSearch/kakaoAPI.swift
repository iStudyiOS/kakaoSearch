//
//  kakaoAPI.swift
//  KakaoSearch
//
//  Created by KEEN on 2021/03/17.
//

import Foundation
import Moya

struct dataType: Decodable {
  var image_url: String
}

struct responseType: Decodable {
  var documents: [dataType]
}

enum KakaoApiType {
  case search
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
    case .search:
      return .requestParameters(
        parameters: ["query": "apple"],
        encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Authorization": "KakaoAK REST_API_KEY"]
  }
}

protocol CallKakaoAPIType {
  func search()
}

class CallKakaoAPI: CallKakaoAPIType {

  let provider = MoyaProvider<KakaoApiType>()
  
  func search() {
    provider.request(.search) { (result) in
      switch result {
      case .success(let response):
        guard let kakaoResponse = try? JSONDecoder().decode(responseType.self, from: response.data) else { return }
        print(kakaoResponse.documents)
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
