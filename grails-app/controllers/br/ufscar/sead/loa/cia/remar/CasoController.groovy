package br.ufscar.sead.loa.cia.remar


import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonBuilder
import org.springframework.web.multipart.MultipartFile
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class CasoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    /*def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Caso.list(params), model:[casoInstanceCount: Caso.count()]
    }*/

    def index(Integer max) {
        log.info("\nEntrou no index")
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        def list = Caso.findAllByAuthor(session.user.username)

        render view: "index", model: [casoInstanceList: list, casoinstanceCount: list.size(),
                                      userName: session.user.username, userId: session.user.id]

    }

    def show(Caso casoInstance) {
        log.info("\nEntrou no show")
        respond casoInstance
    }

    def create() {
        respond new Caso(params)
    }


    @Transactional
    def newCaso(Caso casoInstance) {
        log.info("\nEntrou no newCaso 1")
        if (casoInstance.author == null) {
            casoInstance.author = session.user.username
        }

        Caso newCaso = new Caso();

        newCaso.version = casoInstance.version

        newCaso.descricao = casoInstance.descricao
        newCaso.pergunta1 = casoInstance.pergunta1
        newCaso.pergunta2 = casoInstance.pergunta2
        newCaso.pergunta3 = casoInstance.pergunta3
        newCaso.pergunta4 = casoInstance.pergunta4
        newCaso.pergunta5 = casoInstance.pergunta5
        newCaso.pergunta6 = casoInstance.pergunta6

        newCaso.resposta1 = casoInstance.resposta1
        newCaso.resposta2 = casoInstance.resposta2
        newCaso.resposta3 = casoInstance.resposta3
        newCaso.resposta4 = casoInstance.resposta4
        newCaso.resposta5 = casoInstance.resposta5
        newCaso.pistafinal = casoInstance.pistafinal

        newCaso.author = casoInstance.author
        newCaso.indice = casoInstance.indice
        newCaso.ownerId = casoInstance.ownerId

        log.info("\nAtribuiu valores ao caso " + newCaso.descricao)
        if (newCaso.hasErrors()) {
            respond newCaso.errors, view: 'create' //TODO
            render newCaso.errors;
            return
        }

        log.info("\nSalvar o caso " + newCaso.descricao + " com id: " + newCaso.getId())
        newCaso.save flush: true
        log.info("\nSalvou o caso " + newCaso.descricao + " com id: " + newCaso.getId())
        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + newCaso.getId() + "}")
            }
        } else {
            // TODO
        }
        log.info("\nFinalizando ... ")
        redirect(action: index())


    }

    /*@Transactional
    def save(Caso casoInstance) {
        if (casoInstance == null) {
            notFound()
            return
        }

        if (casoInstance.hasErrors()) {
            respond casoInstance.errors, view:'create'
            return
        }

        casoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'caso.label', default: 'Caso'), casoInstance.id])
                redirect casoInstance
            }
            '*' { respond casoInstance, [status: CREATED] }
        }
    }*/

    @Transactional
    def save(Caso casoInstance) {
        log.info("\nEntrou no save")
        if (casoInstance == null) {
            notFound()
            return
        }

        if (casoInstance.hasErrors()) {
            respond casoInstance.errors, view: 'create' //TODO
            render casoInstance.errors;
            return
        }

        casoInstance.taskId = session.taskId as String

        casoInstance.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + casoInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())
    }

    def edit(Caso casoInstance) {
        log.info("\nEntrou no edit")
        respond casoInstance
    }

    /*@Transactional
    def update(Caso casoInstance) {
        if (casoInstance == null) {
            notFound()
            return
        }

        if (casoInstance.hasErrors()) {
            respond casoInstance.errors, view:'edit'
            return
        }

        casoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Caso.label', default: 'Caso'), casoInstance.id])
                redirect casoInstance
            }
            '*'{ respond casoInstance, [status: OK] }
        }
    }*/

    @Transactional
    def update() {
        log.info("\nEntrou no update")
        Caso casoInstance = Caso.findById(Integer.parseInt(params.casoID))

        casoInstance.descricao = params.descricao
        casoInstance.pergunta1 = params.pergunta1
        casoInstance.pergunta2 = params.pergunta2
        casoInstance.pergunta3 = params.pergunta3
        casoInstance.pergunta4 = params.pergunta4
        casoInstance.pergunta5 = params.pergunta5
        casoInstance.pergunta6 = params.pergunta6

        casoInstance.resposta1 = params.resposta1
        casoInstance.resposta2 = params.resposta2
        casoInstance.resposta3 = params.resposta3
        casoInstance.resposta4 = params.resposta4
        casoInstance.resposta5 = params.resposta5
        casoInstance.pistafinal = params.pistafinal



        casoInstance.save flush:true

        redirect action: "index"
    }

    /*@Transactional
    def delete(Caso casoInstance) {

        if (casoInstance == null) {
            notFound()
            return
        }

        casoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Caso.label', default: 'Caso'), casoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }*/

    @Transactional
    def delete(Caso casoInstance) {
        log.info("\nEntrou no delete")
        if (casoInstance == null) {
            notFound()
            return
        }

        casoInstance.delete flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + casoInstance.getId() + "}")
            }
        } else {
            // TODO
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    def toJson() {
        log.info("\nEntrou no toJson")




        def list = Caso.getAll(params.id ? params.id.split(',').toList() : null)

        def builder = new JsonBuilder()

        list.get(0).indice = 1
        list.get(1).indice = 2
        list.get(2).indice = 3

        def json = builder(
                    [
                            ('caso'+list.get(0).indice+'descricao'): [list.get(0).getDescricao()],
                            ('caso'+list.get(0).indice+'perguntas'): [
                                    list.get(0).getPergunta1(),
                                    list.get(0).getPergunta2(),
                                    list.get(0).getPergunta3(),
                                    list.get(0).getPergunta4(),
                                    list.get(0).getPergunta5(),
                                    list.get(0).getPergunta6()
                           ],

                            ('caso'+list.get(0).indice+'respostas'): [
                                    list.get(0).getResposta1(),
                                    list.get(0).getResposta2(),
                                    list.get(0).getResposta3(),
                                    list.get(0).getResposta4(),
                                    list.get(0).getResposta5()
                           ],
                            ('caso'+list.get(0).indice+'pistafinal'): [list.get(0).getPistafinal()],

                            ('caso'+list.get(1).indice+'descricao'): [list.get(1).getDescricao()],
                            ('caso'+list.get(1).indice+'perguntas'): [
                                    list.get(1).getPergunta1(),
                                    list.get(1).getPergunta2(),
                                    list.get(1).getPergunta3(),
                                    list.get(1).getPergunta4(),
                                    list.get(1).getPergunta5(),
                                    list.get(1).getPergunta6()
                            ],

                            ('caso'+list.get(1).indice+'respostas'): [
                                    list.get(1).getResposta1(),
                                    list.get(1).getResposta2(),
                                    list.get(1).getResposta3(),
                                    list.get(1).getResposta4(),
                                    list.get(1).getResposta5()
                            ],
                            ('caso'+list.get(1).indice+'pistafinal'): [list.get(1).getPistafinal()],

                            ('caso'+list.get(2).indice+'descricao'): [list.get(2).getDescricao()],
                            ('caso'+list.get(2).indice+'perguntas'): [
                                    list.get(2).getPergunta1(),
                                    list.get(2).getPergunta2(),
                                    list.get(2).getPergunta3(),
                                    list.get(2).getPergunta4(),
                                    list.get(2).getPergunta5(),
                                    list.get(2).getPergunta6()
                            ],

                            ('caso'+list.get(2).indice+'respostas'): [
                                    list.get(2).getResposta1(),
                                    list.get(2).getResposta2(),
                                    list.get(2).getResposta3(),
                                    list.get(2).getResposta4(),
                                    list.get(2).getResposta5()
                            ],
                            ('caso'+list.get(2).indice+'pistafinal'): [list.get(2).getPistafinal()]
                    ]
        )

        log.debug builder.toString()

        log.info(json);
        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()

        def fileName = "casos.json"

        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write(builder.toString());
        pw.close();
        log.info(file)
        String id = MongoHelper.putFile(file.absolutePath)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}", params: [files: id]
    }

    def returnInstance(Caso casoInstance){
        log.info("\nEntrou no returnInstance")
        if (casoInstance == null) {
            notFound()
        }
        else{
            render  casoInstance.descricao + "%@!" +
                    casoInstance.pergunta1 + "%@!"+
                    casoInstance.pergunta2 + "%@!"+
                    casoInstance.pergunta3 + "%@!"+
                    casoInstance.pergunta4 + "%@!"+
                    casoInstance.pergunta5 + "%@!"+
                    casoInstance.pergunta6 + "%@!"+

                    casoInstance.resposta1 + "%@!"+
                    casoInstance.resposta2 + "%@!"+
                    casoInstance.resposta3 + "%@!"+
                    casoInstance.resposta4 + "%@!"+
                    casoInstance.resposta5 + "%@!"+
                    casoInstance.pistafinal + "%@!"+

                    casoInstance.version + "%@!" +
                    casoInstance.id
        }
    }

    @Transactional
    def generateCasos() {
log.info("generateCasos")
        MultipartFile csv = params.csv
        def user = springSecurityService.getCurrentUser()
        def userId = user.toString().split(':').toList()
        String username = User.findById(userId[1].toInteger()).username
log.info("abrindo arquivo CVS")
        csv.inputStream.toCsvReader(['separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->

            Caso casoInstance = new Caso()

            try{
                casoInstance.descricao = row[0] ?: "NA";
                casoInstance.pergunta1 = row[1] ?: "NA";
                casoInstance.resposta1 = row[2] ?: "NA";
                casoInstance.pergunta2 = row[3] ?: "NA";
                casoInstance.resposta2 = row[4] ?: "NA";
                casoInstance.pergunta3 = row[5] ?: "NA";
                casoInstance.resposta3 = row[6] ?: "NA";
                casoInstance.pergunta4 = row[7] ?: "NA";
                casoInstance.resposta4 = row[8] ?: "NA";
                casoInstance.pergunta5 = row[9] ?: "NA";
                casoInstance.resposta5 = row[10] ?: "NA";
                casoInstance.pergunta6 = row[11] ?: "NA";
                casoInstance.pistafinal = row[12] ?: "NA";
            }
            catch (ArrayIndexOutOfBoundsException exception){
                //println("Not default .csv - Model: Title-Answer-Category")
                log.error("Erro ao processar arquivo CSV")
            }

            casoInstance.author = username
            casoInstance.taskId = session.taskId as String
            casoInstance.ownerId = session.user.id

            if (casoInstance.hasErrors()) {

            }
            else{
                log.info("salvando um caso " + casoInstance.descricao)
                casoInstance.save flush: true
            }

        }
log.info("Terminei")
        redirect(action: index())

    }

    def exportCSV(){
        /* Função que exporta as questões selecionadas para um arquivo .csv genérico.
           O arquivo .csv gerado será compatível com os modelos Escola Mágica, Forca e Responda Se Puder.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Nível, Pergunta, Alternativa1, Alternativa2, Alternativa3, Alternativa4, Alternativa Correta, Dica, Tema.
           O campo Dica é correspondente ao modelo Responda Se Puder e o campo Tema ao modelo Forca.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */
        ArrayList<Integer> list_casoId = new ArrayList<Integer>() ;
        ArrayList<Caso> casoList = new ArrayList<Caso>();
        list_casoId.addAll(params.list_id);
        for (int i=0; i<list_casoId.size();i++){
            casoList.add(Caso.findById(list_casoId[i]));

        }

        //println(questionList)
        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportCasos.csv"), "UTF-8"));

        for(int i=0; i<casoList.size();i++){
            /*
            "1;" + questionList.getAt(i).statement + ";" +
             questionList.getAt(i).answer + ";"  +
              "Alternativa 2;" +
               "Alternativa 3;" +
               "Alternativa 4;" +
               "1;" +
                "dica;" +
                 questionList.getAt(i).category +";\n" )
             */
            fw.write(casoList.getAt(i).getDescricao() + ";" +
                    casoList.getAt(i).getPergunta1() + ";" +
                    casoList.getAt(i).getResposta1() + ";" +
                    casoList.getAt(i).getPergunta2() + ";" +
                    casoList.getAt(i).getResposta2() + ";" +
                    casoList.getAt(i).getPergunta3() + ";" +
                    casoList.getAt(i).getResposta3() + ";" +
                    casoList.getAt(i).getPergunta4() + ";" +
                    casoList.getAt(i).getResposta4() + ";" +
                    casoList.getAt(i).getPergunta5() + ";" +
                    casoList.getAt(i).getResposta5() + ";" +
                    casoList.getAt(i).getPergunta6() + ";" +
                    casoList.getAt(i).getPistafinal() + ";" +
                    "\n" )
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/cia/samples/export/exportCasos.csv"


    }
    /*@Transactional
    def save(Caso casoInstance) {
        if (casoInstance == null) {
            notFound()
            return
        }

        if (casoInstance.hasErrors()) {
            respond casoInstance.errors, view:'create'
            return
        }

        casoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'caso.label', default: 'Caso'), casoInstance.id])
                redirect casoInstance
            }
            '*' { respond casoInstance, [status: CREATED] }
        }
    }

    def edit(Caso casoInstance) {
        respond casoInstance
    }

    @Transactional
    def update(Caso casoInstance) {
        if (casoInstance == null) {
            notFound()
            return
        }

        if (casoInstance.hasErrors()) {
            respond casoInstance.errors, view:'edit'
            return
        }

        casoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Caso.label', default: 'Caso'), casoInstance.id])
                redirect casoInstance
            }
            '*'{ respond casoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Caso casoInstance) {

        if (casoInstance == null) {
            notFound()
            return
        }

        casoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Caso.label', default: 'Caso'), casoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }*/
}
