#### Runloop概念
* 运行循环（死循环）

#### Runloop作用
* 保持程序的持续运行
* 处理app中的各种事件
* 节省CPU资源，提升性能

#### Runloop处理逻辑图

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

#### RunLoop内部自动释放池
* 自动释放池第一次常见：当runloop启动的时候
* 自动释放池最后一次销毁：当runloop退出的时候
* 自动释放池其它时间的创建和销毁：当runloop即将休眠时销毁之前的自动释放池，创建新的释放池

#### RunLoop应用
* performSelector 受RunLoop运行模式影响
* 线程任务


#### RunLoop常见面试题
* 什么是Runloop?
	* 从字面意思来看：运行循环
	* 其实它内部是do-while循环，在这个循环内不断地处理各种任务（比如Source、Timer、Observer）
	* 一线线程对应一个Runloop，主线程Runloop默认UI经启动，子线程的Runloop需要手动启动（调用run方法）
	* Runloop只能选择一个Mode启动，如果当前Mode中没有Source(Sources0、Sources0)、Timer，那么就直接退出Runloop
	
* 自动释放池什么时候释放？
	* 通过Observer监听Runloop的状态
	
* 在开发中如何使用Runloop？什么应用场景？
	* 开启一个常驻线程（让一个子线程不进入消亡状态，等待其他线程发来消息，处理其他事件）
	* 在子线程中开启一个定时器
	* 在子线程中进行一些长期监控
	* 可以监控定时器在特定模式下执行
	* 可以让某些事件(行为、任务)在特定模式下执行
	* 可以添加Observer监听Runloop的状态，比如监听点击事件的处理(在点击之前做一些事情)



