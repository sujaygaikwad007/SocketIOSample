import UIKit

class ViewController: UIViewController {

    var mSocket = SocketHandler.sharedInstance.getSocket()
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldMessage: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        messageConnection()
        
    }
    
    func messageConnection()
    {
        SocketHandler.sharedInstance.establishConnection()
        mSocket.on("serverMessage") { (dataArray, ack) -> Void in
            let serverMessage = dataArray[0] as! String
            print("Server says: \(serverMessage)")
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
}
