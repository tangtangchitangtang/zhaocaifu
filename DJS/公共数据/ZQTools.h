//
//  ZQTools.h
//  yiyou
//
//  Created by tangtangchitangtang on 2017/8/1.
//  Copyright © 2017年 tangtangchitangtang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import<MediaPlayer/MediaPlayer.h>
#import "TZImagePickerController.h"  //系统媒体库处理封装

@interface ZQTools : NSObject <TZImagePickerControllerDelegate>

#pragma mark————————————单利 初始化
+ (instancetype)sharedZQTools;

//一个公用的block  返回一个数据
typedef void (^responseObjectBlock)(id responseObject);

//一个ZQTools公用的属性 返回值
@property (nonatomic,strong)responseObjectBlock dataBlock;


//添加一个黑色透明背景
@property (nonatomic,strong)UIButton *backButton;
- (void)dismissSelfView;
//隐藏背景后的block
//选择完成后的回调
typedef void (^seletedBlock) (void);
@property (nonatomic,strong)seletedBlock seletedblock;

+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;;
#pragma mark————————————————无限轮播器  (依赖GDScrollBanner)
+ (void)getHederImage :(CGRect)rect :(NSArray*)imageUrlArr :(CGFloat)fenYeheight :(UIView *)rootView :(void(^)(int value)) block;

//图片点击的block
typedef void(^MyBlock)(int value);


#pragma mark————————————————跳转 push
+ (void)pushNextViewController:(UIViewController *)nextViewController andRootController:(UIViewController *)rootVc;

#pragma mark———————————————— 计算文字宽度
+ (CGSize)getNSStringWeight:(NSString *)string andViewWight:(CGFloat)height andFont:(NSInteger)font;
#pragma mark———————————————— 计算文字高度
+ (CGSize)getNSStringSize:(NSString *)string andViewWight:(CGFloat)weight andFont:(NSInteger)font;


#pragma mark———————————————— afn封装 //依赖afn 和FCXRefreshHeaderView 和SVProgressHUD
//url 接口地址
//dict 参数字典
//tableView 用来结束上下拉刷新的状态  不传不结束
//view 当前vc的view 显示菊花
//responseObjectBlock 成功之行的block
+ (void)AFNPostDataUrl:(NSString *)url Dict:(NSDictionary *)dict andTableView:(UIScrollView *)tableview andView:(UIView *)view andSuccessBlock:(responseObjectBlock)responseObjectBlock anderrorBlock:(void(^)(void))errorBlock;

+ (void)AFNGetDataUrl:(NSString *)url Dict:(NSDictionary *)dict andTableView:(UIScrollView *)tableview andView:(UIView *)view andSuccessBlock:(responseObjectBlock)responseObjectBlock anderrorBlock:(void(^)(void))errorBlock;

#pragma mark——————————————转换时间锉 传入时间锉字符串  得到解析后的字符串(DateFormat是需要的时间格式)
+ (NSString *)changeTimeCuo: (NSString *)DateFormat : (NSString *)time;

+(NSString *)getLeiSiQQShiJian:(NSString *)cuo;

#pragma mark——————————————————NSString转NSDate (DateFormat是你要转换的时间格式)
+ (NSDate *)NSStringToNSDate:(NSString *)DateFormat : (NSString *)dateStr;

#pragma mark————————————————nsdate 转 时间搓
+ (NSString *)NSDateToTimeCuo:(NSDate *)date;

#pragma mark——————————————获取当前版本号
+ (NSString *)getAPPBanben;


#pragma mark————————————————清除sdwebImage里面的缓存
+ (void)clearSDWebImageChace;

#pragma mark————————————————获取sdwebImage缓存大笑
+ (void)getSDWebImageChaceSize:(SDWebImageCalculateSizeBlock)completionBlock;

//手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
#pragma mark——————————给lable某段文字颜色
+ (void)withLableAddColorWithLable:(UILabel *)lable with:(NSString *)colorString WithColor:(UIColor *)color;

#pragma mark——————————给lable某段改变大小
+ (void)withLableAddSizeWithLable:(UILabel *)lable with:(NSString *)str WithFont:(NSInteger )fontSize;


#pragma mark———————————七牛上传图片
+(void)qiNiu:(NSString *)token :(NSData *)data success:(responseObjectBlock)responseObjectBlock;

#pragma mark———————————七牛上传图片
+(void)qiNiu2:(NSString *)token :(NSNumber *)abc :(NSData *)data success:(responseObjectBlock)responseObjectBlock;

#pragma mark———————————下载音频
+ (void)downloadURL:(NSString *) downloadURL progress:(void (^)(NSProgress * downloadProgress))progress destination:(void (^)(NSURL *targetPath))destination failure:(void(^)(NSError *error))faliure;

#pragma mark————————————————上传图片(获取到当前时间格式为yyyyMMddHHmmssss)
+(NSString *)curTimeString;

#pragma mark————————————————上传图片
+ (void)afnPostImageWithDict:(NSDictionary *)dict WithAddressUrl:(NSString *)addressUrl isOrUTF8:(BOOL)UTF8 withImageArr:(NSArray *)imageArr withFileName:(NSString *)fileName   WithView:(UIView *)view   success:(responseObjectBlock)responseObjectBlock;


#pragma mark————————————拨打电话(依赖 CoreMediaFuncManagerVC)
+ (void)callTelNumber:(NSString *)telNumber inViewController:(UIViewController *)cuVc failBlock:(void(^)())failBlock;
#pragma mark——————————转换手机格式
+(NSString *)PhoneModel:(NSString *)phoneStr;
#pragma mark——————————判断空字符串
+(BOOL)charIsNil:(NSString *)str;

#pragma mark————————————清空view子view
+ (void)cleanViewSubviews:(UIView *)view;

#pragma mark ————————————生成二维码
+(UIImage *)createNonInterpolatedUIImageFormString:(NSString*)Path withSize:(CGFloat) size;

#pragma mark————————svp提醒
+ (void)svpInfo:(NSString *)title;


#pragma mark——————————以下功能基于TZImagePickerController框架
/** 相册 */
- (void)openAlbumWithMaxImgNumber:(int)maxNumber WithCuVc:(UIViewController *)cuVc  withOverBlock:(responseObjectBlock)dataBlock;

//1. 获取缓存文件的大小
+( float )readCacheSize;

+ ( float ) folderSizeAtPath:( NSString *) folderPath;

+ ( long long ) fileSizeAtPath:( NSString *) filePath;

+ (NSString *)clearFile;



+(UIImage *) getImageFromURL:(NSString *)fileURL ;

//判断密码的长度
+(BOOL)pwdIsYes:(NSString *)pwdStr;

@end
