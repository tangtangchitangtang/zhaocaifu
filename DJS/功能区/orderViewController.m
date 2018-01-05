//
//  orderViewController.m
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "orderViewController.h"
#import "orderView.h"
@interface orderViewController ()
@property(nonatomic,strong)orderView *aView;
@property(nonatomic,strong)NSDictionary *userDic;
@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"订单";
}
-(void)viewWillAppear:(BOOL)animated{
    _userDic = [NSKeyedUnarchiver unarchiveObjectWithFile:_userModelFile];
    if (_userDic==nil) {
        _loginWithVc(self);
        return;
    }
    
    _aView=[orderView new];
    [self.view addSubview:_aView];
    [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    _aView.tableArr1=[NSMutableArray arrayWithCapacity:0];
    _aView.tableArr2=[NSMutableArray arrayWithCapacity:0];
    _aView.viewController=self;
    _aView.abc=1;
     [_aView creatView];
    
    [self loginView];
}

-(void)loginView{
    NSNumber *user_id=[_userDic objectForKey:@"user_id"];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"status",user_id,@"user_id", nil];
    [ZQTools AFNPostDataUrl:@"app/myOrder" Dict:dic andTableView:nil andView:self.view andSuccessBlock:^(id responseObject) {
        NSArray *typeArr=responseObject;
        [_aView.tableArr1 addObjectsFromArray:typeArr];
        [_aView.allTabelView reloadData];
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
