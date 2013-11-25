//
//  ViewController.m
//  KinecticViewSpike
//
//  Created by u16suzu on 2013/11/26.
//  Copyright (c) 2013年 u16suzu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravityBehavior;
@property (nonatomic) UICollisionBehavior *collisionBehavior;
@property (nonatomic) UIDynamicItemBehavior *itemBehavior;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Tap
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:gesture];
    
    
    // Animator
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    
    // Behaviors
    self.gravityBehavior = [[UIGravityBehavior alloc]initWithItems:nil];
    self.collisionBehavior = [[UICollisionBehavior alloc]initWithItems:nil];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:nil];
    self.itemBehavior.elasticity = 0.6; // 弾性 0~1 大きいと弾む
    self.itemBehavior.friction   = 99.0; // 摩擦 2つのアイテムがこすれる場合の抵抗
    self.itemBehavior.resistance = 3.0; // 抵抗 0~CGFLOAT_MAX 大きいとアイテムにかかる力がなくなった瞬間にアイテムの動作が止まるようになる.重力場における空気抵抗
    self.itemBehavior.density = 1;
    self.itemBehavior.angularResistance = 0;
    self.itemBehavior.allowsRotation = YES; // 物体に回転を許可するか否か
    
    
    // AddBehavior (Animator > Behavior > Item の順番で保持する.)
    [self.animator addBehavior:self.gravityBehavior]; // コメントアウトしたら落ちない.
    [self.animator addBehavior:self.collisionBehavior]; // 衝突判定画面の最下部戸の衝突を判定. コメントアウトしたら最下部で止まらない.
    [self.animator addBehavior:self.itemBehavior]; // 上で指定した空気抵抗などの設定値が適用されない.
}

// =============================================================================
#pragma mark - Gesture Handler

- (void)tapped:(UITapGestureRecognizer *)gesture {
    // Image
    UIImage *image = [UIImage imageNamed:@"octocat_small"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    
    CGPoint tappedPos = [gesture locationInView:gesture.view];
    imageView.center = tappedPos;
    
    
    // AddItem
    [self.gravityBehavior addItem:imageView];
    [self.collisionBehavior addItem:imageView];
    [self.itemBehavior addItem:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
