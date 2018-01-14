# MvvmForIOS
MvvmForIOS is a lightweight framework for using Mvvm pattern on iOS. It was written in Obj-C but can be also used with Swift 4. This Frameworks doesn't include dependencies (like reactivekit/Bond/...), so the binding way is very simple by using KVO.

## How to install

###### CocoaPod
_working_
###### Carthage
_working_

## How to use it
There are two samples who explain how to implement the Framework (Obj-C and Swift).

###### AppDelegate
```Swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var service: Service?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds);
        service = Service(window: window!);
        service?.showInitialViewModel(MainViewModel.self);
        return true
    }
    ...
}
```
###### Views
```Swift
class MainView : BaseView<MainViewModel> //MainViewModel is the viewModel  {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Creating binding data between ViewModel to View (OneWay)
        self.bindProperty("helloWorld") { (data) in
            print("update helloWorld", data);
            self.label.text = data as? String;
        };
    }
    @IBAction func textFieldChange(_ sender: UITextField)
    {
        //Send to viewModel a new Value
        self.viewModel?.helloWorld = sender.text;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
```

###### ViewModels
```Swift
//objcMembers is for KVO and Selector
@objcMembers class MainViewModel: BaseViewModel<Service> //Service can also be BaseServices if you don't want to follow this way {
    
    override func start(_ parameters: NSObject?) {
        _helloWorld = service?.data.getData();
    }
    
    private var _helloWorld:String?
    //dynamic is for KVO (http://skyefreeman.io/programming/2017/06/28/kvo-in-ios11.html)
    dynamic var helloWorld:String?
    {
        get
        {
            return (_helloWorld);
        }
        set
        {
            if (_helloWorld != newValue)
            {
                _helloWorld = newValue;
                service?.data.setData(newValue: newValue);
            }
        }
    }
}
```

###### Services
```Swift
//IoC Service, there are no service locator (yet)
class Service: BaseServices {
    var data:IData!;
    
    override init(window:UIWindow) {
        super.init(window: window)
        data = Data();
    }
}
```

###### Interfaces
```Swift
protocol IData {
    func getData() -> String?;
    func setData(newValue:String?) -> Void;
}

class Data: IData {
    func getData() -> String? {
        return (MainData.getData());
    }
    
    func setData(newValue:String?) {
        MainData.setData(newValue: newValue);
    }
}
```

###### Models
```Swift
//the Model
class MainData: NSObject {
    
    static func getData() -> String? {
        return ("Hello world")
    }
    
    static func setData(newValue:String?) -> Void {
        
    }
}
```
###### Obj-C?

Look at the sample, it's just the same thing as Swift

## Navigation

#### Important ####
All navigation between *Views* are made in the ViewModels, it require some specifics naming between the View + (Storyboard) and the corresponding ViewModel.

**For the ViewModel *testViewModel*, the View _must_ be named *testView* and the storyboard must be named *test*.**

The application won't work if you do not respect this rule.

#### So how to navigate?

In the ViewModel just call :

Swift:
```Swift
//Push
    service?.showViewModel(NextViewModel.self)
    service?.showViewModel(NextViewModel.self, withParameters: nil)
//Pop
    service?.closeCurrentViewModel()
```
Obj-C
```OBJc
//Push
    [[self service]showViewModel:[NextViewModel class]];
    [[self service]showViewModel:[NextViewModel class] withParameters:nil];
//Pop
    [[self service] closeCurrentViewModel];
```






