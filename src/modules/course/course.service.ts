import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Component()
export class CourseService {

    constructor(private db: DatabaseService) {
    }

    public async getAll(email: string) {
        return await (this.db.query(`
        	select
			c.id as curso_id,
			c.nombre as curso_nombre,
			COUNT(rt.id) as cursados,
			(select COUNT(t.id) from temario t where t.fk_curso = c.id) as temarios
			from curso c
			inner join curso_usuario cu on cu.fk_curso = c.id
			inner join usuario u on u.id = cu.fk_usuario
			left join respuesta_temario rt on rt.fk_curso_usuario = cu.id
			where u.correo = '${email}'
			group by c.id, u.id
		`))
    }

    public async startGameUsers(){
        return await (this.db.query(`UPDATE usuario SET movimiento='0', movio=0, estado='1', vida = 0`));
    }

}