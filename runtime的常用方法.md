##runtime的常用方法

###1.给类别加属性
预设 char 值

	static char WarningViewKey;
GET方法:`objc_getAssociatedObject`

	- (CustomerWarnView *)warningView{
	    return objc_getAssociatedObject(self, &WarningViewKey);
	}

SET方法:`objc_setAssociatedObject`

	- (void)setWarningView:(CustomerWarnView *)warningView{
	    [self willChangeValueForKey:@"WarningViewKey"];
	    objc_setAssociatedObject(self, &WarningViewKey, warningView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	    [self didChangeValueForKey:@"WarningViewKey"];
	}

###2.替换（重写）方法

核心代码:

	Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
	    Method b = class_getInstanceMethod(self, @selector(rc_sendAction:to:forEvent:));
	    method_exchangeImplementations(a, b);

例子:

	+ (void)load
	{
	    //替换点击事件
	    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
	    Method b = class_getInstanceMethod(self, @selector(rc_sendAction:to:forEvent:));
	    method_exchangeImplementations(a, b);
	}
	
	- (void)rc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
	{
	    if (self.ignoreClick) {
	        return;
	    }
	    else{
	        [self rc_sendAction:action to:target forEvent:event];
	    }
	    if (self.clickInterval > 0)
	    {
	        self.ignoreClick = YES;
	        [self performSelector:@selector(setIgnoreClick:) withObject:@(NO) afterDelay:self.clickInterval];
	    }
	    
	}
	
###3.通过类名(字符串)初始化对象
可以简化代码提高复用:`NSClassFromString`

	Class classVC = NSClassFromString(@"类名");
	[classVC new];


###4.通过方法名(字符串)调用该方法
使用:`NSSelectorFromString`

	SEL normalSelector = NSSelectorFromString(methodName);
	    if ([self respondsToSelector:normalSelector]) {
	        
	        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
	    }