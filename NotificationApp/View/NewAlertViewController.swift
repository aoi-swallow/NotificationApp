//
//  NewAlertViewController.swift
//  NotificationApp
//
//  Created by 大川葵 on 2019/06/25.
//  Copyright © 2019 Aoi Okawa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

// MARK: NewAlertViewController
final class NewAlertViewController: UIViewController {
    
    
    // MARK: UIViewController
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewModel = NewAlertViewModel(self)
        self.title = "新規作成"
        
        self.datePicker.datePickerMode = .time
        
        registerButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel?.tapRegisterButton(name: (self?.nameTextField.text!)!, hour: (self!.datePicker.date.hour), minute: (self!.datePicker.date.minute))
            })
        .disposed(by: disposeBag)
        
        viewModel?.dismissToggle.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.navigationController?.popToRootViewController(animated: true)
            })
        .disposed(by: disposeBag)
    }
    
    
    // MARK: Private
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: Internal
    
    var viewModel: NewAlertViewModel?
}
