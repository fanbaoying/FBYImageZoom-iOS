//
//  ViewController.m
//  FBYImageZoom-iOS
//
//  Created by fby on 2018/3/2.
//  Copyright © 2018年 FBYImageZoom-iOS. All rights reserved.
//

#import "ViewController.h"

#import "FBYImageZoom.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property(strong,nonatomic)UIImageView *myImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.navigationItem.title = @"图片缩放";
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH-100, SCREEN_WIDTH-100)];
    self.myImageView.image = [UIImage imageNamed:@"bankcard"];
    //添加点击事件
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    //1.创建长按手势
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imglongTapClick:)];
    //3.添加手势
    [_myImageView addGestureRecognizer:longTap];
    [_myImageView addGestureRecognizer:tapGestureRecognizer];
    [_myImageView setUserInteractionEnabled:YES];
    [self.view addSubview:_myImageView];
}

#pragma mark - 浏览大图点击事件
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [FBYImageZoom ImageZoomWithImageView:clickedImageView];
}

#pragma mark 长按手势弹出警告视图确认
-(void)imglongTapClick:(UILongPressGestureRecognizer*)gesture

{
    
    if(gesture.state==UIGestureRecognizerStateBegan)
        
    {
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"取消保存图片");
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"确认保存图片");
            
            // 保存图片到相册
            UIImageWriteToSavedPhotosAlbum(self.myImageView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
            
        }];
        
        [alertControl addAction:cancel];
        [alertControl addAction:confirm];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
    
}

#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo

{
    
    NSString *message;
    
    if(!error) {
        
        message =@"成功保存到相册";
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }else
        
    {
        
        message = [error description];
        
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
