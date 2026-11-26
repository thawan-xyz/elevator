# Elevador — modelagem formal em B com visualização no ProB (VisB)
 
Projeto da disciplina de Métodos Formais. O projeto modela em B o software de controle de um elevador de 3 andares (0, 1 e 2) com capacidade de 450 kg. O comportamento pode ser animado graficamente no **ProB2-UI**, usando o plugin de visualização **VisB**.

## Conteúdo da pasta
 
```
elevator-vis-prob/
├── machine.mch      máquina principal: estados, botões, passageiros, manutenção
├── timer.mch        máquina raiz: relógio (tick) que INCLUI a machine
├── elevador.json    configuração do VisB (liga o desenho às variáveis/operações)
├── elevador.svg     desenho do elevador usado pelo VisB
├── bdp/             projeto do Atelier B (obrigações de prova, etc.)
└── lang/
```

## Como rodar a visualização
 
1. **Abrir o modelo:** no ProB2-UI, use *File → Open…* e escolha `timer.mch`. Se aparecer, aceite criar um projeto novo.
2. **Inicializar:** na aba **Operations**, cloque em `SETUP_CONSTANTS` e depois em `INITIALISATION`. O elevador começa no andar 0, com a porta aberta e sentido de subida.
3. **Abrir o VisB:** no menu *Visualisation*, abra o **VisB**. Na janela que aparecer, clique no ícone de pasta (*Load VisB file*) e escolha `elevador.json`. O `elevador.svg` é carregado automaticamente.
4. **Interagir:** cada clique no desenho executa uma operação do modelo B. O ProB só executa a operação se a pré-condição dela for verdadeira. A aba **History** registra todos os passos, e dá para voltar ou avançar por ela.


## O que cada elemento faz
 
| Elemento no desenho | Operação B | Observação |
|---|---|---|
| **tick (+1 segundo)** | `tick` | Avança o relógio em 1 s e chama `time_step`, que abre a porta, move o elevador ou o quebra. |
| Botões **▲/▼** ao lado do poço (UP0, UP1, DOWN1, DOWN2) | `press_button` / `release_button` | 1º clique = pressionar; 2º clique = soltar. |
| Botões **2, 1, 0** do painel da cabine (L2, L1, L0) | `press_button` / `release_button` | Mesmo comportamento dos botões externos. |
| **Abrir porta** / **Fechar porta** | `open_door` / `close_door` | Abrir só funciona com o elevador IDLE; fechar, só com a porta aberta. |
| **+70 kg / +150 kg** | `board_passenger(weight)` | Só funciona fora de trânsito, isto é, com o estado diferente de IDLE e de MOVING. |
| **−70 kg / −150 kg** | `disembark_passenger(weight)` | Só funciona se houver um passageiro com esse peso. |
| **Inserir chave** / **Remover chave** | `insert_maintenance_key` / `remove_key` | Inserir só funciona com o elevador quebrado (BROKEN). |
 
Botões de ação que não podem ser executados no estado atual aparecem semitransparentes.
 
**Como os botões são exibidos:**
- **Cinza:** em espera.
- **Laranja:** a chamada está em `pending_requests`.
- **Azul com um número:** o botão está pressionado. O número é há quantos segundos ele está sendo segurado.
- **Verde:** o botão foi testado durante a manutenção.
**Regra do modelo para os botões:** soltar o botão com menos de 3 s de pressão ativa a chamada. Soltar com 3 s ou mais cancela a chamada. O tempo só passa com `tick`, então para ativar uma chamada basta clicar no botão duas vezes seguidas, sem dar `tick` no meio.
 
**O que o desenho mostra:**
- A cabine se move entre os andares. Durante o movimento ela é desenhada na posição intermediária, de acordo com `movement_duration` (de 0 a 5 s).
- As portas abrem quando o estado é OPEN.
- A cabine fica vermelha em BROKEN e laranja em MAINTENANCE.
- O andar em que a cabine está parada fica destacado.
- O painel da direita mostra o estado, o sentido, o tempo global, os contadores de porta aberta (até 120 s) e de movimento (até 5 s), os passageiros, o peso total, os pedidos pendentes e a chave de manutenção.
## Cenários sugeridos
 
Todos os cenários partem do estado logo após o `INITIALISATION`.
 
**1. Do térreo ao 2º andar**
1. Clique em **2** no painel da cabine e clique de novo. O botão fica laranja (`L2` pendente).
2. Clique em **Fechar porta**. O estado passa a IDLE.
3. Clique em **tick** 12 vezes:
   - a cabine sobe até o andar 1 em 5 s e para lá (IDLE);
   - no tick seguinte, parte para o andar 2;
   - depois de mais 5 s, chega ao andar 2 e abre a porta. O pedido `L2` é atendido e o sentido passa a ser de descida.

**2. Cancelar uma chamada (segurar o botão por 3 s ou mais)**
1. Clique em **▲** do andar 1 (`UP1`). Ele fica azul.
2. Dê 3 ticks. O contador dentro do botão chega a 3.
3. Clique no botão de novo para soltar. A chamada **não** fica pendente.

**3. Excesso de peso**
1. Com a porta aberta, clique em **+150 kg** quatro vezes. O peso total fica em 600 kg e aparece em vermelho.
2. Faça uma chamada para o andar 2, feche a porta e dê vários ticks. O elevador **não se move**, porque `time_step` exige peso ≤ `MAX_CAPACITY`.
3. Clique em **Abrir porta**, depois em **−150 kg**, e feche a porta de novo. O elevador volta a atender a chamada.

**4. Porta aberta por muito tempo e manutenção**
1. Com a porta aberta, dê **120 ticks**. O estado passa a **BROKEN**.
2. Clique em **Inserir chave**. O estado passa a MAINTENANCE e os pedidos e botões pressionados são limpos.
3. Pressione e solte alguns botões. Eles ficam verdes, porque são registrados em `tested_maintenance_buttons`. Esse conjunto é zerado a cada `tick`.
4. Clique em **Remover chave**. O elevador volta ao estado OPEN.
