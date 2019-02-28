import { Injectable } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Injectable()
export class TemaryService {

    constructor(private db: DatabaseService) {
    }

    public async getAll(curso, email) {
        return await (this.db.query(`
            select 
            t.id,
            t.nombre,
            t.image,
            t.description,
            rt.resultado
            from temario t
            left join respuesta_temario rt on rt.fk_temario = t.id and
                (select cu.id
                from usuario u 
                inner join curso_usuario cu on cu.fk_usuario = u.id 
                where u.correo = '${email}') = rt.fk_curso_usuario
            where t.fk_curso = ${curso} 
            order by t.nombre asc`))
    }

    public async getContent(temary) {
        return await (this.db.query(`
            select 
            tm.id,
            tm.titulo,
            tm.descripcion,
            m.url,
            m.tipo as multimedia_tipo
            from temario_multimedia tm
            inner join multimedia m on m.id = tm.fk_multimedia
            where tm.fk_temario = ${temary}`))
    }

    public async getQuestion(temary_id){
        return await(this.db.query(`
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
            where p.estado = 1 and p.fk_temario = ${temary_id}
            group by p.id
            `
        ))
    }

    public async response(temary_id, email, resultado){        
        return await (this.db.query(`CALL CALIFICATE('${email}', '${temary_id}', '${resultado}')`))
    }

    public async startGameUsers(){
        return await (this.db.query(`UPDATE usuario SET movimiento='0', movio=0, estado='1', vida = 0`));
    }

}