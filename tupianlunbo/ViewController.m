//
//  ViewController.m
//  tupianlunbo
//
//  Created by xubinbin on 2020/2/25.
//  Copyright © 2020 ccsu_cat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    for (int i = 1; i < 6; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = (i - 1) * width;
        CGFloat imageY = 0;
        imageView.frame = CGRectMake(imageX, imageY, width, height);
        imageView.backgroundColor = [UIColor blackColor];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_0%d", i]];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(5 * width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addScrollTimer];

}
-(void)nextPage
{
    int currentPage = self.pageControl.currentPage;
    if (currentPage == 4)
        currentPage = -1;
   currentPage++;
    
    CGFloat width = self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(currentPage * width , 0);
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = offset;
    }];
}

-(void)addScrollTimer
{
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)removeScrollTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
//#pragma mark - UIScrollViewDelegate实现方法
-(void)scrollViewDidScroll:(UIScrollView *) scrollView
{
    //NSLog(@"11111");
    CGPoint offset = self.scrollView.contentOffset;
    CGFloat offsetX = offset.x;
    CGFloat width = self.scrollView.frame.size.width;
    int pageNum = (offsetX + width * 0.5)/ self.scrollView.frame.size.width;
    self.pageControl.currentPage = pageNum;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *) scrollView
{
    [self removeScrollTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addScrollTimer];
}
@end
