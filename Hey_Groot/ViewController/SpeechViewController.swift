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

class SpeechViewController : UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    
    private let provider = MoyaProvider<Types>()
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var personSpeechLabel: UILabel!
    @IBOutlet weak var characterSpeechLabel: UILabel!
    @IBOutlet weak var micButton: UIButton!
    
    //움성 녹음 관련
    var recordingSession:AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    
    //음성 재생 관련
    var audioUrl: URL?
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
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
        
        let speechParent = self.view!
        
        speechParent.addSubview(characterNameLabel)
        speechParent.addSubview(characterImage)
        speechParent.addSubview(personSpeechLabel)
        speechParent.addSubview(characterSpeechLabel)
        speechParent.addSubview(micButton)
        
        
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.frame = CGRect(x: 0, y: 0, width: 35, height: 26)
        characterNameLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        characterNameLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20)
        characterNameLabel.attributedText = NSMutableAttributedString(string: "토끼")
        characterNameLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: speechParent.leadingAnchor, constant: 178).isActive = true
        characterNameLabel.topAnchor.constraint(equalTo: speechParent.topAnchor, constant: 70).isActive = true
        
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.image = UIImage(named: GlobalSpeechCharacter.shared.systemSpeechCharacterImageName)
        characterImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: speechParent.leadingAnchor, constant: 15).isActive = true
        characterImage.topAnchor.constraint(equalTo: speechParent.topAnchor, constant: 100).isActive = true
        
        personSpeechLabel.translatesAutoresizingMaskIntoConstraints = false
        personSpeechLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        personSpeechLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        personSpeechLabel.widthAnchor.constraint(equalToConstant: 48).isActive = true
        personSpeechLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        personSpeechLabel.leadingAnchor.constraint(equalTo: speechParent.leadingAnchor, constant: 320).isActive = true
        personSpeechLabel.topAnchor.constraint(equalTo: speechParent.topAnchor, constant: 119).isActive = true
        
        characterSpeechLabel.translatesAutoresizingMaskIntoConstraints = false
        characterSpeechLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        characterSpeechLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        characterSpeechLabel.widthAnchor.constraint(equalToConstant: 48).isActive = true
        characterSpeechLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        characterSpeechLabel.leadingAnchor.constraint(equalTo: speechParent.leadingAnchor, constant: 50).isActive = true
        characterSpeechLabel.topAnchor.constraint(equalTo: speechParent.topAnchor, constant: 163).isActive = true
        
        
        micButton.translatesAutoresizingMaskIntoConstraints = false
        micButton.setImage(UIImage(systemName: "mic.circle.fill"), for: .normal)
        micButton.tintColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
        micButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        micButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        micButton.centerXAnchor.constraint(equalTo: speechParent.centerXAnchor).isActive = true
        micButton.topAnchor.constraint(equalTo: speechParent.topAnchor, constant: 700).isActive = true
        
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
        
        speechFromCharacter()
    }
    
    //녹음된 오디오를 텍스트로 변환하고 해당 텍스트를 서버로 전송하여 응답을 받는 함수
    func speechFromCharacter(){
        
        //오디오 파일의 URL이 nil일 경우 예외처리
        guard let audioUrl = audioUrl else {
            print("Can't find audio url")
            return
        }
        
        //characterSpeechLabel
        guard let question = characterSpeechLabel.text else {
            return
        }
        
        //        if speechRecognizer!.isAvailable {
        //            let request = SFSpeechURLRecognitionRequest(url: audioUrl)
        //            speechRecognizer?.supportsOnDeviceRecognition = true
        //            speechRecognizer?.recognitionTask(with: request, resultHandler: { [weak self] (result, error) in
        //                if let error = error {
        //                    print(error.localizedDescription)
        //                } else if let result = result {
        //                    print(result.bestTranscription.formattedString)
        //                    if result.isFinal {
        //                        self?.text = result.bestTranscription.formattedString
        //                        self?.characterSpeechLabel.text = result.bestTranscription.formattedString
        //
        //                        //전송에 성공하면 실행되는 코드
        //                        guard let question = self?.resultLabel.text else { return }
        //                        self?.provider.request(.postSpeechToText(question: question)) { result in
        //                            switch result {
        //                            case .success(_):
        //                                self?.getAnwser()
        //                            case .failure(let error):
        //                                print("Error: \(error)")
        //                            }
        //                        }
        //                    }
        //                }
        //            })
        //        }
        //   }
        
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
        
        func pressMicBtn(_ sender: UIButton) {
            //녹음
//            if let recorder = audioRecorder {
//                if recorder.isRecording {
//                    finishRecording(success: true)
//                } else {
//                    startRecording()
//                }
//            } else {
//                startRecording()
//            }
        }
        
    }
    
    // MARK: - Recording
//    extension SpeechViewController {
//        func startRecording() {
//            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")
//
//            let settings = [
//                AVFormatIDKey: Int(kAudioFormatLinearPCM),
//                AVSampleRateKey: 16000,
//                AVNumberOfChannelsKey: 1,
//                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//            ]
//
//            do {
//                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//                audioRecorder.delegate = self
//                audioRecorder.record()
//
//                print("녹음 시작")
//            } catch {
//                finishRecording(success: false)
//            }
//        }
//
//        func getDocumentsDirectory() -> URL {
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            return paths[0]
//        }
//
//        func finishRecording(success: Bool) {
//            audioRecorder.stop()
//
//            if success {
//                micButton.isEnabled = true
//                print("finishRecording - success")
//            } else {
//                micButton.isEnabled = false
//                print("finishRecording - fail")
//                // recording failed :(
//            }
//        }
//
//        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//            if !flag {
//                finishRecording(success: false)
//            }
//        }
//
//    }
//
}

