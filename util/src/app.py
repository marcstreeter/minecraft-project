from datetime import datetime
import logging

from flask import (
    Flask,
    jsonify,
)

from libs import game


app = Flask(__name__)
logger = logging.getLogger(__name__)


@app.route('/save', methods=['POST'])
def save():
    try:
        logger.debug("saving...")
        game.save()
    except:
        logger.exception("saving failed")
        return jsonify(response('system error unknown', success=False)), 500
    else:
        logger.debug("saving succeeded")
        return jsonify(response("saved"))


@app.route('/health', methods=['GET', 'POST'])
def health():
    logger.debug("health check {}".format(datetime.now()))
    return {
        'message': 'OK',
        'success': True,
    }


def response(message, success=True) -> dict:
    return {
        'message': message,
        'success': success,
    }