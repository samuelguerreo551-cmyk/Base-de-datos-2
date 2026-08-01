# Sistema de Control de Pedidos para Colmados o Mini Markets

## Descripción

Este proyecto implementa una base de datos en PostgreSQL para gestionar las operaciones de un colmado o mini market.

El sistema permite registrar:

- Clientes
- Productos
- Pedidos
- Detalles de pedidos
- Entregas a domicilio

Además, incorpora características avanzadas de PostgreSQL como:

- Transacciones
- Índices
- Funciones en PL/pgSQL
- Procedimientos almacenados
- Triggers
- Vistas
- Ejemplo de base de datos distribuida mediante PostgreSQL FDW
- Consultas preparadas para procesamiento paralelo

---

## Tecnologías utilizadas

- PostgreSQL
- SQL
- PL/pgSQL
- Git
- GitHub

---

## Estructura del proyecto

```
Sistema-Control-Pedidos/
│
├── README.md
├── crear_tablas.sql
├── insertar_datos.sql
├── indices.sql
├── funciones.sql
├── procedimientos.sql
├── triggers.sql
├── transacciones.sql
├── vistas.sql
└── distribuidas.sql
```

---

## Modelo de la Base de Datos

La base de datos está compuesta por cinco tablas principales:

- Clientes
- Productos
- Pedidos
- Detalle_Pedido
- Entregas

Las relaciones permiten mantener la integridad referencial mediante claves primarias y claves foráneas.

---

## Funcionalidades

✔ Registro de clientes

✔ Registro de productos

✔ Control de inventario

✔ Registro de pedidos

✔ Registro de entregas

✔ Actualización automática del inventario

✔ Cálculo automático del total de cada pedido

✔ Aplicación automática de descuentos

✔ Generación de reportes

---

## Autor

Samuel Guerrero, franco de la cruz martines, alejandro vallejo y jose benitez