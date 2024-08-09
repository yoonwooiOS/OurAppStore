//
//  NetworkManeger.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/9/24.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownRespose
    case statusError
}

final class NetworkManeger {
    static let shared = NetworkManeger()
    private init() { }
    
    func callAPIRequest() -> Observable<Software> {
        let url = "https://itunes.apple.com/search?country=KR&term=kakaotalk&media=software"
        let result = Observable<Software>.create { observer in
            
            guard let url = URL(string: url) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    observer.onError(APIError.unknownRespose)
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                if let data = data , let appData = try? JSONDecoder().decode(Software.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted()
                } else {
                    print("error")
                    observer.onError(APIError.unknownRespose)
                }
            }
            .resume()
            return Disposables.create()
        }
        return result
    }
}
