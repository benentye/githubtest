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
import SnapKit

class ViewController: UIViewController,CommonBaseViewModelDelegate {
    
    var viewModel: CommonBaseViewModel!
    let disposeBag = DisposeBag()
    let delayCount = 5.0
    var scrollerView:UIScrollView!
    var resultTime:UILabel!
    var resultTitleTxt:UILabel!
    var resultTxt:UILabel!
    var historyBtn:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = CommonBaseViewModel()
        viewModel.delegate = self
        
        initViews()
        addData()
        print("first apiGithub count:\(Date())")

        self.perform(#selector(apiGithub), with: nil, afterDelay: delayCount)

    }
    @objc func apiGithub() {
        print("first apiGithub 5 seconds:\(Date())")
        viewModel.apiGitHub(true)
    }

    func updateResult(_ firstOrNot:Bool,_ data: NSDictionary) {
        
        resultTime.text = "调用结果时间:\(Date())"
        resultTitleTxt.text = "调用结果"
        resultTxt.text = "\(data)"
        
        saveData(data)
        
        ///首次
        if firstOrNot
        {
            viewModel.startCountdown() ///之后每5秒调用一次
            return
        }

    }
    
    func initViews()
    {
        scrollerView = UIScrollView.init()
        resultTime = UILabel.init()
        resultTitleTxt = UILabel.init()
        resultTxt = UILabel.init()
        resultTxt.numberOfLines = 0
        self.view.addSubview(scrollerView)
        
        scrollerView.addSubview(resultTime)
        scrollerView.addSubview(resultTitleTxt)
        scrollerView.addSubview(resultTxt)
        
        
        historyBtn = UIButton.init()
        historyBtn.backgroundColor = .blue
        historyBtn.setTitleColor(.white, for: .normal)
        historyBtn.setTitle("调用历史", for: .normal)
        self.view.addSubview(historyBtn)
        historyBtn.addTarget(self, action: #selector(historyVc), for: .touchUpInside)

        scrollerView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-100)
        }
        
        historyBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        resultTime.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(30)
        }
        resultTitleTxt.snp.makeConstraints { (make) in
            make.top.equalTo(resultTime.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.height.equalTo(30)

        }
        resultTxt.snp.makeConstraints { (make) in
            make.top.equalTo(resultTitleTxt.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.bottom.equalTo(scrollerView.snp.bottom)

        }
    }
    @objc  func historyVc(_ sender: UIButton) {
        let vc = HistoryViewController.init()
        self.present(vc, animated: true, completion: nil)
    }
    
    func saveData(_ result:NSDictionary)
    {
        CoreDataManager.shared.saveRequestlistWith(result)

    }
    
    func addData()
    {
        let tmpData =  CoreDataManager.shared.getTopNewResult()
        updateRequestListData(tmpData)
    }
    
    func updateRequestListData(_ data: RequestList)
    {
        resultTime.text = "调用结果时间:\(data.result_time!)"
        resultTitleTxt.text = "调用结果"
        resultTxt.text = "\(data.result_txt!)"
    }
}

