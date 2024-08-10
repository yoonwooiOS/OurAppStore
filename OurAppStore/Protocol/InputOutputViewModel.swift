//
//  InputOutputViewModel.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/10/24.
//

import Foundation

protocol InputOutputViewModel {
    associatedtype Input
    associatedtype Output
    func transfrom(input: Input) -> Output
}
