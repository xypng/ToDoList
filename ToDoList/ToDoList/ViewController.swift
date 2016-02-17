//
//  ViewController.swift
//  ToDoList
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        todos.append(TodoModel(id: "1", image: "child-selected", title: "1,在家带孩子", date: dateFromString("2016-02-17")!))
        todos.append(TodoModel(id: "2", image: "phone-selected", title: "2,打电话", date: dateFromString("2016-02-18")!))
        todos.append(TodoModel(id: "3", image: "shopping-cart-selected", title: "1,购物", date: dateFromString("2016-02-19")!))
        todos.append(TodoModel(id: "4", image: "travel-selected", title: "1,旅游", date: dateFromString("2016-02-20")!))
    }

    func dateFromString(string: String) -> NSDate? {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dt = df.dateFromString(string)
        return dt
    }
}

