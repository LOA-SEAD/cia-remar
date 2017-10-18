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

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", send: "POST"]

    def springSecurityService

    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        def list = Caso.findAllByAuthor(session.user.username)

        render view: "index", model: [CaseInstanceList: list, caseInstanceCount: list.size(),
                                      userName: session.user.username, userId: session.user.id]

    }

    def create() {
        respond new Caso(params)
    }

    @Transactional
    def save(Caso casoInstance) {
        log.info("Saving new Case for ownerId" + session.user.id)
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

        if (casoInstance.author) {
            newCaso.author = casoInstance.author
        } else {
            newCaso.author = session.user.username
        }

        if (casoInstance.ownerId) {
            newCaso.ownerId = casoInstance.ownerId
        } else {
            newCaso.ownerId = session.user.id
        }

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

    @Transactional
    def update(Caso casoInstance) {
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

        casoInstance.save flush: true

        redirect action: "index"
    }

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
            '*' { render status: NOT_FOUND }
        }
    }

    def send() {
        // Get all selected cases
        def casos = Caso.getAll(params["id[]"]);

        def builder = new JsonBuilder()

        // Check if user has selected the minimum number of cases
        if (casos.size >= 3) {

            // Generate case list file and receives the file id inside mongo
            String id = toJson(casos)

            def port = request.serverPort

            if (Environment.current == Environment.DEVELOPMENT) {
                port = 8080
            }
            render "http://${request.serverName}:${port}/process/task/complete/${session.taskId}?files=${id}"
        } else {
            flash.message = "Por favor selecione no minimo 3 casos."
            redirect action: "index"
        }
    }


    private toJson(list) {
        def builder = new JsonBuilder()

        final String SEGREDO = "<segredo>"
        final String PONTOS = "....................";
        def jsonBody = [:]
        for (int i : (1..3)) {
            jsonBody["caso${i}descricao"]  = [list[i-1].getDescricao()]
            jsonBody["caso${i}perguntas"]  = [list[i-1].getPergunta1().replaceAll(SEGREDO, PONTOS),
                                              list[i-1].getPergunta2().replaceAll(SEGREDO, PONTOS),
                                              list[i-1].getPergunta3().replaceAll(SEGREDO, PONTOS),
                                              list[i-1].getPergunta4().replaceAll(SEGREDO, PONTOS),
                                              list[i-1].getPergunta5().replaceAll(SEGREDO, PONTOS),
                                              list[i-1].getPergunta6().replaceAll(SEGREDO, PONTOS)]
            jsonBody["caso${i}respostas"]  = [list[i-1].getResposta1(),
                                              list[i-1].getResposta2(),
                                              list[i-1].getResposta3(),
                                              list[i-1].getResposta4(),
                                              list[i-1].getResposta5()]
            jsonBody["caso${i}pistafinal"] = [list[i-1].getPistafinal()]
        }

        def json = builder(jsonBody);

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
        return id;
    }

    def returnInstance(Caso casoInstance) {
        if (casoInstance == null) {
            notFound()
        } else {
            render  casoInstance.descricao + "%@!" +
                    casoInstance.pergunta1 + "%@!" +
                    casoInstance.pergunta2 + "%@!" +
                    casoInstance.pergunta3 + "%@!" +
                    casoInstance.pergunta4 + "%@!" +
                    casoInstance.pergunta5 + "%@!" +
                    casoInstance.pergunta6 + "%@!" +

                    casoInstance.resposta1 + "%@!" +
                    casoInstance.resposta2 + "%@!" +
                    casoInstance.resposta3 + "%@!" +
                    casoInstance.resposta4 + "%@!" +
                    casoInstance.resposta5 + "%@!" +
                    casoInstance.pistafinal + "%@!" +

                    casoInstance.version + "%@!" +
                    casoInstance.id
        }
    }

    @Transactional
    def generateCasos() {
        MultipartFile csv = params.csv
        def user = springSecurityService.getCurrentUser()
        def userId = user.toString().split(':').toList()
        String username = User.findById(userId[1].toInteger()).username
        log.info("abrindo arquivo CVS")
        csv.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8']).eachLine { row ->

            Caso casoInstance = new Caso()

            try {
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
            catch (ArrayIndexOutOfBoundsException exception) {
                //println("Not default .csv - Model: Title-Answer-Category")
                log.error("Erro ao processar arquivo CSV")
            }

            casoInstance.author = username
            casoInstance.taskId = session.taskId as String
            casoInstance.ownerId = session.user.id

            if (casoInstance.hasErrors()) {

            } else {
                log.info("salvando um caso " + casoInstance.descricao)
                casoInstance.save flush: true
            }

        }
        log.info("Terminei")
        redirect(action: index())

    }

    def exportCSV() {
        /* Função que exporta as questões selecionadas para um arquivo .csv genérico.
           O arquivo .csv gerado será compatível com os modelos Escola Mágica, Forca e Responda Se Puder.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Nível, Pergunta, Alternativa1, Alternativa2, Alternativa3, Alternativa4, Alternativa Correta, Dica, Tema.
           O campo Dica é correspondente ao modelo Responda Se Puder e o campo Tema ao modelo Forca.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */
        ArrayList<Integer> list_casoId = new ArrayList<Integer>();
        ArrayList<Caso> casoList = new ArrayList<Caso>();
        list_casoId.addAll(params.list_id);
        for (int i = 0; i < list_casoId.size(); i++) {
            casoList.add(Caso.findById(list_casoId[i]));

        }

        //println(questionList)
        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportCasos.csv"), "UTF-8"));

        for (int i = 0; i < casoList.size(); i++) {
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
                    "\n")
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/cia/samples/export/exportCasos.csv"
    }
}