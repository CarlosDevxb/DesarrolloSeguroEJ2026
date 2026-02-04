
### Unidad 4: Seguridad Anti-spam

Finalmente, este archivo cubre las técnicas para proteger la aplicación de abusos automatizados.
## 4.1 Limitación de consultas (Rate Limiting)
Controlar la frecuencia con la que un usuario o IP puede realizar peticiones al servidor.
- **Throttling:** Reducir la velocidad de respuesta o bloquear temporalmente tras superar un umbral.
- **Cuotas:** Límites fijos por periodo de tiempo (ej. 1000 peticiones/hora).
- **Prevención de DoS:** Ayuda a mitigar ataques de Denegación de Servicio a nivel de aplicación.
- **Protección de fuerza bruta:** Impide intentos ilimitados de adivinanza de contraseñas.

## 4.2 Captcha de verificación
Prueba de Turing pública y completamente automatizada para diferenciar computadoras de humanos.
- **Tipos:**
  - **Visuales/Texto:** Identificar letras distorsionadas (cada vez menos usados por accesibilidad).
  - **Comportamiento (Invisible):** Analizan el movimiento del mouse y patrones de navegación (ej. reCAPTCHA v3).
  - **Gamificados:** Resolver puzles sencillos.
- **Uso estratégico:** Implementar solo en puntos críticos (registro, login fallido reiterado, formularios de contacto) para no afectar la UX.

## 4.3 Protección de vulnerabilidades
Mecanismos adicionales para evitar el abuso automatizado y spam.
- **Honeypots:** Campos ocultos en formularios (CSS `display: none`) que los bots rellenan automáticamente pero los humanos no ven. Si el campo tiene valor, es spam.
- **CSRF Tokens:** Protegen contra Cross-Site Request Forgery, asegurando que el formulario enviado proviene realmente de la aplicación y no de un sitio malicioso externo.
- **WAF (Web Application Firewall):** Reglas a nivel de red para bloquear patrones de tráfico sospechosos o IPs de botnets conocidas.
```

<!--
[PROMPT_SUGGESTION]¿Puedes darme un ejemplo de código en C# para implementar el punto 1.6 Hash passwords usando BCrypt?[/PROMPT_SUGGESTION]
[PROMPT_SUGGESTION]¿Cómo implementaría un Rate Limiting básico (punto 4.1) en una API .NET?[/PROMPT_SUGGESTION]
