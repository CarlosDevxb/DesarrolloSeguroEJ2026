-- 1. GESTIÓN DE ACCESOS
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE, -- 'ADMIN', 'TECNICO', 'USUARIO'
    descripcion VARCHAR(255)
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- 2. CONFIGURACIÓN DINÁMICA (Tablas para flexibilidad)
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE estados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,    -- 'Abierto', 'En Espera', 'Cerrado'
    slug VARCHAR(50) NOT NULL UNIQUE, -- 'open', 'waiting', 'closed' para lógica de Backend
    color_hex VARCHAR(7) DEFAULT '#808080',
    finaliza_ticket BOOLEAN DEFAULT FALSE, -- Si el estado marca el fin del ciclo
    CONSTRAINT uk_slug UNIQUE (slug)
);

-- 3. ENTIDAD PRINCIPAL (Con uso de ENUMs para lógica estática)
CREATE TYPE nivel_prioridad AS ENUM ('BAJA', 'MEDIA', 'ALTA', 'CRITICA');

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    codigo_ticket VARCHAR(20) UNIQUE, 
    titulo VARCHAR(150) NOT NULL,
    descripcion_inicial TEXT NOT NULL,
    
    -- Uso del ENUM definido arriba
    prioridad nivel_prioridad NOT NULL DEFAULT 'MEDIA',
    
    -- Relaciones con tablas maestras
    categoria_id INT NOT NULL,
    estado_id INT NOT NULL,
    usuario_creador_id INT NOT NULL,
    tecnico_asignado_id INT, 
    
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_cierre TIMESTAMP,
    
    CONSTRAINT fk_ticket_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    CONSTRAINT fk_ticket_estado FOREIGN KEY (estado_id) REFERENCES estados(id),
    CONSTRAINT fk_ticket_creador FOREIGN KEY (usuario_creador_id) REFERENCES usuarios(id),
    CONSTRAINT fk_ticket_tecnico FOREIGN KEY (tecnico_asignado_id) REFERENCES usuarios(id)
);

-- 4. INTERACCIONES Y TRAZABILIDAD
CREATE TABLE ticket_comentarios (
    id SERIAL PRIMARY KEY,
    ticket_id INT NOT NULL,
    usuario_id INT NOT NULL,
    mensaje TEXT NOT NULL,
    es_nota_interna BOOLEAN DEFAULT FALSE,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comentario_ticket FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    CONSTRAINT fk_comentario_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- 5. ADJUNTOS
CREATE TABLE ticket_adjuntos (
    id SERIAL PRIMARY KEY,
    ticket_id INT NOT NULL,
    nombre_archivo VARCHAR(255) NOT NULL,
    url_archivo TEXT NOT NULL,
    tipo_archivo VARCHAR(50), 
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_adjunto_ticket FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE
);
