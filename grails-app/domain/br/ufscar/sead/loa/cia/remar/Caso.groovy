package br.ufscar.sead.loa.cia.remar

class Caso {

    String descricao
    String pergunta1
    String pergunta2
    String pergunta3
    String pergunta4
    String pergunta5
    String pergunta6
    String resposta1
    String resposta2
    String resposta3
    String resposta4
    String resposta5
    String pistafinal
    String author
    long ownerId
    String taskId


    static constraints = {
        descricao blank: false
        pergunta1 blank: false
        pergunta2 blank: false
        pergunta3 blank: false
        pergunta4 blank: false
        pergunta5 blank: false
        pergunta6 blank: false
        resposta1 blank: false, size: 1..15
        resposta2 blank: false, size: 1..15
        resposta3 blank: false, size: 1..15
        resposta4 blank: false, size: 1..15
        resposta5 blank: false, size: 1..15
        pistafinal blank: false, size: 1..15
        author blank: false
        ownerId blank: false, nullable: false
        taskId nullable: true

    }

}
