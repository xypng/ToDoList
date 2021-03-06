//
//  DetailViewController.swift
//  ToDoList
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var childButton: UIButton!

    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var shopingButton: UIButton!
    
    @IBOutlet weak var travelButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var todo: TodoModel?
    
    @IBAction func imageTapped(sender: UIButton) {
        childButton.selected = false
        phoneButton.selected = false
        shopingButton.selected = false
        travelButton.selected = false
        sender.selected = true
    }
    
    
    @IBAction func okTapped(sender: UIButton) {
        var img: String = ""
        if childButton.selected {
            img = "child-selected"
        }
        if phoneButton.selected {
            img = "phone-selected"
        }
        if shopingButton.selected {
            img = "shopping-cart-selected"
        }
        if travelButton.selected {
            img = "travel-selected"
        }
        let uuid = NSUUID().UUIDString
        if todo == nil {
            let model = TodoModel(id: uuid, image: img, title: titleTextField.text!, date: datePicker.date)
            todos.append(model)
        } else {
            todo?.image = img
            todo?.title = titleTextField.text!
            todo?.date = datePicker.date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if todo == nil {
            childButton.selected = true
            navigationController?.title = "新增"
        } else {
            navigationController?.title = "修改"
            if todo?.image == "child-selected" {
                childButton.selected = true
            }
            if todo?.image == "phone-selected" {
                phoneButton.selected = true
            }
            if todo?.image == "shopping-cart-selected" {
                shopingButton.selected = true
            }
            if todo?.image == "travel-selected" {
                travelButton.selected = true
            }
            titleTextField.text = todo?.title
            datePicker.date = (todo?.date)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        titleTextField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
