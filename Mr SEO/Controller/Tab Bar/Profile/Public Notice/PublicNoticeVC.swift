//
//  PublicNoticeVC.swift
//  Mr SEO
//
//  Created by Mac on 20/03/21.
//

import UIKit
import SDWebImage

class PublicNoticeVC: UIViewController
{
    // MARK: - UIControlers Outlate
    @IBOutlet weak var TblNotice:UITableView!
    var arrNoticeBoard = [NoticeBoardModel]()
    // MARK: - Variables
    @IBOutlet weak var LblNavigationTitle: EMLabel!{
        didSet{
            LblNavigationTitle.fontStyle = .Navigation
        }
    }
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TblNotice.setDefaultProperties(vc: self)
        self.TblNotice.registerCell(type: NoticeRow.self)
        self.TblNotice.register(NoticeHeader.self, forHeaderFooterViewReuseIdentifier: "NoticeHeader")
        self.TblNotice.register(UINib(nibName: "NoticeHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "NoticeHeader")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.WSGetNotice(Parameter: [:])
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    func WSGetNotice(Parameter:[String:Any]) -> Void {
        ServiceManager.shared.callGetAPI(WithType: .GetNotice, isAuth: true, passString: "", WithParams: [:]) { (ResponseDict, Success, Status) in
            if Success == true{
                if let CountryList = ResponseDict?.value(forKey: "data") as? NSArray{
                    self.arrNoticeBoard.removeAll()
                    self.arrNoticeBoard = NoticeBoardModel.modelsFromDictionaryArray(array: CountryList)
                    if(self.arrNoticeBoard.count>0)
                    {
                        self.TblNotice.setEmptyMessage("")
                        self.TblNotice.reloadData()
                    }
                    else{
                        self.TblNotice.setEmptyMessage("No Data Found!")
                    }
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
extension PublicNoticeVC:UITableViewDataSource,UITableViewDelegate{
    @objc func toggleCollapse(sender: UIButton) {
      let section = sender.tag
      let collapsed = arrNoticeBoard[section].collapsed

      // Toggle collapse
        self.arrNoticeBoard[section].collapsed = !collapsed!

      // Reload section
        self.TblNotice.beginUpdates()
        self.TblNotice.reloadRows(at: [IndexPath(row: section, section: 0)], with: .fade)
        self.TblNotice.endUpdates()
    }

    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.000001;
    }

     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView(tableView: tableView, willDisplayCell: cell as! NoticeRow, forRowAtIndexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNoticeBoard.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
                withType: NoticeRow.self,
                for: indexPath) as? NoticeRow else {
            return UITableViewCell()
        }
        cell.toggleButton.tag = indexPath.row
        cell.toggleButton.addTarget(self, action: #selector(self.toggleCollapse(sender:)), for: .touchUpInside)
        
        if(self.arrNoticeBoard[indexPath.row].collapsed == false){
            
        UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveLinear, animations: {
            cell.toggleButton.transform = cell.toggleButton.transform.rotated(by: CGFloat(M_PI))
        })
        }
        else{
            UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveLinear, animations: {
                cell.toggleButton.transform = .identity
            })
        }
        cell.LblDescription.isHidden = self.arrNoticeBoard[indexPath.row].collapsed!
        cell.ImgProduct.isHidden = self.arrNoticeBoard[indexPath.row].collapsed!
        cell.LblDescription.text = self.arrNoticeBoard[indexPath.row].description
        cell.LblTIme.text = self.arrNoticeBoard[indexPath.row].created_at?.toDate(withFormat: "dd-MM-yyyy HH:mm:ss")?.getDateinMyFormat()
        cell.LblTitle.text = self.arrNoticeBoard[indexPath.row].title
        cell.ImgProduct.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.ImgProduct.sd_setImage(with: URL(string:self.arrNoticeBoard[indexPath.row].image ?? ""), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
        cell.layoutIfNeeded()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
