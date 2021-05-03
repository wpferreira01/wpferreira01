#!/bin/bash
kubectl get deployments.apps |grep -v '0/'| grep -v NAME|grep -v debug| awk '{print $1}'| sed -n 17,32p| sort > /home/brlink/container-name.txt
seq 17 32 > /home/brlink/grafanId.txt
seq 917 932 > /home/brlink/alertname.txt
containerName=$(head -1 /home/brlink/container-name.txt)
id=$(head -1 /home/brlink/grafanId.txt)
alertname=$(head -1 /home/brlink/alertname.txt)
####INICIO DA CRIAÇÃO DO DASHGRAFANA
for i in {0..120..8} 
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
        "x": '$i',
        "y": 6,
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
