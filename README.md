# iOS-ToolClassDemo
###开发工具类(可以直接取出工程目录***[tool](https://github.com/VolientDuan/iOS-ToolClassDemo/tree/master/testToolDemo/testToolDemo/tool)***文件下的类使用)
#####宏定义的使用

######一、pch文件中宏的使用

1.屏幕的宽度和高度

	#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
	#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

2.16进制颜色转换

	#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
3.自定义log

	#define DEBUGGER 1 //上线版本屏蔽此宏
	
	#ifdef DEBUGGER
	/* 自定义log 可以输出所在的类名,方法名,位置(行数)*/
	#define VDLog(format, ...) NSLog((@"%s [Line %d] " format), __FUNCTION__, __LINE__, ##__VA_ARGS__)
	
	#else
	
	#define VDLog(...)
	
	#endif


#####目前包含一下工具类：
######一、NSString的扩展类

1.NSString+tool

######二、UIView的扩展类

1.UIView+tool

2.UIView+EmptyShow

	/**
	 *  空页面显示提醒图与文字并添加重新刷新
	 *
	 *  @param emptyType 页面的展示的数据类别（例如：我的订单或者web页）
	 *  @param haveData  是否有数据
	 *  @param block     重新加载页面（不需要时赋空）
	 */
	- (void)emptyDataCheckWithType:(ViewDataType)emptyType
	                   andHaveData:(BOOL)haveData
	                andReloadBlock:(ReloadDataBlock)block;
示例图：

![emptyOrder.png](https://github.com/VolientDuan/iOS-ToolClassDemo/blob/master/md+image/emptyOrder.png?raw=true)	                
######三、UIImage的扩展类

1.UIImage+tool

#####四、UIControl的扩展类
1.UIControl+clickRepeatedly（处理按钮的反复点击）

不用再纠结此类问题了，一句代码搞定：

	btn.clickInterval = 3;
#####五、用户信息（单例模式）
UserInfoModel:实现一些轻量级的用户信息存储

#####六、AFNetWorking的二次封装（单例模式）
1.简单的HTTP（POST）请求：其中添加了多种请求错误判断和debug模式下打印响应成功的数据，最后采用block进行响应结果的回调

	/**
	 *  发送请求
	 *
	 *  @param requestAPI 请求的API
	 *  @param vc         发送请求的视图控制器
	 *  @param params     请求参数
	 *  @param className  数据模型
	 *  @param response   请求的返回结果回调
	 */
	- (void)sendRequestWithAPI:(NSString *)requestAPI
	                    withVC:(UIViewController *)vc
	                withParams:(NSDictionary *)params
	                 withClass:(Class)className
	             responseBlock:(RequestResponse)response;

#####七、校验工具类
1.手机号校验

	+(BOOL) isValidateMobile:(NSString *)mobile
2.邮箱校验

	+(BOOL)isValidateEmail:(NSString *)email
3.车牌号校验

	+(BOOL) isvalidateCarNo:(NSString*)carNo