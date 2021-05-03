#!/bin/bash
kubectl get deployments.apps |grep -v '0/'| grep -v NAME|grep -v debug| awk '{print $1}'| sort > /home/brlink/container-name.txt
seq 1 48 > /home/brlink/grafanId.txt
seq 901 948 > /home/brlink/alertname.txt
seq 0 8 120 > /home/brlink/posicaoMeio.txt
containerName=$(head -1 /home/brlink/container-name.txt)
id=$(head -1 /home/brlink/grafanId.txt)
alertname=$(head -1 /home/brlink/alertname.txt)
posicaoMeio=$(head -1 /home/brlink/posicaoMeio.txt)
####INICIO DA CRIAÇÃO DO DASHGRAFANA
		echo '{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "gnetId": null,
  "graphTooltip": 0,
  "id": 27,
  "links": [],
  "panels": [' > /home/brlink/grafana.txt
###############DASHBOARD DA ESQUERDA
for i in {0..90..6} 
	do 
	echo '{
      "alert": {
        "alertRuleTags": {},
        "conditions": [
          {
            "evaluator": {
              "params": [
                0.8
              ],
              "type": "gt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "params": [
                "A",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "avg"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "for": "5m",
        "frequency": "1m",
        "handler": 1,
        "name": "['$alername']Unimed_EKS PRD Pod '$containerName' MemoryUtilization > 80%",
        "noDataState": "no_data",
        "notifications": [
          {
            "uid": "wnJvq08Zk"
          }
        ]
      },
      "aliasColors": {},
      "bars": false,
      "cacheTimeout": null,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus-Produção",
      "decimals": 2,
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 6,
        "w": 8,
        "x": 0,
        "y": '$i'
      },
      "hiddenSeries": false,
      "id": '$id',
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "hideEmpty": false,
        "max": true,
        "min": false,
        "show": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "dataLinks": []
      },
      "percentage": false,
      "pluginVersion": "6.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        { 
        	"expr": "sum(container_memory_working_set_bytes{container_name=\"'$containerName'\",namespace=\"api-services\",pod=~\"'$containerName'.*\",service=\"kubelet\"}) by (pod) / sum(label_join(kube_pod_container_resource_limits_memory_bytes{namespace=\"api-services\",pod=~\"'$containerName'.*\"}, \"pod\", \",\", \"pod\")) by (pod)",
         	 "legendFormat": "{{pod}}",
          	"refId": "A"
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "gt",
          "value": 0.8
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "'$containerName' Memory Utilization",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "decimals": 1,
          "format": "percentunit",
          "label": null,
          "logBase": 1,
          "max": "1.2",
          "min": null,
          "show": true
        },
        {
          "decimals": null,
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
	},' >> /home/brlink/grafana.txt && sed -i 1d /home/brlink/container-name.txt | sed -i 1d /home/brlink/grafanId.txt | sed -i 1d /home/brlink/alertname.txt
	containerName=$(head -1 /home/brlink/container-name.txt)
	alertname=$(head -1 /home/brlink/alertname.txt)
	id=$(head -1 /home/brlink/grafanId.txt)
###############DASHBOARD DO MEIO
	echo '{
      "alert": {
        "alertRuleTags": {},
        "conditions": [
          {
            "evaluator": {
              "params": [
                0.8
              ],
              "type": "gt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "params": [
                "A",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "avg"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "for": "5m",
        "frequency": "1m",
        "handler": 1,
        "name": "['$alername']Unimed_EKS PRD Pod '$containerName' MemoryUtilization > 80%",
        "noDataState": "no_data",
        "notifications": [
          {
            "uid": "wnJvq08Zk"
          }
        ]
      },
      "aliasColors": {},
      "bars": false,
      "cacheTimeout": null,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus-Produção",
      "decimals": 2,
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 6,
        "w": 8,
        "x": '$posicaoMeio',
        "y": 6
      },
      "hiddenSeries": false,
      "id": '$id',
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "hideEmpty": false,
        "max": true,
        "min": false,
        "show": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "dataLinks": []
      },
      "percentage": false,
      "pluginVersion": "6.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        { 
        	"expr": "sum(container_memory_working_set_bytes{container_name=\"'$containerName'\",namespace=\"api-services\",pod=~\"'$containerName'.*\",service=\"kubelet\"}) by (pod) / sum(label_join(kube_pod_container_resource_limits_memory_bytes{namespace=\"api-services\",pod=~\"'$containerName'.*\"}, \"pod\", \",\", \"pod\")) by (pod)",
         	 "legendFormat": "{{pod}}",
          	"refId": "A"
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "gt",
          "value": 0.8
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "'$containerName' Memory Utilization",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "decimals": 1,
          "format": "percentunit",
          "label": null,
          "logBase": 1,
          "max": "1.2",
          "min": null,
          "show": true
        },
        {
          "decimals": null,
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
	},' >> /home/brlink/grafana.txt && sed -i 1d /home/brlink/container-name.txt | sed -i 1d /home/brlink/grafanId.txt | sed -i 1d /home/brlink/alertname.txt | sed -i 1d /home/brlink/posicaoMeio.txt
	containerName=$(head -1 /home/brlink/container-name.txt)
	alertname=$(head -1 /home/brlink/alertname.txt)
	id=$(head -1 /home/brlink/grafanId.txt)
	posicaoMeio=$(head -1 /home/brlink/posicaoMeio.txt)
###############DASHBOARD DA DIREITA
echo '{
      "alert": {
        "alertRuleTags": {},
        "conditions": [
          {
            "evaluator": {
              "params": [
                0.8
              ],
              "type": "gt"
            },
            "operator": {
              "type": "and"
            },
            "query": {
              "params": [
                "A",
                "5m",
                "now"
              ]
            },
            "reducer": {
              "params": [],
              "type": "avg"
            },
            "type": "query"
          }
        ],
        "executionErrorState": "alerting",
        "for": "5m",
        "frequency": "1m",
        "handler": 1,
        "name": "['$alername']Unimed_EKS PRD Pod '$containerName' MemoryUtilization > 80%",
        "noDataState": "no_data",
        "notifications": [
          {
            "uid": "wnJvq08Zk"
          }
        ]
      },
      "aliasColors": {},
      "bars": false,
      "cacheTimeout": null,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus-Produção",
      "decimals": 2,
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 6,
        "w": 8,
        "x": 16,
        "y": '$i'
      },
      "hiddenSeries": false,
      "id": '$id',
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "hideEmpty": false,
        "max": true,
        "min": false,
        "show": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "dataLinks": []
      },
      "percentage": false,
      "pluginVersion": "6.5.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        { 
        	"expr": "sum(container_memory_working_set_bytes{container_name=\"'$containerName'\",namespace=\"api-services\",pod=~\"'$containerName'.*\",service=\"kubelet\"}) by (pod) / sum(label_join(kube_pod_container_resource_limits_memory_bytes{namespace=\"api-services\",pod=~\"'$containerName'.*\"}, \"pod\", \",\", \"pod\")) by (pod)",
         	 "legendFormat": "{{pod}}",
          	"refId": "A"
        }
      ],
      "thresholds": [
        {
          "colorMode": "critical",
          "fill": true,
          "line": true,
          "op": "gt",
          "value": 0.8
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "'$containerName' Memory Utilization",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "decimals": 1,
          "format": "percentunit",
          "label": null,
          "logBase": 1,
          "max": "1.2",
          "min": null,
          "show": true
        },
        {
          "decimals": null,
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
	},' >> /home/brlink/grafana.txt && sed -i 1d /home/brlink/container-name.txt | sed -i 1d /home/brlink/grafanId.txt | sed -i 1d /home/brlink/alertname.txt
	id=$(head -1 /home/brlink/grafanId.txt) 
	containerName=$(head -1 /home/brlink/container-name.txt)
	alertname=$(head -1 /home/brlink/alertname.txt)
	done
        echo '  ],
        "schemaVersion": 21,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-5m",
    "to": "now"
  },
  "timepicker": {
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ]
  },
  "timezone": "",
  "title": "PODS UTILIZATION RESOURES - New",
  "uid": "GgxzDsrGk",
  "version": 13
}' >>  /home/brlink/grafana.txt
