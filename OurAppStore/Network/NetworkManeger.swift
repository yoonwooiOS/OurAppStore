//
//  NetworkManeger.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

enum APIError: Error {
    case invalidURL
    case unknownRespose
    case statusError
}

final class NetworkManeger {
    static let shared = NetworkManeger()
    private init() { }
    
    func callAPIRequest(appName: String) -> Observable<Software> {
        let url = "https://itunes.apple.com/search?country=KR&term=\(appName)&media=software"
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
    
    func fetchSoftware(appNmae: String) -> Single<Software> {
        return Single.create { single -> Disposable in
            let url = "https://itunes.apple.com/search?country=KR&term=\(appNmae)&media=software"
            AF.request(url).validate(statusCode: 200..<299).responseDecodable(of: Software.self) { response in
                switch response.result {
                case .success(let success):
                    single(.success(success))
                case .failure(let failure):
                    single(.failure(failure))
                }
            }
            return Disposables.create()
        }
        .debug("싱글 에이피아이 통신")
    }
    
    func fetchSoftwareResultType(appName: String) ->  Single<Result<Software, APIError>> {
        return Single.create { observer -> Disposable in
            let url = "https://itunes.apple.com/search?country=KR&term=\(appName)&media=software"
            AF.request(url).validate(statusCode: 200..<299).responseDecodable(of: Software.self) { response in
                switch response.result {
                case.success(let value):
                    observer(.success(.success(value)))
                case.failure(let error):
                    observer(.success(.failure(.invalidEmail)))
                }
            }
            return Disposables.create()
        }
        .debug("Joke API 통신")
    }
}
