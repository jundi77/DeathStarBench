{{- define "hotelreservation.templates.baseIngress" }}
{{- $svcName := printf "%s-%s" .Values.name (include "hotel-reservation.fullname" .) -}}
{{- $defaultPort := 80 -}}
{{- if .Values.ports -}}
  {{- $defaultPort = (index .Values.ports 0).port -}}
{{- end -}}
{{- $svcPort := .Values.ingress.servicePort | default $defaultPort -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $svcName }}
  labels:
    {{- include "hotel-reservation.selectorLabels" . | nindent 4 }}
    service: {{ $svcName }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if .Values.ingress.className }}
  ingressClassName: {{ .Values.ingress.className }}
  {{- end }}
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType | default "Prefix" }}
            backend:
              service:
                name: {{ $svcName }}
                port:
                  number: {{ .port | default $svcPort }}
          {{- end }}
    {{- end }}
{{- end }}