//
//  BaseTabBarController.m
//  jiedian
//
//  Created by 美街美店 on 16/5/5.
//  Copyright © 2016年 com.jiedian.www. All rights reserved.
//

#import "BaseTabBarController.h"


@interface BaseTabBarController ()


@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化item 点击后的效果
    NSArray *arrImages = @[@"首页",@"生活圈",@"同城",@"订单",@"我的"];
    
    NSArray *arrSelectedImage= @[@"首页2",@"生活圈2",@"同城2",@"订单2",@"我的2"];

    //更换点击后的背景图
    for (int i=0;i<[self.tabBar.items count];i++) {
        UITabBarItem *item=self.tabBar.items[i];
        
        item.image=[[UIImage imageNamed:arrImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        item.selectedImage=[[UIImage imageNamed:arrSelectedImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        
        
        
    }
    
    //更换文字颜色
    NSDictionary *attrNormalDic = @{
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0],
                                    NSForegroundColorAttributeName:[UIColor grayColor]
                                    };
    NSDictionary *attrSelectDic = @{
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0],
                                    NSForegroundColorAttributeName:_backgroundColor
                                    };
    [[UITabBarItem appearance] setTitleTextAttributes:attrSelectDic forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:attrNormalDic forState:UIControlStateNormal];
 
 
    
}






- (BaseTabBarView *)tabbarView
{
    if(_tabbarView==nil)
    {
        _tabbarView = [BaseTabBarView addBaseTabBarView];
    }
    
  return   _tabbarView;
}

@end
