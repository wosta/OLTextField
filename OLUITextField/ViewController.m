//
//  ViewController.m
//  OLUITextField
//
//  Created by 魏旺 on 16/3/18.
//  Copyright © 2016年 olive. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.tf = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-60, 44)];
    self.tf.backgroundColor = [UIColor redColor];
    self.tf.delegate = self;
    self.tf.placeholder = @"hello";
    [self.view addSubview:self.tf];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(30, 140, self.view.frame.size.width-60, 44)];
    [self.button setTitle:@"好的" forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor cyanColor];
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];

}

- (void)buttonClick {
    NSLog(@"点击此时的button值为多少呢？\n %@", self.tf.text);
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //返回一个BOOL值，指定是否循序文本字段开始编辑
    NSLog(@"textFieldShouldBeginEditing:%@", textField.text);
    self.tf = textField;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
    self.tf = textField;
    NSLog(@"textFieldDidBeginEditing=%@", textField.text);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
    //这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
    self.tf = textField;
    NSLog(@"textFieldShouldEndEditing=%@", textField.text);
    return NO;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //当用户使用自动更正功能，把输入的文字修改为推荐的文字时，就会调用这个方法。
    //这对于想要加入撤销选项的应用程序特别有用
    //可以跟踪字段内所做的最后一次修改，也可以对所有编辑做日志记录,用作审计用途。
    //要防止文字被改变可以返回NO
    //这个方法的参数中有一个NSRange对象，指明了被改变文字的位置，建议修改的文本也在其中
    NSLog(@"length:%zd, location:%zd----%@", range.length, range.location, string);
    NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
    if ([string length] > 0) {
        [str insertString:string atIndex:range.location];
    }
    else{
        [str deleteCharactersInRange:range];
    }
    
    NSInteger strLength = textField.text.length - range.length + string.length;
    if (strLength > 3) {
        return NO;
    }
    NSLog(@"shouldChangeCharactersInRange=%@", textField.text);
    self.tf = textField;
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    self.tf = textField;
    NSLog(@"textFieldShouldClear= %@", textField.text);
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //如果允许要调用resignFirstResponder 方法，这回导致结束编辑，而键盘会被收起
    [textField resignFirstResponder];//查一下resign这个单词的意思就明白这个方法了
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
