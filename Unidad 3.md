
### Unidad 3: Validaciones

Aquí se profundiza en la importancia de validar y sanear cualquier dato que entre al sistema.


## 3.1 Validación de entradas
El proceso de asegurar que los datos recibidos cumplen con los criterios esperados antes de procesarlos.
- **Validación Sintáctica:** Verificar el formato (ej. es un número, es una fecha, es un email).
- **Validación Semántica:** Verificar el sentido del dato en el contexto de negocio (ej. la fecha de nacimiento indica que es mayor de edad, el precio es positivo).
- **Allow-list (Lista blanca):** Aceptar solo lo que se sabe que es bueno (ej. "solo letras a-z"), en lugar de intentar bloquear lo malo (Block-list).

## 3.2 Validación de datos
Asegurar la calidad y consistencia de los datos persistidos o procesados.
- **Tipado fuerte:** Utilizar las características del lenguaje de programación para asegurar tipos de datos correctos.
- **Restricciones de base de datos:** Uso de `Constraints`, `Foreign Keys` y `Triggers` para asegurar que los datos almacenados sean válidos, independientemente de la aplicación.

## 3.3 Validación de integridad
Garantizar que los datos no han sido alterados de forma no autorizada.
- **Checksums:** Sumas de verificación para detectar errores en transmisión.
- **Firmas digitales:** Uso de criptografía asimétrica para asegurar que el dato proviene de una fuente confiable y no ha sido modificado.
- **HMAC:** Hash Message Authentication Code para verificar integridad y autenticidad simultáneamente.

## 3.4 Implementación de validación de entradas
Técnicas de codificación para aplicar las reglas de validación.
- **Validación en capas:**
  1. **Cliente (Frontend):** Para UX rápida (no es seguridad).
  2. **Servidor (Backend):** Obligatoria para seguridad.
- **Sanitización:** Limpiar los datos de entrada de caracteres peligrosos (ej. eliminar etiquetas `<script>` de un comentario) antes de procesarlos, aunque se prefiere la validación estricta y el uso de parámetros seguros.

## 3.5 Implementación de validación de datos
Lógica de negocio aplicada a los datos.
- **Validadores personalizados:** Clases o funciones dedicadas a validar reglas complejas de negocio.
- **Manejo de estados:** Validar que los cambios de estado de un dato son lícitos (ej. un pedido "Entregado" no puede pasar a "Pendiente").

## 3.6 Implementación de validación de integridad
Mecanismos técnicos para asegurar la integridad.
- **Hashing de archivos:** Verificar el hash de un archivo subido contra un valor esperado.
- **Control de concurrencia:** Uso de `Optimistic Locking` (versionado de filas) para evitar que dos usuarios sobrescriban datos simultáneamente sin saberlo.