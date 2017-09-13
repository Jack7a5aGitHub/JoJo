//
//  EntryFormViewController.swift
//  MyProfolio
//
//  Created by Jack Wong on 2017/08/30.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class EntryFormViewController: FormViewController {
    
    
    @IBAction func saveBtn(_ sender: Any) {
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Form(context: context)
        
        if theChosen != nil {
            
            theChosen?.task = taskSubject
            theChosen?.details = details
            theChosen?.dueDate = dueDate as NSDate?
            theChosen?.priority = priority
            
            task.task = theChosen?.task
            task.dueDate = theChosen?.dueDate as NSDate?
            task.priority = theChosen?.priority
            task.details = theChosen?.details
            context.delete(theChosen!)
            
        }else{
            
            task.task = taskSubject
            task.dueDate = dueDate as NSDate?
            task.priority = priority
            task.details = details
        }
        print("save success")
        // save the data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    var theChosen  : Form? = nil
    var taskSubject : String?
    var dueDate : Date?
    var details : String?
    var priority : String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewDidLoad()
        
        
        if theChosen != nil {
            print("yes taskSubject")
            print(theChosen!)
            
            self.taskSubject = (theChosen?.task)!
            self.dueDate = (theChosen?.dueDate)! as Date
            self.priority = (theChosen?.priority)!
            self.details = (theChosen?.details)!
            
        }
        
        
        
        
        
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 20
        // Do any additional setup after loading the view.
        
        form +++ Section()
            <<< TextRow(){
                let ruleRequiredViaClosure = RuleClosure<String> { rowValue in
                    return (rowValue == nil || rowValue!.isEmpty) ? ValidationError(msg: "Field required!") : nil
                }
                var rules = RuleSet<String>()
                rules.add(rule: ruleRequiredViaClosure )
                $0.title = " Task "
                $0.placeholder = "e.g Interview"
                $0.value = taskSubject
                $0.add(ruleSet: rules)
                $0.validationOptions = .validatesAlways
                $0.onChange{[unowned self] row in
                    self.taskSubject = row.value
                    }
                $0.cellUpdate { cell, row in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                }
                
                        
                }
                form +++ Section()
                    <<< DateTimeRow(){
                        
                        $0.title = "Due Date"
                        $0.dateFormatter = type(of: self).dateFormatter
                        $0.minimumDate = Date()
                        $0.value = dueDate
                        $0.onChange({[unowned self] row in
                            if let date = row.value{
                                self.dueDate = date
                                
                            }})
                    }
                    <<< SegmentedRow<String>() {
                        $0.title = "Priority"
                        $0.options = ["L", "M", "H"]
                        $0.value = priority
                        $0.onChange({[unowned self] row in
                            if let option = row.value{
                                self.priority = option
                            }})
                    }
                    +++ Section()
                    <<< TextAreaRow(){
                        $0.placeholder = "Details"
                        $0.value = details
                        $0.onChange({[unowned self] row in
                            if let typedDetails = row.value{
                                self.details = typedDetails
                            }})
                        
                }
                
                
        }
        /*
         func setupForm(){
         
         form +++ Section("ABC")
         <<< TextRow(){
         $0.title = " Task "
         $0.placeholder = "e.g Interview"
         $0.value = taskSubject
         $0.onChange{[unowned self] row in
         self.taskSubject = row.value!
         }
         
         }
         form +++ Section()
         <<< DateTimeRow(){
         
         $0.title = "Due Date"
         $0.dateFormatter = type(of: self).dateFormatter
         $0.minimumDate = Date()
         $0.value = dueDate
         $0.onChange({[unowned self] row in
         if let date = row.value{
         self.dueDate = date
         
         }})
         }
         <<< SegmentedRow<String>() {
         $0.title = "Priority"
         $0.options = ["L", "M", "H"]
         $0.value = priority
         }
         +++ Section()
         <<< TextAreaRow(){
         $0.placeholder = "Details"
         $0.value = details
         
         
         }
         }
         */
        
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d yyyy, h mm:a"
            return formatter
        }()
        
        
        
}
