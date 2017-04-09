### 写在前面

弹窗是app中常见控件之一，一般由于项目需求，我们很少能直接使用系统提供的弹窗，这个时候就需要我们根据产品需求封装自定义弹窗了。这两天正好封装了一个弹窗，分享出来（主要是思路），希望新手少走点弯路，当然更希望高手能提出一些实在的建议哈哈😄。总之，只要思路清晰点，封装一般的弹窗还是没有问题的😎。
###先看看UI设计图
![UI设计图](http://upload-images.jianshu.io/upload_images/1692043-a72d97a849bdc225.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
其中，红色文本和灰色方框里的文本是后台返回的。

---



###我做出的效果



![demo中的效果.gif](http://upload-images.jianshu.io/upload_images/1692043-8a0cc01fc7d2fdf4.gif?imageMogr2/auto-orient/strip)

![项目中的效果，后台未返回说明文字的情况.gif](http://upload-images.jianshu.io/upload_images/1692043-cdcfe763866cb92c.gif?imageMogr2/auto-orient/strip)



###思路



- 封装之前，不如先来看看系统是怎样弹出一个弹窗的：

```
- (void)showAlert{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"标题" message:@"内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

```
- 简单分析一下这两句代码：
  1.
```
UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"标题" message:@"内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
```
这句是调用`UIAlertView `的构造方法初始化一个`UIAlertView `对象。
2.
```
[alertView show];
```
这句是调用这个`UIAlertView `对象的`show`方法，将弹窗show出来。

- 分析完系统弹窗后，基本思路也就清晰了：
  1. 创建一个弹窗对象
  2. show出来



###开始封装



####一. 弹窗命名



系统的叫`UIAlertView`，那么我这个根据弹窗的功能就给它取名`DeclareAbnormalAlertView`



####二. 构造方法的命名



系统的叫：

```
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString 
*)otherButtonTitles, ...`。
```
我的这个弹窗，因为有且只有两个按钮（向PM确认），所以命名为：
```
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle;
```


####三. 弹出这个弹窗的方法命名



```
/** show出这个弹窗 */
- (void)show;
```
当然还是show😄



####四. 构造方法的实现



**弹窗，说白了就是一个覆盖在屏幕顶层的半透明view**
1. 弹窗的最底部是覆盖全屏的半透明view
2. 根据UI设计图，添加subViews到半透明view上
3. 这里就不贴代码了，文末有demo😅



####五. `show`方法的实现



`show`其实就是将弹窗放在最顶层，如何将view放在最顶层，我知道的有这几种方式：
1. 直接在当前视图控制器上放`view`（简直6翻了）
2. present到一个新的半透明视图控制器（想想`UIAlertViewController`，如果要使用这种弹窗的话，自定义的弹窗就是继承自`UIViewController`而不是`UIView`了）
3. 使用一个`windowLevel`更高的`UIWindow`（`UIAlertView`就是这种）
4. 放在`keyWindow`上（我用的就是这种方法）
5. ​

####六. 代理方法的命名:



系统的代理方法叫：

```
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
```
所以我写的代理方法是：
```
- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
```



###注意事项：



1. 弹窗里有`UITextView`，注意不要让键盘挡住弹窗。处理方式：监听键盘显示和隐藏并对弹窗做出相应调整：

```
        // 接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
```

```
/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillShow:(NSNotification *)notification
{
    // 获取到了键盘frame
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = frame.size.height;
    
    self.contentView.maxY = SCREEN_HEIGHT - keyboardHeight - 10;
}
/**
 *  键盘将要隐藏
 *
 *  @param notification 通知
 */
-(void)keyboardWillHidden:(NSNotification *)notification
{
    // 弹窗回到屏幕正中
    self.contentView.centerY = SCREEN_HEIGHT / 2;
}

```



###使用封装好的弹窗



```
        DeclareAbnormalAlertView *alertView = [[DeclareAbnormalAlertView alloc]
                                              initWithTitle:@"填写异常信息" 
                                              message:responseDict[@"data"][@"apply_exception_overtime"] 
                                              delegate:self 
                                              leftButtonTitle:@"申报异常" 
                                              rightButtonTitle:@"取消"];

        [alertView show];
```
代理方法：
```
/** 申报异常弹窗的代理方法 */
- (void)declareAbnormalAlertView:(DeclareAbnormalAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == AlertButtonLeft) { // 申报异常按钮点击
    }
}
```
**是不是感觉就像在用系统的弹窗？恩，要的就是这种感觉。为什么要努力向系统弹窗靠近？理由有三：**
1. 每个人的编码风格都不同，但有一点毋庸置疑，那就是，每一个开发者对这些常用系统方法肯定都很熟悉，如果你的方法和系统方法类似，相信其他人维护时一定会有似曾相识的感觉。
2. 我们写代码应该尽量按照官方推荐的编码规范来写，而这些系统方法，就是最好的例子。
3. 只有这样严格要求自己，养成良好的编码习惯，才算得上一个合格的程序员。
