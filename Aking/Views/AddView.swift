//
//  AddView.swift
//  Aking
//
//  Created by Usama Sadiq on 4/7/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

class AddView: UIView {
    let ADDVIEW_XIB_NAME = "AddView"
    @IBOutlet var contentView: UIView!
    
    var delegate:AddViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(ADDVIEW_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
        delegate?.addTaskDidTapped()
        self.removeFromSuperview()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KNotifcations.NEW_TASK), object: nil)
    }
    
    @IBAction func addQuickNoteButtonTapped(_ sender: Any) {
        delegate?.addTaskDidTapped()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KNotifcations.QUICK_NOTE), object: nil)
        self.removeFromSuperview()
    }
    @IBAction func addCheckListButtonTapped(_ sender: Any) {
        delegate?.addCheckListDidTapped()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KNotifcations.CHECK_LIST), object: nil)
        self.removeFromSuperview()
    }
}
