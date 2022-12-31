# Overview
Simple extension for observing view controller lifecyle in combine way.

You can easily observe any lifecyle with this code:
```swift
observeViewWillAppear()
    .sink { _ in
        print("ViewWillAppear")
    }.store(in: &subscriptions)
```
