# CONTRIBUTING

Última atualização: 2025-10-25

Obrigado por considerar contribuir para o repositório Delean-Mafra/faculdade! Este documento descreve como você pode reportar problemas, enviar melhorias e contribuir com conteúdo de forma clara e organizada. Antes de contribuir, por favor leia também o CODE_OF_CONDUCT.md do repositório.

## 1. Visão geral
Este repositório reúne códigos, exemplos e soluções usadas para estudo e referência acadêmica. Contribuições que melhoram a documentação, corrigem bugs, adicionam exemplos explicativos e organizam o conteúdo são especialmente bem-vindas.

## 2. Antes de abrir uma issue ou PR
- Verifique se já existe uma issue ou PR relacionada.
- Leia o README e outros arquivos de documentação do repositório.
- Consulte a licença do repositório (arquivo LICENSE) para entender permissões de uso.

## 3. Reportando bugs e pedindo melhorias (issues)
Ao abrir uma issue, use um título claro e inclua:
- Descrição concisa do problema ou sugestão.
- Passos para reproduzir (quando for bug).
- Sistema/versão (ex.: Python 3.10, NumPy 1.25).
- Trechos de código, outputs e mensagens de erro (se aplicável).
- Link para o arquivo/arquivo(s) relevantes no repositório.

Exemplo mínimo:
Título: "Erro ao executar exemplo 'Operações com Arrays e Matrizes usando NumPy.py'"
Descrição:
- Passos: python arquivo.py
- Erro: Traceback...
- Versão: Python 3.11, NumPy 2.0

## 4. Como sugerir uma mudança (Pull Requests)
Fluxo recomendado:
1. Fork do repositório.
2. Crie uma branch com nome claro:
   - feature/nome-descritivo
   - fix/nome-descritivo
   - docs/atualiza-exemplo
3. Faça commits pequenos e atômicos com mensagens claras.
4. Atualize o README ou adicione documentação quando necessário.
5. Execute testes manuais (quando aplicável) e descreva como validar a mudança no PR.
6. Abra um Pull Request no branch `main` do repositório original com descrição detalhada.

No corpo do PR inclua:
- O que foi mudado e por quê.
- Como testar/localmente validar.
- Se adicionar solução de exercício: marcar claramente que é uma solução e adicionar explicação didática (passo a passo).
- Se a mudança depende de outros PRs, indique.

Modelo rápido de mensagem de commit:
- feat: adiciona exemplo de leitura de CSV com pandas
- fix: corrige índice no exemplo de matrizes
- docs: atualiza README com instruções de instalação

## 5. Padrões de código e formatação
- Use comentários claros e explicativos, especialmente em soluções de exercícios.
- Adicione docstrings e exemplos de uso quando fizer sentido.
- Para Python, siga PEP 8 (linters como flake8/black são bem-vindos).
- Nomeie arquivos e funções de forma descritiva.

## 6. Como adicionar soluções de exercícios
Este repositório contém soluções. Para manter o repositório útil e ético:
- Marque claramente arquivos que são soluções (por exemplo, acrescentando "SOLUÇÃO" no nome do arquivo ou em um cabeçalho).
- Inclua comentários explicativos: por que a solução funciona, alternativas, e referências.
- Se a solução foi adaptada de outra fonte (coleção de colegas, material da disciplina, livro), declare a fonte e adicione atribuição.
- Evite publicar soluções completas que possam violar políticas acadêmicas de instituições quando for explícito que não é permitido; se tiver dúvidas, pergunte antes e marque claramente como "Exemplo/Material de Estudo".

Exemplo de cabeçalho para arquivos com solução:
# Arquivo: exemplo_soma_SOLUCAO.py
# Adaptado de: Delean-Mafra/faculdade
# Fonte original: Nome do livro ou material (se aplicável)
# Descrição: Explica passo a passo a solução do exercício X

## 7. Licença e atribuição
- Respeite a licença do repositório. Se for necessário, pergunte sobre permissões de uso.
- Ao reutilizar trechos em projetos públicos, inclua uma linha de atribuição com link para o arquivo original.

Exemplo de atribuição em arquivos:
# Adaptado de: Delean-Mafra/faculdade
# https://github.com/Delean-Mafra/faculdade/path/para/o/arquivo.py

## 8. Testes e verificação
- Se adicionar exemplos que dependem de pacotes, indique as dependências (requirements.txt ou comentário).
- Sempre que possível, verifique localmente que o script roda no ambiente descrito (ex.: Python 3.10).

## 9. Comunicação e revisão
- Comentários nas PRs devem ser respeitosos e focados no código.
- Mantenedor(es) podem solicitar mudanças antes de aceitar o PR.
- Pull requests inativas por longos períodos podem ser fechadas — sinta-se à vontade para reabrir com atualizações.

## 10. Contato e suporte
- Para problemas de conduta, violeção de direitos autorais, ou outras questões sensíveis, abra uma issue marcada como "privado" ou use o mecanismo indicado no CODE_OF_CONDUCT.md (ou envie mensagem direta ao mantenedor).
- Issues públicas são preferíveis para bugs/melhorias que beneficiem a comunidade.
