//
//  CustomBtnView.h
//  archcollege
//
//  Created by Apple on 17/2/15.
//  Copyright © 2017年 zhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBtnView : UIView{
    
    NSArray *_titleArr;
}
@property(nonatomic,strong)NSMutableArray *titleBtnArr;
-(void)setupUITitleArr:(NSArray *)arr;
-(void)layoutContentUI;
+(CGFloat)getHeight:(NSArray *)titleArr;
+(NSInteger)getIndexFromArr:(NSArray *)arr;


@property(nonatomic,copy)void(^selectedBlock) (NSInteger index);

@end
