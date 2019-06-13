//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Frank Chen on 2019-06-13.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var foods = [Food]()
  var navHeightConstraint: NSLayoutConstraint!
  var titleHeightConstraint: NSLayoutConstraint!
  
  let navView: UIView = {
    let v = UIView()
    v.backgroundColor = UIColor(hexString: "#DDDDDD")
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "SNACKS"
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var navButton: UIButton = {
    let b = UIButton()
    b.setTitle("＋", for: .normal)
    b.setTitleColor(.blue, for: .normal)
    b.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    b.translatesAutoresizingMaskIntoConstraints = false
    b.addTarget(self, action: #selector(navButtonTapped), for: .touchUpInside)
    return b
  }()
  
  lazy var imageView1 : UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "oreos")
    iv.tag = 1
    iv.isUserInteractionEnabled = true
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  lazy var imageView2 : UIImageView = {
    let iv = UIImageView()
    iv.tag = 2
    iv.isUserInteractionEnabled = true
    iv.image = UIImage(named: "pizza_pockets")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  lazy var imageView3 : UIImageView = {
    let iv = UIImageView()
    iv.tag = 3
    iv.isUserInteractionEnabled = true
    iv.image = UIImage(named: "pop_tarts")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  lazy var imageView4 : UIImageView = {
    let iv = UIImageView()
    iv.tag = 4
    iv.isUserInteractionEnabled = true
    iv.image = UIImage(named: "popsicle")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  lazy var imageView5 : UIImageView = {
    let iv = UIImageView()
    iv.tag = 5
    iv.isUserInteractionEnabled = true
    iv.image = UIImage(named: "ramen")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  lazy var stackView : UIStackView = {
    let sv = UIStackView()
    sv.distribution = .fillEqually
    sv.axis = .horizontal
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.isUserInteractionEnabled = true
    return sv
  }()
  
  lazy var tableView : UITableView = {
    let tb = UITableView()
    tb.delegate = self
    tb.dataSource = self
    tb.translatesAutoresizingMaskIntoConstraints = false
    return tb
  }()
  
  lazy var tapGesture: UITapGestureRecognizer = {
    let g = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
    return g
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(hexString: "#DDDDDD")
    setupView()
  }
  
  func setupView(){
    self.view.addSubview(tableView)
    self.view.addSubview(navView)
    self.navView.addSubview(navButton)
    self.navView.addSubview(titleLabel)
    self.stackView.addArrangedSubview(imageView1)
    self.stackView.addArrangedSubview(imageView2)
    self.stackView.addArrangedSubview(imageView3)
    self.stackView.addArrangedSubview(imageView4)
    self.stackView.addArrangedSubview(imageView5)
    self.navView.addSubview(stackView)
    self.stackView.addGestureRecognizer(tapGesture)
    stackView.isHidden = true
    
    navHeightConstraint = navView.heightAnchor.constraint(equalToConstant: 44)
    titleHeightConstraint = titleLabel.topAnchor.constraint(equalTo: self.navView.topAnchor)
    NSLayoutConstraint.activate([
      navView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
      navView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      navView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      navHeightConstraint,
      
      navButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 4),
      navButton.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -4),
      navButton.heightAnchor.constraint(equalToConstant: 44),
      
      stackView.topAnchor.constraint(equalTo: navView.topAnchor, constant: 30),
      stackView.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: 0),
      stackView.bottomAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0),
      
      tableView.topAnchor.constraint(equalTo: self.navView.bottomAnchor, constant: 0),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
      
     
      titleLabel.leadingAnchor.constraint(equalTo: self.navView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: self.navView.trailingAnchor),
      titleHeightConstraint,
      titleLabel.heightAnchor.constraint(equalToConstant: 14)
      ])
  }
  
  @objc func navButtonTapped(){
    print(navHeightConstraint.constant)
    if navHeightConstraint.constant == 44{
      stackView.isHidden = false
      navHeightConstraint.constant = 200
      titleHeightConstraint.constant = 60
      titleLabel.text = "Add a snack"
    }else if navHeightConstraint.constant == 200{
      stackView.isHidden = true
      navHeightConstraint.constant = 44
      titleHeightConstraint.constant = 0
      titleLabel.text = "SNACKS"
    }
    
    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
      if self.navHeightConstraint.constant == 44{
        self.navButton.transform = CGAffineTransform.identity
      }else{
        self.navButton.transform = self.navButton.transform.rotated(by: CGFloat.pi/4)
      }
      self.view.layoutIfNeeded()
    }) { (_) in
    }
  }
  
  @objc func viewTapped(sender: UITapGestureRecognizer){
    let location = sender.location(in: stackView)
    let imageView = stackView.hitTest(location, with: UIEvent())
    guard let iv = imageView else{return}
    switch iv.tag {
    case 1:
      let food = Food(name: "oreo")
      foods.append(food)
      tableView.insertRows(at: [IndexPath(row: foods.count - 1, section: 0)], with: .left)
    case 2:
      let food = Food(name: "pizza_pockets")
      foods.append(food)
      tableView.insertRows(at: [IndexPath(row: foods.count - 1, section: 0)], with: .left)
    case 3:
      let food = Food(name: "tarts")
      foods.append(food)
      tableView.insertRows(at: [IndexPath(row: foods.count - 1, section: 0)], with: .left)
    case 4:
      let food = Food(name: "popsicle")
      foods.append(food)
     tableView.insertRows(at: [IndexPath(row: foods.count - 1, section: 0)], with: .left)
    case 5:
      let food = Food(name: "ramen")
      foods.append(food)
      tableView.insertRows(at: [IndexPath(row: foods.count - 1, section: 0)], with: .left)
    default:
      return
    }
  }
  
}

extension UIColor {
  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)
    if (hexString.hasPrefix("#")) {
      scanner.scanLocation = 1
    }
    var color: UInt32 = 0
    scanner.scanHexInt32(&color)
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0
    self.init(red:red, green:green, blue:blue, alpha:alpha)
  }
  func toHexString() -> String {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
    return String(format:"#%06x", rgb)
  }
}

extension UIApplication {
  var statusBarView: UIView? {
    if responds(to: Selector(("statusBar"))) {
      return value(forKey: "statusBar") as? UIView
    }
    return nil
  }
}

extension ViewController:UITableViewDelegate{
  
}

extension ViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return foods.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
      }
      return cell
    }()
    let food = foods[indexPath.row]
    cell.textLabel?.text = food.name
    return cell
  }
  
  
}


