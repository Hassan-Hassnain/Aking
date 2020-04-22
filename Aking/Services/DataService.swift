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


protocol DataServiceDelegate {
    func tasksUpdatedOnServer()
}


class DataService {
    
    static let instance = DataService()
    var delegate: DataServiceDelegate!
    var tasks: [Task] = [] { didSet {delegate.tasksUpdatedOnServer()} }
    var people: [Assignee] = []
    var colors: [UIColor] = []
    var projects: [Project] = []
    var checkListItems: [CheckListItem] = []
    init() {
        //        tasks = [ task1, task2, task3, task4, task5, task6, task7, task8, task9  ]
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
    
    
    
}




let DB_BASE = Database.database().reference()

class GDataService {
    
    static let instance = GDataService()
    //MARK: - Properties
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_TASKS = DB_BASE.child("tasks")
    private var _REF_CHECKLIST = DB_BASE.child("notes")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    //MARK: - Project Related Properties
    var REF_TASKS: DatabaseReference {
        return _REF_TASKS
    }
    
    var REF_CHECKLIST: DatabaseReference {
        return _REF_CHECKLIST
    }
    
    
    //MARK: - General Methods
    
    func thisUserUID() -> String {
        return Auth.auth().currentUser!.uid
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


//MARK: - Project Releted Methods
extension GDataService {
    
    func uploadTask(withTask task: Task, onSuccess: @escaping (_ status: Bool) -> ()){
        let uid = thisUserUID()
        let taskData = convertTaskToDictionary(task: task)
        REF_TASKS.child(uid).childByAutoId().updateChildValues(taskData) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    func updateTask(withTask task: Task, onSuccess: @escaping (_ success: Bool) -> ()) {
        let uid = thisUserUID()
        let taskData = convertTaskToDictionary(task: task)
        REF_TASKS.child(uid).child(task.id).updateChildValues(taskData) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    
    
    func getAllTask(forUID uid: String = Auth.auth().currentUser!.uid, onCompletion: @escaping ([Task]?) -> ()) {
        REF_TASKS.observe(.value) { (dataSnapshot) in
            guard let allTasks = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            let downloadedTasks = self.convertDataSanpshotToTasksArray(allTasks)
            
            onCompletion(downloadedTasks)
        }
    }
    
    func uploadCheckList(withCheckList checkList: CheckListItem, onSuccess: @escaping (_ success: Bool) -> ()) {
        let uid = AuthService.instance.getUID()
        REF_CHECKLIST.child(uid).childByAutoId().updateChildValues(convertCheckListToDictionary(checkList: checkList)) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    func getAllCheckList(forUID uid: String = Auth.auth().currentUser!.uid ){ //, onCompletion: @escaping ([CheckListItem]?) -> ())
           REF_CHECKLIST.observe(.value) { (dataSnapshot) in
               guard let allCheck = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
//               let downloadedCheckListItems = self.convertDataSanpshotToCheckListItemsArray(allCheck)
                print(allCheck)
//               onCompletion(downloadedCheckListItems)
           }
       }
    
//    fileprivate func convertDataSanpshotToCheckListItemsArray(_ allCheckListItems: [DataSnapshot]) -> [CheckListItem] {
//        var downloadedCheckListItems: [CheckListItem] = []
//        for userCheckLists in allCheckListItems {
//            for checkList in userCheckLists.value as! [String:Any] {
//                if let checkList = checkList.value as?[String:Any] {
//
//                    let d = checkList.note
//
//
//
//
//                    let taskColor = UIColor.init(hexaDecimalString: color)
//                    let sts: TaskStatus = (status == true) ? .done : .pending
//
//                    let newTask = Task(id: id, title: title, assigneeName: assigneName, projectName: projectName, dueDate: dueDate, description: description, members: members, tag: tag, color: taskColor ?? UIColor.white, status: sts)
//
//                    downloadedTasks.append(newTask)
//                }
//            }
//        }
//        return downloadedCheckListItems
//    }
    
    fileprivate func convertDataSanpshotToTasksArray(_ allTasks: [DataSnapshot]) -> [Task] {
        var downloadedTasks: [Task] = []
        for userTasks in allTasks {
            for task in userTasks.value as! [String:Any] {
                if let task = task.value as?[String:Any] {
                    let title = task[KTask.TITLE] as! String
                    let id = task[KTask.ID] as! String
                    let assigneName = task[KTask.ASSIGNEE_NAME] as! String
                    let projectName = task[KTask.PROJECT_NAME] as! String
                    let dueDate = task[KTask.DUE_DATE] as! String
                    let description = task[KTask.DESCRIPTION] as! String
                    let members:NSArray = task[KTask.MEMBERS] as? NSArray ?? []
                    let tag = task[KTask.TAG] as! String
                    let color = task[KTask.COLOR] as! String
                    let status = task[KTask.STATUS] as! Bool
                    
                    let taskColor = UIColor.init(hexaDecimalString: color)
                    let sts: TaskStatus = (status == true) ? .done : .pending
                    
                    
                    let newTask = Task(id: id, title: title, assigneeName: assigneName, projectName: projectName, dueDate: dueDate, description: description, members: members as! [String], tag: tag, color: taskColor ?? UIColor.white, status: sts)
                    
                    downloadedTasks.append(newTask)
                }
            }
        }
        return downloadedTasks
    }
    func convertTaskToDictionary(task: Task) -> Dictionary<String, Any> {
        
        let taskDict: Dictionary<String, Any> =  [
            KTask.ID: String(describing: task.id),
            KTask.TITLE: task.title,
            KTask.ASSIGNEE_NAME : task.assigneeName,
            KTask.PROJECT_NAME : task.projectName,
            KTask.DUE_DATE : task.dueDate,
            KTask.DESCRIPTION : task.description,
            KTask.MEMBERS : task.members,
            KTask.TAG : task.tag,
            KTask.COLOR : task.color.toRGBAString(),
            KTask.STATUS : task.status == .done ? true : false
        ]
        return taskDict
    }
    
    func convertCheckListToDictionary(checkList: CheckListItem) -> Dictionary<String, Any> {
        let checkListItemDict: Dictionary<String, Any> =  [
            KNote.DESCRIPTION : checkList.note.description,
            KNote.COLOR : checkList.note.color.toRGBAString(),
            "itemArray" : convertCheckListItemsToArray(items: checkList.items)
        ]
        return checkListItemDict
    }
    
    func convertCheckListItemsToArray(items: [Item]) -> [Dictionary<String,Any>] {
        var dict: [Dictionary<String,Any>]  = []
        for item in items {
            dict.append(convertItemToDictionary(item: item))
        }
        return dict
    }
    
    func convertItemToDictionary (item: Item) -> Dictionary<String, Any> {
        let dict: Dictionary<String, Any> = [
            KItem.TITLE : item.title,
            KItem.STATUS : item.status
        ]
        return dict
    }
    
    func convertDictionaryToArray(dict: [String : Int]) -> [String] {
        var dictArray: [String] = []
        for (_, v) in dict {
            dictArray.append("\(v)")
        }
        return dictArray
    }
}