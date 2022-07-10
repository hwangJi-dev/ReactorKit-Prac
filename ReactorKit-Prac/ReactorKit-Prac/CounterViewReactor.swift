//
//  CounterViewReactor.swift
//  ReactorKit-Prac
//
//  Created by hwangJi on 2022/07/06.
//

import Foundation
import ReactorKit

class CounterViewReactor: Reactor {
    
    let initialState: State = State()
    
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    /// Reactor의 초기 상태 정의
    struct State {
        var value = 0
        var isLoading = false
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .increase:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.decreaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
}
