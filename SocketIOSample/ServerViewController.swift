import UIKit
import SocketIO

class ServerViewController: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    var mSocket = SocketHandler.sharedInstance.getSocket()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SocketHandler.sharedInstance.delegate = self
        messageConnection()
    }
    
    
    func messageConnection() {
            SocketHandler.sharedInstance.establishConnection()
            mSocket.on("serverMessage") { (dataArray, ack) -> Void in
                let serverMessage = dataArray[0] as! String
                print("Server says: \(serverMessage)")
                
                self.didReceiveServerMessage(serverMessage)
            }
            
            mSocket.on("chatMessage") { (dataArray, ack) -> Void in
                let messageReceived = dataArray[0] as! String
                print("Received message: \(messageReceived)")
                self.lblMessage.text = messageReceived
            }
        }
       
}

extension ServerViewController: SocketHandlerDelegate{
    func didReceiveServerMessage(_ message: String) {
        print("Received server message on this view controller: \(message)")
        lblMessage.text = message
    }
}
