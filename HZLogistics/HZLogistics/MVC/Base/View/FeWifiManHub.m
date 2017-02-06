//
//  FeWifiManHub.m
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "FeWifiManHub.h"

#define kFe_WifiMan_Width 180.0f
#define kFe_WifiMan_Height 156.0f
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface FeWifiManHub ()
{
    // Target, method, object and block
    id targetForExecuting;
    SEL methodForExecuting;
    id objectForExecuting;
    dispatch_block_t completionBlock;
}

@property (strong, nonatomic) UIImageView *contentImage;


-(void) initCommon;
-(void) initWifiManHub;
@end


@implementation FeWifiManHub

-(id) initWithView:(UIView *)view withMode:(FeWifiManHubMode)mode
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
        _currentMode = mode;
        
        self.hidden = YES;
        
        [self initCommon];
        [self initWifiManHub];
        
    }
    return self;
}
-(void) initCommon
{
    _isAnimate = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
}



-(void) initWifiManHub
{
    CGRect frame = CGRectMake(0, 0, kFe_WifiMan_Width, kFe_WifiMan_Height);
    _contentImage = [[UIImageView alloc] init];
    _contentImage.frame = frame;
    _contentImage.center = CGPointMake(self.center.x, self.center.y - 100);
    _contentImage.backgroundColor = [UIColor clearColor];
    _contentImage.layer.cornerRadius = 10.0f;
    _contentImage.clipsToBounds = YES;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 1; i <= 5; i ++) {
        NSString *str = [NSString stringWithFormat:@"animation_%ld.png",(long)i];
        UIImage *myimage = [UIImage imageNamed:str];
        [arr addObject:myimage];
    }
    
    UIImage *image = [UIImage imageNamed:@"animation_1.png"];
    [_contentImage setImage:image];
    [_contentImage setUserInteractionEnabled:YES];
    [_contentImage setAnimationImages:arr];
    [_contentImage setAnimationDuration:1.0];
    
    [self addSubview:_contentImage];
    
}
#pragma mark Action
-(void) show
{
    if (_isAnimate)
        return;
    
    _isAnimate = YES;
    self.hidden = NO;
    
    
    [_contentImage startAnimating];
    
}
-(void) dismiss
{
    if (!_isAnimate)
        return;
    
    [self removeFromSuperview];
    _isAnimate = NO;
}

-(void) showWhileExecutingBlock:(dispatch_block_t)block
{
    [self showWhileExecutingBlock:block completion:nil];
}
-(void) showWhileExecutingSelector:(SEL)selector onTarget:(id)target withObject:(id)object
{
    [self showWhileExecutingSelector:selector onTarget:target withObject:object completion:nil];
    
}
-(void) showWhileExecutingBlock:(dispatch_block_t)block completion:(dispatch_block_t)completion
{
    // Check block != nil
    if (block != nil)
    {
        [self show];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
                       {
                           block();
                           
                           // Update UI
                           dispatch_async(dispatch_get_main_queue(), ^{
                               completion();
                               [self dismiss];
                           });
                       });
    }
}
-(void) showWhileExecutingSelector:(SEL)selector onTarget:(id)target withObject:(id)object completion:(dispatch_block_t)completion
{
    // Check Selector is responded
    if ([target respondsToSelector:selector])
    {
        methodForExecuting = selector;
        targetForExecuting = target;
        objectForExecuting = object;
        completionBlock = completion;
        
        [self show];
        
        [NSThread detachNewThreadSelector:@selector(executingMethod) toTarget:self withObject:nil];
    }
}
#pragma mark Helper method
-(void) executingMethod
{
    @autoreleasepool {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // Start executing the requested task
        [targetForExecuting performSelector:methodForExecuting withObject:objectForExecuting];
#pragma clang diagnostic pop
        // Task completed, update view in main thread (note: view operations should
        // be done only in the main thread)
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock();
            [self performSelectorOnMainThread:@selector(cleanUp) withObject:nil waitUntilDone:NO];
        });
        
    }
}
-(void) cleanUp
{
    NSLog(@"Clean up");
    if (objectForExecuting)
        objectForExecuting = nil;
    if (methodForExecuting)
        methodForExecuting = nil;
    if (targetForExecuting)
        targetForExecuting = nil;
    if (completionBlock)
        completionBlock = nil;
    [self dismiss];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
