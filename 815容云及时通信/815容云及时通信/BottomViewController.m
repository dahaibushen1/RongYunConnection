//
//  BottomViewController.m
//  815容云及时通信
//
//  Created by hu on 16/8/14.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "BottomViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatViewController.h"
#import "ServerController.h"

@interface BottomViewController ()<RCIMConnectionStatusDelegate>

@property (nonatomic,strong)UIButton *button;

@end


@implementation BottomViewController

-(UIButton*)button{

    if (!_button) {
        _button = [UIButton new];
        _button.frame = CGRectMake(120, 420, 120, 30);
        _button.backgroundColor = [UIColor purpleColor];
        [_button addTarget:self action:@selector(buttClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)viewDidLoad{

    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    
}

-(void)buttClick:(UIButton*)button{
    
        [[RCIM sharedRCIM] initWithAppKey:@"pwe86ga5e5ed6"];
        

        [[RCIM sharedRCIM] connectWithToken:@"ySfi6k9oyt6/rZqANrAEGSBvlfTVvEknZFQa2xbn9V3Q9I+xQ9ijcN+nZ+Ox1lQhFWvWLuyVGaG1R0Y7cnApHcjG7d8d9X1uOfR67pfNHxo=" success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
             [[RCIM sharedRCIM] setUserInfoDataSource:self];
        dispatch_async(dispatch_get_main_queue(), ^{
        //新建一个聊天会话View Controller对象
        ChatViewController *chat = [[ChatViewController alloc]init];
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
//        chat.conversationType = ConversationType_PRIVATE;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
//        chat.targetId = @"1";
        //设置聊天会话界面要显示的标题
        chat.title = @"想显示的会话标题";
        //显示聊天会话界面
        [self.navigationController pushViewController:chat animated:YES];
        });
            
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(didReceiveMessageNotification:)
//     name:RCKitDispatchMessageNotification
//     object:nil];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
}
-(void)didReceiveMessageNotification{

}

/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"测试1";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
    }else if([@"2" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"2";
        user.name = @"测试2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }
}

@end
