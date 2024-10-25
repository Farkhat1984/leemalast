# leema/__init__.py
from flask import Flask
from config import Config


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    from controllers.main import main_bp
    app.register_blueprint(main_bp)

    return app

if __name__ == '__main__':
    create_app().run(host="0.0.0.0", port=5001, debug=True)
