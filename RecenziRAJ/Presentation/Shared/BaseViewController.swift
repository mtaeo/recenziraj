//
//  BaseViewController.swift
//  RecenziRAJ
//
//  Created by Mateo on 31.08.2022..
//

import UIKit
import Lottie

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    var viewModel: T
    
    private lazy var spinnerView: LottieAnimationView = {
        let spinnerView = LottieAnimationView.init(name: "lottie_spinner")
        spinnerView.frame = view.bounds
        spinnerView.contentMode = .scaleAspectFit
        spinnerView.loopMode = .loop
        spinnerView.isHidden = true
        return spinnerView
    }()
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopSpinner()
    }
}

private extension BaseViewController {
    func addSubviews() {
        view.addSubview(spinnerView)
    }
    
    func makeConstraints() {
        spinnerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(125)
        }
    }
}

extension BaseViewController {
    func startSpinner() {
        view.bringSubviewToFront(spinnerView)
        spinnerView.isHidden = false
        spinnerView.play()
    }
    
    func stopSpinner() {
        spinnerView.stop()
        spinnerView.isHidden = true
    }
}
