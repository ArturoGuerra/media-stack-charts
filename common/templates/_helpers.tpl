{{- define "image" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{ printf "%s:%s" .Values.image.repository $tag }}
{{- end -}}

{{- define "fullname" -}}
{{ .Values.fullnameOverride | default (printf "%s-%s" (.Values.nameOverride | default .Release.Name) .Chart.Name) }}
{{- end -}}

{{- define "service.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "ingress.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "pvc.fullname" -}}
{{ template "fullname" . }}-{{ .Values.persistence.name | default "config" }}
{{- end -}}

{{- define "configmap.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- if .Values.labels }}
{{ toYaml .Values.labels }}
{{- end }}
{{- end -}}

{{- define "selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "volumeMounts" -}}
{{- if .Values.persistence.enabled }}
- name: {{ .Values.persistence.name | default "config" }}
  mountPath: {{ .Values.persistence.mountPath }}
{{- end }}
{{- with .Values.extraVolumeMounts }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "volumes" -}}
{{- if .Values.persistence.enabled }}
- name: {{ .Values.persistence.name | default "config" }}
  persistentVolumeClaim:
    claimName: {{ .Values.persistence.existingClaim | default (include "pvc.fullname" .) }}
{{- end }}
{{- with .Values.extraVolumes }}
{{ toYaml . }}
{{- end }}
{{- end -}}
