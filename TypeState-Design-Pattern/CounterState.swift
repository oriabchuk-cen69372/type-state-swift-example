//
//  CounterState.swift
//  TypeState-Design-Pattern
//
//  Created by Oleksandr Riabchuk on 10.09.2024.
//

import Foundation

enum Locked {}
enum Unlocked {}

/// A class to handle counter logic for increment and decrement operations.
struct Turnstile<State>: ~Copyable {
    private(set) var coins: Int

    private init(coins: Int) {
        self.coins = coins
    }
}

class CurrentState: ObservableObject {
    var state: TurnstileState
    
    init(state: consuming TurnstileState) {
        self.state = state
    }
}

enum TurnstileState: ~Copyable {
    case locked(Turnstile<Locked>)
    case unlocked(Turnstile<Unlocked>)
    
    init() {
      self = .locked(Turnstile<Locked>())
    }

    mutating func insertCoin() {
        switch consume self {
        case .locked(let locked):
            let unlocked = locked.insertCoin()
            self = .unlocked(unlocked)
        case .unlocked(let unlocked):
            self = .unlocked(unlocked)
        }
    }

    mutating func push() {
        switch consume self {
        case .locked(let locked):
            self = .locked(locked)

        case .unlocked(let unlocked):
            let locked = unlocked.push()
            self = .locked(locked)
        }
    }

    mutating func coins() -> Int {
        let coins: Int
        switch consume self {
        case .locked(let locked):
            coins = locked.coins
            print("conns locked", locked.coins)
            self = .locked(locked)

        case .unlocked(let unlocked):
            coins = unlocked.coins
            print("conns locked", unlocked.coins)
            self = .unlocked(unlocked)
        }
        return coins
    }
}

extension Turnstile where State == Locked {
    init() {
        self.init(coins: 0)
    }

    consuming func insertCoin() -> Turnstile<Unlocked> {
        // guard state == .locked else { return }
        return Turnstile<Unlocked>(coins: coins + 1)
    }
}

extension Turnstile where State == Unlocked {
    consuming func push() -> Turnstile<Locked> {
        return Turnstile<Locked>(coins: coins)
    }
}
