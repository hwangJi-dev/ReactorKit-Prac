//
//  ViewController.swift
//  ReactorKit-Prac
//
//  Created by hwangJi on 2022/07/06.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, StoryboardView {
    
    var disposeBag: DisposeBag = DisposeBag()

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var increaseBtn: UIButton!
    
    func bind(reactor: CounterViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: CounterViewReactor) {
        increaseBtn.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func bindState(_ reactor: CounterViewReactor) {
        reactor.state
            .map { String($0.value) }
            .distinctUntilChanged()
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

