// Блок 1. 
// ### ViewController.swift:

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let tableButton = UIButton(type: .system)
        tableButton.setTitle("Перейти на TableViewController", for: .normal)
        tableButton.addTarget(self, action: #selector(goToTableViewController), for: .touchUpInside)
        tableButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableButton)
        
        let collectionButton = UIButton(type: .system)
        collectionButton.setTitle("Перейти на CollectionViewController", for: .normal)
        collectionButton.addTarget(self, action: #selector(goToCollectionViewController), for: .touchUpInside)
        collectionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionButton)
        
        NSLayoutConstraint.activate([
            tableButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            
            collectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionButton.topAnchor.constraint(equalTo: tableButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func goToTableViewController() {
        let tableViewController = TableViewController()
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    @objc func goToCollectionViewController() {

    }
}
```

// ### TableViewController.swift:

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        return cell
    }
}

class CustomTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let circleView = UIView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        circleView.backgroundColor = .green
        circleView.layer.cornerRadius = 10
        contentView.addSubview(circleView)
        
        for i in 0..<3 {
            let rectView = UIView(frame: CGRect(x: 50, y: 10 + 30 * i, width: 100, height: 20))
            rectView.backgroundColor = .blue
            let label = UILabel(frame: rectView.bounds)
            label.text = "Text \(i+1)"
            label.textAlignment = .center
            label.textColor = .white
            rectView.addSubview(label)
            contentView.addSubview(rectView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Блок 2

// ### CollectionViewController.swift:

class CollectionViewController: UICollectionViewController {
    
    let images = ["image1", "image2", "image3", "image4", "image5", "image6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageViewController = ImageViewController()
        imageViewController.imageName = images[indexPath.item]
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}

class ImageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImageViewController: UIViewController {
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        if let imageName = imageName, let image = UIImage(named: imageName) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            view.addSubview(imageView)
        }
    }
}

@objc func goToCollectionViewController() {
    let collectionViewController = CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    navigationController?.pushViewController(collectionViewController, animated: true)
}

// Д.З.

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        return true
    }
}

// ### MainTabBarController.swift:

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendsController = FriendsViewController()
        friendsController.tabBarItem = UITabBarItem(title: "Friends", image: nil, tag: 0)
        
        let groupsController = GroupsViewController()
        groupsController.tabBarItem = UITabBarItem(title: "Groups", image: nil, tag: 1)
        
        let photosController = PhotosViewController()
        photosController.tabBarItem = UITabBarItem(title: "Photos", image: nil, tag: 2)
        
        viewControllers = [friendsController, groupsController, photosController]
    }
}

// ### FriendsViewController.swift:

class FriendsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

// ### GroupsViewController.swift:

class GroupsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

// ### PhotosViewController.swift:

class PhotosViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

// ### SignInViewController.swift:

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let signInButton = UIButton(type: .system)
        signInButton.setTitle("Войти", for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func signInButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let tabBarController = appDelegate.window?.rootViewController as? MainTabBarController {
            tabBarController.selectedIndex = 0 // Переход к первой вкладке
        }
    }
}