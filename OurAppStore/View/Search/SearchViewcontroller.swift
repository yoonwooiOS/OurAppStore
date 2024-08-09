//
//  SearchViewcontroller.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewcontroller: BaseViewController {
    let tempData = Observable.just(["dfads", "dasdsad"])
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "게임, 앱, 스토리 등"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    private let appListTableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.rowHeight = 240
        return view
    }()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManeger.shared.callAPIRequest()
            .subscribe(with: self) { owner, value in
                dump(value)
            } onError: { owner, error in
                print("Response Error: \(error)")
            } onCompleted: { owner in
                print("complete")
            } onDisposed: { owner in
                print("onDiosposed")
            }
            .disposed(by: disposeBag)
    }
    override func setUpHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(appListTableView)
    }
    override func setUpLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        appListTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(4)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpNavigationTitle() {
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
     override func bind() {
        tempData
            .bind(to: appListTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in

                
            }
            .disposed(by: disposeBag)
    }
}

