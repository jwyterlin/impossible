//
//  GameViewController.m
//  impossible
//
//  Created by Jhonathan Wyterlin on 17/08/14.
//  Copyright (c) 2014 Jhonathan Wyterlin. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

#pragma mark - View Lifecycle

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Instance an object type ImpossibleView
    self.impossibleView = [ImpossibleView new];
    
    // Set the size of it, based on screen size
    self.impossibleView.frame = CGRectMake( 0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height );
    
    [self.view addSubview:self.impossibleView];
    
    // Instancia um objeto para reconhecimento de gestos do tipo "Tap"
    // e a ação a ser executada quando o usuário realizar o gesto
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    // Adiciona o reconhecimento de gestos à view com a qual o usuário irá interagir
    [self.impossibleView addGestureRecognizer:tapGesture];
    
    // Botão para Reiniciar o jogo
    UIButton *buttonRestart = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRestart setTitle:@"Restart" forState:UIControlStateNormal];
    buttonRestart.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonRestart.frame = CGRectMake(20, 170, 80, 35);
    [buttonRestart addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRestart];
    
    // Botão para Parar o jogo
    UIButton *buttonStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonStop setTitle:@"Stop" forState:UIControlStateNormal];
    buttonStop.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonStop.frame = CGRectMake(20, 250, 80, 35);
    [buttonStop addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStop];

}

#pragma mark - Helper Methods

-(void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        
        [self.impossibleView moveDown:10];
        [self.impossibleView increaseScore:100];
        
    }
    
}

-(void)restart:(id)sender {
    
    [self.impossibleView restart];
    
}

-(void)stop:(id)sender {
    
    [self.impossibleView stopGame];
    
}

@end
