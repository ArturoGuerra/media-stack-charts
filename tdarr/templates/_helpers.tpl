{{/*
Deep-merge a single worker instance's overrides onto worker.defaults.
deepCopy prevents mustMergeOverwrite from mutating the shared
worker.defaults map across range iterations.
*/}}
{{- define "tdarr.worker.merge" -}}
{{- mustMergeOverwrite (deepCopy .root.Values.worker.defaults) .instance | toYaml -}}
{{- end -}}
