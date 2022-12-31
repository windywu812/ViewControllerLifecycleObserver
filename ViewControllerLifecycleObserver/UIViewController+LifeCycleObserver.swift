//
//  UIViewController+LifeCycleObserver.swift
//  TDDDummy
//
//  Created by Windy on 31/12/22.
//

import Combine
import UIKit

private var pointer: UInt8 = 0

extension UIViewController {

    func observeViewWillAppear() -> AnyPublisher<Void, Never> {
        makeViewControllerLifeCycleObserver()
            .viewWillAppearSubject
            .eraseToAnyPublisher()
    }

    func observeViewDidAppear() -> AnyPublisher<Void, Never> {
        makeViewControllerLifeCycleObserver()
            .viewDidAppearSubject
            .eraseToAnyPublisher()
    }

    func observeViewWillDisappear() -> AnyPublisher<Void, Never> {
        makeViewControllerLifeCycleObserver()
            .viewWillDisappearSubject
            .eraseToAnyPublisher()
    }

    func observeViewDidDisappear() -> AnyPublisher<Void, Never> {
        makeViewControllerLifeCycleObserver()
            .viewDidDisappearSubject
            .eraseToAnyPublisher()
    }

    func observeViewWillLayoutSubviews() -> AnyPublisher<Void, Never> {
        makeViewControllerLifeCycleObserver()
            .viewWillLayoutSubviewsSubject
            .eraseToAnyPublisher()
    }

    func observeViewDidLayoutSubviews() -> AnyPublisher<Void, Never> {
        makeViewControllerLifeCycleObserver()
            .viewDidLayoutSubviewsSubject
            .eraseToAnyPublisher()
    }

    private var viewControllerLifeCycleObserver: ViewControllerLifeCycleObserver? {
        get {
            return objc_getAssociatedObject(self, &pointer) as? ViewControllerLifeCycleObserver
        }
        set(newValue) {
            objc_setAssociatedObject(self, &pointer, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    private func makeViewControllerLifeCycleObserver() -> ViewControllerLifeCycleObserver {
        if viewControllerLifeCycleObserver == nil {
            viewControllerLifeCycleObserver = ViewControllerLifeCycleObserver(parent: self)
        }
        return viewControllerLifeCycleObserver!
    }

}

final class ViewControllerLifeCycleObserver: UIViewController {

    let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    let viewWillDisappearSubject = PassthroughSubject<Void, Never>()
    let viewDidDisappearSubject = PassthroughSubject<Void, Never>()
    let viewWillLayoutSubviewsSubject = PassthroughSubject<Void, Never>()
    let viewDidLayoutSubviewsSubject = PassthroughSubject<Void, Never>()

    convenience init(parent: UIViewController) {
        self.init()
        parent.addChild(self)
        parent.view.addSubview(view)
        view.isHidden = true
        didMove(toParent: parent)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.send()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSubject.send()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearSubject.send()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewWillLayoutSubviewsSubject.send()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsSubject.send()
    }

}
