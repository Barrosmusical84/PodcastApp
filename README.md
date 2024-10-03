# MyPodcaster

## Objetivo
O objetivo deste projeto é desenvolver um aplicativo que acessa feeds RSS de podcasts públicos e reproduz seus episódios. TODAS as funcionalidades obrigatórias foram implementadas!

O app contém os seguintes módulos principais:

- Home (Fonte de RSS)
- Lista de Podcasts
- Detalhes do Podcast
- Lista de Episódios
- Detalhes do Episódio
- Player de Episódios
  
A arquitetura do aplicativo é a MVVM com coordinator. 
Cada módulo segue uma estrutura clara para garantir manutenibilidade e separação de responsabilidades.

## Requisitos do Projeto:

- MacOS Sonoma 14.3.1
- iOS 17
- Swift 5
- Xcode 15.0.1

## Sobre o Projeto:

### Tela 1 - Fonte de RSS (Home)
- A primeira tela consiste em um formulário simples onde o usuário pode inserir uma URL de um feed RSS de um podcast público. Ao adicional outra URL o usuário consegue ver as que foram carregadas anteriormente exibindo sempre da última a primeira.
- Armazenamento de Cache:
  - Implementado o cache para o feed RSS e para as imagens dos podcasts.
- Tratamento de Erros:
  - O tratamento de erros é feito de maneira robusta para garantir que o usuário seja informado de problemas de conexão e URLs inválidas.

### Tela 2 - Detalhes do Podcast
Ao carregar um feed RSS, esta tela exibe os detalhes do podcast, incluindo:

- Título do podcast
- Imagem de capa
- Descrição do podcast
- Autores
- Duração média dos episódios
- Gênero do podcast
- Nesta tela, também é possível ver a lista de episódios disponíveis e selecionar qualquer episódio para reprodução.

### Tela 3 - Player de Episódios
Aqui o usuário pode controlar a reprodução do podcast. 
As seguintes funcionalidades foram implementadas:

- Botão de Play/Pausa

## Arquitetura MVVM + Coordinator
Todas as telas são 100% implementadas em ViewCode, sem o uso de Storyboards, seguindo os princípios SOLID, o que torna o código mais fácil de manter, estender e testar de forma isolada.

## Design Pattern e implementações importantes.
Estou utilizando o padrão de design Factory, que encapsula a lógica de criação de objetos, promovendo flexibilidade e desacoplamento no código ao delegar a subclasses a decisão de qual classe instanciar.

Desenvolvi um cache de imagem utilizando a classe Image Load, otimizando o carregamento e reutilização de imagens no projeto.
O armazenando dos podcasts estão sendo feitos usando a API UserDefaults.

## Débito técnicos:
  - Se tivesse mais tempo iria implementar as ações nos botões do player de áudio,  para pular para o próximo episódio ou voltar ao episódio anterior e o tempo de progresso inicial e final.
  - Tratamentos de erros do AVPlayer.
  - Ação na Barra de progresso do episódio.
  - Estudar mais a documentação pra entender melhor o AVPlayer
  - Implemenetar testes unitários das outras classes.
    

## Considerações Finais
Este projeto visa não apenas atender aos requisitos de funcionalidade, mas também implementar boas práticas de código, como uma estrutura de commits limpa e modularização. A arquitetura MVVM, o tratamento de erros e o uso de caching foram cuidadosamente planejados para oferecer uma experiência fluida e confiável.
