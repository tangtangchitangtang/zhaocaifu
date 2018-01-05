//
//  detailsViewController.m
//  DJS
//
//  Created by 浪尖渝力 on 2017/12/29.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "detailsViewController.h"
#import "detailsView.h"

@interface detailsViewController ()
@property(nonatomic,strong)detailsView *aView;
@end

@implementation detailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"店铺详情";
    
    _aView=[detailsView new];
    [self.view addSubview:_aView];
    [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self loginView];
    _aView.viewController=self;
    
}
-(void)loginView{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_shop_id,@"shop_id", nil];
    [ZQTools AFNPostDataUrl:@"app/shopdetail" Dict:dic andTableView:nil andView:self.view andSuccessBlock:^(id responseObject) {
        _aView.dic=responseObject;
        [_aView creatView];
        
    } anderrorBlock:nil];
    
}
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
