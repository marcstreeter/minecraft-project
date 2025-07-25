{{/*
Expand the name of the chart.
*/}}
{{- define "minecraft-project.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "minecraft-project.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "minecraft-project.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "minecraft-project.labels" -}}
helm.sh/chart: {{ include "minecraft-project.chart" . }}
{{ include "minecraft-project.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "minecraft-project.selectorLabels" -}}
app.kubernetes.io/name: {{ include "minecraft-project.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "minecraft-project.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "minecraft-project.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate image name
*/}}
{{- define "minecraft-project.image" -}}
{{- $registry := .Values.global.imageRegistry | default .Values.images.spigot.registry | default "" -}}
{{- $repository := .Values.images.spigot.repository -}}
{{- $tag := .Values.images.spigot.tag | default .Chart.AppVersion -}}
{{- printf "%s%s:%s" $registry $repository $tag -}}
{{- end }}

{{/*
Generate proxy image name
*/}}
{{- define "minecraft-project.proxyImage" -}}
{{- $registry := .Values.global.imageRegistry | default .Values.images.proxy.registry | default "" -}}
{{- $repository := .Values.images.proxy.repository -}}
{{- $tag := .Values.images.proxy.tag | default .Chart.AppVersion -}}
{{- printf "%s%s:%s" $registry $repository $tag -}}
{{- end }}

{{/*
Generate utils image name
*/}}
{{- define "minecraft-project.utilsImage" -}}
{{- $registry := .Values.global.imageRegistry | default .Values.images.utils.registry | default "" -}}
{{- $repository := .Values.images.utils.repository -}}
{{- $tag := .Values.images.utils.tag | default .Chart.AppVersion -}}
{{- printf "%s%s:%s" $registry $repository $tag -}}
{{- end }}

{{/*
Generate configmap name for a specific service
*/}}
{{- define "minecraft-project.configmapName" -}}
{{- printf "%s-%s" (include "minecraft-project.fullname" .) .serviceName -}}
{{- end }}

{{/*
Generate deployment name for a specific service
*/}}
{{- define "minecraft-project.deploymentName" -}}
{{- printf "%s-%s" (include "minecraft-project.fullname" .) .serviceName -}}
{{- end }}

{{/*
Generate service name for a specific service
*/}}
{{- define "minecraft-project.serviceName" -}}
{{- printf "%s-%s" (include "minecraft-project.fullname" .) .serviceName -}}
{{- end }} 