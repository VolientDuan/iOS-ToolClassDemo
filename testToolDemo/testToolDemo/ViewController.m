//
//  ViewController.m
//  testToolDemo
//
//  Created by 段贤才 on 16/6/22.
//  Copyright © 2016年 volientDuan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+tool.h"
#import "NSString+tool.h"
#import "UIImage+tool.h"
#import "UIView+EmptyShow.h"
#import "FileManageTool.h"

#import <SVProgressHUD/SVProgressHUD.h>

#define MENU_APPKEY @"e9d5a19b5d072b671ff9072cc31c61a8"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (instancetype)init{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [sb instantiateViewControllerWithIdentifier:@"sbVc"];
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [SVProgressHUD showProgress:10.0];
//    [SVProgressHUD show];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor grayColor];
    if (_vcType == 1) {
        [_tableView emptyDataCheckWithType:ViewDataTypeMyOrder andHaveData:NO andReloadBlock:^{
            [_dataArray addObjectsFromArray:@[@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"ToolClassDemo.zip"]];
            [self.tableView reloadData];
        }];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_vcType == 0) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 33)];
        btn.center = self.view.center;
        btn.backgroundColor = [UIColor greenColor];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *path = [[FileManageTool shareManager]createFilePathWithFileName:@"test.txt" folder:@"test" type:VDFileTypeDocument];
        BOOL isSuccess = [[FileManageTool shareManager]writeToFileWithContent:@[@"1",@"2",@"3"] path:path];
        VDLog(@"%@", [NSString stringWithFormat:@"%@",isSuccess?@"保存成功":@"保存失败"]);
        if (isSuccess) {
            NSArray *arr = [NSArray arrayWithContentsOfFile:path];
            VDLog(@"文件内容：\n%@",[arr description]);
        }
//        VDLog(@"很好用的");
//        self.title = @"傻傻的你";
//        //UserInfoModel(单例)的使用
//        [UserInfoModel sharedManage].token = [NSString getDeviceIdentifierForVendor];
//        [UserInfoModel sharedManage].userName = @"volientDuan";
//        [UserInfoModel sharedManage].isBind = YES;
//        
//        VDLog(@"token:%@;\nuserName:%@",[UserInfoModel sharedManage].token,[UserInfoModel sharedManage].userName);
//        
//        //监听用户信息中token的变化（可能有些小伙伴会用到这种监听用户某个信息的变化的变态需求）
//        [[UserInfoModel sharedManage] addObserver:self forKeyPath:@"token" options:NSKeyValueObservingOptionNew context:nil];
//        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeToken) userInfo:nil repeats:YES];
    }else{
        _dataArray = [NSMutableArray array];
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
        [self.view addSubview:_tableView];
    }
    

//#pragma mark [普通http请求]
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@"红烧肉" forKey:@"menu"];
//    [params setObject:MENU_APPKEY forKey:@"key"];
//    [[RequestTool shareManager]sendRequestWithAPI:@"/cook/query.php" withVC:self withParams:params withClass:nil responseBlock:^(id response, BOOL isError, NSString *errorMessage, NSInteger errorCode) {
//        
//    }];
    
    
////调试自己写的工具类真的很累哦
//    UIView *bgView = [[UIView alloc]init];
//    bgView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:bgView];
//    
//    bgView.v_x = 50;
//    bgView.v_y = 50;
//    bgView.v_w = 50;
//    bgView.v_h = 50;
//    
//    bgView.v_cornerRadius = bgView.v_w/2;
    
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, V_SCREEN_WIDTH, 100)];
//    lable.center = self.view.center;
//    lable.numberOfLines = 0;
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.textColor = [UIColor blackColor];
//    lable.font = [UIFont systemFontOfSize:15.0];
//    [self.view addSubview:lable];
//    NSString *str = @"这个是绿色字号是20";
//    //富文本
//    lable.attributedText = [str changeColor:[UIColor greenColor] andColorRang:NSMakeRange(3, 2) andFont:[UIFont systemFontOfSize:20] andFontRange:NSMakeRange(8, 2)];
//    
//    UIImage *image = [UIImage imageNamed:@"name.gif"];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//    imageView.image = image;
//    [self.view addSubview:imageView];
//    UIView *bitView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 200, 200)];
//    bitView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:bitView];
//    UIImage *bitImage = [UIImage imageFromView:bitView];
//    
//    [imageView setImage:bitImage];
    
    
    
//    UIImageView *gifImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    gifImageView.center = self.view.center;
//    [self.view addSubview:gifImageView];
//    
//    NSMutableArray *images = [NSMutableArray array];
//    for (int i=0; i < 10; i++) {
//        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i]]];
//    }
//    gifImageView.animationImages = images;
//    gifImageView.animationDuration = 5.0;
//    gifImageView.animationRepeatCount = NSUIntegerMax;
//    [gifImageView startAnimating];
    
//    CGSize size = [UIImage imageNamed:@"name.gif"].size;
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    webView.center = self.view.center;
//    webView.userInteractionEnabled = NO;
//    webView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:webView];
//    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"name" ofType:@"gif"]];
//    [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)btnClick{
    ViewController *vc = [[ViewController alloc]init];
    vc.vcType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@",[UserInfoModel sharedManage].token);
}
static NSString *str = @"duan";
static NSInteger tokenIndex;
- (void)changeToken{
    tokenIndex ++;
    [UserInfoModel sharedManage].token = [NSString stringWithFormat:@"%ld",tokenIndex+100000];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (![_dataArray[indexPath.row] isEqualToString:@"👌~\(^o^)/~"]) {
//#pragma mark [创建下载任务]
//        [[RequestTool shareManager]createDownloadTaskWithURL:@"https://github.com/VolientDuan/iOS-ToolClassDemo/archive/master.zip" withFileName:@"ToolClassDemo.zip" Task:^(NSURLSessionDownloadTask *task) {
//            NSLog(@"taskDescription:%@",task.taskDescription);
//        } Progress:^(float progress, NSString *taskDesc) {
//            [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (![(NSString *)obj isEqualToString:@"👌~\(^o^)/~"]) {
//                    NSIndexPath *indexP = [NSIndexPath indexPathForRow:idx inSection:0];
//                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexP];
//                     _dataArray[indexP.row] = [NSString stringWithFormat:@"%.3f",progress];
//                    if (progress >= 1.) {
//                        _dataArray[indexP.row] = @"下载完成";
//                    }
//                    cell.textLabel.text = _dataArray[indexP.row];
//                }
//            }];
//            VDLog(@"%@:%@",taskDesc,[NSString stringWithFormat:@"%f",progress]);
//        } Result:^(id response, BOOL isError) {
//            
//        }];
//    }
//    else{
//        [_dataArray removeObjectAtIndex:indexPath.row];
//        [_tableView reloadData];
//    }

}


@end
