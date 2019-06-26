//
//  BelongingsListViewController.swift
//  NotificationApp
//
//  Created by 大川葵 on 2019/06/25.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit
import UserNotifications
import RxCocoa
import RxSwift

// MARK: BelongingsListViewController
final class BelongingsListViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewModel = BelongingsListViewModel(self)
        self.tableView.dataSource = self
        
        viewModel?.refreshToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
        .disposed(by: disposeBag)
        
        viewModel?.segueToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.performSegue(withIdentifier: R.segue.belongingsListViewController.showNewDataView, sender: nil)
            })
        .disposed(by: disposeBag)
        
        addButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel?.tapAddButton()
            })
        .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        viewModel?.getData()
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var viewModel: BelongingsListViewModel?
    
}

// MARK: UITableViewDataSource
extension BelongingsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.alertData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.belongingCell, for: indexPath)
        
        let data = viewModel?.alertData[indexPath.row]
        cell?.textLabel?.text = data?.belonging
        cell?.detailTextLabel?.text = "\(String(describing: (data?.hour)!)):\(String(describing: (data?.minute)!))"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            viewModel?.deleteAction(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
