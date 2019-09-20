

import Foundation

func getServiceCall(){
    
    let urlStr = ""
    let url = URL(string: urlStr)
    URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
        
        guard let respData = data else {
            return
        }
        guard error == nil else {
            print("error")
            return
        }
        do{
            DispatchQueue.main.async {
                //activityIndicator.startAnimating()
            }
            let jsonObj = try JSONSerialization.jsonObject(with: respData, options: .allowFragments) as! [String: Any]
            print("the  json is \(jsonObj)")
            
            DispatchQueue.main.async {
            }
        }
        catch {
            print("catch error")
        }
        DispatchQueue.main.async {
            //activityIndicator.stopAnimating()
        }
    }).resume()
}

func postServiceCall(){
    
    print("register tapped")
    
    let parameters = [] as? [String : Any]
    
    let url = URL(string: "")
    var req =  URLRequest(url: url!)
    req.httpMethod = "POST"
    req.addValue("application/json", forHTTPHeaderField: "Contet-Type")
    req.addValue("application/json", forHTTPHeaderField: "Accept")
    
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {return}
    req.httpBody = httpBody
    
    let session = URLSession.shared
    
    session.dataTask(with: req, completionHandler: {(data, response, error) in
        if let response = response {
            // print(response)
        }
        if let data = data {
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                print("the json  \(json)")
                
                DispatchQueue.main.async {
                }
                
            }catch{
                print("error")
            }
        }
    }).resume()
}
