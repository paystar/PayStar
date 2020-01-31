  
  
//
//  let arrayCustomersDetail = []
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    [...]
//    if let customerDetail = selectedBiller?.bcustomerparms[indexPath.row] {
//        arrayCustomersDetail.append(customerDetail)
//        alertParam = customerDetail.paramName
//        [...]
//    }
//    [...]
//  }
//  And when you click the button, you iterate the array and print out every value.
//
//  @objc func buttonClicked(sender: UIButton) {
//    arrayCustomersDetail.forEach {
//        // Print your stuff
//        print("Param name: \($0.paramName), minLength: \($0.minLenght)")
//    }
//  }

  
  /*
  override func viewDidLoad(){
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }

  //MARK: Methods to manage keybaord
  @objc func keyboardDidShow(notification: NSNotification) {
      var info = notification.userInfo
      let keyBoardSize = info![UIKeyboardFrameEndUserInfoKey] as! CGRect
      scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyBoardSize.height, 0.0)
      scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, keyBoardSize.height, 0.0)
  }

  @objc func keyboardDidHide(notification: NSNotification) {
      scrollView.contentInset = UIEdgeInsets.zero
      scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
  }
*/

  
  


  
