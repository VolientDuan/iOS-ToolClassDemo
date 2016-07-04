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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VDLog(@"很好用的");
    
    self.title = @"傻傻的你";
    _dataArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    
    //UserInfoModel(单例)的使用
    [UserInfoModel sharedManage].token = [NSString getDeviceIdentifierForVendor];
    [UserInfoModel sharedManage].userName = @"volientDuan";
    [UserInfoModel sharedManage].isBind = YES;
    
    VDLog(@"token:%@;\nuserName:%@",[UserInfoModel sharedManage].token,[UserInfoModel sharedManage].userName);
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView emptyDataCheckWithType:ViewDataTypeMyOrder andHaveData:NO andReloadBlock:^{
        [_dataArray addObjectsFromArray:@[@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~",@"👌~\(^o^)/~"]];
        [self.tableView reloadData];
    }];
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



@end
