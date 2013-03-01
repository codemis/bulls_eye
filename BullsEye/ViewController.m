#import "ViewController.h"
@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic) NSInteger currentValue;
- (IBAction)hitMeButtonClicked:(id)sender;
- (IBAction)sliderMoved:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *numberSlider;
@property (nonatomic) NSInteger targetValue;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSInteger currentScore;
@property (nonatomic) NSInteger currentRound;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@end

@implementation ViewController
-(void) startNewRound
{
    self.currentRound ++;
    self.roundLabel.text = [NSString stringWithFormat:@"%d", self.currentRound];
    self.targetValue = 1+(arc4random() % 100);
    self.targetLabel.text = [NSString stringWithFormat:@"%d", self.targetValue];
    self.numberSlider.value = 50;
}
-(void) setCurrentScore:(NSInteger)newScore
{
    _currentScore += newScore;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", _currentScore];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentValue = self.numberSlider.value;
    self.currentScore = 0;
    [self startNewRound];
}
- (IBAction)hitMeButtonClicked:(id)sender
{
    int difference = abs(self.currentValue - self.targetValue);
    NSString *title;
    if (difference == 0) {
        title = @"Perfect";
    }else if (difference < 5){
        title = @"You Almost Had It";
    }else if (difference < 10){
        title = @"Pretty Good";
    }else{
        title = @"You Suck";
    }
    NSString *message = [NSString stringWithFormat:@"The value of the slider is: %d\n The target value is: %d\n The difference is: %d", self.currentValue, self.targetValue, difference];
    self.currentScore = (100-difference);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Awesome"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    self.currentValue = lroundf(slider.value);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
}
@end
