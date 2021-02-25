//
//  ViewController.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/23.
//  Copyright © 2021 叶绿青. All rights reserved.
//

import UIKit
import RxSwift
import CLToast

class ViewController: UIViewController,CommonBaseViewModelDelegate {
    
    var viewModel: CommonBaseViewModel!
    let disposeBag = DisposeBag()
    let delayCount = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = CommonBaseViewModel()
        viewModel.delegate = self
        print("first apiGithub count:\(Date())")

        self.perform(#selector(apiGithub), with: nil, afterDelay: delayCount)

    }
    @objc func apiGithub() {
        print("first apiGithub 5 seconds:\(Date())")
        viewModel.apiGitHub(true)
    }

    func updateResult(_ data: NSDictionary) {
        viewModel.startCountdown() ///之后每5秒调用一次
    }

}

