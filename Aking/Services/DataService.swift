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


//protocol DataServiceDelegate {
//    func tasksUpdatedOnServer()
//}

let DB_BASE = Database.database().reference()
let THIS_USER_ID = AuthService.instance.getUID()

class DataService {
    
    static let instance = DataService()
    
    //MARK: - Properties
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_TASKS = DB_BASE.child("tasks")
    private var _REF_CHECKLIST = DB_BASE.child("checkLists")
    private var _REF_PROJECT = DB_BASE.child("projects")
    private var _REF_COLORS = DB_BASE.child("color")
    
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
    
    var REF_PROJECT: DatabaseReference {
        return _REF_PROJECT
    }
    
    var REF_COLORS: DatabaseReference {
        return _REF_COLORS
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
    
    func getUserData(forUID uid: String = THIS_USER_ID, handler: @escaping (_ user: DeviceUser) -> ()){
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
    
    func uploadTask(withTask task: Task, onSuccess: @escaping (_ status: Bool) -> ()){
        
        let thisTaskId = REF_TASKS.child(THIS_USER_ID).childByAutoId()
        var thisTask = task
        
        thisTask.id = "\(thisTaskId.key! )"
        let taskData = convertTaskToDictionary(task: thisTask)
        
        thisTaskId.updateChildValues(taskData) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    func updateTask(withTask task: Task, onSuccess: @escaping (_ success: Bool) -> ()) {
        
        let taskData = convertTaskToDictionary(task: task)
        REF_TASKS.child(THIS_USER_ID).child(task.id).updateChildValues(taskData) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    func getSingleTask(forTaskId tId: String, onCompletion: @escaping (Task) -> ()) {
        REF_TASKS.child(THIS_USER_ID).observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let allTasks = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            let downloadedTasks = self.convertDataSanpshotToTasksArray(allTasks)
            for task in downloadedTasks {
                if task.id == tId {
                    onCompletion(task)
                    print("Task returned with id \(tId)")
                }
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
    
    func removeTask(taskId: String){
        REF_TASKS.child(THIS_USER_ID).child(taskId).removeValue { (error, dbRef) in
            if error  != nil{
                print(error!.localizedDescription)
            } else {
                print("Child with Id \(taskId) removed from server")
            }
        }
    }
    
    func uploadCheckList(withCheckList checkList: CheckListItem, onSuccess: @escaping (_ success: Bool) -> ()) {
        let thisCheckListID = REF_CHECKLIST.child(THIS_USER_ID).childByAutoId()
        var thisCheckList = checkList
        
        thisCheckList.id = "\(thisCheckListID.key! )"
        thisCheckListID.updateChildValues(convertCheckListToDictionary(checkList: thisCheckList)) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    func updateCheckList(withCheckList checkList: CheckListItem, onSuccess: @escaping (_ success: Bool) -> ()) {
        let checkListData = convertCheckListToDictionary(checkList: checkList)
        REF_CHECKLIST.child(THIS_USER_ID).child(checkList.id).updateChildValues(checkListData)
        REF_CHECKLIST.child(THIS_USER_ID).child(checkList.id).updateChildValues(checkListData) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    func getAllCheckList(forUID uid: String = THIS_USER_ID, onCompletion: @escaping ([CheckListItem]?) -> ()){
        REF_CHECKLIST.observe(.value) { (dataSnapshot) in
            guard let allCheckLists = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            let downloadedCheckListItems: [CheckListItem] = self.convertDataSanpshotToCheckListArray(allCheckLists)
            
            onCompletion(downloadedCheckListItems)
        }
    }
    
    func uploadProject(withProject project: Project, onSuccess: @escaping (_ success: Bool) -> ()) {
        
        let thisProjectID = REF_PROJECT.child(THIS_USER_ID).childByAutoId()
        
        let projectDict: Dictionary<String, Any> = [
            KProject.ID : thisProjectID.key!,
            KProject.COLOR : project.color.toRGBAString(),
            KProject.PROJECT_NAME : project.projectName,
            KProject.NUMBER_OF_TASKS : project.numberOfTasks
        ]
        
        thisProjectID.updateChildValues( projectDict) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
    
    func getAllProject(forUID uid: String = THIS_USER_ID, onCompletion: @escaping ([Project]?) -> ()){
        REF_PROJECT.observe(.value) { (dataSnapshot) in
            guard let allProjects = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            var downloadedProjects: [Project] = []
            
            for usersProject in allProjects {
                if usersProject.key == THIS_USER_ID {
                    for project in usersProject.value as! [String:Any]  {
                        if let project = project.value as? [String: Any] {
                            let id = project[KProject.ID] as! String
                            let colorString = project[KProject.COLOR] as! String
                            let projectName = project[KProject.PROJECT_NAME] as! String
                            let numberOfTasks = project[KProject.NUMBER_OF_TASKS] as! String
                            
                            let color = UIColor.init(rgbaString: colorString)
                            print("color String: \(colorString), and color : \(String(describing: color))")
                            let newProject = Project(id: id, color: color!, projectName: projectName, numberOfTasks: numberOfTasks)
                            downloadedProjects.append(newProject)
                        }
                    }
                }
            }
            onCompletion(downloadedProjects)
        }
    }
    
    func uploadColors(withColor color: [UIColor], onSuccess: @escaping (_ success:Bool) -> ()) {
        var colorStingArray: [String] = []
        for c in color {
            colorStingArray.append(c.toRGBAString())
        }
        let colorDict = ["color" : colorStingArray]
        REF_COLORS.updateChildValues(colorDict) { (error, dbRef) in
            if error == nil {
                onSuccess(true)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func getAllColors(onCompletion: @escaping (_ colors: [UIColor]) -> ()) {
        var downloadedColors: [UIColor] = []
        REF_COLORS.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let snapShot = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for colors in snapShot {
                for color in colors.value as! NSArray {
                    let colorString = color as! String
                    let thisColor = UIColor.init(rgbaString: colorString)!
                    print(thisColor)
                    downloadedColors.append(thisColor)
                }
            }
            onCompletion(downloadedColors)
        }
    }
    
    func getTotalAndCompletedTasks(onCompletion: @escaping (_ totalTasks: Int, _ completedTasks: Int) -> ()) {
        REF_TASKS.observe( .value) { (dataSnapshot) in
            guard let allUsersTasks = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            var totalTasks: Int = 0, completedTask: Int = 0
            for thisUserTask in allUsersTasks {
                if thisUserTask.key == THIS_USER_ID {
                    for thisTask in thisUserTask.value as! [String:Any]  {
                        if let thisTask = thisTask.value as? [String: Any] {
                            totalTasks += 1
                            let status = thisTask[KTask.STATUS] as! Bool
                            if status { completedTask += 1 }
                        }
                    }
                    onCompletion(totalTasks, completedTask)
                }
            }
        }
    }
    
    fileprivate func convertDataSanpshotToCheckListArray(_ allCheckLists: [DataSnapshot]) -> [CheckListItem] {
        var downloadedCheckLists: [CheckListItem] = []
        for userCheckLists in allCheckLists {
            if userCheckLists.key == THIS_USER_ID {
                for thisItem in userCheckLists.value as! [String:Any] {
                    if let checkList = thisItem.value as? [String:Any] {
                        let id = checkList[KCheckListItem.ID] as! String
                        let description = checkList[KCheckListItem.DESCRIPTION] as! String
                        let colorString = checkList[KCheckListItem.COLOR] as! String
                        let thisCheckListItems = checkList[KCheckListItem.ITEMS_ARRAY] as? NSArray
                        let date = checkList[KCheckListItem.DATE] as! String
                        
                        let color = UIColor.init(rgbaString: colorString)
                        
                        let items = convertItemDictionaryToArray(items: thisCheckListItems as? [[String : Any]])
                        let chList = CheckListItem(id: id, description: description, items: items, color: color ?? UIColor.white, date: date)
                        downloadedCheckLists.append(chList)
                    }
                }
            }
        }
        return downloadedCheckLists
    }
    
    fileprivate func convertItemDictionaryToArray(items: [[String:Any]]?) -> [Item] {
        var itemsArray: [Item] = []
        guard let items = items else {return itemsArray}
        
        for element in 0..<items.count {
            let item = items[element]
            let status = item[KCheckListItem.STATUS] as! Bool
            let title = item[KCheckListItem.TITLE] as! String
            
            itemsArray.append(Item(title: title, status: status))
        }
        return itemsArray
    }
    
    fileprivate func convertDataSanpshotToTasksArray(_ allTasks: [DataSnapshot]) -> [Task] {
        var downloadedTasks: [Task] = []
        for userTasks in allTasks {
            if userTasks.key == THIS_USER_ID {
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
                        let colorString = task[KTask.COLOR] as! String
                        let status = task[KTask.STATUS] as! Bool
                        
                        let taskColor = UIColor.init(rgbaString: colorString)
                        let sts: TaskStatus = (status == true) ? .done : .pending
                        
                        let newTask = Task(id: id, title: title, assigneeName: assigneName, projectName: projectName, dueDate: dueDate, description: description, members: members as! [String], tag: tag, color: taskColor ?? UIColor.white, status: sts)
                        
                        downloadedTasks.append(newTask)
                    }
                }
            }
        }
        return downloadedTasks
    }
    
    fileprivate func convertTaskToDictionary(task: Task) -> Dictionary<String, Any> {
        
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
    
    fileprivate func convertCheckListToDictionary( checkList: CheckListItem) -> Dictionary<String, Any> {
        let itemsArray = checkList.items
        var itemsDict: [Dictionary<String, Any>] = []
        if itemsArray.count > 0 {
            if itemsArray[0].title != "" {
                itemsDict = convertCheckListItemsArrayToDictionary(items: itemsArray)
            }
        }
        let checkListItemDict: Dictionary<String, Any> =  [
            KCheckListItem.ID : checkList.id,
            KCheckListItem.DESCRIPTION : checkList.note.description,
            KCheckListItem.COLOR : checkList.note.color.toRGBAString(),
            KCheckListItem.ITEMS_ARRAY: itemsDict,
            KCheckListItem.DATE : checkList.date
        ]
        return checkListItemDict
    }
    
    fileprivate func convertCheckListItemsArrayToDictionary(items: [Item]) -> [Dictionary<String,Any>] {
        var dict: [Dictionary<String,Any>]  = []
        for item in items {
            dict.append(convertItemToDictionary(item: item))
        }
        return dict
    }
    
    fileprivate func convertItemToDictionary (item: Item) -> Dictionary<String, Any> {
        let dict: Dictionary<String, Any> = [
            KCheckListItem.TITLE : item.title,
            KCheckListItem.STATUS : item.status
        ]
        return dict
    }
    
    
    
    
    //MARK: - Dummy Date
    
    var people: [Assignee] = []
    var colors: [UIColor] = []
    init() {
        people = [assignee1, assignee2, assignee3, assignee4, assignee5, assignee6, assignee7]
        colors = [#colorLiteral(red: 0.436617732, green: 0.5095470548, blue: 0.9817432761, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9404537678, green: 0.4846215248, blue: 0.7824941278, alpha: 1), #colorLiteral(red: 0.8879843354, green: 0.5014117956, blue: 0, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.3921400309, green: 0.152138263, blue: 0.1213966534, alpha: 1), #colorLiteral(red: 0.2389388382, green: 0.5892125368, blue: 0.8818323016, alpha: 1)]
    }
    
    
    //MARK: - USERS
    let assignee1 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I Assignee1", email: "dummy-1@email.com")
    let assignee2 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee2", email: "dummy-2@email.com")
    let assignee3 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee3", email: "dummy-3@email.com")
    let assignee4 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee4", email: "dummy-4@email.com")
    let assignee5 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee5", email: "dummy-5@email.com")
    let assignee6 = Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee6", email: "dummy-6@email.com")
    let assignee7 =  Assignee(avator: #imageLiteral(resourceName: "dummy_Avator"), name: "I am Assignee7", email: "dummy-7@email.com")
    
    
}


