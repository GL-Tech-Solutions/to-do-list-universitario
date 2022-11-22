A fazer:

· Clicar na data e subir bottom sheet com lista de tarefas  
· Formatar a tela inicial para exibir próxima tarefa em baixo do calendario (MI)  
· Internacionalização   
· Função de remover disciplina  
· Gerenciamento de estado tarefas pendentes / concluídas  
· Filtrar por disciplina  
· Clicar na disciplina e ir para tarefas filtrado (MI)  
· Tratar para concluir e remover selecionadas   
· Alterar model tarefa para ter campo disciplina  
· Ajustar editar tarefa para puxar disciplina   
· Criar tarefa_detalhes_dialog  
· Criar page Editar Flashcard   
· Deixar funcional Editar/Adicionar/Remover flashcards  

###· Integração completa Firebase:
  -Alterar estrutura model Disciplina para aceitar uma Color em vez de MaterialColor,
  -Fazer método para converter Color para String e String para Color,
  -Retirar parâmetro "cod" de disciplina e utilizar o gerador automático de indexador do Firebase,
  -Realizar configurações similares para integrar Tarefas e FlashCards ao Firebase,
  -Alterar estrutura model Tarefa para ficar dentro de uma coleção em Disciplinas e conseguir puxar dados de sua Disciplina pai (Exemplo: cor)
  -Criar query Firebase no TarefaRepository para listar tarefas de forma filtrada (usando where)
