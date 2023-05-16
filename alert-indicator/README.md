# Alert Indicator

A simple python script that queries the given Prometheus alert an will turn an
LED on if it's firing.

## Configuration

Alert indicator can be configured using the following environment variables

| Envrionment Variable | Description                                        | Default Value |
|----------------------|----------------------------------------------------|---------------|
| **LED_PIN**          | The raspberry pi GPIO pin of the LED.              | _REQUIRED_    |
| **PROMETHEUS_URL**   | The URL of the Prometheus instance                 | _REQUIRED_    |
| **ALERT_NAME**       | The name of the Prometheus alert to monitor        | _REQUIRED_    |
| **POLL_TIME**        | The number of seconds between Prometheus API polls | 10            |
