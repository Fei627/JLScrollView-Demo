//
//  ViewController.m
//  轮播图666
//
//  Created by JLItem on 15/7/17.
//  Copyright (c) 2015年 高建龙. All rights reserved.
//

#import "ViewController.h"


#define kViewWidth self.view.frame.size.width
#define kViewHeight self.view.frame.size.height

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *imageArray;

@property (nonatomic, copy) NSString *leftName;
@property (nonatomic, copy) NSString *centerName;
@property (nonatomic, copy) NSString *rightName;

@property (nonatomic, retain) UIImageView *leftImageView;
@property (nonatomic, retain) UIImageView *centerImageView;
@property (nonatomic, retain) UIImageView *rightImageView;

@end

@implementation ViewController

-(void)dealloc
{
    [_scrollView release];
    [_imageArray release];
    [_leftName release];
    [_centerName release];
    [_rightName release];
    [_leftImageView release];
    [_centerImageView release];
    [_rightImageView release];
    self.scrollView.delegate = nil;
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readLoadView];
    
    
}

#pragma mark --- 加载视图 ---
-(void)readLoadView
{
    self.imageArray = @[@"h1.jpeg",@"h2.jpeg",@"h3.jpeg",@"h4.jpeg",@"h5.jpeg",@"h6.jpeg",@"h7.jpeg",@"h8.jpeg"];
    
    self.leftName = self.imageArray[self.imageArray.count - 1];
    self.centerName = self.imageArray[0];
    self.rightName = self.imageArray[1];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    self.scrollView.contentSize = CGSizeMake(3 * kViewWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(kViewWidth, 0);
    [self.view addSubview:self.scrollView];
    [self.scrollView release];
    
    //创建imageView
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    self.leftImageView.image = [UIImage imageNamed:self.leftName];
    [self.scrollView addSubview:self.leftImageView];
    
    self.centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kViewWidth, 0, kViewWidth, kViewHeight)];
    self.centerImageView.image = [UIImage imageNamed:self.centerName];
    [self.scrollView addSubview:self.centerImageView];
    
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kViewWidth * 2, 0, kViewWidth, kViewHeight)];
    self.rightImageView.image = [UIImage imageNamed:self.rightName];
    [self.scrollView addSubview:self.rightImageView];

}

/**
 *  根据给定的图片名 返回该图片在数组内的下标
 */
-(NSInteger)getImageName:(NSString *)imageName
{
    for (int i = 0; i < self.imageArray.count; i ++) {
        if ([self.imageArray[i] isEqualToString:imageName]) {
            
            return i;
        }
    }
    return 0;
}

/**
 *  scrollView 的代理方法
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == kViewWidth * 2) {
        //NSLog(@"11111111111111");
        self.leftName = self.centerName;
        self.centerName = self.rightName;
        
        if ([self getImageName:self.rightName] == self.imageArray.count - 1) {
            
            self.rightName = self.imageArray[0];
        } else {
            
            self.rightName = self.imageArray[[self getImageName:self.rightName] + 1];
        }
    }
    
    if (scrollView.contentOffset.x == 0) {
        //NSLog(@"---------------");
        self.rightName = self.centerName;
        self.centerName = self.leftName;
        
        if ([self getImageName:self.leftName] == 0) {
            
            self.leftName = self.imageArray[self.imageArray.count - 1];
        } else {
            
            self.leftName = self.imageArray[[self getImageName:self.leftName] - 1];
        }
    }
    
    self.centerImageView.image  = [UIImage imageNamed:self.centerName];
    self.scrollView.contentOffset = CGPointMake(kViewWidth, 0);

    self.leftImageView.image = [UIImage imageNamed:self.leftName];
    self.rightImageView.image = [UIImage imageNamed:self.rightName];
    
    //NSLog(@"%@",self.centerName);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
