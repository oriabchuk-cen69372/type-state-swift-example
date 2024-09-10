# Turnstile State Machine

This repository demonstrates a typestate pattern in Swift using Swift 5.9 features, such as noncopyable types and exhaustive state management. The project simulates a turnstile mechanism with two states: `Locked` and `Unlocked`. The design enforces strict transitions between states, improving compile-time safety and reducing runtime errors.

## Features

- Noncopyable types (`~Copyable`) for memory efficiency.
- Compile-time enforcement of valid state transitions.
- Methods to insert coins and push the turnstile.

## Code Overview

### `Turnstile<State>`

A generic structure representing a turnstile in a given state (`Locked` or `Unlocked`), holding the number of coins.

### `TurnstileState`

Enum representing two states:
- `.locked(Turnstile<Locked>)`
- `.unlocked(Turnstile<Unlocked>)`

### State Transitions

- `insertCoin()`: Switches from `.locked` to `.unlocked`.
- `push()`: Switches from `.unlocked` to `.locked`.

### Example Usage

```swift
var state = TurnstileState()
state.insertCoin()
state.push()
```

## Requirements

- Swift 5.9 or later.
