//
//  robotSettingBillColorView.m
//  wechatHook
//
//  Created by antion on 2017/10/21.
//
//

#import "robotSettingBillColorView.h"
#import "ycButtonView.h"
#import "toolManager.h"

@implementation robotSettingBillColorView {
    NSString* mKey;
    UILabel* mExaple;
    UILabel* mLabelR;
    UILabel* mLabelG;
    UILabel* mLabelB;
    UISlider* mSliderR;
    UISlider* mSliderG;
    UISlider* mSliderB;
}

-(id) initWithFrame:(CGRect)frame key:(NSString*)key {
    if (self = [super initWithFrame: frame]) {
        mKey = [key retain];
        
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 22)];
        title.center = CGPointMake(self.frame.size.width/2, 30);
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor yellowColor];
        [self addSubview:title];
        [title release];
        
        mExaple = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 22)];
        mExaple.textAlignment = NSTextAlignmentCenter;
        mExaple.textColor = [UIColor whiteColor];
        [self addSubview:mExaple];
        [mExaple release];
        
        int r, g, b;
        if ([key isEqualToString: @"titleR"]) {
            title.text = @"设置【标题背景颜色】";
            mExaple.text = @"标题背景颜色";
            r = [tmanager.mRobot.mData.mBaseSetting[@"titleTextR"] intValue];
            g = [tmanager.mRobot.mData.mBaseSetting[@"titleTextG"] intValue];
            b = [tmanager.mRobot.mData.mBaseSetting[@"titleTextB"] intValue];
            mExaple.textColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
            r = [tmanager.mRobot.mData.mBaseSetting[@"titleR"] intValue];
            g = [tmanager.mRobot.mData.mBaseSetting[@"titleG"] intValue];
            b = [tmanager.mRobot.mData.mBaseSetting[@"titleB"] intValue];
        }
        else if ([key isEqualToString: @"titleTextR"]) {
            title.text = @"设置【标题文字颜色】";
            mExaple.text = @"标题文字颜色";
            r = [tmanager.mRobot.mData.mBaseSetting[@"titleR"] intValue];
            g = [tmanager.mRobot.mData.mBaseSetting[@"titleG"] intValue];
            b = [tmanager.mRobot.mData.mBaseSetting[@"titleB"] intValue];
            mExaple.backgroundColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
            r = [tmanager.mRobot.mData.mBaseSetting[@"titleTextR"] intValue];
            g = [tmanager.mRobot.mData.mBaseSetting[@"titleTextG"] intValue];
            b = [tmanager.mRobot.mData.mBaseSetting[@"titleTextB"] intValue];
        }
        else if ([key isEqualToString: @"trendHighR"]) {
            title.text = @"设置【往期走势图圆颜色】";
            r = [tmanager.mRobot.mData.mBaseSetting[@"trendHighR"] intValue];
            g = [tmanager.mRobot.mData.mBaseSetting[@"trendHighG"] intValue];
            b = [tmanager.mRobot.mData.mBaseSetting[@"trendHighB"] intValue];
            mExaple.text = @"牛牛";
            mExaple.frame = CGRectMake(0, 0, 36, 36);
            mExaple.font = [UIFont boldSystemFontOfSize: 16];
            mExaple.layer.masksToBounds = YES;
            mExaple.layer.cornerRadius = mExaple.bounds.size.width/2;
        }
        else if ([key isEqualToString: @"trendCurrentR"]) {
            title.text = @"设置【本期走势图圆颜色】";
            r = [tmanager.mRobot.mData.mBaseSetting[@"trendCurrentR"] intValue];
            g = [tmanager.mRobot.mData.mBaseSetting[@"trendCurrentG"] intValue];
            b = [tmanager.mRobot.mData.mBaseSetting[@"trendCurrentB"] intValue];
            mExaple.text = @"牛牛";
            mExaple.frame = CGRectMake(0, 0, 36, 36);
            mExaple.font = [UIFont boldSystemFontOfSize: 16];
            mExaple.layer.masksToBounds = YES;
            mExaple.layer.cornerRadius = mExaple.bounds.size.width/2;
        }
        mExaple.center = CGPointMake(self.frame.size.width/2, 90);
        
        mSliderR = [[UISlider alloc] initWithFrame:CGRectMake(10, 160, 210, 20)];
        mSliderR.minimumValue = 0;
        mSliderR.maximumValue = 255;
        mSliderR.value = r;
        mSliderR.continuous = YES;
        [mSliderR addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:mSliderR];
        
        mSliderG = [[UISlider alloc] initWithFrame:CGRectMake(10, 230, 210, 20)];
        mSliderG.minimumValue = 0;
        mSliderG.maximumValue = 255;
        mSliderG.value = g;
        mSliderG.continuous = YES;
        [mSliderG addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:mSliderG];
        
        mSliderB = [[UISlider alloc] initWithFrame:CGRectMake(10, 300, 210, 20)];
        mSliderB.minimumValue = 0;
        mSliderB.maximumValue = 255;
        mSliderB.value = b;
        mSliderB.continuous = YES;
        [mSliderB addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:mSliderB];
        
        mLabelR = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 100, 22)];
        mLabelR.textAlignment = NSTextAlignmentLeft;
        mLabelR.text = @"R: 255";
        mLabelR.textColor = [UIColor yellowColor];
        [self addSubview:mLabelR];
        [mLabelR release];
        
        mLabelG = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 100, 22)];
        mLabelG.textAlignment = NSTextAlignmentLeft;
        mLabelG.text = @"G: 255";
        mLabelG.textColor = [UIColor yellowColor];
        [self addSubview:mLabelG];
        [mLabelG release];
        
        mLabelB = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 100, 22)];
        mLabelB.textAlignment = NSTextAlignmentLeft;
        mLabelB.text = @"B: 255";
        mLabelB.textColor = [UIColor yellowColor];
        [self addSubview:mLabelB];
        [mLabelB release];

        ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 80, 30) text: @"确定" func: ^() {
            int r = (int)mSliderR.value;
            int g = (int)mSliderG.value;
            int b = (int)mSliderB.value;
            self.mFunc(true, r, g, b);
        }];
        okBtn.center = CGPointMake(self.frame.size.width/2-50, self.frame.size.height-30);
        [self addSubview: okBtn];
        [okBtn release];
        
        ycButtonView* cancelBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 80, 30) text: @"取消" func: ^(){
            self.mFunc(false, 0, 0, 0);
        }];
        cancelBtn.center = CGPointMake(self.frame.size.width/2+50, self.frame.size.height-30);
        [self addSubview: cancelBtn];
        [cancelBtn release];
        
        [self updateUI];
    }
    return self;
}

-(void) dealloc {
    self.mFunc = nil;
    [mKey release];
    [super dealloc];
}

-(void) sliderValueChanged:(UISlider*)sender {
    [self updateUI];
}

-(void) updateUI {
    int r = (int)mSliderR.value;
    int g = (int)mSliderG.value;
    int b = (int)mSliderB.value;
    
    mLabelR.text = deString(@"R: %d", r);
    mLabelG.text = deString(@"G: %d", g);
    mLabelB.text = deString(@"B: %d", b);
    
    UIColor* color = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    if ([mKey isEqualToString: @"titleTextR"]) {
        mExaple.textColor = color;
    }
    else {
        mExaple.backgroundColor = color;
    }
}

@end

