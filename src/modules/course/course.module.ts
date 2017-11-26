import { Module, NestModule, MiddlewaresConsumer, RequestMethod } from '@nestjs/common';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';

import { CourseController } from './course.controller';
import { CourseService } from './course.service';

import { SharedModule } from './../shared/shared.module';

@Module({
    components: [CourseService],
    controllers: [CourseController],
    modules: [SharedModule]
})
export class CourseModule { 
	public configure(consumer: MiddlewaresConsumer) {
    	consumer.apply(AuthMiddleware).forRoutes(CourseController);
  	}
}