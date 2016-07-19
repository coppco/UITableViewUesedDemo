//
//  ViewController.swift
//  UITableView的使用
//
//  Created by coco on 16/7/19.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var numbers:UInt8 = 18
    
    @IBOutlet weak var editingButton: UIBarButtonItem!
    
    @IBOutlet weak var allSelect: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func change(sender: UIBarButtonItem) {
        if true == self.tableView.editing {
            self.tableView.setEditing(false, animated: true)
            self.allSelect.hidden = true
            sender.title = "编辑"
        } else {
            self.tableView.setEditing(true, animated: true)
            self.allSelect.hidden = false
            sender.title = "完成"
        }
        
        for cell in self.tableView.visibleCells {
            cell.selected = false
        }
        self.allSelect.selected = false
    }
    
    @IBAction func all(sender: UIButton) {
        //全选的操作,  一般都是更改数据源,刷新数据
        sender.selected = !sender.selected
        for cell in self.tableView.visibleCells {
            if true == sender.selected {
                cell.selected = true
            } else {
                cell.selected = false
            }
        }
    }
    //FIXME: UITableVeiwDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(numbers)
    }
    
    //TODO: iOS8.0以前实现下面三个方法即可实现侧滑出现删除按钮,注意它只有一个按钮,Delete样式才可以出来,文字可以更改,//code 写上删除的代码逻辑
    /*
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //code  你的代码逻辑
        numbers -= 1
        guard 0 != numbers else {
            numbers = 8
            return
        }
        self.tableView.reloadData()
    }
    */
    
    //FIXME: iOS 8.0以后可以使用这个方法添加多个按钮

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let actionDelete = UITableViewRowAction(style: .Default, title: "删除") { (UITableViewRowAction, NSIndexPath) -> Void in
            print("删除了\(indexPath.row)行")
            self.endEditing()
        }
        actionDelete.backgroundColor = UIColor.orangeColor()
        let actionHaHa = UITableViewRowAction(style: .Normal, title: "默默转身") { (UITableViewRowAction, NSIndexPath) -> Void in
            print("默默转身了\(indexPath.row)行")
            self.endEditing()
        }
        actionHaHa.backgroundColor = UIColor.redColor()
        let actionMark = UITableViewRowAction(style: .Normal, title: "标记") { (UITableViewRowAction, NSIndexPath) -> Void in
            print("标记了\(indexPath.row)行")
            self.endEditing()
        }
        actionMark.backgroundEffect = UIBlurEffect(style: .ExtraLight)
        return [actionDelete, actionHaHa, actionMark]
    }
    
    func endEditing() {
        self.tableView.setEditing(false, animated: true)
    }

    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if true == self.tableView.editing {
            return UITableViewCellEditingStyle(rawValue: 3)!
        }
        return .Delete
    }

}


