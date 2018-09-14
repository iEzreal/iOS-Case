#### Runloop概念
* 运行循环（死循环）

#### Runloop作用
* 保持程序的持续运行
* 处理app中的各种事件
* 节省CPU资源，提升性能

#### Runloop对象和线程
* 每条线程都有唯一的一个与之对应的Runloop对象
* 主线程的Runloop已经自动创建好了，子线程的Runloop需要主动创建
* Runloop在第一次获取时创建，在线程结束时销毁

#### Runloop对象获取
* Foundation

		[NSRunLoop currentRunLoop]; // 获取当前对象的Runloop对象
   		[NSRunLoop mainRunLoop]; // 获取主线程的Runloop对象

* Core Foundation

		CFRunLoopGetCurrent(); // 获取当前对象的Runloop对象
   		CFRunLoopGetMain(); // 获取主线程的Runloop对象


#### CFRunLoopModeRef（Runloop运行模式）
> * 一个Runloop包含若干个Mode，每个mode有包含若干个Source/Timer/Observer。
> 
> * 每次Runloop启动时，只能指定其中一个Mode，这个Mode被称作CurrentMode。
> 
> * 如果需要切换Mode，只能退出Loop，在重新指定一个Mode进入。这样做主要是为了分隔不同组Source/Timer/Observer，让其互不影响。
> ![Runloop](/Users/Ezreal/Workspace/iOS/iOS-Case/iOS-Runloop/iOS-Runloop/runloop.jpg)

#### 系统默认注册5个Mode
* kCFRunLoopDefaultMode：APP的默认Mode，通常主线程是在这个Mode下运行
* UITrackingRunLoopMode：界面跟踪Mode，用于ScrollView追踪触摸滑动，保证界面滑动时不受其他Mode影响
* UIInitializationRunLoopMode：在APP启动时进入的第一个Mode，启动完成后就不在使用了
* GSEventReceiveRunLoopMode：接受系统事件的内部Mode，通常用不到
* kCFRunLoopCommonModes：这是一个占位用的Mode，不是一种真正的Mode

#### CFRunLoopTimerRef
* 基于时间的触发器
* 基本上说的就是NSTimer

#### CFRunLoopSourceRef
* 事件源（输入源）
* Source0：非基于port的 用户事件
* Source1：基于port的 系统事件





