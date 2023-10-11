from langchain import OpenAI 
from langchain.chat_models import ChatOpenAI
from langchain.chains.conversation.memory import ConversationBufferWindowMemory
from langchain.agents import Tool
from langchain.agents import initialize_agent
from groot_tool.response_generator import ResponseGenerator
from groot_tool.chatbot_name import ChatBotName
from groot_tool.plant_info import PlantInfo
from groot_tool.plant_for_sensor import PlantSensor
from langchain.agents import AgentType
from dotenv import load_dotenv

load_dotenv()

ChatBotName_tool = Tool(
    name="chatbot_name",
    func=ChatBotName().run,
    description = """이름을 물을 때 사용하면 좋은 도구이다. 예를 들자면 너의 이름은 뭐야?, 너는 누구야?, 넌 누구니?"""
)

response_tool = Tool(
    name="response_generator",
    func=ResponseGenerator().run,
    description="""일상적인 대화 시 사용하는 도구"""
)

sensor_tool = Tool(
    name='sensor_tool',
    func= PlantSensor().run,
    description="It is a good tool to use when receiving sensor values and asking the condition of the plant, and the answer is printed as it is, and an example of the question is as follows. Sanseveria, how are you now?"
)

plant_info_tool = Tool(
    name='plant_info_tool',
    func= PlantInfo().run,
    description="""It's a good tool to use when asking about plant information. Summarize it in 100 characters"""
)

tools = [response_tool, sensor_tool, plant_info_tool, ChatBotName_tool]

memory = ConversationBufferWindowMemory(
    memory_key='chat_history',
    k=3,
    return_messages=True
)

# create our agent
conversational_agent = initialize_agent(
    agent=AgentType.OPENAI_FUNCTIONS,
    tools=tools,
    llm=ChatOpenAI(temperature=0, model="gpt-3.5-turbo-0613"),
    verbose=True,
    max_iterations=3,
    early_stopping_method='generate',
    memory=memory
)

print(conversational_agent.run("너의 이름은 뭐니?"))


# vscode에서 실행해보기.
# pipenv shell
# pipenv install langchain
# pipenv install OPENAI
# pipenv install python-dotenv = .env 파일안에 있는 환경 변수를 프로젝트로 가져올 수 있도록 도와줌
# pipenv install sentence_transformers