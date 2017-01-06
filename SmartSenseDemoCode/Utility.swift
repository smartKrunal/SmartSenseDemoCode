import UIKit
import AVFoundation

// MARK:- Extenstions

@objc
public class Utility: NSObject {
    // MARK:- Constant & Variables Declaration
    public static let alertOffset = CGFloat(UIApplication.shared.delegate!.window!!.frame.size.height)/2 * 0.7
    public static var hud:MBProgressHUD?
    public static var AutorizationToken = ""
    public static var JWT = "JWT "

    // MARK:- ProgressHUD Methods
    public static func showProgressHUDWithTitle(title: String?){
        let window:UIWindow = (UIApplication.shared.windows.last!)
        hud = MBProgressHUD.showAdded(to:(window.rootViewController!.view)!, animated: true)
        hud?.bezelView.color = UIColor.black
        hud?.mode = .indeterminate
        hud?.contentColor = UIColor.white
        hud?.label.text = title ?? "Please Wait..."
        hud?.isSquare = true
    }
    
    public static func hideProgressHUD() -> Void{
        hud?.hide(animated: true)
    }
    
    // MARK:- Toast Message
    public static func showToastMessage(_ message:String , yOffset:CGFloat?){
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.delegate!.window!!, animated:true)
        hud.bezelView.color = UIColor.black
        hud.contentColor = UIColor.white
        hud.detailsLabel.text = message
        hud.mode = MBProgressHUDMode.text
        hud.offset.y = yOffset ?? alertOffset
        hud.margin = 10
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2)
    }
    
}
