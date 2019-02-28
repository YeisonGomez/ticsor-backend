import { Module, NestModule, MiddlewareConsumer, RequestMethod } from '@nestjs/common';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';

import { CourseController } from './course.controller';
import { CourseService } from './course.service';

import { SharedModule } from './../shared/shared.module';

@Module({
    providers: [CourseService],
    controllers: [CourseController],
    imports: [SharedModule]
})
export class CourseModule { 
	public configure(consumer: MiddlewareConsumer) {
    	consumer.apply(AuthMiddleware).forRoutes(CourseController);
  	}
}