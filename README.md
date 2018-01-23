# MvvmForIOS
MvvmForIOS is a lightweight framework for using Mvvm pattern on iOS. It was written in Obj-C but can be also used with Swift 4. This Frameworks doesn't include dependencies (like reactivekit/Bond/...), so the binding way is very simple by using KVO.
Also I'm using generics for linking the type of ViewModel to the View.

This tool is fully compatible with ObjC and swift 4, which means sometimes you need to use @objc keywords, also you can have some limitation about Swift Type or declaration.

## How to install

##### 1 - CocoaPod

Create a podfile

pod 'MvvmForIOS'

Don't forget to add a Bridging Header with inside

\#import <MvvmForIOS/MvvmForIOS.h>

##### 2 - Carthage
github "frankois944/MvvmForIOS"

## Release Note

### 0.1
First implementation
### 0.2
Add Modal navigation

Add callback navigation completion

Updating Sample with new features

### 0.3
Add Service Locator
## How to use it
There are two samples who explain how to implement the Framework (Obj-C and Swift).

###### AppDelegate
```Swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var service: BaseServices?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after 
        application launch.

        //Service Locator (saving)
        Locator.save(Data());

        window = UIWindow(frame: UIScreen.main.bounds);
        service = BaseServices(window: window!);
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
        //Creating binding data from ViewModel to View (OneWay)
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
//you can remove @objcMembers and place @objc at the attribute you want to bind
@objcMembers class MainViewModel: BaseViewModel<BaseServices> //Service can also be BaseServices if you don't want to follow this way {
    
    //The viewModel is ready to use
    override func start(_ parameters: NSObject?) {
        //Service Locator (getting)
        _helloWorld = (Locator.get(IData.self) as! IData).getData();
    }
    
    private var _helloWorld:String?
    //dynamic is for KVO (http://skyefreeman.io/programming/2017/06/28/kvo-in-ios11.html)
    //it requires @objc or @objcMembers
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
                //Service Locator (getting)
                (Locator.get(IData.self) as! IData).setData(newValue: newValue);
            }
        }
    }
}
```

###### Interfaces
```Swift
//@objc is for Service Locator
@objc protocol IData {
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

## Binding

Currently, the Framework is using KVO.

###### View
Swift
```Swift
//From ViewModel to View
self.bindProperty("helloWorld") { (data) in
};

//From View to ViewModel
self.viewModel?.helloWorld = ...;

```
Obj-C
```OBJc
//From ViewModel to View
[self bindProperty:@"helloWorld" onUpdate:^(NSString  * _Nonnull value) {
}];
//From View to ViewModel
[[self viewModel] setHelloWorld:...];

```

###### ViewModel
Swift
```Swift
private var _helloWorld:String?
//@objc or @objcMembers + dynamic are mandatory for KVO in swift 4
@objc dynamic var helloWorld:String?
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
        }
    }
}
```
Obj-C
```OBJc
@property (strong, nonatomic, nullable) NSString *helloWorld;
@dynamic helloWorld;

- (NSString *)helloWorld
{
    return (_helloWorld);
}

- (void)setHelloWorld:(NSString *)newValue
{
    if (![_helloWorld isEqualToString:newValue])
    {
        _helloWorld = newValue;
    }
}
```

## Service Locator (0.3)
There is an optionnal service locator which can be used for using IoC.
For now, we're using Protocol for matching the model and the interface, so the service class must implement the protocol.

Swift
```Swift
//interface
//@objc is mandatory
@objc protocol IData {
    func getData() -> String?;
    func setData(newValue:String?) -> Void;
    func helloWorld() -> String;
}
//store
Locator.save(Data());
//retrieve
(Locator.get(IData.self) as! IData)
```

Obj-C
```OBJc
@protocol IData <NSObject>

- (nullable NSString *)getData;
- (void)setData:(nullable NSString *)newData;

@end

//store
[Locator save:[Data new]];
//retrieve
[Locator get:@protocol(IData)] 
```

## Navigation

#### Important ####
All navigation between *Views* are made in the ViewModels, it requires some specifics naming between the *View* + (Storyboard) and the corresponding *ViewModel*.

**For the ViewModel *testViewModel*, the View _must_ be named *testView* and the storyboard must be named *test*.**

The application won't work if you do not respect this rule.

#### So how to navigate?

In the ViewModel just call :

Swift
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

## TO-DO

- [x] Implement ModalView in navigation
- [x] Add callback navigation completion
- [x] Service Locator (removing ViewModel dependencies)
- [ ] Navigation customisation
- [ ] Better binding
- [ ] And More ...




