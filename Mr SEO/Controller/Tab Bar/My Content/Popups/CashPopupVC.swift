//
//  CashPopupVC.swift
//  Mr SEO
//
//  Created by Mac on 24/03/21.
//

import UIKit
protocol CashPopupProtocol:AnyObject {
    func YesButtonAction()
}
class CashPopupVC: UIViewController
{
    // MARK: - UIControlers Outlate
    var delegate:CashPopupProtocol?
    var helpid = String()
    // MARK: - Variables
    @IBOutlet weak var BtnNo: EMButton!{
        didSet{
            BtnNo.btnType = .BorderButton
        }
    }
    @IBOutlet weak var BtnYes: EMButton!{
        didSet{
            BtnYes.btnType = .Submit
        }
    }
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnNoAction(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnYesAction(_ sender:UIButton){
        self.WSPostStatus(Parameter: ["status":"cash_sent","help_id":Int(self.helpid)!])
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSPostStatus(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .ChangeStatus, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                self.dismiss(animated: true, completion: {
                    self.delegate?.YesButtonAction()
                })
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            print("Failure Response:",ResponseDict)
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    
}
