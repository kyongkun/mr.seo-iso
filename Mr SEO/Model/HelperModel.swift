/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class HelperModel {
    public var help_id : Int?
    public var user_id : Int?
    public var user_name : String?
    public var email : String?
    public var bank_name : String?
    public var account_number : String?
    public var proof_upload : String?
    public var status : String?
    public var thread_id : Int?
    public var proof_image : Array<Proof_image>?
    public var IsImageDisable : Bool?
    public var BtnCaseSendIsRed : Bool?
    public var BtnViewProofIsRed : Bool?
    public var BtnConfirm : Bool?
    public var BtnFinishedIsRed : Bool?


/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let helper_list = Helper.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Helper Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [HelperModel]
    {
        var models:[HelperModel] = []
        for item in array
        {
            models.append(HelperModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let helper = Helper(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Helper Instance.
*/
    required public init?(dictionary: NSDictionary) {
        IsImageDisable = true

        help_id = dictionary["help_id"] as? Int
        user_id = dictionary["user_id"] as? Int
        user_name = dictionary["user_name"] as? String
        email = dictionary["email"] as? String
        bank_name = dictionary["bank_name"] as? String
        account_number = dictionary["account_number"] as? String
        proof_upload = dictionary["proof_upload"] as? String
        status = dictionary["status"] as? String
        status = dictionary["status"] as? String
                if(status == "request_completed"){
                    BtnCaseSendIsRed = true
                    BtnViewProofIsRed = true
                    BtnFinishedIsRed = true
                    BtnConfirm = false
                }
                else if(status == "cash_sent"){
                    BtnCaseSendIsRed = false
                    BtnViewProofIsRed = true
                    BtnFinishedIsRed = true
                    BtnConfirm = false
                }
                //status == "checking_proofs" ||
                else if( status == "proofs_checked"){
                    IsImageDisable = false
                    BtnCaseSendIsRed = false
                    BtnViewProofIsRed = false
                    BtnFinishedIsRed = true
                    BtnConfirm = true
                }
                else if(status == "finished"){
                    BtnConfirm = true
                    BtnCaseSendIsRed = false
                    BtnViewProofIsRed = false
                    BtnFinishedIsRed = false
                }
                else{
                    
                }
        thread_id = dictionary["thread_id"] as? Int
        if (dictionary["proof_image"] != nil) { proof_image = Proof_image.modelsFromDictionaryArray(array: dictionary["proof_image"] as? NSArray ?? []) }
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.proof_image, forKey: "proof_image")
        dictionary.setValue(self.IsImageDisable, forKey: "IsImageDisable")
        dictionary.setValue(self.BtnConfirm, forKey: "BtnConfirm")
        dictionary.setValue(self.BtnCaseSendIsRed, forKey: "BtnCaseSendIsRed")
        dictionary.setValue(self.BtnViewProofIsRed, forKey: "BtnViewProofIsRed")
        dictionary.setValue(self.BtnFinishedIsRed, forKey: "BtnFinishedIsRed")

        
        dictionary.setValue(self.help_id, forKey: "help_id")
        dictionary.setValue(self.user_id, forKey: "user_id")
        dictionary.setValue(self.user_name, forKey: "user_name")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.bank_name, forKey: "bank_name")
        dictionary.setValue(self.account_number, forKey: "account_number")
        dictionary.setValue(self.proof_upload, forKey: "proof_upload")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.thread_id, forKey: "thread_id")

        return dictionary
    }

}
