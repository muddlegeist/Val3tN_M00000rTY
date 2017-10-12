import Foundation
import Valet

class SecureData
{
    static let kString1Key = "kString1Key"
    static let kString2Key = "kString2Key"
    
    private static var internalShared: SecureEnclaveValet?
    static var shared : SecureEnclaveValet?
    {
        get
        {
            if internalShared == nil
            {
                if let identifier = Identifier(nonEmpty: "secure_valet")
                {
                    internalShared = SecureEnclaveValet.valet(with: identifier, accessControl: .userPresence)
                }
            }
            
            return internalShared
        }
    }
    
    static func storeMyStrings(string1:String, string2:String) -> Bool
    {
        var storeOk = true
        
        if SecureData.shared?.canAccessKeychain() ?? false
        {
           
            let string1Set = SecureData.shared?.set(string:string1, for: kString1Key) ?? false
            let string2Set = SecureData.shared?.set(string:string2, for: kString2Key) ?? false
            
            
            if !string1Set
            {
                print("FAILED TO SET STRING1 TOKEN")
                storeOk = false
            }
            
            if !string2Set
            {
                print("FAILED TO SET STRING2 TOKEN")
                storeOk = false
            }
        }
        else
        {
            print("CANNOT ACCESS KEYCHAIN")
            storeOk = false
        }
        
        return storeOk
    }
    
    static func getMyString1() -> String?
    {
        var string1:String? = nil
        
        if let string1Result = SecureData.shared?.string(for: kString1Key, withPrompt:"Because.")
        {
            switch string1Result
            {
            case let .success(value):
                string1 = value
                
            default:
                break;
            }
        }
        
        return string1
    }
    
    static func getMyString2() -> String?
    {
        var string2:String? = nil
        
        if let string2Result = SecureData.shared?.string(for: kString2Key, withPrompt:"Because.")
        {
            switch string2Result
            {
            case let .success(value):
                string2 = value
                
            default:
                break;
            }
        }
        
        return string2
    }
    
    static func containsMyStrings() -> Bool
    {
        var contains = false
        
        let containsString1 = SecureData.shared?.containsObject(for: kString1Key) ?? false
        let containsString2 = SecureData.shared?.containsObject(for: kString2Key) ?? false
        
        if containsString1 && containsString2
        {
            contains = true
        }
        
        print("MY STRINGS: CONTAINS = \(contains)")
        
        return contains
    }
    
    static func clearMyStrings()
    {
        SecureData.shared?.removeObject(for: kString1Key)
        SecureData.shared?.removeObject(for: kString2Key)
    }
}

