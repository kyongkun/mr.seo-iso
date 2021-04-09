//
//  ChatDetailsVC.swift
//  Mr SEO
//
//  Created by Mac on 01/03/21.
//

import UIKit
import IQKeyboardManagerSwift

class ChatDetailsVC: UIViewController
{
    // MARK: - UIControlers Outlate
    
    // MARK: - Variables
    var IsFromThreadList = false
    var ToUserId = String()
    var ToUserName = String()

    var threads_id = String()
    var ObjChatDataModel = ChatDataModel.init(dictionary:[:])
    var ArrChatDetails = [ChatDetailsModel]()
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    @IBOutlet weak var TblChat:UITableView!
    @IBOutlet weak var TxtMessage:PaddingTextField!

    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TblChat.setDefaultProperties(vc: self)
        self.TblChat.registerCell(type: SenderCellXIB.self)
        self.TblChat.registerCell(type: ReceiverCellXIB.self)
        self.TblChat.registerCell(type: SenderImageCellXIB.self)
        self.TblChat.registerCell(type: ReciverImageCellXIB.self)
        self.TblChat.reloadData()
        //IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.disabledToolbarClasses.append(ChatDetailsVC.self)
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")

        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        super.viewWillAppear(animated)
        if(IsFromThreadList == true){
            self.threads_id = self.ObjChatDataModel!.id!.description
            self.title = self.ObjChatDataModel!.sender_user?.name
            self.WSChatHistory(Parameter: ["threads_id":self.ObjChatDataModel!.id!])
        }
        else{
            self.title = self.ToUserName
            self.WSChatHistory(Parameter: ["threads_id":self.threads_id])
//            self.WSChatHistory(Parameter: ["threads_id":self.ObjChatDataModel!.id!])
        }
        
    }
    // MARK: - Functions
    

    // MARK: - UIButton Actions
    @IBAction func BtnSendAction(_ sender:UIButton){
        if(self.ArrChatDetails.count>0){
            self.ToUserId =  "\(self.ArrChatDetails.first!.receiver_id!)"
        }
        else{
            self.ToUserId = ObjChatDataModel!.receiver_user!.id!.description

        }
        let message = self.TxtMessage.text?.removeWhiteSpace()
        if(message != ""){
            if(IsFromThreadList == true){
                let rectouser = ObjChatDataModel!.receiver_user!.id!
                    if self.validate() {
                        DispatchQueue.global(qos: .background).async {
                            self.WSSendMessage(Parameter: ["threads_id":self.ObjChatDataModel!.id!,"to_user_id":rectouser,"message":message!,"type":"message"])
                        }
                        let dataHist = [ "created_at" : Date().getFullDate(),
                                         "message" : self.TxtMessage.text!,
                                         "receiver_id" : Int(self.ToUserId)!,
                                         "receiver_status" : "y",
                                         "sender_id" : Int(EstalimUser.shared.id)!,
                                         "sender_name" : EstalimUser.shared.name,
                                         "sender_status" : "y",
                                         "status" : "unread",
                                         "threads_id" : self.threads_id,
                                         "type" : "message"
                                         ] as [String : Any]
                        
                        let obj = ChatDetailsModel.init(dictionary: dataHist as NSDictionary)
                        self.TxtMessage.text = ""
                        self.ArrChatDetails.append(obj!)
                        self.TblChat.reloadData()
                        let lastSectionIndex = self.TblChat!.numberOfSections - 1
                        let lastRowIndex = self.TblChat!.numberOfRows(inSection: lastSectionIndex) - 1
                        let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
                        self.TblChat?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.none, animated: true)
                        return
                    }
        }
        else{
            if self.validate() {
                var msg = self.TxtMessage.text!
                DispatchQueue.global(qos: .background).async {
                    self.WSSendMessage(Parameter: ["threads_id":self.threads_id,"to_user_id":self.ToUserId,"message":message!,"type":"message"])

                }
                let dataHist = [ "created_at" : Date().getFullDate(),
                                 "message" : self.TxtMessage.text!,
                                 "receiver_id" : Int(self.ToUserId)!,
                                 "receiver_status" : "y",
                                 "sender_id" : Int(EstalimUser.shared.id)!,
                                 "sender_name" : EstalimUser.shared.name,
                                 "sender_status" : "y",
                                 "status" : "unread",
                                 "threads_id" : self.threads_id,
                                 "type" : "message"
                                 ] as [String : Any]
                
                let obj = ChatDetailsModel.init(dictionary: dataHist as NSDictionary)
                self.TxtMessage.text = ""
                self.ArrChatDetails.append(obj!)
                self.TblChat.reloadData()
                let lastSectionIndex = self.TblChat!.numberOfSections - 1
                let lastRowIndex = self.TblChat!.numberOfRows(inSection: lastSectionIndex) - 1
                let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
                self.TblChat?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.none, animated: true)
                return
            }
            
        }
        }
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func scrollBottom() {
        if self.ArrChatDetails.count > 0
        {
            DispatchQueue.main.asyncAfter(deadline: .now()) {

                let lastIndex = NSIndexPath(row: self.ArrChatDetails.count-1, section: 0)
           self.TblChat.scrollToRow(at: lastIndex as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
            self.TblChat.scrollRectToVisible(CGRect(x: 0, y: self.TblChat.contentSize.height, width: 1, height: 1), animated: false)
            }

        }
    }
    func validate() -> Bool {
        guard (TxtMessage.text?.removeWhiteSpace().count)! > 0 else
        {
            return false
        }
        return true
    }
    // MARK: - Custom Methods
    func RefreshWithOutLoader(){
        self.WSChatHistorywithoutLoader(Parameter: ["threads_id":self.threads_id])
    }
    // MARK: - WEB API Methods
    func WSSendMessage(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPostWithOutLoader(WithType: .SendMessage, isAuth: true, WithParams: Parameter){ (ResponseDict, Success, Status) in
            if Success == true{
            }
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSChatHistorywithoutLoader(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPostWithOutLoader(WithType: .ChatHistory, isAuth: true, WithParams: Parameter) {  (ResponseDict, Success, Status) in
            if Success == true{
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrChatDetails.removeAll()
                    self.ArrChatDetails = ChatDetailsModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrChatDetails.count>0){
                        self.TblChat.setEmptyMessage("")
                    }
                    else{
                        self.TblChat.setEmptyMessage("No Data Found!")
                    }
                    self.TblChat.reloadData()
                    self.TblChat.scrollToBottom(animated: false)
                    let lastSectionIndex = self.TblChat!.numberOfSections - 1
                    let lastRowIndex = self.TblChat!.numberOfRows(inSection: lastSectionIndex) - 1
                    let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
                    self.TblChat?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.none, animated: true)
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSChatHistory(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .ChatHistory, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if let Language = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.ArrChatDetails.removeAll()
                    self.ArrChatDetails = ChatDetailsModel.modelsFromDictionaryArray(array: Language)
                    if(self.ArrChatDetails.count>0){
                        self.TblChat.setEmptyMessage("")
                    }
                    else{
                        self.TblChat.setEmptyMessage("No Data Found!")
                    }
                    self.TblChat.reloadData()
                    //self.TblChat.scrollToBottom(animated: false)
                    self.TblChat.reloadData()
                    let lastSectionIndex = self.TblChat!.numberOfSections - 1
                    let lastRowIndex = self.TblChat!.numberOfRows(inSection: lastSectionIndex) - 1
                    let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
                    self.TblChat?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.none, animated: true)
//                    /self.updateTableContentInset()
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
}
// MARK: - UITableView Delegate Methods

extension ChatDetailsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrChatDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.ArrChatDetails[indexPath.row].sender_id == Int(EstalimUser.shared.id)){
                guard let cell = tableView.dequeueCell(
                     withType: SenderCellXIB.self,
                     for: indexPath) as? SenderCellXIB else {
                          return UITableViewCell()
                }
                cell.LblMessage.text = self.ArrChatDetails[indexPath.row].message
                cell.LblTime.text = timeAgoSinceDate1(getDateFromString(date: self.ArrChatDetails[indexPath.row].created_at!))
                cell.selectionStyle = .none
                return cell

            }
            else{
                guard let cell = tableView.dequeueCell(
                     withType: ReceiverCellXIB.self,
                     for: indexPath) as? ReceiverCellXIB else {
                          return UITableViewCell()
                }
                cell.LblMessage.text = self.ArrChatDetails[indexPath.row].message
                cell.LblTime.text = timeAgoSinceDate1(getDateFromString(date: self.ArrChatDetails[indexPath.row].created_at!))
                cell.selectionStyle = .none
                return cell

            }
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
