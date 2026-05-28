# AgentKit - WhatsApp AI Agent Builder

Plantilla para crear agentes de WhatsApp con `OpenCode + Gemini` y desplegarlos en `Railway`.

El enfoque recomendado es simple: **un agente por cliente**.

---

## Para que sirve

Este repo no esta pensado como un bot multi-tenant centralizado.
Esta pensado como una **fabrica de agentes** para que puedas crear una automatizacion separada por cliente.

Cada proyecto generado puede tener:
- su propio prompt
- su propio negocio
- su propia base de datos
- su propio proveedor de WhatsApp
- su propio despliegue en Railway

Esto evita mezclar:
- historial de conversaciones
- credenciales
- tono y reglas del negocio
- integraciones de distintos clientes

---

## Modelo operativo recomendado

Usa este repo como plantilla base y crea **una copia por cliente**.

Ejemplo:

```txt
clientes/
  clinica-sonrisa/
  pizzeria-norte/
  inmobiliaria-sol/
```

En cada carpeta ejecutas el onboarding y generas un agente distinto.

---

## Flujo por cliente

### 1. Crear una copia del proyecto

```bash
git clone https://github.com/Hainrixz/whatsapp-agentkit.git cliente-demo
cd cliente-demo
```

Si ya usas este repo como base interna, tambien puedes duplicar la carpeta o crear un nuevo repo por cliente.

### 2. Verificar entorno

```bash
bash start.sh
```

`start.sh` verifica Python 3.11+ y `opencode`.

### 3. Ejecutar el onboarding

```bash
opencode
# Dentro de OpenCode:
/build-agent
```

OpenCode usa `opencode.json` y `AGENTKIT.md` para generar el agente.

### 4. Responder la entrevista

OpenCode te pedira:

1. Nombre del negocio
2. Descripcion del negocio
3. Casos de uso del agente
4. Nombre del agente
5. Tono de comunicacion
6. Horario de atencion
7. Archivos de referencia en `knowledge/`
8. `GEMINI_API_KEY`
9. Proveedor de WhatsApp
10. Credenciales del proveedor

### 5. Probar localmente

```bash
python tests/test_local.py
```

### 6. Ajustar lo necesario

Ejemplos:

```bash
opencode "El agente esta siendo muy formal. Hazlo mas cercano."
opencode "Agrega respuestas para preguntas frecuentes sobre precios."
opencode "Quiero que tome solicitudes de cita y pida nombre, fecha y telefono."
```

### 7. Desplegar a produccion

Recomendado: `Railway`

---

## Estructura generada

```txt
agent/
  main.py
  brain.py
  memory.py
  tools.py
  providers/
config/
  business.yaml
  prompts.yaml
knowledge/
tests/
  test_local.py
requirements.txt
Dockerfile
docker-compose.yml
.env
```

---

## Arquitectura

```txt
WhatsApp (cliente)
  -> proveedor (Meta/Twilio)
  -> FastAPI (agent/main.py)
  -> memoria (agent/memory.py)
  -> Gemini API (agent/brain.py)
  -> respuesta por WhatsApp
```

Cada cliente conserva su propio historial y su propia configuracion.

---

## Requisitos previos

### 1. Python 3.11 o superior

- Mac: `brew install python`
- Windows: descarga desde `python.org`
- Linux: `sudo apt install python3.11`

```bash
python3 --version
```

### 2. OpenCode

```bash
curl -fsSL https://opencode.ai/install | bash
```

Luego abre OpenCode una vez:

```bash
opencode
```

### 3. API Key de Gemini

1. Ve a `https://ai.google.dev/gemini-api/docs/api-key`
2. Entra a Google AI Studio
3. Crea una API key
4. Guardala como `GEMINI_API_KEY`

### 4. Cuenta de WhatsApp API

| Proveedor | Mejor para | Necesitas |
|-----------|------------|-----------|
| Twilio | Empezar rapido | `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, `TWILIO_PHONE_NUMBER` |
| Meta Cloud API | Produccion seria | `META_ACCESS_TOKEN`, `META_PHONE_NUMBER_ID`, `META_VERIFY_TOKEN` |

---

## Produccion en Railway

Railway es la opcion recomendada para este proyecto porque:
- despliega bien aplicaciones Python pequenas
- soporta `Dockerfile`
- maneja variables de entorno facil
- te da URL publica HTTPS
- es comodo para tener **un servicio por cliente**

### Flujo recomendado

1. Crear un repo por cliente en GitHub
2. Subir el proyecto generado
3. Crear un proyecto en Railway
4. Conectar el repo
5. Configurar variables de entorno
6. Desplegar
7. Configurar el webhook de Meta o Twilio

### Variables de entorno tipicas

```env
GEMINI_API_KEY=
GEMINI_MODEL=gemini-2.5-flash
WHATSAPP_PROVIDER=
PORT=8000
ENVIRONMENT=production
DATABASE_URL=
```

Mas las del proveedor elegido.

### Webhook esperado

```txt
https://tu-app.up.railway.app/webhook
```

---

## Costos aproximados

Estimacion simple por cliente en produccion usando `Railway + Gemini + WhatsApp`.

Supuestos:
- modelo: `gemini-2.5-flash`
- bot transaccional normal, no agentes complejos
- servicio pequeno en Railway
- WhatsApp con costo variable segun proveedor y pais

| Escenario | Interacciones/mes | Gemini aprox | Railway aprox | WhatsApp aprox | Total aprox |
|---|---:|---:|---:|---:|---:|
| Bajo | 1,000 | USD 0.80 | USD 5-10 | USD 5-20 | USD 11-31 |
| Pyme ligera | 5,000 | USD 4 | USD 8-15 | USD 15-50 | USD 27-69 |
| Pyme media | 10,000 | USD 8 | USD 10-20 | USD 20-100 | USD 38-128 |
| Pyme activa | 20,000 | USD 16 | USD 15-30 | USD 40-180 | USD 71-226 |
| Pyme alta | 50,000 | USD 40 | USD 20-50 | USD 100-400 | USD 160-490 |

En la practica:
- `Railway` normalmente no es lo mas caro
- `Gemini` sigue siendo razonable si usas `gemini-2.5-flash`
- `WhatsApp` puede terminar siendo el costo dominante

---

## Estrategia para multiples clientes

### Recomendado al inicio

**1 proyecto por cliente**

Ventajas:
- aislamiento total
- menos riesgo operativo
- deploy separado
- debugging mas facil
- cada cliente puede evolucionar a su ritmo

### No recomendado al inicio

**1 solo bot para muchos clientes**

Eso exige rediseñar:
- multi-tenancy
- seleccion dinamica de prompts
- credenciales por tenant
- aislamiento de memoria
- herramientas configurables por cliente

Solo tiene sentido cuando ya tengas volumen alto y un producto mas maduro.

---

## Archivos clave del template

- `opencode.json`: configura OpenCode y el comando `/build-agent`
- `AGENTKIT.md`: instrucciones maestras del onboarding
- `.env.example`: variables base
- `start.sh`: validacion del entorno

---

## Comandos utiles

```bash
# Verificar entorno
bash start.sh

# Abrir OpenCode
opencode

# Probar el agente generado
python tests/test_local.py

# Arrancar API local
uvicorn agent.main:app --reload --port 8000

# Produccion local con Docker
docker compose up --build
```

---

## Preguntas frecuentes

**Necesito saber programar?**
No. OpenCode genera la base del proyecto por ti.

**Puedo usarlo para una agencia?**
Si. De hecho ese es el mejor uso inicial: una automatizacion por cliente.

**Puedo cambiar de proveedor de WhatsApp despues?**
Si. Pides el cambio en OpenCode y regeneras los archivos necesarios.

**Puedo usarlo con mi negocio real?**
Si, pero conviene probar localmente antes de desplegar.

---

## Creditos

Creado por **Todo de IA** - [@soyenriquerocha](https://instagram.com/soyenriquerocha)

Adaptado para **OpenCode + Gemini**.

---

## Licencia

MIT
