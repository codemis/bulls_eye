#import "ViewController.h"
@interface ViewController ()
@property (nonatomic) NSInteger currentValue;
- (IBAction)hitMeButtonClicked:(id)sender;
- (IBAction)sliderMoved:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *numberSlider;
@property (nonatomic) NSInteger targetValue;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation ViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.currentValue = self.numberSlider.value;
    self.targetValue = 1+(arc4random() % 100);
    self.targetLabel.text = [NSString stringWithFormat:@"%d", self.targetValue];
    self.scoreLabel.text = @"0";
}
- (IBAction)hitMeButtonClicked:(id)sender {
    int difference = abs(self.currentValue - self.targetValue);
    NSString *message = [NSString stringWithFormat:@"The value of the slider is: %d\n The target value is: %d\n The difference is: %d", self.currentValue, self.targetValue, difference];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hello,World"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Awesome"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)slider {
    self.currentValue = lroundf(slider.value);
}
@end
