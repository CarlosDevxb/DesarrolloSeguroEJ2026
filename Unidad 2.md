
### Unidad 2: Autorización

Este archivo detalla cómo gestionar los permisos una vez que el usuario ha sido autenticado.

## 2.1 Privilegios de acceso
Concepto fundamental que define qué puede hacer un usuario autenticado.
- **Principio de Mínimo Privilegio (PoLP):** Un usuario o proceso debe tener solo los permisos estrictamente necesarios para realizar su tarea, ni uno más.
- **Separación de funciones:** Evitar que una sola cuenta tenga control total sobre procesos críticos (ej. quien solicita un pago no debe ser quien lo aprueba).

## 2.2 Control de Roles (RBAC)
Role-Based Access Control es el modelo más común.
- **Definición de Roles:** Agrupación de permisos bajo una etiqueta (ej. Admin, Editor, Lector).
- **Asignación:** Los usuarios se asignan a roles, no a permisos individuales directamente, facilitando la gestión.
- **Jerarquía:** Los roles pueden heredar permisos de otros roles (ej. SuperAdmin hereda de Admin).

## 2.3 Implementación de acceso a recursos
Cómo se aplica la autorización a nivel de código y arquitectura.
- **Middleware/Filtros:** Interceptores que validan los permisos antes de que la petición llegue a la lógica de negocio.
- **Autorización a nivel de servicio:** No confiar solo en la validación del frontend; el backend debe validar cada petición.
- **Contexto de seguridad:** Objeto que viaja con la petición conteniendo la identidad y roles del usuario (ej. `IPrincipal` en .NET o `SecurityContext` en Spring).

## 2.4 Permisos basados en control de acceso
Modelos más granulares que RBAC.
- **ABAC (Attribute-Based Access Control):** Decisiones basadas en atributos del usuario, del recurso y del entorno (ej. "Gerentes pueden ver reportes, pero solo de 9am a 5pm").
- **ACL (Access Control Lists):** Listas específicas asociadas a un objeto que dicen qué usuarios tienen qué permisos sobre ese objeto específico.

## 2.5 Check de datos para acceso (Prevención de IDOR)
Validación de que el usuario tiene derecho a acceder al dato específico solicitado.
- **IDOR (Insecure Direct Object References):** Vulnerabilidad donde un usuario cambia un ID en la URL (ej. `/factura/100` a `/factura/101`) y accede a datos ajenos.
- **Validación de propiedad:** Verificar siempre que `Resource.OwnerID == CurrentUser.ID` antes de devolver o modificar datos.
- **Uso de UUIDs:** Utilizar identificadores aleatorios difíciles de adivinar en lugar de IDs autoincrementales secuenciales.

## 2.6 Seguridad de URLs
Protección de los puntos de entrada de la aplicación.
- **Forzar autorización:** Todas las URLs privadas deben requerir autenticación y autorización explícita.
- **Ocultación no es seguridad:** No basta con ocultar botones en la interfaz; la URL directa debe estar protegida en el servidor.
- **Estructura predecible:** Evitar estructuras de URL que revelen la arquitectura interna o permitan enumeración de recursos sin control.