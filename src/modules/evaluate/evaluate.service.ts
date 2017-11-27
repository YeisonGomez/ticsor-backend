import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Component()
export class EvaluateService {

    constructor(private db: DatabaseService) {
    }

    public async getAll(course) {
        return await (this.db.query(`
            select 
			*
			from evaluacion
			where fk_curso = ${course}
			`))
    }

    public async getQuestion(evaluate) {
        return await (this.db.query(`
            select 
			p.id as pregunta_id,
			p.pregunta as pregunta,
			concat('[', concat(group_concat(distinct concat('"', concat(m.url, '"'))), ']')) as images,
			concat('[', concat(group_concat(distinct  json_object(
					"id", r.id,
					"contenido", IFNULL((select url from multimedia where id = r.fk_multimedia), r.contenido),
					"correcta", r.correcta,
					"imagen", IFNULL(IFNULL(r.fk_multimedia, 0), 0)
			)), ']')) as respuesta
			from pregunta p 
			left join pregunta_multimedia pm on pm.fk_pregunta = p.id
			left join multimedia m on m.id = pm.fk_multimedia
			left join respuesta r on r.fk_pregunta = p.id
			where p.estado = 1 and p.fk_evaluacion = ${evaluate}
			group by p.id
			`))
    }

    public async response(evaluate_id, email, resultado){        
        return await (this.db.query(`CALL CALIFICATE_FINISH('${email}', '${evaluate_id}', '${resultado}')`))
    }

}