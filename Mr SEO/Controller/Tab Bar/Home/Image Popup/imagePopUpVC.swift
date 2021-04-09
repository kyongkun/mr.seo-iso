//
//  imagePopUpVC.swift
//  Mr SEO
//
//  Created by Mac on 03/04/21.
//

import UIKit
import SDWebImage
class imagePopUpVC: UIViewController
{
    // MARK: - UIControlers Outlate
    
    // MARK: - Variables
    @IBOutlet weak var ImgPopup:UIImageView!
    
    // MARK: - UIControler Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ImgPopup.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        self.ImgPopup.sd_setImage(with: URL(string:EstalimUser.shared.set_image), placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
    }
    // MARK: - Functions
    // MARK: - UIButton Actions
    @IBAction func BtnBackAction(_ sender:UIButton){
        self.dismiss(animated: true, completion: {
            EstalimUser.shared.set_image = ""
            EstalimUser.shared.save()
        })
    }
    // MARK: - UITableView Delegate Methods
    // MARK: - UICollectionView Delegate Methods
    // MARK: - WEB API Methods
    
}
