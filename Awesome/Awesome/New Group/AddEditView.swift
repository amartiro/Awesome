//
//  AddEditView.swift
//  Awesome
//
//  Created by Artak on 1/29/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

protocol AddEditViewDelegate {
    func increaseLevel()
    func decreaseLevel()
    
    func titleChanged(_ title : String)
    func shortDescrChanged(_ title : String)
    func longDescrChanged(_ title : String)
    
    func saveButtonAction()
}

class AddEditView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var shortDescrTextField: UITextField!
    @IBOutlet weak var longDescTextView: UITextView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var minusLevelButton: UIButton!
    @IBOutlet weak var plusLevelButton: UIButton!
    
    var delegate : AddEditViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let bundles = Bundle.main.loadNibNamed("AddEditView", owner: self, options: nil)
        let xibView = bundles!.first as! UIView
        xibView.frame = self.bounds
        
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        scrollView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleHeight];
        self.addSubview(xibView)
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        delegate?.decreaseLevel()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        delegate?.increaseLevel()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        titleTextField.resignFirstResponder()
        shortDescrTextField.resignFirstResponder()
        longDescTextView.resignFirstResponder()
        
        delegate?.saveButtonAction()
    }
}

extension AddEditView : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text!
        
        switch textField {
            
        case titleTextField:
            delegate?.titleChanged(text)
        case shortDescrTextField:
            delegate?.shortDescrChanged(text)
        default:
            print(text)
        }
    }
}

extension AddEditView : UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == longDescTextView {
            delegate?.longDescrChanged(textView.text)
        }
    }
}
