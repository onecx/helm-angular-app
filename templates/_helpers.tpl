{{- define "app-angular.fullname" -}}
    {{- if or .Values.product (not (hasKey .Values "product")) -}}
        {{ .Release.Name }}-{{ .Values.name | default .Chart.Name }}
    {{- else -}}
        {{ .Release.Name }}
    {{- end -}}
{{- end -}}

{{- define "app-angular.product.name" -}}
    {{ .Release.Name }}
{{- end -}}


{{- define "app-angular.version" -}}
    {{ .Values.image.tag }} 
{{- end -}}

{{- define "app-angular.id" -}}
    {{ if .Values.routing.backend }}{{ .Values.appId }}{{ else  }}{{ template "app-angular.fullname" $ }}{{ end }}
{{- end -}}

{{- define "app-angular.routing.type" -}}
{{ if .Values.global.routing.type }}{{ .Values.global.routing.type }}{{ else }}{{ .Values.routing.type }}{{ end }}
{{- end -}}

{{- define "app-angular.routing.service" -}}
    {{- if .Values.routing.service.name -}}
        {{- .Values.routing.service.name -}}
    {{- else if .Values.service.name -}}
        {{- .Values.service.name -}}
    {{- else -}}
        {{- template "app-angular.fullname" $ }}
    {{- end -}}
{{- end -}}

{{- define "app-angular.ingress.host" -}}
    {{ if .Values.routing.backend }}
        {{ template "app-angular.fullname" $ }}-{{ .Release.Namespace }}.{{ .Values.global.default_url | default .Values.routing.default_url }}
    {{ else if .Values.routing.hostName }}
        {{ .Values.routing.hostName }}
    {{ else if .Values.global.hostName }}
        {{ .Values.global.hostName }}
    {{ else  }}
        {{ template "app-angular.fullname" $ }}-{{ .Release.Namespace }}.{{ .Values.global.default_url | default .Values.routing.default_url }}
    {{ end }}
{{- end -}}

{{- define "app-angular.permission.product.name" -}}
    {{- if .Values.operator.permission.spec.productName -}}
        {{- .Values.operator.permission.spec.productName -}}
    {{- else -}}
        {{ include "app-angular.product.name" $ }}
    {{- end -}}
{{- end -}}

{{- define "app-angular.microservice.product.name" -}}
    {{- if .Values.operator.microservice.spec.productName -}}
        {{- .Values.operator.microservice.spec.productName -}}
    {{- else -}}
        {{ include "app-angular.product.name" $ }}
    {{- end -}}
{{- end -}}

{{- define "app-angular.labels.common" -}}
version: {{ .Values.version | default .Values.image.tag | quote }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/name: {{ template "app-angular.fullname" $ }}
{{- end -}}
