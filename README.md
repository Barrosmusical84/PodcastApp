MyPodcaster

Objetivo:
O objetivo deste projeto é desenvolver um aplicativo que acessa feeds RSS de podcasts públicos e reproduz seus episódios. TODAS as funcionalidades obrigatórias foram implementadas!

O app contém os seguintes módulos principais:

Home (Fonte de RSS)
Lista de Podcasts
Detalhes do Podcast
Lista de Episódios
Detalhes do Episódio
Player de Episódios
A arquitetura do aplicativo é baseada em MVVM. Cada módulo segue uma estrutura clara para garantir manutenibilidade e separação de responsabilidades.

Requisitos do Projeto
MacOS Monterey 12.3.1+
iOS 15+
Swift 5+
Xcode 13.3+
Sobre o Projeto
Tela 1 - Fonte de RSS (Home)
A primeira tela consiste em um formulário simples onde o usuário pode inserir uma URL de um feed RSS de um podcast público. Existe também um botão de ação para carregar o feed e exibir os detalhes do podcast.

Funcionalidades Extras:

Histórico de URLs usadas previamente pelo usuário.
Tela 2 - Detalhes do Podcast
Ao carregar um feed RSS, esta tela exibe os detalhes do podcast, incluindo:

Título do podcast
Imagem de capa
Descrição do podcast
Autores
Duração média dos episódios
Gênero do podcast
Nesta tela, também é possível ver a lista de episódios disponíveis e selecionar qualquer episódio para reprodução.

Tela 3 - Player de Episódios
Aqui o usuário pode controlar a reprodução do podcast. As seguintes funcionalidades foram implementadas:

Barra de progresso do episódio
Botão de Play/Pausa
Botões para pular para o próximo episódio ou voltar ao episódio anterior
Armazenamento de Cache
Implementado o cache para o feed RSS e para as imagens dos podcasts, com a opção de limpar o cache diretamente pela interface do usuário.
Tratamento de Erros
O tratamento de erros é feito de maneira robusta para garantir que o usuário seja informado de problemas de conexão, URLs inválidas, e falhas ao carregar episódios.

Arquitetura MVVM
Todas as telas são 100% implementadas em ViewCode, sem o uso de Storyboards, seguindo os princípios SOLID, o que torna o código mais fácil de manter, estender e testar de forma isolada.

Considerações Finais
Este projeto visa não apenas atender aos requisitos de funcionalidade, mas também implementar boas práticas de código, como uma estrutura de commits limpa e modularização. A arquitetura MVVM, o tratamento de erros e o uso de caching foram cuidadosamente planejados para oferecer uma experiência fluida e confiável.
