## DBSwift
用swift4.0模仿斗鱼直播，支持iOS 9.0以上系统

### 项目简介
####1、技术点
+ swift4.0 + HandyJSON + Alamofire + Kingfisher
+ MVVM设计模式
+ CocoaPods

####2、功能点
+ 无限循环轮播图
+ 首页推荐界面

### swift使用心得
#### 1、模型转化

+ 在swift4.0中引入了Codable协议，可以让你在不添加其他特殊代码的情况下序列化和反序列化自定义的数据类型。但是经过测试，如果服务端返回的实体字段和本地模型数据不一致，会导致序列化失败。使用Codable协议只能对模型字段与待序列化的字段一致的情况。因此，最终还是选择了HandyJSON进行数据模型转换
+ 继承HandyJSON的类，无法进行数据监测，didSet等方法不会执行。只能通过HandyJSON提供的 `didFinishMapping()`进行处理
+ HandyJSON会有内存泄漏，解决方案: <https://github.com/alibaba/HandyJSON/issues/199>

#### 2、权限访问
在Swift语言中，目前有五种修饰符，分别为fileprivate，private，internal，public，open

```
* private修饰的属性或者方法只能在当前类里面访问
* fileprivate访问级别所修饰的属性或者方法在当前的Swift源文件里可以访问
* internal访问级别所修饰的属性或方法在源代码所在的整个模块都可以访问
* public可以被任何人访问，但是在其他module中不可以被重写和继承，而在本module中可以重写和继承
* open可以任何人使用，包括重写和继承
```
但在开发过程，如果在一个common.swift类中定义了一个常量，而其他类如果要使用该常量，需要在该常量前面添加public。另外，对于同一源文件中的extension，即可以访问private修饰的变量，也可以访问fileprivate修饰的变量

