//
//  ZQTools.m
//  yiyou
//
//  Created by tangtangchitangtang on 2017/8/1.
//  Copyright © 2017年 tangtangchitangtang. All rights reserved.
//

#import "ZQTools.h"



#import "Toast.h"
#import "NSString+CZNSStringExt.h"
#import "NSString+ArvinCategory.h" //把字典的参数转为汉字
//#import "EmptyViewFactory.h"//tableView没有数据的占位效果
#import "ZKImgRunLoopView.h"//轮播器

#import <sys/utsname.h>

#import "AppDelegate.h"
#import<CommonCrypto/CommonDigest.h> //苹果自带的MD5加密

#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>

//MD5加密
#import "NSString+Hash.h"

//更改系统导航栏透明度
#import <objc/runtime.h>

//#import "JIUUserDataManager.h"       //获取手机udid用

//#import "CoreBlurView.h"             //模糊效果

//#import "CoreMediaFuncManagerVC.h"   //拨打电话

@implementation ZQTools

#pragma mark————————————单利 初始化
+ (instancetype)sharedZQTools
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[ZQTools alloc]init];
        
        
    });
    
    return instance;
    
}


+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size
{
    CGSize originalsize = [originalImage size];
    NSLog(@"改变前图片的宽度为%f,图片的高度为%f",originalsize.width,originalsize.height);
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}
#pragma mark———————————————— 轮播图 依赖GDScrollBanner
+ (void)getHederImage :(CGRect)rect :(NSArray*)imageUrlArr :(CGFloat)fenYeheight :(UIView *)rootView :(void(^)(int value)) block
{
    
    //网络图片happendTime
    //网络图片

    
    
    
    ZKImgRunLoopView *imgRunView = [[ZKImgRunLoopView alloc] initWithFrame:rect fenYeheight:fenYeheight placeholderImg:_zhanweiImageData];
    imgRunView.imgUrlArray =imageUrlArr;
    [rootView addSubview:imgRunView];

    [imgRunView  touchImageIndexBlock:^(NSInteger index) {
        
        if(block!=nil)
        {
            block((int)index);
        }
    }];
    
}

#pragma mark———————————————— 跳转 push
+ (void)pushNextViewController:(UIViewController *)nextViewController andRootController:(UIViewController *)rootVc
{
    
    
    rootVc.hidesBottomBarWhenPushed = YES;
    
    [nextViewController.navigationController pushViewController:rootVc
                                                       animated:YES];
    
}


#pragma mark———————————————— 计算文字宽度
+ (CGSize)getNSStringWeight:(NSString *)string andViewWight:(CGFloat)height andFont:(NSInteger)font
{
    
    
    return  [string sizeOfTextWithMaxSize:CGSizeMake(MAXFLOAT, height) font:[UIFont systemFontOfSize:font]];
    
}

#pragma mark———————————————— 计算文字高度
+ (CGSize)getNSStringSize:(NSString *)string andViewWight:(CGFloat)weight andFont:(NSInteger)font
{
    
    
    return  [string sizeOfTextWithMaxSize:CGSizeMake(weight, MAXFLOAT) font:[UIFont systemFontOfSize:font]];
    
}

#pragma mark———————————————— afn封装 //依赖afn 和FCXRefreshHeaderView 和SVProgressHUD
//url 接口地址
//dict 参数字典
//tableView 用来结束上下拉刷新的状态  不传不结束
//view 当前vc的view 显示菊花
//responseObjectBlock 成功之行的block
+ (void)AFNPostDataUrl:(NSString *)url Dict:(NSDictionary *)dict andTableView:(UIScrollView *)tableview andView:(UIView *)view andSuccessBlock:(responseObjectBlock)responseObjectBlock anderrorBlock:(void(^)(void))errorBlock
{
    
    
    //如果正在上下拉刷新 就不显示
    if([tableview.mj_header isRefreshing]==NO&&[tableview.mj_footer isRefreshing]==NO)
    {
        
        if(view!=nil)
        {
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
    }
    
  
    NSString *allUrl = [NSString stringWithFormat:@"%@/%@",_addressUrl,url];
    
    allUrl= [allUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    

    
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];//默认是yes
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
   
    
    [manager POST:allUrl  parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //打印接口地址和参数 和返回的参数
            NSLog(@"\n接口调用成功___\n根地址___%@\n接口:%@ \n参数:%@  \n返回的参数%@",_addressUrl,url,dict,[[responseObject description] kdtk_stringByReplaceingUnicode]);
            
            
            [MBProgressHUD hideHUDForView:view animated:YES];
            
            [tableview.mj_header endRefreshing];
            
            [tableview.mj_footer endRefreshing];
            
            BaseModel *dataModel = [BaseModel mj_objectWithKeyValues:responseObject];
            if ([dataModel.errCode isEqualToString:@"1"]) {
                if(responseObjectBlock!=nil)
                {
                    responseObjectBlock(dataModel.data);
                }
                return ;
            }
            else
            {
                [ZQTools svpInfo:dataModel.errMsg];
            }
            
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:view animated:YES];
            
            [tableview.mj_header endRefreshing];
            
            [tableview.mj_footer endRefreshing];
            
            //打印接口地址和参数 和返回的参数
            NSLog(@"\n报错___\n根地址___%@\n接口:%@ \n参数:%@  \n返回的失败原因%@",_addressUrl,url,dict,error);
            
          
            
            [FTToastIndicator dismiss];
            [ZQTools svpInfo:@"网络连接失败"];
            
            if(errorBlock!=nil)
            {
                errorBlock();
            }
            
        });
    }];
    
    
    
    
}

+ (void)AFNGetDataUrl:(NSString *)url Dict:(NSDictionary *)dict andTableView:(UIScrollView *)tableview andView:(UIView *)view andSuccessBlock:(responseObjectBlock)responseObjectBlock anderrorBlock:(void(^)(void))errorBlock
{
    
    
    //如果正在上下拉刷新 就不显示
    if([tableview.mj_header isRefreshing]==NO&&[tableview.mj_footer isRefreshing]==NO)
    {
        
        if(view!=nil)
        {
            
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    NSString *authorization=[dict objectForKey:@"authorization"];
    if (![ZQTools charIsNil:authorization]) {
        [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"authorization"];
    }
    
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];//默认是yes
    
    
    
    NSString *allUrl = [NSString stringWithFormat:@"%@/%@",_addressUrl,url];
    
    [manager GET:allUrl  parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            //打印接口地址和参数 和返回的参数
            NSLog(@"\n接口调用成功___\n根地址___%@\n接口:%@ \n参数:%@  \n返回的参数%@",_addressUrl,url,dict,[[responseObject description] kdtk_stringByReplaceingUnicode]);
            
            [MBProgressHUD hideHUDForView:view animated:YES];
            
            [tableview.mj_header endRefreshing];
            
            [tableview.mj_footer endRefreshing];
            
            responseObjectBlock(responseObject);
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:view animated:YES];
            
            [tableview.mj_header endRefreshing];
            
            [tableview.mj_footer endRefreshing];
            
            //打印接口地址和参数 和返回的参数
            NSLog(@"\n报错___\n根地址___%@\n接口:%@ \n参数:%@  \n返回的失败原因%@",_addressUrl,url,dict,error);
            
            [FTToastIndicator dismiss];
            [ZQTools svpInfo:@"网络连接失败"];
            
            if(errorBlock!=nil)
            {
                errorBlock();
            }
            
        });
    }];
}




#pragma mark——————————————转换时间锉 传入时间锉字符串  得到解析后的字符串
+ (NSString *)changeTimeCuo: (NSString *)DateFormat : (NSString *)time
{
    
    //如果带有网页标签 就先去掉
    if([time rangeOfString:@"/Date"].location !=NSNotFound)//_roaldSearchText
    {
        
        //去掉多余的字符
        NSString *timeString = [[time stringByReplacingOccurrencesOfString:@"/Date(" withString:@""] stringByReplacingOccurrencesOfString:@"000)/" withString:@""];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:DateFormat];
        
        
        
        double timeInt =[timeString doubleValue];
        
        
        
        NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:timeInt];
        
        
        
        
        
        NSString *myNewDateString = [formatter stringFromDate:date1];
        return myNewDateString;
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:DateFormat];
        
        
        //这里看后台返回的时间锉 长度是否为包含了毫秒级 如果返回了毫秒级 就／1000才能解析成正常的时间
        
        double timeInt =[time doubleValue]/1000;
        
        
        
        NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:timeInt];
        
        
        
        
        
        NSString *myNewDateString = [formatter stringFromDate:date1];
        return myNewDateString;
    }
    
    
}


#pragma mark——————————————————NSString转NSDate (年月日)
+ (NSDate *)NSStringToNSDate:(NSString *)DateFormat : (NSString *)dateStr
{
    //先获得开始时间
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:DateFormat];
    
    NSDate *date=[dateFormatter dateFromString:dateStr];
    
    return date;
}

#pragma mark————————————————nsdate 转 时间搓
+ (NSString *)NSDateToTimeCuo:(NSDate *)date
{
    
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    
    return timeSp;
}

#pragma mark——————————————获取当前版本号
+ (NSString *)getAPPBanben
{
    
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

#pragma mark——————————给view 添加一个黑色透明背景 如果为空  就添加到window
- (void)addBackView:(UIView *)view
{
    
    if(self.backButton==nil)
    {
        
        
        //蒙板view
        self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _mainW, _mainH)];
        self.backButton.backgroundColor =[UIColor blackColor];
        
        self.backButton.alpha = 0;
        
        
        //设置手势
        [self.backButton addTarget:self action:@selector(dismissSelfView) forControlEvents:UIControlEventTouchUpInside];
        
        
        if(view==nil)
        {
            [[[UIApplication sharedApplication] keyWindow]addSubview:self.backButton];
        }
        else
        {
            [view addSubview:self.backButton];
        }
        
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            self.backButton.alpha = 0.7;
            
            
        }];
        
    }
    
    
    
}

#pragma mark————————————————清除sdwebImage里面的缓存
+ (void)clearSDWebImageChace{
    
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    
    
}

#pragma mark————————————————获取sdwebImage缓存大笑
+ (void)getSDWebImageChaceSize:(SDWebImageCalculateSizeBlock)completionBlock{
    
    [SDWebImageManager.sharedManager.imageCache
     calculateSizeWithCompletionBlock:completionBlock];
    
    //    NSLog(@"有%d张图片 缓存%.2fM",fileCount,totalSize / 1024.0 / 1024.0);
    
}

//手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    //移动号段正则表达式
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    //联通号段正则表达式
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    //电信号段正则表达式
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobileNum];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:mobileNum];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:mobileNum];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark——————————给lable某段文字颜色
+ (void)withLableAddColorWithLable:(UILabel *)lable with:(NSString *)colorString WithColor:(UIColor *)color
{
    if(colorString!=nil)
    {
        NSRange range1 = [lable.text rangeOfString:colorString];
        NSMutableAttributedString *richText =[[NSMutableAttributedString alloc]initWithAttributedString:lable.attributedText];
        [richText addAttribute:NSForegroundColorAttributeName value:color range:range1];
        lable.attributedText = richText;
    }
    
}

#pragma mark——————————给lable某段改变大小
+ (void)withLableAddSizeWithLable:(UILabel *)lable with:(NSString *)str WithFont:(NSInteger )fontSize
{
    if(str!=nil)
    {
        NSRange range1 = [lable.text rangeOfString:str];
        NSMutableAttributedString *richText =[[NSMutableAttributedString alloc]initWithAttributedString:lable.attributedText];
        
        //文字大小
        [richText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range1];
        
        lable.attributedText = richText;
    }
    
}

+(NSString *)getLeiSiQQShiJian:(NSString *)cuo{
    NSString *time1=[self changeTimeCuo:@"yyyy:MM:dd:HH:mm" :cuo];
    NSDate *date=[NSDate date];
    NSString* time2=[self changeTimeCuo:@"yyyy:MM:dd:HH:mm" :[self NSDateToTimeCuo:date]];
    NSArray *timeArr1=[time1 componentsSeparatedByString:@":"];
    NSArray *timeArr2=[time2 componentsSeparatedByString:@":"];
    if ([timeArr1[0] intValue]<[timeArr2[0] intValue]) {
        return [self changeTimeCuo:@"yyyy/MM/dd HH:mm" :cuo];
    }
    else if([timeArr1[1] intValue]<[timeArr2[1] intValue]){
        return [self changeTimeCuo:@"MM-dd HH:mm" :cuo];
    }
    else if([timeArr1[2] intValue]<=[timeArr2[2] intValue]){
        if ([timeArr2[2] intValue]-[timeArr1[2] intValue]>2) {
             return [self changeTimeCuo:@"MM-dd HH:mm" :cuo];
        }if ([timeArr2[2] intValue]-[timeArr1[2] intValue]==2) {
           
        }
        if([timeArr2[2] intValue]-[timeArr1[2] intValue]==1) {
            return [NSString stringWithFormat:@"昨天%@" ,[self changeTimeCuo:@"HH:mm" :cuo]];
        }
        if([timeArr2[2] intValue]-[timeArr1[2] intValue]==0) {
             return [NSString stringWithFormat:@"今天%@" ,[self changeTimeCuo:@"HH:mm" :cuo]];
        }
    }
    
    
    return @"dasf";
}


+(NSString *)curTimeString
{
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *curDate = [NSDate date];//获取当前日期
    [formater setDateFormat:@"yyyyMMddHHmmssss"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    
    NSLog(@"%@",curTime);
    
    return curTime;
}


#pragma mark———————————下载音频
+ (void)downloadURL:(NSString *) downloadURL progress:(void (^)(NSProgress * downloadProgress))progress destination:(void (^)(NSURL *targetPath))destination failure:(void(^)(NSError *error))faliure{
    
    
    //下载
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:downloadURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"%@",error);
        }
        else
        {
            NSLog(@"%@",filePath);
            //回传 储存路径
            destination(filePath);
            
        }
    }];
    //开始下载
    [downloadTask resume];
}



#pragma mark————————————————上传图片
+ (void)afnPostImageWithDict:(NSDictionary *)dict WithAddressUrl:(NSString *)addressUrl isOrUTF8:(BOOL)UTF8 withImageArr:(NSArray *)imageArr withFileName:(NSString *)fileName   WithView:(UIView *)view   success:(responseObjectBlock)responseObjectBlock{
    
    //菊花
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [hud showAnimated:YES];
    
    NSString *source=@"02";
    NSString *channel=@"pingguo";
    
    
    NSDictionary *dic2 = [NSKeyedUnarchiver unarchiveObjectWithFile:_userModelFile];
    
    NSString *client_id = [[NSUUID UUID] UUIDString];
    NSString *app_version=[self getAPPBanben];
    NSString *os_name=@"Ios";
    NSString *client_model = [self iphoneType];//方法在下面
    NSString *uid=[dic2 objectForKey:@"uid"];
    
    
    NSString *ip=[self deviceIPAdress];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *dic = [defaults objectForKey:@"dingWei"];
    //    NSString *position=[dic objectForKey:@"cityName"];
    NSString *position=@"chongqing";
    //    position= [self firstCharactor:position];
    
    NSString *timestamp=[self NSDateToTimeCuo:[NSDate new]];
  
    NSString *paramsStr;
    
    
    NSArray *nameArr = [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (int i=0; i<nameArr.count; i++) {
        NSString *str=[dict objectForKey:nameArr[i]];
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        str= [self encodeString:str];
        if (i==0) {
            paramsStr=[NSString stringWithFormat:@"%@=%@&",nameArr[i],str];
        }else{
            paramsStr=[NSString stringWithFormat:@"%@%@=%@&",paramsStr,nameArr[i],str];
        }
    }
    paramsStr=[paramsStr substringToIndex:paramsStr.length-1];
    
    if ([self charIsNil:paramsStr]) {
        paramsStr=@"";
    }

    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", app_key, source, channel, app_version, client_id, timestamp, paramsStr];
    
    
    
    sign=[sign md5String];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:app_key forHTTPHeaderField:@"app_key"];
    [manager.requestSerializer setValue:app_version forHTTPHeaderField:@"app_version"];
    [manager.requestSerializer setValue:channel forHTTPHeaderField:@"channel"];
    [manager.requestSerializer setValue:client_id forHTTPHeaderField:@"client_id"];
    [manager.requestSerializer setValue:client_model forHTTPHeaderField:@"client_model"];
    [manager.requestSerializer setValue:ip forHTTPHeaderField:@"ip"];
    [manager.requestSerializer setValue:os_name forHTTPHeaderField:@"os_name"];
    [manager.requestSerializer setValue:position forHTTPHeaderField:@"position"];
    [manager.requestSerializer setValue:source forHTTPHeaderField:@"source"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [manager.requestSerializer setValue:uid forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:sign forHTTPHeaderField:@"sign"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",_addressUrl,addressUrl] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        //这个就是流参数
        // 传图片
        for (int x=0; x<imageArr.count; x++) {
            
            
            UIImage *image = imageArr[x];
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            if(imageData==nil)
            {
                imageData = UIImagePNGRepresentation(image);
            }
            
            [formData appendPartWithFileData:imageData name:fileName fileName:[NSString stringWithFormat:@"%@%d.png",[ZQTools curTimeString],0] mimeType:@"image/png"];
            
        }
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [MBProgressHUD hideHUDForView:view animated:YES];
        
         responseObjectBlock(responseObject);
        
    }  failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:view animated:YES];
        
        //打印接口地址和参数 和返回的参数
        NSLog(@"\n报错___\n根地址___%@\n接口:%@ \n参数:%@  \n返回的参数%@",_addressUrl,addressUrl,dict,error);
        
        [FTToastIndicator dismiss];
        
        [ZQTools svpInfo:@"网络连接失败"];
        
        
    }];
    
    
    
    
}

+(NSString*)encodeString:(NSString*)unencodedString{

    NSString *str=@"";
    NSArray *array = [unencodedString componentsSeparatedByString:@" "];
    for (int i=0;i<array.count; i++) {
        if (i==0) {
             str= [array[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        else{
            str=[NSString stringWithFormat:@"%@+%@",str,[array[i]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    return str;
}


#pragma mark——————————隐藏背景
- (void)dismissSelfView
{
    
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        self.backButton.alpha = 0;
        
        
    }completion:^(BOOL finished) {
        
        
        [self.backButton removeFromSuperview];
        self.backButton=nil;
    }];
    
    
    if(self.seletedblock!=nil)
    {
        self.seletedblock();
    }
}

//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(self.dataBlock!=nil)
        {
            self.dataBlock(photos);
            
        }
    });
}

#pragma mark——————————以下功能基于TZImagePickerController框架
/** 相册 */
- (void)openAlbumWithMaxImgNumber:(int)maxNumber WithCuVc:(UIViewController *)cuVc  withOverBlock:(responseObjectBlock)dataBlock{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.dataBlock =dataBlock;
        
        TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:maxNumber delegate:self];
        
        
        //是否 在相册中显示拍照按钮
        imagePickController.allowTakePicture = NO;
        //是否可以选择显示原图
        imagePickController.allowPickingOriginalPhoto = NO;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = NO;
        
        [cuVc presentViewController: imagePickController animated:YES completion:nil];
        
    });
}

//#pragma mark————————————拨打电话(依赖 CoreMediaFuncManagerVC)
//+ (void)callTelNumber:(NSString *)telNumber inViewController:(UIViewController *)cuVc failBlock:(void(^)())failBlock{
//    
//    
//    [CoreMediaFuncManagerVC call:telNumber inViewController:cuVc failBlock:failBlock];
//}



+(NSString *)PhoneModel:(NSString *)phoneStr{
    
    if(phoneStr==nil)
    {
        return @"";
    }
    NSString *phone=[NSString stringWithFormat:@"%@****%@",[phoneStr substringToIndex:3],[[phoneStr substringFromIndex:7] substringToIndex:4]];
    return phone;
}
//判断字符是否为空
+(BOOL)charIsNil:(NSString *)str{
    
    if ([str isKindOfClass:[NSNull class]]||[str isEqualToString:@""]||str==nil) {
        return YES;
    }
    return  NO;
}


#pragma mark————————————清空view子view
+ (void)cleanViewSubviews:(UIView *)view{
    
    for (UIView *sonView in view.subviews) {
        [sonView removeFromSuperview];
    }
    
}

#pragma mark————————生成二维码
+(UIImage *)createNonInterpolatedUIImageFormString:(NSString*)Path withSize:(CGFloat) size
{
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    NSString *dataString =Path;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage * outputImage= [filter outputImage];
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark————————svp提醒
+ (void)svpInfo:(NSString *)title
{
    
    //    Toast *toast = [Toast toast]; //创建一个toast
    //
    //    [toast makeText:title]; //显示
    //
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [FTIndicator setIndicatorStyle:UIBlurEffectStyleDark];
        [FTIndicator showToastMessage:title];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [FTIndicator dismissToast];
            
        });
        
    });
    
}

//1. 获取缓存文件的大小
+(float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}

+ ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}

+ ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

+ (NSString *)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
    [self clearSDWebImageChace];
    //读取缓存大小
    float cacheSize = [self readCacheSize] ;
    return [NSString stringWithFormat:@"%.2fMB",cacheSize];
    
}


+(NSDictionary *)parseJSONStringToNSDictionary:(NSData *)JSONString {
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONString options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
+(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

//判断密码的的格式

+(BOOL)pwdIsYes:(NSString *)pwdStr{
    if (pwdStr.length<6||pwdStr.length>20) {
        return YES;
    }
    
    return NO;
}

//判断字符串为纯数字
- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

+(NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}

+ (NSString *)deviceIPAdress {
    
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    
    //    if (sockfd <</span> 0) return nil;
    
    NSMutableArray *ips = [NSMutableArray array];
    
    
    
    int BUFFERSIZE =4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len =sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
                
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            
            
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
            
        }
        
    }
    
    close(sockfd);
    
    
    
    
    
    NSString *deviceIP =@"";
    
    for (int i=0; i < ips.count; i++)
        
    {
        
        if (ips.count >0)
            
        {
            
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
            
            
            
        }
        
    }
    
    NSLog(@"deviceIP========%@",deviceIP);
    return deviceIP;
    
 }



+ (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}



@end
