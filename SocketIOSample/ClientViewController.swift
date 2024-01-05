import UIKit
import SocketIO

class ClientViewController: UIViewController{
    
    var mSocket = SocketHandler.sharedInstance.getSocket()
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldMessage: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageConnection()
        
        SocketHandler.sharedInstance.delegate = self
        
    }
    
    func messageConnection()
    {
        SocketHandler.sharedInstance.establishConnection()
        mSocket.on("serverMessage") { (dataArray, ack) -> Void in
            let serverMessage = dataArray[0] as! String
            print("Server says: \(serverMessage)")
            
            self.didReceiveServerMessage(serverMessage)
        }
        
        mSocket.on("chatMessage") { (dataArray, ack) -> Void in
            let messageReceived = dataArray[0] as! String
            print("Received message: \(messageReceived)")
            self.labelMessage.text = messageReceived
        }
    }
    
    @IBAction func btnSendMessage(_ sender: Any) {
        if let message = textFieldMessage.text, !message.isEmpty {
            SocketHandler.sharedInstance.sendMessage(message: message)
            textFieldMessage.text = ""
        }
    }
    
    
    @IBAction func serverBtn(_ sender: UIButton) {
        let serverVC = storyboard?.instantiateViewController(withIdentifier: "ServerViewController") as! ServerViewController
        self.navigationController?.pushViewController(serverVC, animated: true)
    }
    
}

extension ClientViewController: SocketHandlerDelegate{
    func didReceiveServerMessage(_ message: String) {
        print("Received server message on another view controller:\(message)")
        
    }
    
    
}
