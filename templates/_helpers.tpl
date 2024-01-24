{{- define "app.fullname" -}}
    {{ .Release.Name }}-{{ .Values.name | default .Chart.Name }}
{{- end -}}

{{- define "app.version" -}}
    {{ .Values.image.tag }} 
{{- end -}}

{{- define "app.id" -}}
    {{ if .Values.routing.backend }}{{ .Values.appId }}{{ else  }}{{ template "app.fullname" $ }}{{ end }}
{{- end -}}

{{- define "app.routing.type" -}}
{{ if .Values.global.routing.type }}{{ .Values.global.routing.type }}{{ else }}{{ .Values.routing.type }}{{ end }}
{{- end -}}

{{- define "app.ingress.host" -}}
    {{ if .Values.routing.backend }}
        {{ template "app.fullname" $ }}-{{ .Release.Namespace }}.{{ .Values.global.default_url | default .Values.routing.default_url }}
    {{ else if .Values.routing.hostName }}
        {{ .Values.routing.hostName }}
    {{ else if .Values.global.hostName }}
        {{ .Values.global.hostName }}
    {{ else  }}
        {{ template "app.fullname" $ }}-{{ .Release.Namespace }}.{{ .Values.global.default_url | default .Values.routing.default_url }}
    {{ end }}
{{- end -}}

{{- define "app.labels.common" -}}
version: {{ .Values.version | default .Values.image.tag | quote }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/name: {{ template "app.fullname" $ }}
{{- end -}}
