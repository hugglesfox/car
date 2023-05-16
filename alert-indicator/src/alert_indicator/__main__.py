import logging
import os
import requests
import time

from gpiozero import LED

led = LED(int(os.environ["LED_PIN"]))


def is_firing(alert_name: str):
    resp = requests.get("{}/api/v1/alerts".format(os.environ["PROMETHEUS_URL"])).json()

    if resp["status"] == "error":
        logging.error(
            "Prometheus reported an unsuccessful response: {}".format(resp["error"])
        )
        return True

    for alert in resp["alerts"]:
        if alert["labels"]["alertname"] == alert_name:
            return alert["state"] == "firing"

    return False


led.off()

while True:
    if is_firing(os.environ["ALERT_NAME"]):
        led.on()
    else:
        led.off()

    time.sleep(float(os.getenv("POLL_TIME", 10)))
