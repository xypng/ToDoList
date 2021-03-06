//
//  ViewController.swift
//  ToDoList
//
//  Created by 肖奕鹏 on 16/2/17.
//  Copyright © 2016年 xiaoyipeng. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []
var fieldtodos: [TodoModel] = []
//字符串得到NSDate
func dateFromString(string: String) -> NSDate? {
    let df = NSDateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    let dt = df.dateFromString(string)
    return dt
}

//NSDate得到本地化的时间格式字符串
func stringFromDate(date: NSDate) -> String {
    let locale = NSLocale.currentLocale()
    let formatter = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
    let dateformatter = NSDateFormatter()
    dateformatter.dateFormat = formatter
    return dateformatter.stringFromDate(date)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        todos.append(TodoModel(id: "1", image: "child-selected", title: "1,在家带孩子", date: dateFromString("2016-02-17")!))
        todos.append(TodoModel(id: "2", image: "phone-selected", title: "2,打电话", date: dateFromString("2016-02-18")!))
        todos.append(TodoModel(id: "3", image: "shopping-cart-selected", title: "1,购物", date: dateFromString("2016-02-19")!))
        todos.append(TodoModel(id: "4", image: "travel-selected", title: "1,旅游", date: dateFromString("2016-02-20")!))
        
        self.navigationItem.leftBarButtonItem = editButtonItem()
    }

    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            return fieldtodos.count
        } else {
            return todos.count;
        }
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellId")! as UITableViewCell
        var todo: TodoModel
        if tableView == searchDisplayController?.searchResultsTableView {
            todo = fieldtodos[indexPath.row] as TodoModel
        } else {
            todo = todos[indexPath.row] as TodoModel
        }
        let image = cell.viewWithTag(101) as! UIImageView
        let title = cell.viewWithTag(102) as! UILabel
        let date = cell.viewWithTag(103) as! UILabel
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        date.text = stringFromDate(todo.date)
        
        return cell
    }
    
    internal func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "changeTodoSegue" {
            let dvc = segue.destinationViewController as! DetailViewController
            let indexpath = tableView.indexPathForSelectedRow
            if let index = indexpath {
                dvc.todo = todos[index.row]
            }
        }
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let model = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(model, atIndex: destinationIndexPath.row)
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        fieldtodos = todos.filter(){$0.title.rangeOfString(searchString!) != nil}
        return true
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
}

