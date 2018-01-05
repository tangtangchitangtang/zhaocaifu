//
//  homeViewController.m
//  DJS
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "homeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "homeView.h"
@interface homeViewController ()<UITextFieldDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)homeView *aView;
@property(nonatomic,strong)UITextField *souShuoLabel;
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _aView=[homeView new];
    [self.view addSubview:_aView];
    [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    _aView.viewController=self;
    [self creatSouSuo];
    [self getBanner];
//    _aView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self locatemap];
//    }];
    
  
}
- (void)locatemap{
    
//    if ([CLLocationManager locationServicesEnabled]) {
//        _locationManager = [[CLLocationManager alloc]init];
//        _locationManager.delegate = self;
//        [_locationManager requestAlwaysAuthorization];
//        [_locationManager requestWhenInUseAuthorization];
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        _locationManager.distanceFilter = 5.0;
//        [_locationManager startUpdatingLocation];
//    }
    
    NSDictionary *Dic=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"longitude",@"",@"latitude", nil];
    [ZQTools AFNPostDataUrl:@"app/shoplist" Dict:Dic andTableView:nil andView:self.view andSuccessBlock:^(id responseObject) {
        _aView.tableArr=responseObject;
        [_aView creatView];
    } anderrorBlock:nil];
    
}

//#pragma mark - 定位失败
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        [[UIApplication sharedApplication]openURL:settingURL];
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alert addAction:cancel];
//    [alert addAction:ok];
//    //    [self presentViewController:alert animated:YES completion:nil];
//}
//#pragma mark - 定位成功
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//
//    [_locationManager stopUpdatingLocation];
//    CLLocation *currentLocation = [locations lastObject];
//    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
//    //当前的经纬度
//    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
//    NSString *strLatitude=[NSString stringWithFormat:@"%.6f",currentLocation.coordinate.latitude];
//    NSString *strLongitude=[NSString stringWithFormat:@"%.6f",currentLocation.coordinate.longitude];
//
//    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
//    if (locationAge > 1.0){//如果调用已经一次，不再执行
//        return;
//    }
//
//    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count >0) {
//            CLPlacemark *placeMark = placemarks[0];
//            NSLog(@"%@",placeMark);
//
//            NSDictionary *Dic=[NSDictionary dictionaryWithObjectsAndKeys:strLongitude,@"longitude",strLatitude,@"latitude", nil];
//
//
//        }else if (error == nil && placemarks.count){
//
//            NSLog(@"NO location and error return");
//        }else if (error){
//
//            NSLog(@"loction error:%@",error);
//        }
//    }];
//}

-(void)creatSouSuo{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mainW-100, 35)];//allocate titleView
    [titleView setBackgroundColor:_LightGrey];
    
    UIImageView *souShuoImage=[UIImageView new];
    [titleView addSubview:souShuoImage];
    [souShuoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.width.height.mas_equalTo(20);
    }];
    souShuoImage.image=[UIImage imageNamed:@"搜索"];
    
    _souShuoLabel=[UITextField new];
    [titleView addSubview:_souShuoLabel];
    [_souShuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(souShuoImage.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    _souShuoLabel.placeholder=@"搜索";
    _souShuoLabel.font=[UIFont systemFontOfSize:14];
    _souShuoLabel.delegate=self;
    _souShuoLabel.returnKeyType= UIReturnKeyDone;
    
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(sousuo)];
}

-(void)sousuo{
//    [_aView.tableArr removeAllObjects];
    
    [_souShuoLabel resignFirstResponder];
    NSString *keyword=_souShuoLabel.text;
    
    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    keyword=[keyword stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    if ([keyword isEqualToString:@""]) {
        [ZQTools svpInfo:@"不能为空"];
        return;
    }
//    if (_abc==2) {
//
//        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:keyword,@"keyword",@1,@"page",nil];
//
//        [ZQTools AFNGetDataUrl:@"voice/search" Dict:dic andTableView:nil andView:self.view andSuccessBlock:^(id responseObject) {
//            [_aView.tableArr addObjectsFromArray:responseObject];
//            [_aView.tableView reloadData];
//            if (_aView.tableArr.count==0) {
//                [kongBai creatWeiSouSuoDao:self.view];
//            }
//        } anderrorBlock:nil];
//
//    }
//    else{
//        NSString *url=[NSString stringWithFormat:@"home/searchScenic/%@",keyword];
//        NSString*hString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [ZQTools AFNGetDataUrl:hString Dict:nil andTableView:nil andView:self.view andSuccessBlock:^(id responseObject) {
//            [_aView.tableArr addObjectsFromArray:responseObject];
//            [_aView.tableView reloadData];
//            if (_aView.tableArr.count==0) {
//                [kongBai creatWeiSouSuoDao:self.view];
//            }
//        } anderrorBlock:nil];
//
//
//    }
    
    
}
-(void)getBanner{
    [ZQTools AFNPostDataUrl:@"app/banner" Dict:nil andTableView:nil andView:self.view andSuccessBlock:^(id responseObject) {
        _aView.bannerArr=responseObject;
          [self locatemap];
        
    } anderrorBlock:nil];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
