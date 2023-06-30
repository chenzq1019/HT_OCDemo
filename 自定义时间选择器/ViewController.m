//
//  ViewController.m
//  自定义时间选择器
//
//  Created by 陈竹青 on 2022/8/29.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView * startTimePicker;
@property (nonatomic, strong) UIPickerView * endTimePicker;

@property (nonatomic, strong) NSMutableArray * startTimeArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startTimeArray = @[@"8:00",@"8:30",@"9:00",@"9:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30"].mutableCopy;
    
    [self.view  addSubview:self.startTimePicker];
    
    [self.view addSubview:self.endTimePicker];
    
    [self.endTimePicker selectRow:self.startTimeArray.count-1 inComponent:0 animated:NO];
   
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.startTimeArray.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(@available(iOS 14.0,*)){
        pickerView.subviews[1].backgroundColor = UIColor.clearColor;
    }
    return [self.startTimeArray objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont systemFontOfSize:15];
        pickerLabel.contentMode = UIViewContentModeCenter;
        pickerLabel.textColor = [UIColor blueColor];
        pickerLabel.textAlignment= NSTextAlignmentCenter;
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UIView* view = [self pickerView:pickerView viewForRow:row forComponent:component reusingView:nil];
    view.backgroundColor = [UIColor greenColor];
}

#pragma mark
- (UIPickerView *) startTimePicker{
    if (!_startTimePicker) {
        _startTimePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame)/2.0, 200)];
        _startTimePicker.delegate = self;
        _startTimePicker.dataSource = self;

    }
    return _startTimePicker;
}

- (UIPickerView *) endTimePicker{
    if (!_endTimePicker) {
        _endTimePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2.0, 100, 200, 200)];
        _endTimePicker.delegate = self;
        _endTimePicker.dataSource = self;
    }
    return _endTimePicker;
}

@end
