//
//  ChatViewController.m
//  815容云及时通信
//
//  Created by hu on 16/8/14.
//  Copyright © 2016年 hu. All rights reserved.
//

#import "ChatViewController.h"


@interface ChatViewController ()


@end

@implementation ChatViewController

-(void)viewDidLoad{

    [super viewDidLoad];

    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    
    //修改图片以及图片形状
    RCUserInfo *userInfo = [RCIM sharedRCIM].currentUserInfo;
    userInfo.portraitUri = @"http://love.doghouse.com.tw/image/wallpaper/011102/bf1554.jpg";
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];
    
    [self chatMySelf];

}
#pragma mark 跟自己聊天
-(void)chatMySelf{

    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"pwe86ga5e5ed6"; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
    conversationVC.title = @"测试1";
    conversationVC.title = @"自问自答";
    [self.navigationController pushViewController:conversationVC animated:YES];
}

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.userName =model.conversationTitle;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];


}

-(void)dealloc{

     [[RCIM sharedRCIM]disconnect];
}


@end
