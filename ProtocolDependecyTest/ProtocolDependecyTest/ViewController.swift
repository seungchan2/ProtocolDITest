//
//  ViewController.swift
//  ProtocolDependecyTest
//
//  Created by 김승찬 on 2022/07/18.
//

import UIKit

import Combine
import SnapKit
import Then

class ViewController: UIViewController {
    
    private lazy var button = UIButton().then {
        $0.backgroundColor = .blue
        $0.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
    }
    
    private var viewModelLogic: ViewModelLogic? = nil
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        bind()
    }
    
    @objc func buttonDidTapped() {
        viewModelLogic?.input.userTapAction()
    }
    
    private func style() {
        view.backgroundColor = .white
        
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    private func bind() {
        viewModelLogic?.output.backgroundPublisher.sink(receiveValue: { [weak self] color in
            guard let self = self else { return }
            self.view.backgroundColor = color
        }).store(in: &cancellable)
    }
}

extension ViewController {
    static func instance(viewModelLogic: ViewModelLogic = ViewModel()) -> ViewController {
        let viewController = ViewController()
        viewController.viewModelLogic = viewModelLogic
        return viewController
    }
}
