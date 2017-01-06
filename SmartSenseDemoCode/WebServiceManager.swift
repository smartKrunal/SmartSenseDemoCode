@objc
public class WebServiceManager: AFHTTPSessionManager {
    
    public var hud:MBProgressHUD?
    public static var instance : WebServiceManager?
    
    public typealias ServiceResponse = (Error? , AnyObject?) -> Void
    
    public static func getInstance() -> WebServiceManager {
        if (instance == nil) {
            instance = WebServiceManager()
        }
        return instance!;
    }
    
    // Get Request
    public func getRequest (_ method : String , withParameters  params: Dictionary<String, Any>?? , andCallback callback :@escaping ServiceResponse  , shallCalllbackInFailure failureCall: Bool){
        responseSerializer = AFJSONResponseSerializer()

        
        Utility.showProgressHUDWithTitle(title: nil)
        self.get(method, parameters: params, progress: { (progress) in
            print("Progress----------------->", progress)
            }, success: { (sessionTask , response ) in
                Utility.hideProgressHUD()
                print("Response----------------->", response)
                callback(nil, response as AnyObject?)
        }) { (sessionTask, error) in
            Utility.hideProgressHUD()
            Utility.showToastMessage(error.localizedDescription, yOffset: nil)
            print("Error----------------->", error)
            callback(error as Error?, nil)
        }
    }
    
    // Post Request
    public func postRequest (_ method : String , withParameters  params: Dictionary<String, Any>? , andCallback callback :@escaping ServiceResponse  , shallCalllbackInFailure failureCall: Bool){
        responseSerializer = AFJSONResponseSerializer()
        if Utility.AutorizationToken != ""{
            requestSerializer = AFJSONRequestSerializer()
            requestSerializer.setValue(Utility.JWT + Utility.AutorizationToken, forHTTPHeaderField: "Authorization")
        }
        Utility.showProgressHUDWithTitle(title: nil)
        post(method, parameters: params, progress: { (progress) in
            print("Progress----------------->", progress)
            }, success: { (sessionTask, response) in
                Utility.hideProgressHUD()
                print("Response----------------->", response)
                callback(nil, response as AnyObject?)
        }) { (sessionTask, error) in
            Utility.hideProgressHUD()
            Utility.showToastMessage(error.localizedDescription, yOffset: nil)
            print("Error----------------->", error)
            callback(error as Error?, nil)
        }
    }
    
    // Delete Request
    public func deleteRequest (_ method : String , withParameters  params: Dictionary<String,Any>? , andCallback callback :@escaping ServiceResponse  , shallCalllbackInFailure failureCall: Bool){
        responseSerializer = AFJSONResponseSerializer()
        requestSerializer = AFHTTPRequestSerializer()
        requestSerializer.setValue(Utility.JWT + Utility.AutorizationToken, forHTTPHeaderField: "Authorization")

        Utility.showProgressHUDWithTitle(title: nil)
        self.delete(method, parameters: params, success: { (sessionTask, response) in
            Utility.hideProgressHUD()
            print("Response----------------->", response)
            callback(nil, response as AnyObject?)
            }) { (sessionTask, error) in
                Utility.hideProgressHUD()
                Utility.showToastMessage(error.localizedDescription, yOffset: nil)
                print("Error----------------->", error)
                callback(error as Error?, nil)
        }
    }

    // Put Request
    public func putRequest (_ method : String , withParameters  params: Dictionary<String,Any>? , andCallback callback :@escaping ServiceResponse  , shallCalllbackInFailure failureCall: Bool){
        responseSerializer = AFJSONResponseSerializer()
        requestSerializer = AFJSONRequestSerializer()
        requestSerializer.setValue(Utility.JWT + Utility.AutorizationToken, forHTTPHeaderField: "Authorization")

        Utility.showProgressHUDWithTitle(title: nil)
        put(method, parameters: params, success: { (sessionTask, response) in
            Utility.hideProgressHUD()
            print("Response----------------->", response)
            callback(nil, response as AnyObject?)
        }) { (sessionTask, error) in
            Utility.hideProgressHUD()
            Utility.showToastMessage(error.localizedDescription, yOffset: nil)
            print("Error----------------->", error)
            callback(error as Error?, nil)
        }
    }
    
    public func putMultipartRequest (_ method : String , withParameters  params: Dictionary<String,Any>? , ImageData multipartData : Data , andCallback callback :@escaping ServiceResponse  , shallCalllbackInFailure failureCall: Bool){
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFHTTPRequestSerializer()
        requestSerializer.setValue(Utility.JWT + Utility.AutorizationToken, forHTTPHeaderField: "Authorization")

        Utility.showProgressHUDWithTitle(title: nil)
        let request = self.requestSerializer.multipartFormRequest(withMethod: "PUT", urlString: method, parameters: nil, constructingBodyWith: { (data) in
            data.appendPart(withFileData: multipartData, name: "userProfilePicture", fileName: "jpg", mimeType: "image/jpeg")
        }, error: ErrorPointer.none)
        
        let uploadTask = self.uploadTask(withStreamedRequest: request as URLRequest, progress: { (progress) in
            print("Progress----------------->", progress)
            }) { (response, responseObject, error) in
                Utility.hideProgressHUD()
                if((error == nil)) {
                    print(responseObject)
                    callback(nil, responseObject as AnyObject?)
                } else {
                    print(error)
                    callback(error as Error?, nil)
                }
        }
        uploadTask.resume()
    }
    
 
}
