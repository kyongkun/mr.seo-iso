//
//  OtpVerificationVC.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import SVPinView
import Firebase


class OtpVerificationVC: UIViewController
{
    // MARK: - UIControlers Outlate
    var datadict:[String:Any]?
    var bankimg = UIImage()
    var userimg = UIImage()
    var MyverificationID = String()
    @IBOutlet weak var LblMobileNumber: UILabel!

    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
            LblNavigationTitle.text  = "OTP 인증"
        }
    }
    @IBOutlet weak var BtnVerify: EMButton!{
        didSet{
            BtnVerify.btnType = .Submit
            BtnVerify.setTitle("Verify & Proceed", for: .normal)
            BtnVerify.setTitle("Verify & Proceed", for: .selected)
        }
    }
    @IBOutlet var otpTextFieldView: SVPinView!{
        didSet{
            otpTextFieldView.style = .box
            otpTextFieldView.borderLineColor = .AppTextField
            otpTextFieldView.borderLineThickness  = 1.3
            otpTextFieldView.activeBorderLineThickness = 1.3
            otpTextFieldView.activeBorderLineColor = .AppTextField
      //      otpTextFieldView.pastePin(pin: "1234")
//            otpTextFieldView.borderWidth = 1
//            otpTextFieldView.borderColor = .AppTextField
            otpTextFieldView.backgroundColor = .white
            otpTextFieldView.textColor = .black
            
        }
    }
    
    
    // MARK: - Variables
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        let code = "+82"
        let mobile = self.datadict!["mobile"] as! String
        let phoneNumber = code + mobile
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
          if let error = error {
            showAlertWithTitleFromVC(vc: self, andMessage: error.localizedDescription)
            return
          }
            self.MyverificationID = verificationID!
            //showAlertWithTitleFromVC(vc: self, andMessage: "please enter \(verificationID)")

          // Sign in using the verificationID and the code sent to the user
          // ...
        }

        let countryCode = self.datadict!["country_code"]! as! String
        let mob = self.datadict!["mobile"]! as! String

        self.LblMobileNumber.text = countryCode + mob
        
        
        otpTextFieldView.didChangeCallback = { [weak self] pin in
            print(pin)
        }

    }
    // MARK: - Functions
    

    // MARK: - UIButton Actions
    @IBAction func BtnVerifyOTPAction(_ sender:UIButton){
        //self.WSverify_otp(Parameter: self.datadict)
        let pin = otpTextFieldView.getPin()

        guard !pin.isEmpty else {
            showAlertWithTitleFromVC(vc: self, andMessage: "핀을 입력해 주세요")
            //showAlert(title: "Error", message: "Pin entry incomplete")
            return
        }
        if(pin.length == 6){
            self.VerifyOTP(testVerificationCode: pin, verificationID: self.MyverificationID)
        }
        else{
            showAlertWithTitleFromVC(vc: self, andMessage: "핀을 입력해 주세요")
        }

//
//        /self.WSRegister(Parameter: datadict!, bank_image: self.bankimg)

        
    }
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSRegisterWithBankAndUserImage(Parameter:[String:Any],bank_image:UIImage) -> Void {
        ServiceManager.shared.callAPIWithMultipleImage(WithType: .Register, imageUpload: [self.userimg,self.bankimg], WithParams: Parameter) { (DataResponce, Status, Message) in
            if(Status == true){
                if let DataDict = DataResponce?.value(forKey: "data")  as? NSDictionary{
                    EstalimUser.shared.setData(dict: DataDict)
                    if #available(iOS 13.0, *) {
                        sceneDelegate.setHome()
                    } else {
                        appDelegate.setHome()
                    }		
                }

            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        } Failure: { (DataResponce, Status, Message) in
            
        }
}
    func VerifyOTP(testVerificationCode:String,verificationID:String){

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ,
                                                                       verificationCode: testVerificationCode)
            Auth.auth().signIn(with: credential) { authData, error in
                if ((error) != nil) {
                    print(error.debugDescription)
                    print(error?.localizedDescription)
                  // Handles error
                    self.handleError(error!)      // use the handleError method
                    return
                    //showAlertWithTitleFromVC(vc: self, andMessage: error.debugDescription)
                  //self.handleError(error)
                  return
                }
                self.WSRegister(Parameter: self.datadict!, bank_image: self.bankimg)
                let user = authData!.user
                print("user : ", authData?.user.phoneNumber)
                let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }

              
        }
    }
    func WSRegister(Parameter:[String:Any],bank_image:UIImage) -> Void {
        ServiceManager.shared.callAPIWithImage(WithType: .Register, imageUpload: bank_image, imageName: "bank_image", WithParams: Parameter) { (DataResponce, Status, Message) in
            if(Status == true){
                if let DataDict = DataResponce?.value(forKey: "data")  as? NSDictionary{
                    EstalimUser.shared.setData(dict: DataDict)
                
                if #available(iOS 13.0, *) {
                    sceneDelegate.makeLoginAsRoot()
                } else {
                    appDelegate.makeLoginAsRoot()
                }
            }
            }
            else{
                if let errorMessage:String = Message{
                    showAlertWithTitleFromVC(vc: self, andMessage: errorMessage)
                }
            }
        } Failure: { (DataResponce, Status, Message) in
            
        }
    }
    func WSverify_otp(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callAPIPost(WithType: .VerifyOTP, isAuth: true, WithParams: Parameter) { (ResponseDict, Success, Status) in
            if Success == true{
                if #available(iOS 13.0, *) {
                    sceneDelegate.setHome()
                } else {
                    appDelegate.setHome()
                }
                
            }
            
        } Failure: { (ResponseDict, Success, Status) in
            print("Failure Response:",ResponseDict)
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }

    
}
// MARK: - OTP Delegate Methods

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .invalidVerificationCode:
            return "정확하지 않는 핀입니다"
        case .invalidPhoneNumber:
            return "정확하지 않은 전화번호입니다."
        case .wrongPassword:
            return "정확하지 않는 비밀번호입니다"
        case .tooManyRequests:
            return  "요청이 거절됬습니다. 나중에 다시 시도해 주세요."
        
        case .emailAlreadyInUse:
            return "이미 등록된 이메일 입니다"
        case .userNotFound:
            return "입력한 사용자의 계정을 확인할 수 없습니다. 확인하시고 다시 시도해주세요."
        case .userDisabled:
            return "당신의 계정은 정지됬습니다. 고객센터에 문의해주세요."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "정확히지 않은 이메일입니다"
        case .networkError:
            return "네트워크 오류. 다시시도 해주세요."
        case .weakPassword:
            return "비밀번호가 약합니다. 비밀번호는 최소 6 자리여야 합니다."
        default:
            return "정확하지 않는 오류"
        }
    }
}


extension UIViewController{
    func handleError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: Constant.APP_NAME, message: errorCode.errorMessage, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

            alert.addAction(okAction)

            self.present(alert, animated: true, completion: nil)

        }
    }

}
