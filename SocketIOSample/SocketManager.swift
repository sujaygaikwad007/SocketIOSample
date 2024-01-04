import Foundation
import SocketIO

class SocketHandler: NSObject {
    static let sharedInstance = SocketHandler()
    //http://localhost:3000
    
    let socket = SocketManager(socketURL: URL(string: "http://13.234.77.6:5000/")!, config: [.log(true), .compress])
    var mSocket: SocketIOClient!

    override init() {
        super.init()
        mSocket = socket.defaultSocket
    }

    func getSocket() -> SocketIOClient {
        return mSocket
    }

    func establishConnection() {
        mSocket.connect()
    }

    func closeConnection() {
        mSocket.disconnect()
    }

    func sendMessage(message: String) {
        mSocket.emit("chatMessage", message)
    }
}
