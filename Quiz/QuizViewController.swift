//
//  QuizViewController.swift
//  Quiz
//
//  Created by fukumoriminori on 2016/01/09.
//  Copyright © 2016年 fukumoriminori. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //問題文を格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer: Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一時的にクイズを格納しておく配列
        var tmpArray = [AnyObject]()
        
        //tmpArrayに問題文と3つの選択肢と答えの番号の入った配列の番号の入った配列を追加していく
        tmpArray.append(["フォーリミが結成されたのはどこ？","名古屋","横浜","宇都宮",1])
        tmpArray.append(["J-WAVEのラジオ番組、THE KINGS PLACEにてフォーリミがナビゲーターを務めているのは何曜日？","火曜日","水曜日","木曜日",2])
        tmpArray.append(["フォーリミのメジャーデビューアルバムのタイトルはどれ？","TOY","CAVU","Marking all!!!",2])
        tmpArray.append(["オリコンインディーズランキングで一位を獲得したアルバムはどれ？","YON","sonor","monolith",3])
        tmpArray.append(["4月2,3日に行われるフォーリミ主催のフェスの名前はどれ？","Limited Fes","04 Fes","YON FES",3])
        
        
        //問題をシャッフルしてquizArrayに格納する
        srand(UInt32(time(nil)))
        while (tmpArray.count > 0) {
            let index = Int(rand()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        choiceQuiz()
    }
    
    func choiceQuiz() {
        
        //問題文のテキストを表示
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButton1.setTitle((quizArray[0][1] as! String), forState: .Normal)
        choiceButton2.setTitle((quizArray[0][2] as! String), forState: .Normal)
        choiceButton3.setTitle((quizArray[0][3] as! String), forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        //引数のsender.tagに格納されているTagの値を使って処理を区別する
        if quizArray[0][4] as! Int == sender.tag {
            
            //正解数を増やす
            correctAnswer++
        }
        
        //解いた問題をquizArrayから取り除く
        quizArray.removeAtIndex(0)
        
        //解いた問題の合計が予め設定されていた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }

    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }
    
    //セグエが呼ばれた時に呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destinationViewController as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
    }

        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
