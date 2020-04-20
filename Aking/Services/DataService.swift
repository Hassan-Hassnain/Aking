//
//  DummyDB.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class DataService {
    
    static let instance = DataService()
    var tasks: [Task] = []
    var people: [Assignee] = []
    var colors: [UIColor] = []
     var projects: [Project] = []
     var checkListItems: [CheckListItem] = []
    init() {
               tasks = [ task1, task2, task3, task4, task5, task6, task7, task8, task9  ]
               people = [assignee1, assignee2, assignee3, assignee4, assignee5, assignee6, assignee7]
               colors = [#colorLiteral(red: 0.436617732, green: 0.5095470548, blue: 0.9817432761, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9404537678, green: 0.4846215248, blue: 0.7824941278, alpha: 1), #colorLiteral(red: 0.8879843354, green: 0.5014117956, blue: 0, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.3921400309, green: 0.152138263, blue: 0.1213966534, alpha: 1), #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)]
               checkListItems = [c1,c2,c3, c4,c5, c6]
               projects = [p1, p2, p3, p4, p5]
           }
   
        
    //MARK: - USERS
            let assignee1 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I fffffffffffam Assignee1", email: "dummy-1@email.com")
            let assignee2 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee2", email: "dummy-2@email.com")
            let assignee3 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee3", email: "dummy-3@email.com")
            let assignee4 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee4", email: "dummy-4@email.com")
            let assignee5 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee5", email: "dummy-5@email.com")
            let assignee6 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee6", email: "dummy-6@email.com")
           let assignee7 =  Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee7", email: "dummy-7@email.com")
        
    //MARK: - PROJECTS
       
            let p1 = Project(color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), projectName: "Home", numberOfTasks: "10")
            let p2 = Project(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), projectName: "Team", numberOfTasks: "10")
            let p3 = Project(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), projectName: "Office Work", numberOfTasks: "10")
            let p4 = Project(color: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), projectName: "Entertainment", numberOfTasks: "10")
            let p5 = Project(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), projectName: "Personal", numberOfTasks: "10")
        
    //MARK: - CHECK LIST
            let c1 = CheckListItem(description: "Testing", items: [Item(title: "Buy Grocery", status: false),Item(title: "Buy Milk", status: false)], color: .gray)
            let c2 = CheckListItem(description: "Testing", items: [], color: .green)
            let c3 = CheckListItem(description: "Testing", items: [], color: .yellow)
            let c4 = CheckListItem(description: "Testing", items: [], color: .purple)
            let c5 = CheckListItem(description: "Testing", items: [], color: .magenta)
            let c6 = CheckListItem(description: "Testing", items: [], color: .orange)
        
        
        
    //MARK: - TASKS
        let task1 = Task(id: nil, title: "Task-1", assigneeName: "Israr ul haq", projectName: "Test Project-1", dueDate: "Apr 20,2020", description: "Testing the app", members: [], tag: "Personal", color: .blue, status: .done)
        let task2 = Task(id: nil, title: "Task-2", assigneeName: "Israr", projectName: "Test Project-2", dueDate: "Apr 20,2020", description: "Testing the app", members: [], tag: "Work", color: .green, status: .pending)
        let task3 = Task(id: nil, title: "Task-3", assigneeName: "Test User", projectName: "Test Project-3", dueDate: "Apr 20,2020", description: "Testing the app", members: [], tag: "Entertainment", color: .red, status: .pending)
        
        let task4 = Task(id: nil, title: "Task-1", assigneeName: "Israr ul haq", projectName: "Test Project-1", dueDate: "Apr 21,2020", description: "Testing the app", members: [], tag: "Personal", color: .blue, status: .pending)
        let task5 = Task(id: nil, title: "Task-2", assigneeName: "Israr", projectName: "Test Project-2", dueDate: "Apr 21,2020", description: "Testing the app", members: [], tag: "Work", color: .green, status: .pending)
        let task6 = Task(id: nil, title: "Task-3", assigneeName: "Test User", projectName: "Test Project-3", dueDate: "Apr 21,2020", description: "Testing the app", members: [], tag: "Entertainment", color: .red, status: .pending)
        
        let task7 = Task(id: nil, title: "Task-1", assigneeName: "Israr ul haq", projectName: "Test Project-1", dueDate: "Apr 22,2020", description: "Testing the app", members: [], tag: "Personal", color: .blue, status: .pending)
        let task8 = Task(id: nil, title: "Task-2", assigneeName: "Israr", projectName: "Test Project-2", dueDate: "Apr 22,2020", description: "Testing the app", members: [], tag: "Work", color: .green, status: .pending)
        let task9 = Task(id: nil, title: "Task-3", assigneeName: "Test User", projectName: "Test Project-3", dueDate: "Apr 22,2020", description: "Testing the app", members: [], tag: "Entertainment", color: .red, status: .pending)
        
}




    let DB_BASE = Database.database().reference()

    class GDataService {
        static let instance = GDataService()
        
        private var _REF_BASE = DB_BASE
        private var _REF_USERS = DB_BASE.child("users")
        
        
        var REF_BASE: DatabaseReference {
            return _REF_BASE
        }
        
        var REF_USERS: DatabaseReference {
            return _REF_USERS
        }
        
         func createDBUser(uid: String, userData: Dictionary<String, Any>){
               REF_USERS.child(uid).updateChildValues(userData)
           }
           
        func updateDBUser(uid: String, userData: Dictionary<String, Any>, onSuccess: @escaping (_ success: Bool)->()) {
            REF_USERS.child(uid).updateChildValues(userData, withCompletionBlock: { (error, ref) in
                if error == nil {
                    onSuccess(true)
                } else {
                    onSuccess(false)
                }
            })
        }
        
        func getUserData(forUID uid: String, handler: @escaping (_ user: DeviceUser) -> ()){
            REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
                guard let FirebaseUser = userSnapShot .children.allObjects as? [DataSnapshot] else {return}
                
                for FirUser in FirebaseUser {
                    if FirUser.key == uid {
                        let name = FirUser.childSnapshot(forPath: KUserData.USER_NAME).value as! String
                        let email = FirUser.childSnapshot(forPath: KUserData.UESR_EMAIL).value as! String
                        
                        let user = DeviceUser(uid: FirUser.key, name: name, email: email)
                        handler(user)
                    }
                }
            }
        }
        
        
    }


        

