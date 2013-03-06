#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic) NSInteger currentValue;
- (IBAction)hitMeButtonClicked;
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)startOver;
@property (weak, nonatomic) IBOutlet UISlider *numberSlider;
@property (nonatomic) NSInteger targetValue;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSInteger currentScore;
@property (nonatomic) NSInteger currentRound;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@end

@implementation ViewController
-(IBAction)home:(UIStoryboardSegue *)segue
{
}
- (IBAction)startOver
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    [self startNewGame];
    [self.view.layer addAnimation:transition forKey:nil];
}
-(void) startNewGame
{
    self.currentScore = 0;
    self.currentRound = 0;
    [self startNewRound];
}
-(void) startNewRound
{
    self.currentRound ++;
    self.numberSlider.value = 50;
    self.targetValue = 1+(arc4random() % 100);
    [self updateLabels];
}
-(void) updateLabels
{
    self.roundLabel.text = [NSString stringWithFormat:@"%d", self.currentRound];
    self.targetLabel.text = [NSString stringWithFormat:@"%d", self.targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.currentScore];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.numberSlider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    UIImage *thumbImageHighlighted =
        [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.numberSlider setThumbImage:thumbImageHighlighted
                            forState:UIControlStateHighlighted];
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.numberSlider setMinimumTrackImage:trackLeftImage
                                   forState:UIControlStateNormal];
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.numberSlider setMaximumTrackImage:trackRightImage
                                   forState:UIControlStateNormal];
    [self startNewGame];
}
- (IBAction)hitMeButtonClicked
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
    self.currentScore += (100-difference);
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
