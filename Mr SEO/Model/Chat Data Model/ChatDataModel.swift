/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class ChatDataModel {
	public var id : Int?
	public var user_id : Int?
	public var friend_id : Int?
	public var post_id : Int?
	public var is_active : String?
	public var user_status : String?
	public var friend_status : String?
	public var created_at : String?
	public var updated_at : String?
	public var is_accept : String?
	public var chat_type : String?
	public var message_latest : MessageLatestModel?
	public var sender_user : SenderUserModel?
	public var receiver_user : ReceiverUserMold?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [ChatDataModel]
    {
        var models:[ChatDataModel] = []
        for item in array
        {
            models.append(ChatDataModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let data = Data(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Data Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? Int
		user_id = dictionary["user_id"] as? Int
		friend_id = dictionary["friend_id"] as? Int
		post_id = dictionary["post_id"] as? Int
		is_active = dictionary["is_active"] as? String
		user_status = dictionary["user_status"] as? String
		friend_status = dictionary["friend_status"] as? String
		created_at = dictionary["created_at"] as? String
		updated_at = dictionary["updated_at"] as? String
		is_accept = dictionary["is_accept"] as? String
		chat_type = dictionary["chat_type"] as? String
		if (dictionary["message_latest"] != nil) { message_latest = MessageLatestModel(dictionary: dictionary["message_latest"] as! NSDictionary) }
		if (dictionary["sender_user"] != nil) { sender_user = SenderUserModel(dictionary: dictionary["sender_user"] as! NSDictionary) }
		if (dictionary["receiver_user"] != nil) { receiver_user = ReceiverUserMold(dictionary: dictionary["receiver_user"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.user_id, forKey: "user_id")
		dictionary.setValue(self.friend_id, forKey: "friend_id")
		dictionary.setValue(self.post_id, forKey: "post_id")
		dictionary.setValue(self.is_active, forKey: "is_active")
		dictionary.setValue(self.user_status, forKey: "user_status")
		dictionary.setValue(self.friend_status, forKey: "friend_status")
		dictionary.setValue(self.created_at, forKey: "created_at")
		dictionary.setValue(self.updated_at, forKey: "updated_at")
		dictionary.setValue(self.is_accept, forKey: "is_accept")
		dictionary.setValue(self.chat_type, forKey: "chat_type")
		dictionary.setValue(self.message_latest?.dictionaryRepresentation(), forKey: "message_latest")
		dictionary.setValue(self.sender_user?.dictionaryRepresentation(), forKey: "sender_user")
		dictionary.setValue(self.receiver_user?.dictionaryRepresentation(), forKey: "receiver_user")

		return dictionary
	}

}
