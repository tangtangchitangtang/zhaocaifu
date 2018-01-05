//
//  BaseTableViewController.m
//  jiedian
//
//  Created by 美街美店 on 16/5/5.
//  Copyright © 2016年 com.jiedian.www. All rights reserved.
//

#import "BaseTableViewController.h"

#import "CDPMonitorKeyboard.h"
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, _mainH, 0)];
    
    //设置分割线填充满屏幕
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if(self.navigationController.viewControllers.count>0)
    {
        if(self!=self.navigationController.viewControllers[0])
        {
            //左上角返回按钮
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(popVc)];
            
            CGFloat offY = self.tableView.contentOffset.y;
            
            CGFloat udY = self.tableView.frame.origin.y;
            
            NSLog(@"");
            
            if (self.tableView.contentOffset.y>0)
            {
                self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
            }
            else
            {
                
            }
        }
 
    }
    

    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    //适配ios10
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    //设定哪些类不用处理这个
//    NSArray *vcClassArr = @[ ];
//    
//    BOOL isHave = NO;
//    
//    for (int x=0; x<vcClassArr.count; x++) {
//        
//        if([self isKindOfClass:vcClassArr[x]])
//        {
//        
//            isHave = YES;
//        }
//        
//    }
//    
//    if(isHave==NO)
//    {
//
//        
//        /*******只需要在要处理键盘的界面创建WHC_KeyboardManager对象即可无需任何其他设置*******/
//        [[WHC_KeyboardManager share]addMonitorViewController:self];
//      
//    }
    
    //————————————————设置导航栏两边按钮颜色(依赖WRNavigationBar)
//    [ZQTools setNavVcTinColor:self withAlpha:[UIColor blackColor]];

    
}

#pragma mark——————————收到内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // 清除sd的内存缓存
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark----------------设置单元格分割线填充满屏幕--------------------
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)popVc
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc
{
     [self.view endEditing:YES];

    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    //清空并重置数据
    [[CDPMonitorKeyboard defaultMonitorKeyboard] clearAll];
    

}

#pragma mark————————程序即将离开页面
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    
//    [[WHC_KeyboardManager share] removeMonitorViewController:self];

    [self.view endEditing:YES];
    
}

#pragma mark————————程序即将进入界面
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    
    
    //设定哪些类不用处理这个
    NSArray *vcClassArr = @[];
    
    BOOL isHave = NO;
    
    for (int x=0; x<vcClassArr.count; x++) {
        
        if([self isKindOfClass:vcClassArr[x]])
        {
            
            isHave = YES;
        }
        
    }
    
    if(isHave==NO)
    {
        
        
        /*******只需要在要处理键盘的界面创建WHC_KeyboardManager对象即可无需任何其他设置*******/
//        [[WHC_KeyboardManager share]addMonitorViewController:self];
        
        
        
    }
    
    
}


//- (ZQTools *)tools
//{
//    if(_tools==nil)
//    {
//        _tools = [[ZQTools alloc]init];
//    }
//    return _tools;
//    
//}
- (UISearchBar *)searchBar
{
    if(_searchBar==nil)
    {
        // 创建UISearchBar对象
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, _mainW*0.6, 60)];
        
        
        _searchBar.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        
//        _searchBar.tintColor =  _navColor;
        _searchBar.backgroundImage = [[UIImage alloc] init];
        // 设置没有输入时的提示占位符
        [_searchBar setPlaceholder:@"输入关键词、标签"];
        
        
    }
    
    
    return _searchBar;
}



@end
