# from sentence_transformers import SentenceTransformer
# model = SentenceTransformer('jhgan/ko-sroberta-multitask')
from django.shortcuts import render
from django.http import JsonResponse
import pickle
import numpy as np
import json
import random

MODEL_PATH = 'chatbot/sentence_transformer_model.pkl'
JSON_PATH = 'chatbot/embedding_data.json'

with open(MODEL_PATH, 'rb') as f:
     model = pickle.load(f)

# JSON 데이터 로딩
with open(JSON_PATH, 'r') as f:
    data = json.load(f)

def get_most_similar_question(query):
    # 사용자로부터 입력 받은 질문을 임베딩
    query_embedding = model.encode(query)
    similarities = []

    # 질문에 대해 임베딩을 생성하고 쿼리와의 유사도를 계산
    for question in data.keys():
        question_embedding = model.encode(question)
        # 코사인 유사도 계산식
        similarity = np.dot(query_embedding, question_embedding) / (np.linalg.norm(query_embedding) * np.linalg.norm(question_embedding))
        similarities.append(similarity)

    # 가장 유사한 질문의 인덱스를 찾음
    most_similar_idx = np.argmax(similarities)
    return list(data.keys())[most_similar_idx]

def get_response(query):
    # 가장 유사한 질문을 가져옴
    most_similar_question = get_most_similar_question(query)
    responses = data[most_similar_question]

    # 해당 질문에 대한 응답 중 하나를 무작위로 선택
    response = random.choice(responses)
    response_text = list(response.values())[0]

    # 응답 텍스트에서 `${h}`라는 템플릿 문자열을 찾아 사용자 입력을 기반으로 대체함.
    if '${h}' in response_text:
        user_input_humidity = 25 # 임시로 습도 값을 주었습니다.

        # 습도가 30 이하라면 `${h}`를 사용자가 입력한 습도 값으로 대체
        if user_input_humidity <= 30:
            response_text = response_text.replace('${h}', str(user_input_humidity))
        else:
            # 습도 값이 30이 넘어가면, ${h} 문자열이 포함되지 않은 응답 중에서 랜덤 선택
            responses_without_h = [resp for resp in responses if '${h}' not in list(resp.values())[0]]
            chosen_response = random.choice(responses_without_h)
            response_text = list(chosen_response.values())[0]

    return response_text

def ask(request):
    if request.method == "GET":
        question = request.GET.get("question")
        if question:
            answer = get_response(question)
            return JsonResponse({"answer": answer})
        else:
            return render(request, "ask.html")
