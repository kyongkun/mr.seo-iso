//
//  ChatDetailsVC.swift
//  Mr SEO
//
//  Created by Mac on 01/03/21.
//

import UIKit
import IQKeyboardManagerSwift

class AdminChatVC: UIViewController
{
    // MARK: - UIControlers Outlate
    
    // MARK: - Variables
    var IsFromThreadList = false
    var ToUserId = String()
    var ToUserName = String()
    var threads_id = String()
    var AutoMessage = String()

    var message_type = String()
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
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")

        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.title = "Admin"
        self.WSChatHistory(Parameter: ["message_type":self.message_type])
        
    }
    // MARK: - Functions
    

    // MARK: - UIButton Actions
    @IBAction func BtnSendAction(_ sender:UIButton){
//        showAlertWithTitleFromVC(vc: self, andMessage: "This Feature is under wrok in progress!")
//        return
        if(self.ArrChatDetails.count>0){
            self.ToUserId =  "\(self.ArrChatDetails.first!.receiver_id!)"
        }
        else{
            self.ToUserId = ObjChatDataModel!.receiver_user!.id!.description

        }
        let message = self.TxtMessage.text?.removeWhiteSpace()
        if(message != ""){
                let msg = self.TxtMessage.text!
                DispatchQueue.global(qos: .background).async {
                    self.WSSendMessage(Parameter: ["message":message!,"type":"message","message_type":self.message_type])

                }
                let dataHist = [ "created_at" : Date().getFullDate(),
                                 "message" : msg,
                                 "receiver_id" : "\(Int.random(in: 1234..<9999))",
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
        

        self.WSChatHistorywithoutLoader(Parameter: ["message_type":self.message_type])
    }
    // MARK: - WEB API Methods
    func WSSendAutoMessage(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPostWithOutLoader(WithType: .SendMsgToAdmin, isAuth: true, WithParams: Parameter){ (ResponseDict, Success, Status) in
            if Success == true{
                self.AutoMessage = ""
                self.WSChatHistory(Parameter: ["message_type":self.message_type])

            }
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSSendMessage(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPostWithOutLoader(WithType: .SendMsgToAdmin, isAuth: true, WithParams: Parameter){ (ResponseDict, Success, Status) in
            if Success == true{
            }
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSChatHistorywithoutLoader(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPostWithOutLoader(WithType: .AdminChatHIstory, isAuth: true, WithParams: Parameter) {  (ResponseDict, Success, Status) in
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
                    //self.TblChat.scrollToRow(at: indexPath, at: UITableViewScrollPosition.none, animated: true)

//                    /self.updateTableContentInset()
                }
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    func WSChatHistory(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .AdminChatHIstory, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
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

extension AdminChatVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrChatDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.ArrChatDetails[indexPath.row].sender_id!.description == EstalimUser.shared.id){
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
