# Galddino.IA

IA em português com agente (calculadora, data/hora, Wikipedia com fontes, anexos), rodando no seu PC e acessível online.

## Uso diário: um clique
1. Dê dois cliques em `iniciar-tudo.bat`.
   - 1ª vez: instala o que faltar (feche e abra de novo), pede uma senha e baixa o modelo.
2. O chat local abre sozinho. Espere o topo mostrar "modelo local pronto".
3. O endereço do túnel (https://...trycloudflare.com) aparece na janela e já fica copiado.

## Versão online (Netlify)
1. Uma vez: app.netlify.com/drop e arraste a pasta `public`.
2. Sempre que reiniciar o iniciar-tudo.bat o endereço do túnel muda:
   abra o site, clique em ⚙ Conexão, cole o novo endereço e digite a senha.

## Outros arquivos
- iniciar.bat: só o modelo local. iniciar-rapido.bat: teste de velocidade (Q4, sem imagem/áudio).
- netlify/functions/chat.mjs: alternativa online por API paga (variáveis LLM_API_URL, LLM_API_KEY, LLM_MODEL, SENHA).

## Segurança
Não compartilhe a senha nem o endereço do túnel: quem tiver os dois usa seu computador.

## Otimização (o que já vem aplicado)
- Página única de ~60 KB, sem bibliotecas externas e com logos embutidos: abre instantaneamente, igual offline e hospedada.
- Streaming com renderização limitada a 1 vez por quadro (sem travar em respostas longas) e rolagem que respeita você ter subido a tela.
- Contexto com janela deslizante (24 mensagens) e prompt fixo, o que permite ao llama.cpp reaproveitar o cache.
- Verificação de status pausada quando a aba está oculta.
- Para ganhar velocidade de geração (a parte lenta, ~12 tokens/s): teste o iniciar-rapido.bat (Q4, sem visão/áudio, contexto 8192).
