//
//  ViewController.swift
//  ViewControllerLifecycleObserver
//
//  Created by Windy on 31/12/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewWillAppear()
            .sink { _ in
                print("ViewWillAppear")
            }.store(in: &subscriptions)
    }


}

