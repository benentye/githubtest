//
//  HistoryViewController.swift
//  githubTest
//
//  Created by 叶绿青 on 2021/2/25.
//  Copyright © 2021 叶绿青. All rights reserved.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController
{
    
    var closeBtn:UIButton!
    var tableView:UITableView!

    var resultData:[RequestList] = []
    let cellId = "historyListCellID" //CellId
    let cellHeight:CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        initViews()
        addData()
        
    }
    
    func initViews()
    {
        self.view.backgroundColor = .white
        closeBtn = UIButton.init()
        self.view.addSubview(closeBtn)
        closeBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        closeBtn.setImage(UIImage.init(named: "close"), for: .normal)
        
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.right.equalTo(-30)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        tableView = UITableView.init()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        let nib = UINib(nibName: "historyListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(closeBtn.snp.bottom).offset(10)
            make.right.equalTo(-20)
            make.left.equalTo(20)
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
        }
        
        
    }
    @objc  func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addData()
    {
        let tmpData =  CoreDataManager.shared.getAllRequestlist()
        updateRequestListData(tmpData)
    }
    
    func updateRequestListData(_ data: [RequestList])
    {
        resultData = data
        tableView.reloadData()
    }

}

extension HistoryViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! historyListCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        let tmpData = resultData[indexPath.row]
        cell.title.text = "编号:\(tmpData.rid!)"
        cell.result_time.text = "调用结果时间:\(tmpData.result_time!)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
}
