
//
//  securityView.m
//  DJS
//
//  Created by 浪尖渝力 on 2018/1/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "securityView.h"
#import "modifyLoginViewController.h"

@implementation securityView

-(void)creatView{
    NSArray *arr=[NSArray arrayWithObjects:@"登陆密码",@"支付密码",@"启动密码", nil];
    for (int i=0; i<arr.count; i++) {
        UIView *beiJingView=[UIView new];
        [self addSubview:beiJingView];
        [beiJingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64+46*i);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        beiJingView.backgroundColor=[UIColor whiteColor];
        beiJingView.tag=i;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DianJiView:)];
        [beiJingView addGestureRecognizer:tapGesture];
        
        UIView *xianView=[UIView new];
        [self addSubview:xianView];
        [xianView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(beiJingView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        xianView.backgroundColor=_LightGrey;
        
        UILabel *titleLabel=[UILabel new];
        [beiJingView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        titleLabel.text=arr[i];
        titleLabel.font=[UIFont systemFontOfSize:16];
        titleLabel.textColor=ColorWithRGB(100.0 , 100.0, 100.0);
        
        UIImageView *iamgeView=[UIImageView new];
        [beiJingView addSubview:iamgeView];
        [iamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(17);
        }];
        iamgeView.image=[UIImage imageNamed:@"iconfont-fanhui-拷贝-3"];
    }
    
}
-(void)DianJiView:(UITapGestureRecognizer *)tap{
    int tag=(int)tap.view.tag;
    if(tag==0){
        modifyLoginViewController *modif=[[modifyLoginViewController alloc] init];
        [ZQTools pushNextViewController:self.viewController andRootController:modif];
        
    }
    
}

@end
