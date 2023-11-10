from langchain.tools import BaseTool
import random

class ChatBotName(BaseTool):
    name = "chatbot_name"
    description = """이름을 물을 때 사용하면 좋은 도구이다. 예를 들면 너의 이름은 뭐야?, 너는 누구야?"""

    def _run(self, query: str) -> str:
        return greet_user(query)
    
    async def _arun(self, query: str) -> str:
        raise NotImplementedError("질문에 답할 수 없어요.")
    

def greet_user(input="") -> str:
    names = ["나비란", "그루트", "산세베리아"]
    name = random.choice(names)
    responses = [
        f"제 이름은 {name} 입니다. 어떤 도움이 필요하시나요?",
        f"저는 {name}. 무슨 일을 도와드릴까요?"
    ]
    return random.choice(responses)