//
//  SpeechViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/20.
//

import Foundation
import UIKit
import Speech
import AVFoundation
import Moya
import SnapKit

class SpeechViewController : UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, UITextFieldDelegate{
    
    private let provider = MoyaProvider<Types>()
    
    let placeholderLabel = UILabel()
   // let chatGuideLabel = UILabel()
    let sendLabelContainer = UIView()
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var personSpeechLabel: UILabel!
    @IBOutlet weak var characterSpeechLabel: UILabel!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var chatScrollView: UIScrollView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var chatTextView: UITextView!
    
    //움성 녹음 관련
    var recordingSession:AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    

    var audioUrl: URL?
    var text: String?
    let synthesizer = AVSpeechSynthesizer()
    var speech: String? = "배가 불러서 기분이 좋아요!"
    
    
    
    override func viewDidLoad() {
        
        //사용자의 음성 인식 권한 요청
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .notDetermined: print("Not determined")
            case .restricted: print("Restricted")
            case .denied: print("Denied")
            case .authorized: print("We can recognize speech now.")
            @unknown default: print("Unknown case")
            }
        }

        setupKeyboardEvent()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
        initStyle()
        
        chatTextView.delegate = self
       
       
        micButton.addTarget(self, action: #selector(pressMicroBtn), for: .touchUpInside)
        sendBtn.addTarget(self, action: #selector(addChatData), for: .touchUpInside)
        
        
        //내장된 AVAudioSession을 가져옴
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            //오디오 녹음 권한 요청
            recordingSession.requestRecordPermission() { allowed in
                if allowed {
                    print("음성 녹음 허용")
                } else {
                    print("음성 녹음 비허용")
                }
            }
        } catch {
            print("음성 녹음 실패")
        }
        
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true) // todo...
        }
        sender.cancelsTouchesInView = false
    }
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        view.frame.origin.y -= 250
    }

    @objc func keyboardWillHide(_ sender: Notification) {
            view.frame.origin.y = 0
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    
    private func initStyle() {
        chatTextView.layer.cornerRadius = 20.0
        chatTextView.isScrollEnabled = true
        chatTextView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10) // 여백 설정
        chatTextView.layer.borderWidth = 1
        
        chatTextView.layer.borderColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
    
        micButton.translatesAutoresizingMaskIntoConstraints = false
        micButton.setImage(UIImage(systemName: "mic.circle.fill"), for: .normal)
        micButton.tintColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
        micButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        micButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sendBtn.layer.cornerRadius = 20.0
        sendBtn.layer.masksToBounds = true
        sendBtn.layer.borderWidth = 1
        sendBtn.setImage(UIImage(systemName: "carat"), for: .normal)
        sendBtn.layer.borderColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
        
        
        placeholderLabel.text = "채팅을 입력하세요."

        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatScrollView.snp.leading).offset(15)
            make.centerY.equalTo(chatTextView.snp.centerY)
        }

        
    }
    
   
    
    @objc func addSpeechData() {
        if let text=text, !text.isEmpty{
            // 새로운 UIView 생성 및 설정
            let messageContainer = UIView()
            messageContainer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
            messageContainer.layer.cornerRadius = 10

            // UILabel을 messageContainer 위에 추가
            let sendMessage = UILabel()
            sendMessage.text = text
            sendMessage.numberOfLines = 0 // 여러 줄 허용
            sendMessage.lineBreakMode = .byWordWrapping // 단어 단위로 줄 바꿈

            // 텍스트의 크기를 계산하여 label의 width를 설정
            
            let labelMaxWidth = chatScrollView.bounds.width - 115 // 최대 허용 너비
            let textRect = text.boundingRect(with: CGSize(width: labelMaxWidth, height: .greatestFiniteMagnitude),
                                      options: .usesLineFragmentOrigin,
                                      attributes: [NSAttributedString.Key.font: sendMessage.font!],
                                      context: nil)
            let labelWidth = textRect.width // 텍스트의 실제 너비
            let labelheight = textRect.height

            // UILabel을 messageContainer에 추가
            messageContainer.addSubview(sendMessage)

            // messageContainer를 UIScrollView에 추가
            chatScrollView.addSubview(messageContainer)

            // SnapKit을 사용하여 레이아웃 설정
            messageContainer.snp.makeConstraints { make in
                make.trailing.equalTo(view.snp.trailing).offset(-20) // 왼쪽 여백 추가
                make.top.equalTo(chatScrollView.contentSize.height + 20)
                make.width.equalTo(labelWidth + 20) // 여백 추가
                make.height.equalTo(textRect.height + 20) // 여백 추가
            }

            sendMessage.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
            }

            // UIScrollView의 contentSize 업데이트
            chatScrollView.contentSize.height += messageContainer.frame.height + labelheight + 30 // 여백 추가
            
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                // 2초 뒤에 실행될 코드
//                self.receiveDataLayout()
//            }
        }
    }
    
    @objc func addChatData() {
        
      //  progressView.fillProgressBar(duration: 2.0)
        // UITextView에서 입력된 데이터 가져오기
        if let text = chatTextView.text, !text.isEmpty {
            
            // 새로운 UIView 생성 및 설정
            let messageContainer = UIView()
            messageContainer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
            messageContainer.layer.cornerRadius = 10

            // UILabel을 messageContainer 위에 추가
            let sendMessage = UILabel()
            sendMessage.text = text
            sendMessage.numberOfLines = 0 // 여러 줄 허용
            sendMessage.lineBreakMode = .byWordWrapping // 단어 단위로 줄 바꿈

            // 텍스트의 크기를 계산하여 label의 width를 설정
            
            let labelMaxWidth = chatScrollView.bounds.width - 115 // 최대 허용 너비
            let textRect = text.boundingRect(with: CGSize(width: labelMaxWidth, height: .greatestFiniteMagnitude),
                                      options: .usesLineFragmentOrigin,
                                      attributes: [NSAttributedString.Key.font: sendMessage.font!],
                                      context: nil)
            let labelWidth = textRect.width // 텍스트의 실제 너비
            let labelheight = textRect.height

            // UILabel을 messageContainer에 추가
            messageContainer.addSubview(sendMessage)

            // messageContainer를 UIScrollView에 추가
            chatScrollView.addSubview(messageContainer)

            // SnapKit을 사용하여 레이아웃 설정
            messageContainer.snp.makeConstraints { make in
                make.trailing.equalTo(view.snp.trailing).offset(-20) // 왼쪽 여백 추가
                make.top.equalTo(chatScrollView.contentSize.height + 20)
                make.width.equalTo(labelWidth + 20) // 여백 추가
                make.height.equalTo(textRect.height + 20) // 여백 추가
            }

            sendMessage.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
            }

            // UIScrollView의 contentSize 업데이트
            chatScrollView.contentSize.height += messageContainer.frame.height + labelheight + 30 // 여백 추가
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // 2초 뒤에 실행될 코드
                self.receiveDataLayout()
            }
        }
    }
    
    
    @IBAction func pressMicroBtn(_ sender: UIButton) {
        if let recorder = audioRecorder {
            if recorder.isRecording {
                finishRecording(success: true)
                //addSpeechData()
            } else {
                startRecording()
            }
        } else {
            startRecording()
            //createSpeechLabels()
        }
    }
    
    func receiveDataLayout(){
        let receiveLabelContainer = UIView()
        receiveLabelContainer.backgroundColor = UIColor(red: 0.988, green: 0.98, blue: 0.945, alpha: 1)
        receiveLabelContainer.layer.cornerRadius = 10
        
        let responseText = UILabel()
        
       
        provider.request(.getSpeechAnswer) { [weak self] result in
                    switch result {
                    case .success(let response):
                        do {
                            let result = try
                            response.map([SpeechReturn].self).last?.answer
                            //response.map([SpeechReturn].self).first?.answer
                            responseText.text = result
                            self?.speech = result
                            if let message = self?.speech {
                                let utterance = AVSpeechUtterance(string: message)
                                utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
                                utterance.rate = 0.5
                                utterance.pitchMultiplier = 0.9
                                self?.synthesizer.speak(utterance)
                            } else {
                                print("TTS 오류")
                            }
                        } catch(let error) {
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                }
        }
        
        
       // responseText.text = "\(getAnwser())"
        responseText.numberOfLines = 0
        responseText.lineBreakMode = .byWordWrapping
 
        
        receiveLabelContainer.addSubview(responseText)
        chatScrollView.addSubview(receiveLabelContainer)
        
        receiveLabelContainer.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20) // 왼쪽 여백 추가
            make.top.equalTo(chatScrollView.contentSize.height + 40)
            make.trailing.equalTo(view.snp.trailing).offset(-70)
        }

        responseText.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        
        chatScrollView.contentSize.height += receiveLabelContainer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + 60 // + receiveSentenceContainer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + 70  // 여백 추가
}

    
    //녹음된 오디오를 텍스트로 변환하고 해당 텍스트를 서버로 전송하여 응답을 받는 함수
    func speechFromCharacter(){
        
        //오디오 파일의 URL이 nil일 경우 예외처리
        guard let audioUrl = audioUrl else {
            print("Can't find audio url")
            return
        }
        
        // speechRecognizer 인스턴스 생성
        if let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR")) {
            if speechRecognizer.isAvailable {
                let request = SFSpeechURLRecognitionRequest(url: audioUrl)
                speechRecognizer.supportsOnDeviceRecognition = true
                speechRecognizer.recognitionTask(with: request, resultHandler: { [weak self] (result, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let result = result {
                        print(result.bestTranscription.formattedString)
                        
                        if result.isFinal {
                            self?.text = result.bestTranscription.formattedString
                            self?.addSpeechData()
                            //self?.chatTextView.text = result.bestTranscription.formattedString
                           // self?.personSpeechLabel.text = result.bestTranscription.formattedString
                            
                            // 전송에 성공하면 실행되는 코드
                            if let question = self?.text {
                                self?.provider.request(.postSpeechToText(question: question)) { result in
                                    switch result {
                                    case .success(_):
                                        // getAnwser() 함수 호출
                                        //self?.getAnwser()
                                        self?.receiveDataLayout()
                                    case .failure(let error):
                                        print("Error: \(error)")
                                    }
                                }
                            }
                        }
                    }
                })
            }
        }
        
    }
        //함수 끝
        
    @MainActor
    func getAnwser() {
            provider.request(.getSpeechAnswer) { [weak self] result in
                switch result {
                case .success(let response):
                    do {
                        let result = try
                        response.map([SpeechReturn].self).last?.answer
                        //response.map([SpeechReturn].self).first?.answer
                        self?.characterSpeechLabel.text = result
                        self?.speech = result
                        if let message = self?.speech {
                            let utterance = AVSpeechUtterance(string: message)

                            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
                            utterance.rate = 0.5
                            utterance.pitchMultiplier = 0.9
                            self?.synthesizer.speak(utterance)
                        } else {
                            print("TTS 오류")
                        }
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
        //함수 끝
}

extension SpeechViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // UITextView의 내용이 변경될 때 placeholderLabel을 숨기거나 표시
        placeholderLabel.isHidden = !chatTextView.text.isEmpty
        sendLabelContainer.isHidden = !chatTextView.text.isEmpty
        sendLabelContainer.isHidden = true
    }
}
    
    // MARK: - Recording
extension SpeechViewController {
    
        func startRecording() {
            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")
            // 녹음 파일의 URL을 audioURL 변수에 할당
           // self.audioUrl = audioFilename

            let settings = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: 16000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            do {
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()

                print("녹음 시작")
            } catch {
                finishRecording(success: false)
            }
        }

        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }

        func finishRecording(success: Bool) {
            audioRecorder.stop()

            if success {
                micButton.isEnabled = true
                print("finishRecording - success")
                self.audioUrl = audioRecorder.url
                speechFromCharacter()
            } else {
                micButton.isEnabled = false
                print("finishRecording - fail")
                // recording failed :(
            }
        }

        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
            if !flag {
                finishRecording(success: false)
            }
        }

}

