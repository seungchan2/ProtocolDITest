//
//  ViewModel.swift
//  ProtocolDependecyTest
//
//  Created by 김승찬 on 2022/07/18.
//

import Foundation
import UIKit
import Combine

protocol ViewModelInputLogic {
    func userTapAction()
}

protocol ViewModelOutputLogic {
    var backgroundPublisher: AnyPublisher<UIColor, Never> { get }
}

protocol ViewModelLogic: AnyObject {
    var input: ViewModelInputLogic { get }
    var output: ViewModelOutputLogic { get }
}

class ViewModel: ViewModelLogic, ViewModelOutputLogic, ViewModelInputLogic {
  
    var input: ViewModelInputLogic { self }
    var output: ViewModelOutputLogic { self }

    private let backgroundSubject = PassthroughSubject<UIColor, Never>()
    var backgroundPublisher: AnyPublisher<UIColor, Never> {
        return backgroundSubject.eraseToAnyPublisher()
    }

    func userTapAction() {
        backgroundSubject.send(.red)
    }
}
