//
//  Network.swift
//  CheckInternetConnection
//
//  Created by Eslam Ali  on 31/03/2022.
//

import Foundation
import Network


// don't forget to mention startMonitoring in AppDelegate


final class NetworkMonitor {
    
    static let shared  =  NetworkMonitor()
    // to check the internet conection every time it changes
    // global to set it into background thread
    private let queue =  DispatchQueue.global()
   
    private let monitor : NWPathMonitor
    
    // everyone can read but can not change
    public private(set) var isConnected : Bool =  false
    
    // to know connection type

    public private(set) var connectionType : ConnectionType = .unknow
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknow
    }
    
    
    
    private init () {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring () {
        // to chack the conncetion everytime it changes
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self ] path in
            self?.isConnected = path.status != .unsatisfied  //  true of connected successfully
           // to know connection type if the internet connected
            self?.getConnectionType(path: path)
        }
    }
// stop monitoring
    public func stopMonitoring () {
        monitor.cancel()
    }
// to know connction type if the internet connected
    private func getConnectionType (path : NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else  {
            connectionType = .unknow
        }
    }
    
    
}
