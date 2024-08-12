from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.app import logs
from src.app.config.generic_config import GenericConfig
from src.app.config.server_config import Servlet
from src.app.exception.router_exception import initiate_exception_handling

# Routes
from src.app.app1.api import router as portfolio_router_v3


class MoneyMitraApplication:
    app: FastAPI

    def __init__(self):
        _cfgs = GenericConfig()
        self.app = FastAPI(
            debug=True,
            title="Money Mitra Services",
            description="Endpoints for MM (Money Mitra Services)",
            version="3.0",
            openapi_url=f"{_cfgs.get_context_root_path()}/apidoc/v3/openapi.json",
            docs_url=f"{_cfgs.get_context_root_path()}/apidoc/swagger-ui.html",
        )
        self.configure_cors()

    def configure_cors(self):
        """Configure CORS middleware"""
        self.app.add_middleware(
            CORSMiddleware,
            allow_origins=["*"],  
            allow_credentials=True,
            allow_methods=["*"], 
            allow_headers=["*"],  
        )

    def patchRoutes(self, with_context: str):
        """return the configuration"""
        logs.info("Money Mitra Services v3.0 - STARTING")
        # Routers
        self.app.include_router(
            portfolio_router_v3.route_controller, prefix=with_context
        )


if __name__ == "__main__":
    """All Operation starts from here"""
    global api
    api = MoneyMitraApplication()
    initiate_exception_handling(api.app)
    servlet = Servlet()
    executor = servlet.configure_server(api)
    executor.run()

# Uncomment for Hot reload while development
# print("DEBUG")
# api = MoneyMitraApplication()
# initiate_exception_handling(api.app)
# api.patchRoutes('/mm')
# app = api.app