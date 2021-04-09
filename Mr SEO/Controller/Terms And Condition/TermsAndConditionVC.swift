//
//  TermsAndConditionVC.swift
//  Mr SEO
//
//  Created by Mac on 27/02/21.
//

import UIKit
import WebKit

class TermsAndConditionVC: UIViewController  ,WKUIDelegate ,WKNavigationDelegate{
    var webView: WKWebView!
    @IBOutlet weak var wbView:UIView!

    func constrainView(view:UIView, toView contentView:UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    var tmpURL1:URL?
    var url_string = String()
    var titleString = String()
    
    let documentInteractionController = UIDocumentInteractionController()
     func load(_ request: URLRequest) -> WKNavigation? {
           guard let requestHead: NSMutableURLRequest = request as? NSMutableURLRequest else {
            return webView.load(request)
           }
        requestHead.setValue("Accept-Language", forHTTPHeaderField:EstalimUser.shared.language)
        requestHead.setValue("Accept", forHTTPHeaderField:"application/json")
        requestHead.setValue("Content-Type", forHTTPHeaderField:"application/json")
//           mutableRequest.setValue("custom value", forHTTPHeaderField: "custom field")
        return webView.load(requestHead as URLRequest)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        webView = WKWebView(frame:wbView.frame)
        wbView.addSubview(webView)
        constrainView(view: webView, toView: wbView)
        let request = URLRequest(url:URL(string:"https://www.website.com/terms-and-conditions/")!)
        webView.load(request)
        //self.WSGetTandC(Parameter: [:])
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        //webView.load(request)
        
    }
    func WSGetTandC(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .TandC, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                if let data = ResponseDict?.value(forKey: "data") as? NSDictionary{
                    if let HtmlText = data.value(forKey: "content") as? String{
                        self.webView.loadHTMLString(HtmlText, baseURL: Bundle.main.bundleURL)

                    }
                }
            }
        } Failure: { (ResponseDict, Success, Status) in
            if let message  = ResponseDict?.value(forKey: "message") as? String{
                showAlertWithTitleFromVC(vc: self, andMessage: message)
            }
        }
    }
    @IBAction func btnCloseAction(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func webViewDidStartLoad(_ webView: WKWebView) {
        self.SHOW_CUSTOM_LOADER()
     }

     func webView(_ webView: WKWebView, didFailLoadWithError error: Error)
     {
        self.HIDE_CUSTOM_LOADER()
     }

     func webViewDidFinishLoad(_ webView: WKWebView)
     {
        self.HIDE_CUSTOM_LOADER()
     }
    @IBAction func btn_For_back(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
