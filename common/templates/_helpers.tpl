{{- define "image" -}}
{{ printf "%s:%s" .Values.image.repository .Values.image.tag }}
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
{{ template "fullname" . }}
{{- end -}}

{{- define "configmap.fullname" -}}
{{ template "fullname" . }}
{{- end -}}

{{- define "labels" -}}
app: {{ template "fullname" . }}
app.kubernetes.io/name: {{ template "fullname" . }}
{{- if .Values.labels }}
{{ toYaml .Values.labels }}
{{- end }}
{{- end -}}

{{- define "selectorLabels" -}}
{{ include "labels" . }}
{{- end -}}

{{- define "volumeMounts" -}}
{{- range $k, $v := .Values.persistence }}
{{- if $v.enabled }}
- name: {{ $k }}
  mountPath: {{ $v.mountPath }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "volumes" -}}
{{- range $k, $v := .Values.persistence }}
{{- if $v.enabled }}
- name: {{ $k }}
  {{- if $v.emptyDir }}
  {{- if $v.emptyDirConfig }}
  emptyDir:
    {{- toYaml $v.emptyDirConfig | nindent 4 }}
  {{- else }}
  emptyDir: {}
  {{- end }}
  {{- else }}
  persistentVolumeClaim:
    claimName: {{ $v.existingClaim | default (printf "%s-%s" (include "fullname" $) $k) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end -}}
