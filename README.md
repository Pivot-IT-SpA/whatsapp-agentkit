# AgentKit - WhatsApp AI Agent Builder

Construye tu propio agente de WhatsApp con inteligencia artificial en menos de 30 minutos.
No necesitas saber programar. OpenCode construye todo por ti.

---

## Que es AgentKit?

AgentKit es un proyecto que usa **OpenCode** para generar un agente de WhatsApp completo
y personalizado para tu negocio.

Tu solo respondes preguntas sobre tu negocio. OpenCode se encarga de:
- Escribir el codigo
- Configurar la conexion con WhatsApp
- Crear el cerebro con Gemini API
- Dejarlo listo para pruebas y produccion

---

## Como funciona?

### Paso 1: Clonas el repo y corres un comando

```bash
git clone https://github.com/Hainrixz/whatsapp-agentkit.git
cd whatsapp-agentkit
bash start.sh
```

`start.sh` verifica Python 3.11+ y OpenCode.

### Paso 2: Abres OpenCode y ejecutas `/build-agent`

```bash
opencode
# Dentro de OpenCode escribe:
/build-agent
```

Esto activa el flujo definido en `AGENTKIT.md` a traves de `opencode.json`.

### Paso 3: OpenCode te entrevista

Te pregunta por:

1. Nombre de tu negocio
2. A que se dedica
3. Que quieres automatizar
4. Nombre del agente
5. Tono de comunicacion
6. Horario de atencion
7. Archivos de referencia en `knowledge/`
8. Tu `GEMINI_API_KEY`
9. Tu proveedor de WhatsApp
10. Las credenciales de ese proveedor

### Paso 4: OpenCode genera tu agente

Genera archivos como:

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
tests/
  test_local.py
requirements.txt
Dockerfile
docker-compose.yml
.env
```

### Paso 5: Lo pruebas en local

```bash
python tests/test_local.py
```

Si algo no te gusta, se lo pides a OpenCode en lenguaje natural y ajusta el proyecto.

### Paso 6: Deploy a produccion

Si quieres, OpenCode tambien te guia para:
- construir la imagen Docker
- preparar variables de Railway
- conectar el webhook de Meta o Twilio

---

## Arquitectura del agente

```txt
WhatsApp (cliente)
  -> proveedor (Meta/Twilio)
  -> FastAPI (agent/main.py)
  -> memoria (agent/memory.py)
  -> Gemini API (agent/brain.py)
  -> respuesta por WhatsApp
```

Cada cliente conserva su historial y el agente responde con base en:
- el system prompt de `config/prompts.yaml`
- el historial de la conversacion
- la informacion de `knowledge/`

---

## Requisitos previos

### 1. Python 3.11 o superior

- Mac: `brew install python`
- Windows: descarga desde `python.org`
- Linux: `sudo apt install python3.11`

Verifica con:

```bash
python3 --version
```

### 2. OpenCode

Instalacion recomendada:

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
4. Guardala para usarla como `GEMINI_API_KEY`

### 4. Cuenta de WhatsApp API

| Proveedor | Mejor para | Necesitas |
|-----------|------------|-----------|
| Twilio | Empezar rapido | `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, `TWILIO_PHONE_NUMBER` |
| Meta Cloud API | Produccion seria | `META_ACCESS_TOKEN`, `META_PHONE_NUMBER_ID`, `META_VERIFY_TOKEN` |

---

## Inicio rapido

```bash
git clone https://github.com/Hainrixz/whatsapp-agentkit.git
cd whatsapp-agentkit
bash start.sh
opencode
# Dentro de OpenCode: /build-agent
```

---

## Personalizar tu agente despues

Puedes seguir trabajando con OpenCode en lenguaje natural:

```bash
opencode "El agente esta siendo muy formal. Hazlo mas amigable y casual."
opencode "Agregamos un nuevo servicio de delivery. Actualiza el agente."
opencode "Quiero que el agente pueda consultar disponibilidad de citas."
opencode "Quiero migrar de Twilio a Meta Cloud API."
```

---

## Stack tecnico

| Componente | Tecnologia | Para que sirve |
|-----------|-----------|----------------|
| IA | Gemini API (`gemini-2.5-flash`) | Genera respuestas inteligentes |
| Servidor | FastAPI + Uvicorn | Recibe webhooks |
| WhatsApp | Meta / Twilio | Envia y recibe mensajes |
| Base de datos | SQLite / PostgreSQL | Guarda historial |
| Deploy | Docker + Railway | Produccion |
| Config | dotenv + YAML | Variables y prompts |

---

## Archivos clave

- `opencode.json`: configura OpenCode y el comando `/build-agent`
- `AGENTKIT.md`: instrucciones maestras del onboarding
- `.env.example`: variables base del agente generado
- `start.sh`: validacion de entorno

---

## Preguntas frecuentes

**Necesito saber programar?**
No. OpenCode escribe el codigo por ti.

**Cuanto cuesta?**
- AgentKit es gratis y open source
- Gemini API se paga por uso segun el modelo elegido
- WhatsApp depende del proveedor
- Railway depende del plan que uses

**Puedo usar esto con mi negocio real?**
Si. El flujo genera una base funcional para pruebas y deploy.

**Puedo cambiar de proveedor de WhatsApp despues?**
Si. Pides el cambio en OpenCode y regeneras lo necesario.

---

## Creditos

Creado por **Todo de IA** - [@soyenriquerocha](https://instagram.com/soyenriquerocha)

Adaptado para **OpenCode + Gemini**.

---

## Licencia

MIT
