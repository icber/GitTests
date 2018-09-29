//
//  ViewController.m
//  GitTests
//
//  Created by yy on 2018/9/5.
//  Copyright © 2018年 yy. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "WMPageController.h"
#import "GitScrollView.h"
#import "testViewController.h"
#import <Lottie/LOTAnimationView.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WMMenuItemDelegate,WMMenuItemDelegate,WMMenuViewDataSource>


@property (nonatomic , strong)WMPageController *pageController;

@property (nonatomic , strong)GitScrollView *scrollVC;
@property (nonatomic , strong)UITableView *tableVC;
@property (nonatomic , strong)UIView *topVC;
@property (nonatomic , strong)UIView *bannerVC;

@property (nonatomic , strong)UIView *contentView;


@property (nonatomic , strong)LOTAnimationView *animati;

@property (nonatomic , assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic , assign) BOOL isTopIsCanNotMoveTabViewPre;
@property (nonatomic , assign) BOOL canScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.title = @"标题";
    _canScroll = YES;

    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"Home_Leave_Top" object:nil];

    
    [self donghua];
//    [self setupView];

//    [self.view addSubview:self.scrollVC];
//    [_scrollVC addSubview:self.topVC];
//    [_topVC addSubview:self.bannerVC];
//
//    [_scrollVC addSubview:self.contentView];
//    [_scrollVC addSubview:self.pageController.view];
//    [_scrollVC addSubview:self.tableVC];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)donghua{
    [self.view addSubview:self.animati];
    [_animati play];
}

-(LOTAnimationView *)animati{
    if (!_animati) {
        
//        [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"GitTests" ofType:@"bundle"]] pathForResource:@"animation-w1440-h1080" ofType:@"json"]
//
        _animati = [LOTAnimationView animationWithFilePath:[[NSBundle mainBundle] pathForResource:@"animation-w1440-h1080" ofType:@"json"]];
        
        _animati.frame = CGRectMake(0, 0, 360, 270);
        _animati.backgroundColor = [UIColor yellowColor];
        _animati.loopAnimation = YES;
        
    }
    return _animati;
}

-(void)setupView{
    [self.view addSubview:self.scrollVC];
    _scrollVC.frame = CGRectMake(0, 0, kWidth, kHeight);
    [_scrollVC addSubview:self.topVC];
    _topVC.frame = CGRectMake(0, 0, kWidth, 300);
    [_topVC addSubview:self.bannerVC];
    _bannerVC.frame = _topVC.frame;
    
    [_scrollVC addSubview:self.contentView];
    _contentView.frame = CGRectMake(0, 300, kWidth, kHeight-64);
//    [_scrollVC addSubview:self.pageController.view];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    if (scrollView == _scrollVC) {//对其偏移量进行设置。
        CGFloat offsetY = scrollView.contentOffset.y;
        NSLog(@"-----  %f",offsetY);
        if (offsetY <= 0) {

            CGRect rect = _topVC.frame;
            _bannerVC.frame = rect;

//            rect.origin.y = offsetY;
//            _topVC.frame = rect;
//            rect = _tableVC.frame;
//            rect.origin.y = offsetY + kWidth;
//            _tableVC.frame = rect;
//            rect = _bannerVC.frame;
//            rect.origin.y = 0;
//            _bannerVC.frame = rect;
            
//            rect = _bannerVC.frame;
//            rect.origin.y = 0;
//            _bannerVC.frame = rect;
            
        } else  {
            CGRect rect = _bannerVC.frame;
            rect.origin.y = offsetY / 2;
            _bannerVC.frame = rect;
        }
    }
}



-(GitScrollView *)scrollVC{
    if (!_scrollVC) {
        _scrollVC = [[GitScrollView alloc]init];
        _scrollVC.contentSize = CGSizeMake(0, kHeight * 8);
        _scrollVC.delegate = self;
        _scrollVC.bounces = YES;
        _scrollVC.showsVerticalScrollIndicator = NO;

    }
    return _scrollVC;
}

-(UIView *)topVC{
    if (!_topVC) {
        _topVC = [[UIView alloc]init];
        _topVC.backgroundColor = [UIColor yellowColor];
    }
    return _topVC;
}

-(UIView *)bannerVC{
    if (!_bannerVC) {
        _bannerVC = [[UIView alloc]initWithFrame:_topVC.bounds];
        _bannerVC.layer.contents = (id)[UIImage imageNamed: @"asdf.jpg"].CGImage;
    }
    return _bannerVC;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor yellowColor];
    }
    return _contentView;
}

-(WMPageController *)pageController{
    if (!_pageController) {
        _pageController = [[WMPageController alloc]initWithViewControllerClasses:@[[testViewController class],[testViewController class],[testViewController class]] andTheirTitles:@[@"tab1",@"asdfasdf",@"子栏目"]];
        _pageController.menuViewStyle = WMMenuViewStyleLine;
        _pageController.selectIndex = 1;
    }
    return _pageController;
}








-(UITableView *)tableVC{
    if (!_tableVC) {
        _tableVC = [[UITableView alloc]initWithFrame:CGRectMake(0, 300, kWidth, kHeight) style:UITableViewStyleGrouped];
        _tableVC.delegate = self;
        _tableVC.backgroundColor = [UIColor yellowColor];
        _tableVC.dataSource = self;
        _tableVC.bounces = NO;
        _tableVC.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _tableVC.estimatedRowHeight = 0;
            _tableVC.estimatedSectionFooterHeight = 0;
            _tableVC.estimatedSectionHeaderHeight = 0;
            _tableVC.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _scrollVC.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableVC registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableVC;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor redColor];
    cell.detailTextLabel.text = @"akdjfjalkfsaklfjsalfjs";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
