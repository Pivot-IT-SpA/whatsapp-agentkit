#!/bin/bash
# AgentKit - Script de inicio

set -e

echo ""
echo "==========================================================="
echo "   AgentKit - WhatsApp AI Agent Builder"
echo "==========================================================="
echo ""
echo "  Preparando tu entorno para construir tu agente de IA..."
echo ""

echo "  [1/4] Verificando Python..."
if ! command -v python3 &> /dev/null; then
    echo ""
    echo "  ERROR: Python 3 no encontrado."
    echo "  Descargalo en: https://python.org/downloads"
    echo ""
    exit 1
fi

PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')
if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 11 ]); then
    echo ""
    echo "  ERROR: Necesitas Python 3.11 o superior."
    echo "  Version actual: $(python3 --version)"
    echo "  Descarga la ultima version en: https://python.org/downloads"
    echo ""
    exit 1
fi
echo "  OK - $(python3 --version)"

echo "  [2/4] Verificando OpenCode..."
if ! command -v opencode &> /dev/null; then
    echo ""
    echo "  OpenCode no esta instalado."
    echo ""
    echo "  Para instalarlo:"
    echo "    curl -fsSL https://opencode.ai/install | bash"
    echo ""
    echo "  Despues de instalar, ejecuta 'opencode' una vez"
    echo "  y luego vuelve a correr: bash start.sh"
    echo ""
    exit 1
fi
echo "  OK - OpenCode instalado"

echo "  [3/4] Preparando carpetas..."
mkdir -p knowledge
echo "  OK - Estructura lista"

echo "  [4/4] Todo verificado"

echo ""
echo "==========================================================="
echo ""
echo "  Todo listo. Ahora abre OpenCode:"
echo ""
echo "    opencode"
echo ""
echo "  Y escribe:"
echo ""
echo "    /build-agent"
echo ""
echo "  OpenCode te guiara paso a paso para construir"
echo "  tu agente de WhatsApp personalizado con Gemini."
echo ""
echo "==========================================================="
echo ""
