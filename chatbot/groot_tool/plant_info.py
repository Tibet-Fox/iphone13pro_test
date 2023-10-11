from langchain.agents import create_csv_agent
from langchain.tools import BaseTool
from langchain import OpenAI
from langchain.agents import AgentType

class PlantInfo(BaseTool):
    name = "Plant_Info"
    description = """It's a good tool to use when asking about plant information. Summarize it in 100 characters"""

    def _run(self, query: str) -> str:
        agent = create_csv_agent(
        OpenAI(temperature=0.5),
        "csv/plant_info_.csv",
        verbose=True,
        agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        )
        return agent.run(query)
    
    async def _arun(self, query: str) -> str:
        raise NotImplementedError("질문에 답할 수 없어요.")
    