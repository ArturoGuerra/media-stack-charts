{{- define "image" -}}
{{ printf "%s:%s" .repository .tag }}
{{- end -}}

{{- define "controller-image" -}}
{{ template "image" .Values.controller.image }}
{{- end -}}

{{- define "worker-image" -}}
{{ template "image" .Values.workers.image }}
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
app: {{ . }}
app.kubernetes.io/name: {{ . }}
{{- end -}}

{{- define "selectorLabels" -}}
app: {{ . }}
app.kubernetes.io/name: {{ . }}
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
