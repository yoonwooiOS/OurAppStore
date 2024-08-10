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
    let searchController = UISearchController(searchResultsController: nil)
    private let appListTableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.rowHeight = 92
        return view
    }()
    private let saerchViewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    override func setUpHierarchy() {
        view.addSubview(appListTableView)
    }
    override func setUpLayout() {
        appListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func setUpNavigationTitle() {
        self.navigationItem.searchController = searchController
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setupSearchBar() {
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
    }
    override func bind() {
         searchController.searchBar.rx.searchButtonClicked
             .throttle(.seconds(1), scheduler: MainScheduler.instance)
             .withLatestFrom(searchController.searchBar.rx.text.orEmpty)
             .debug("1")
             .distinctUntilChanged()
             .debug("2")
             .map { return "\($0)"}
             .flatMap { value in
                 NetworkManeger.shared.callAPIRequest(appName: value)
             }
             .debug("3")
             .subscribe(with: self) { owner, value in
                 print(type(of: value))
                 dump(value)
             } onError: { owner, error in
                 print("error")
             } onCompleted: { owner in
                 print("oncompleted")
             } onDisposed: { owner in
                 print("ondisposed")
             }
             .disposed(by: disposeBag)
         let input = SearchViewModel.Input(searchText: searchController.searchBar.rx.text.orEmpty, searchButtonClicked: searchController.searchBar.rx.searchButtonClicked)
         let output = saerchViewModel.transfrom(input: input)
         
         output.appList
            .bind(to: appListTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.setUpCell(data: element)
            }
            .disposed(by: disposeBag)
        Observable.zip(appListTableView.rx.modelSelected(Result.self), appListTableView.rx.itemSelected)
            .debug()
            .subscribe(with: self) { owner, value in
                print(value.0)
                let vc = SearchDetailView()
                vc.value = value.0
                owner.navigationController?.pushViewController(vc, animated: true)
            } onError: { owner, error in
                print("Error: \(error)")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
}

