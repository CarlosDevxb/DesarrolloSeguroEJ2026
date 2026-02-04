# Unidad 1: Autenticación y Seguridad

## 1.1 Nombres de usuario seguros
La seguridad en los nombres de usuario es el primer paso para evitar la enumeración de cuentas.
- **Unicidad:** El sistema debe garantizar que no existan duplicados.
- **Restricciones de formato:** Evitar caracteres especiales que puedan ser vectores de ataques XSS o SQL Injection.
- **Privacidad:** No permitir el uso de información sensible (como números de seguridad social) como nombre de usuario público.
- **Enumeración:** Las respuestas del servidor no deben revelar si un usuario existe o no durante el registro o login (ej. evitar "El usuario ya existe", preferir correos de confirmación).

## 1.2 Contraseñas seguras
Las políticas de contraseñas deben equilibrar la seguridad con la usabilidad.
- **Longitud:** Según NIST, la longitud es más importante que la complejidad. Se recomienda un mínimo de 8-12 caracteres.
- **Complejidad:** Uso de mayúsculas, minúsculas, números y símbolos (aunque hoy se prefiere fomentar frases de contraseña o "passphrases").
- **Rotación:** No forzar cambios de contraseña periódicos a menos que haya sospecha de compromiso, ya que esto fomenta contraseñas débiles.
- **Blocklist:** Prohibir contraseñas comunes (ej. "123456", "password") usando diccionarios de contraseñas filtradas.

## 1.3 Validación de correos seguros
El correo electrónico es un identificador clave y vector de recuperación.
- **Formato:** Validación estricta mediante expresiones regulares (Regex) conforme al estándar RFC 5322.
- **Verificación de dominio:** Comprobar que el dominio del correo tiene registros MX válidos.
- **Confirmación (Double Opt-in):** Enviar un enlace único temporal para verificar que el usuario tiene acceso a la cuenta.

## 1.4 Implementación de passwords seguros
Se refiere a las prácticas de codificación para manejar credenciales en memoria y tránsito.
- **HTTPS/TLS:** Las contraseñas nunca deben viajar en texto plano por la red.
- **Limpieza de memoria:** En lenguajes de bajo nivel o donde sea posible, limpiar las variables que contienen contraseñas de la memoria RAM tan pronto como dejen de usarse.
- **No logging:** Nunca escribir contraseñas en logs del sistema o consola.

## 1.5 Tokens de seguridad
Mecanismos para mantener la sesión sin enviar credenciales constantemente.
- **JWT (JSON Web Tokens):** Estándar para tokens autocontenidos. Deben firmarse (HMAC o RSA) para evitar manipulación.
- **Ciclo de vida:** Tokens de acceso (vida corta) y Refresh Tokens (vida larga, almacenados de forma segura).
- **Almacenamiento:** En web, preferiblemente en Cookies con flags `HttpOnly` y `Secure` para evitar robo vía XSS, en lugar de `localStorage`.

## 1.6 Hash passwords
Transformación unidireccional de la contraseña para su almacenamiento.
- **Algoritmos recomendados:** Argon2id (ganador de la Password Hashing Competition), bcrypt, scrypt o PBKDF2.
- **Algoritmos obsoletos:** MD5, SHA-1, SHA-256 (sin iteraciones masivas) son rápidos y vulnerables a ataques de fuerza bruta.
- **Factor de trabajo:** Configurar el algoritmo para que sea lento computacionalmente, dificultando ataques de hardware dedicado.

## 1.7 Almacenamiento de passwords
Cómo guardar los hashes en la base de datos.
- **Salt (Sal):** Valor aleatorio único por usuario que se añade a la contraseña antes de hashear. Protege contra ataques de Rainbow Tables.
- **Pepper (Pimienta):** Valor secreto global almacenado fuera de la base de datos (ej. en variables de entorno o HSM) que se añade al hash.
- **Re-hashing:** Mecanismo para actualizar hashes antiguos a nuevos algoritmos cuando el usuario se loguea.

## 1.8 Autenticación en pasos críticos
Protección adicional para acciones sensibles.
- **Re-autenticación:** Solicitar la contraseña nuevamente antes de acciones como cambiar el correo, cambiar la contraseña o realizar transferencias bancarias.
- **MFA (Multi-Factor Authentication):** Exigir un segundo factor (OTP, biometría) en estos pasos críticos.

## 1.9 Casos de error
El manejo de errores es crítico para no filtrar información.
- **Mensajes genéricos:** Usar "Usuario o contraseña incorrectos" en lugar de especificar cuál de los dos falló.
- **Tiempos de respuesta:** Mitigar ataques de tiempo (Timing Attacks) asegurando que el proceso de verificación tome el mismo tiempo independientemente de si el usuario existe o no.

## 1.10 Implementación de excepciones
Manejo robusto de fallos en el código de autenticación.
- **Fail-safe:** Si el sistema de autenticación falla (ej. base de datos caída), el acceso debe denegarse por defecto.
- **Logging seguro:** Registrar el error interno para los desarrolladores, pero mostrar un mensaje amigable y seguro al usuario final.


