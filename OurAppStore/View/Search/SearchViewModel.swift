//
//  SearchViewModel.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/10/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: InputOutputViewModel {
   let disposeBag = DisposeBag()
    struct Input {
        let searchText: ControlProperty<String>
        let searchButtonClicked: ControlEvent<Void>
    }
    struct Output {
        var appList: PublishSubject<[Result]>
    }
    
    func transfrom(input: Input) -> Output {
        let appList = PublishSubject<[Result]>()
        let result = input.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .flatMap { value in
                NetworkManeger.shared.fetchSoftware(appNmae: value)
                    .catch { error in
                        return Single<Software>.never()
                    }
            }
            .subscribe(with: self) { owner, value in
                           appList.onNext(value.results)
                           print(value)
                       } onError: { owner, error in
                            print("Error: \(error)")
                       } onCompleted: { owner in
                           print("onCompleted")
                       } onDisposed: { owner in
                           print()
                       }
                       .disposed(by: disposeBag)
            
//        input.searchButtonClicked
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .withLatestFrom(input.searchText)
//            .debug("1")
//            .distinctUntilChanged()
//            .debug("2")
//            .map { "\($0)"}
//            .flatMap { value in
//                NetworkManeger.shared.callAPIRequest(appName: value)
//            }
//            .debug("3")
//            .subscribe(with: self) { owner, value in
//                appList.onNext(value.results)
//                print(value)
//            } onError: { owner, error in
//                 print("Error: \(error)")
//            } onCompleted: { owner in
//                print("onCompleted")
//            } onDisposed: { owner in
//                print()
//            }
//            .disposed(by: disposeBag)
        return Output(appList: appList)
    }
}
