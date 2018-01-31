//
//  RYVController.m
//  RYApp
//
//  Created by 连杰 on 2018/1/27.
//  Copyright © 2018年 连杰. All rights reserved.
//

#import "RYVController.h"
//#import "RCDCustomerServiceViewController.h"


#define SERVICE_ID @"KEFU151703811665720"
@interface RYVController ()

@end

@implementation RYVController

-(instancetype)init{
    if (self = [super init]) {
        //设置需要需要显示那些类型的会话
//        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_CHATROOM),@(ConversationType_GROUP),@(ConversationType_APPSERVICE),@(ConversationType_SYSTEM)]];
//         //设置需要将那些类型的会话列表中聚合显示
//        [self setCollectionConversationType:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)]];
//
//
//
        
        
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    RCDCustomerServiceViewController *vcv = [[RCDCustomerServiceViewController alloc]init];
////    vcv.displayUserNameInCell = YES;
//    vcv.conversationType = ConversationType_CUSTOMERSERVICE;
//
//    vcv.targetId = SERVICE_ID;
//    vcv.title = @"客服";
//
  
}

/*

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        RYVController *chartlist = [[RYVController alloc]init];
        NSArray *arr = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
        [chartlist setDisplayConversationTypes:arr];
        [chartlist setCollectionConversationType:nil];
        chartlist.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:chartlist animated:YES];
    }else if (model.conversationType == ConversationType_PRIVATE){
    
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"会话的标题";
    
    NSLog(@"-----%@-----targetID",model.targetId);
    
    [self.navigationController pushViewController:conversationVC animated:YES];
    }
    else if (model.conversationType == ConversationType_CUSTOMERSERVICE){
        RCDCustomerServiceViewController *chatSer = [[RCDCustomerServiceViewController alloc]init];
        
//        chatSer.conversationType = model.conversationType;
//        chatSer.targetId = SERVICE_ID;

//        [self.navigationController pushViewController:chatSer animated:YES];

    }
    
    
}
*/
 
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
