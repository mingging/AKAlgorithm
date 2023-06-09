//
//  05_10.swift
//  AKAlgorithm
//
//  Created by milli on 2023/05/09.
//

import Foundation

/// N이 주어졌을 때, 제일 마지막에 남게 되는 카드를 구하시오
func b2164() {
    /// N을 입력받는다.
    let n = Int(readLine()!)!
    
    /// 1부터 N까지의 번호가 있다.
    var numbers: [String] = []
    var indexFirst = 0
    var firstNumber: String = ""
    
    for i in 1...n {
        numbers.append("\(i)")
    }
    
    /// 아래 내용을 마지막 하나가 남을 때까지 반복한다.
    /// index가 2 이하 일때까지만 반복한다.
    while numbers.count - indexFirst >= 2 {
        
        /// 제일 위에 있는 카드를 바닥에 버린다.
        numbers[indexFirst] = ""
        
        print(indexFirst)
        print(numbers.count)
        
        /// 첫번째 카드를 저장해두고 해당 위치도 비워준다.
        firstNumber = numbers[indexFirst + 1]
        numbers[indexFirst + 1] = ""
        
        /// 제일 위에 있는 카드를 제일 아래에 있는 카드 밑으로 옮긴다.
        numbers.append(firstNumber)
        
        indexFirst += 2
        
        print(numbers)
    }
    
    print(numbers[numbers.count - 1])
}

/// 여러 개의 서로 다른 단어가 주어질 때, 첫 번째 단어와 비슷한 단어가 모두 몇 개인지 출력하시오.
func b2607() {
    /// 첫째 줄에는 단어의 개수가 주어진다.
    let count = Int(readLine()!)!
    
    var words: [String] = []
    var firstWord: [String] = []
    var compareWords: [String] = []
    var wordsIndex = 1
    var matchCount = 0
    
    /// 둘째 줄 부터는 한 줄에 하나씩 단어가 주어진다.
    for _ in 0..<count {
        let word = readLine()!
        
        /// 단어를 오름차순으로 정렬한다.
        words.append(String(word.sorted(by: <)))
    }

    /// 첫  번째 단어를 배열에 저장한다.
    firstWord = words[0].map { String($0) }
    
    /// 첫번째 단어와 비슷한 단어가 몇 개인지 출력한다.
    while wordsIndex < words.count {
        
        /// 비교할 단어를 배열에 저장한다.
        compareWords = words[wordsIndex].map { String($0) }
        
        /// sorting 한 두 단어가 똑같으면 바로 넘긴다.
        if firstWord.joined() == compareWords.joined() {
            wordsIndex += 1
            matchCount += 1
            continue
        }
        
        print("firstWord : \(firstWord)")
        print("compareWord : \(compareWords)")
        
        /// 비교를 위해 temp 변수를 만든다.
        var firstTempWords: [String] = firstWord
        var compareTempWords: [String] = compareWords

        /// 두 배열에 같은 값이 있는지 확인한다.
        for i in 0..<firstWord.count {
            for j in 0..<compareWords.count {
                if firstTempWords[i] == compareTempWords[j] {
                    compareTempWords[j] = ""
                    firstTempWords[i] = ""
                    break
                }
            }
            
            print("firstWorkd : \(firstTempWords)")
            print("compareWord : \(compareTempWords)")
        }
        
        /// 배열에 남겨진 문자 가져오기
        /// 배열에 남겨진 문자 인덱스 가져오기
        var extraCompareIndex: Int = 0
        var extraFirstIndex: Int = 0
        
        for i in 0..<compareTempWords.count {
            if !compareTempWords[i].isEmpty {
                extraCompareIndex = i
                break
            }
        }
        
        for i in 0..<firstTempWords.count {
            if !firstTempWords[i].isEmpty {
                extraFirstIndex = i
                break
            }
        }
        
        print("extraCompareIndex : \(extraCompareIndex)")
        print("extraFirstIndex : \(extraFirstIndex)")
        
        /// 두개의 배열 갯수가 같고, 하나씩 다른 문자가 있다면 치환해준다.
        if firstWord.count == compareWords.count {
            compareWords = compareWords.enumerated().map { index, value in
                ///  인덱스가 같으면
                if index == extraCompareIndex {
                    /// 해당 인덱스를 firstWord의 index로 바꿔주기
                    return firstWord[extraFirstIndex]
                }
                return String(value)
            }.sorted(by: <)
            
            print(firstWord)
            print(compareWords)
            
        } else if firstWord.count <= compareWords.count {
            /// 비교하는 문자가 첫번째 문자보다 더 길 때, 비교하는 문자에서 남는 문자를 제거해준다.
            /// AAAB
            /// AAABB
            compareWords.remove(at: extraCompareIndex)
            compareWords = compareWords.sorted(by: <)
        } else if firstWord.count >= compareWords.count {
            ///첫 문자가 더 길 때 비교하는 문자에 추가해준다.
            compareWords.append(firstWord[extraFirstIndex])
            compareWords = compareWords.sorted(by: <)
        }
        
        print(extraCompareIndex)
        
        print(firstWord)
        print(compareWords)
        
        if firstWord.joined() == compareWords.joined() {
            matchCount += 1
        }
        
        print(matchCount)
        wordsIndex += 1
        print("------------ done ------------")
    }
    
   print(matchCount)
   
}

/// 역전패를 했는지 구하는 프로그램을 작성하여라
func b14582() {
    /// 첫째 줄에는 9개의 정수가 주어진다 -> 울림 제미니스가 1회 초, 2회 초 ... 9회 초에 낸 득점
    let woollimTotalScore = readLine()!
    let woollimScoreArray: [String] = woollimTotalScore.components(separatedBy: " ")
    var woollimScore: Int = 0
    
    /// 두 번째 줄에는 9개의 정수가 주어진다 -> 스타트링크 걸리버스가 1회 말, 2회 말 ... 9회 말에 낸 득점
    let startLinkTotalScore = readLine()!
    let startLinkScoreArray: [String] = startLinkTotalScore.components(separatedBy: " ")
    var startLinkScore: Int = 0
    
    /// 총 경기는 9번 (1회초, 1회말)
    var match: Int = 1
    
    /// 울림이 이긴 적이 있는지 확인
    var woollimWin: Bool = false
    
    /// 경기는 1회 초 -> 1회 말, 2회 초 -> 2회 말 순서로 진행된다.
    while match <= 9 {
        /// 울림이 먼저 시작한다.
        woollimScore += Int(woollimScoreArray[match - 1])!
        
        /// 울림이 이기고 있으면 true
        if woollimScore > startLinkScore {
            woollimWin = true
        }
        
        /// 스타트링크가 시작한다.
        startLinkScore += Int(startLinkScoreArray[match - 1])!
        
        /// 다음 경기를 시작한다.
        match += 1
    }
    
    print(woollimWin ? print("Yes") : print("No"))
}

func test_2607() {
    let count = Int(readLine()!)!
    var words: [String] = []
    var firstWords: [String] = []
    var compareWords: [String] = []
    var wordsIndex = 1
    var matchCount = 0

    for _ in 0..<count {
        let word = readLine()!
        words.append(String(word.sorted(by: <)))
    }
    
    firstWords = words[0].map { String($0) }

    while wordsIndex < words.count {
        compareWords = words[wordsIndex].map { String($0) }
        
        var firstTempWords: [String] = firstWords
        var compareTempWords: [String] = compareWords

        for i in 0..<firstWords.count {
            for j in 0..<compareWords.count {
                if firstTempWords[i] == compareTempWords[j] {
                    compareTempWords[j] = ""
                    firstTempWords[i] = ""
                    break
                }
            }
        }
        
        
        var extraCompareIndex: [String] = []
        for i in 0..<compareTempWords.count {
            if !compareTempWords[i].isEmpty {
                extraCompareIndex.append("\(i)")
            } else {
                extraCompareIndex.append("")
            }
        }
        
//        var extraCompareIndex = compareTempWords.enumerated().map { (index, value) in
//            if !value.isEmpty {
//                return "\(index)"
//            }
//            return ""
//        }
        
        extraCompareIndex = extraCompareIndex.filter { value in
            if !value.isEmpty {
                return true
            }
            return false
        }
        
        var extraFirstIndex: [String] = []
        for i in 0..<firstTempWords.count {
            if !firstTempWords[i].isEmpty {
                extraFirstIndex.append("\(i)")
            } else {
                extraFirstIndex.append("")
            }
        }
        
//        var extraFirstIndex = firstTempWords.enumerated().map { (index, value) in
//            if !value.isEmpty {
//                return "\(index)"
//            }
//            return ""
//        }
        
        extraFirstIndex = extraFirstIndex.filter { value in
            if !value.isEmpty {
                return true
            }
            return false
        }
        
        if extraFirstIndex.count == extraCompareIndex.count && !extraCompareIndex.isEmpty {
            compareWords = compareWords.enumerated().map { index, value in
                if index == Int(extraCompareIndex[0])! {
                    return firstWords[Int(extraFirstIndex[0])!]
                }
                return String(value)
            }.sorted(by: <)
            
        } else if extraCompareIndex.count <= 1 && !extraCompareIndex.isEmpty {
            compareWords.remove(at: Int(extraCompareIndex[0])!)
            compareWords = compareWords.sorted(by: <)
        } else if extraFirstIndex.count <= 1 && !extraFirstIndex.isEmpty {
            compareWords.append(firstWords[Int(extraFirstIndex[0])!])
            compareWords = compareWords.sorted(by: <)
        }
        
        if firstWords.joined() == compareWords.joined() {
            matchCount += 1
        }
        
        wordsIndex += 1
    }
    
   print(matchCount)
}
