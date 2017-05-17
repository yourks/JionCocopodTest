//
//  CustomBtnView.m
//  archcollege
//
//  Created by Apple on 17/2/15.
//  Copyright © 2017年 zhx. All rights reserved.
//

#import "CustomBtnView.h"
#import "Masonry.h"

#define CustomBtnView_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define CustomBtnView_WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

static NSInteger customBtnView_Tag  = 1000000;

static CGFloat customBtnView_Space  = 12;

@interface CustomBtnView()

@end

@implementation CustomBtnView
- (instancetype)initWithPartTitle:(NSString *)partTitle
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(NSMutableArray *)titleBtnArr{
    if (!_titleBtnArr) {
        _titleBtnArr = [NSMutableArray array];
    }
    return _titleBtnArr;
}


-(void)setupUITitleArr:(NSArray *)arr{
    if (arr.count == 0) {
        return;
    }
    
    if (self.titleBtnArr.count>0) {
        
        [self removeAllSubviews];

    }
    
    _titleArr = [NSArray arrayWithArray:arr];
    for (NSInteger i = 0; i<arr.count; i++) {
        UIButton *titleBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        [self addSubview:titleBtn];
        [titleBtn setBackgroundColor:[UIColor yellowColor]];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn.titleLabel setFont:[CustomBtnView btnFont]];
        [self.titleBtnArr addObject:titleBtn];
    }
}

-(void)layoutContentUI{

    //顶部的距离
    CGFloat topOffest = 0;
    
    //哪一行
    NSInteger row = 0;
    //上一行最后一个的序号
    NSInteger beforeRowLastIndex = 0;
    //这一行最后一个的序号
    NSInteger rowLastIndex = 0;
    //当前按钮所在的行的行宽度
    CGFloat rowWidth = 0.0;
    
    for (NSInteger i = 0; i<self.titleBtnArr.count; i++) {
        
        if (rowLastIndex +1 == i ) {
            row ++;
            rowWidth = 0.0;
            beforeRowLastIndex = rowLastIndex +1;
        }
        
        if (i >=  rowLastIndex +1 || i== 0) {
            
            
            CGFloat nextBtnWidth = 0.0;
            
            //取得当前按钮所在的行的行宽度
            for (NSInteger j = beforeRowLastIndex ; j<self.titleBtnArr.count; j++) {
                rowWidth += [CustomBtnView getBtnWidth:_titleArr[j]] + customBtnView_Space;
                
                if (rowWidth - customBtnView_Space + 2*customBtnView_Space > CustomBtnView_SCREEN_WIDTH) {
                    //当前行的宽度
                    rowWidth = rowWidth - [CustomBtnView getBtnWidth:_titleArr[j]] - customBtnView_Space*2;
                    //这一行最后一个
                    rowLastIndex = j -1;
                    
                    nextBtnWidth =  [CustomBtnView getBtnWidth:_titleArr[j]] + customBtnView_Space*2;
                    break;
                }
            }
            
            //如果不足一行 那么当前行的宽度
            if (rowWidth + nextBtnWidth - customBtnView_Space + 2*customBtnView_Space < CustomBtnView_SCREEN_WIDTH ) {
                rowWidth = rowWidth - customBtnView_Space;
                rowLastIndex = self.titleBtnArr.count -1;
            }
            
        }
        

        
        CGFloat leadingOffes  = (CustomBtnView_SCREEN_WIDTH - rowWidth)/2;
        
        
        for (NSInteger k = beforeRowLastIndex; k<rowLastIndex+1; k++) {
            if (i> k) {
                leadingOffes  += [CustomBtnView getBtnWidth:_titleArr[k]] + customBtnView_Space;
            }
        }

        topOffest = row * ([CustomBtnView btnHeight] +customBtnView_Space);
        UIButton *titleBtn = self.titleBtnArr[i];

        [titleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(topOffest);
            make.leading.mas_equalTo(self).with.offset(leadingOffes);
            make.width.mas_equalTo([CustomBtnView getBtnWidth:_titleArr[i]]);
            make.height.mas_equalTo([CustomBtnView btnHeight]);
        }];
        
        titleBtn.tag = customBtnView_Tag+i;
        [titleBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleBtn setTitle:_titleArr[i] forState:UIControlStateNormal];
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([CustomBtnView btnHeight] + topOffest);
    }];
}

-(void)clickAction:(UIButton *)sender{
    
    
    if (self.selectedBlock) {
        self.selectedBlock(sender.tag - customBtnView_Tag);
    }
}

+(NSInteger)getIndexFromArr:(NSArray *)arr{

    if (arr.count == 0) {
        return 0;
    }
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:arr];
    
    //用于计算 是否开始下一行
    CGFloat rowWidth = 0.0;
    //哪一行
    NSInteger row = 0;

    
    for (NSInteger i = 0; i<dataArr.count; i++) {
        
        rowWidth += [CustomBtnView getBtnWidth:dataArr[i]] +customBtnView_Space;
    
        
        if (rowWidth - customBtnView_Space + 2*customBtnView_Space> CustomBtnView_SCREEN_WIDTH) {
            rowWidth = 0.0;
            row ++;
        }
        
        if (row == 4) {
            return i;
            break;
        }
    }
    return 0;
}

+(CGFloat)getBtnWidth:(NSString *)titleStr{
    CGSize size = [titleStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, [CustomBtnView btnHeight]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[CustomBtnView btnFont]} context:nil].size;
    
    return size.width + customBtnView_Space*2;
}

+(UIFont *)btnFont{
    return [UIFont systemFontOfSize:13.0];
}

+(CGFloat)btnHeight{
    return 36;
}


+(CGFloat)getHeight:(NSArray *)titleArr{
    //还可以优化 
    CGFloat leadingOffest = customBtnView_Space;
    
    NSInteger row = 0;
    
    CGFloat topOffest =  0;
    
    for (NSInteger i = 0; i<titleArr.count; i++) {
        
        if (i==0) {
            
        }else{
            leadingOffest += (customBtnView_Space + [CustomBtnView getBtnWidth:titleArr[i-1]]);
        }
        
        if (leadingOffest + [CustomBtnView getBtnWidth:titleArr[i]] + customBtnView_Space > CustomBtnView_SCREEN_WIDTH) {
            leadingOffest = customBtnView_Space;
            row ++;
        }
        
        topOffest = row * ([CustomBtnView btnHeight] +customBtnView_Space)  + [CustomBtnView btnHeight];
    }
    
    if (topOffest == 0) {
        return [CustomBtnView btnHeight];
    }
    
    return [CustomBtnView btnHeight] + topOffest;
}

-(void)deleteAllSubView{
    _titleArr = [NSArray array];
    [self.titleBtnArr removeAllObjects];
    [self removeAllSubviews];
}


- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}



@end
