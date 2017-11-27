import { Module, NestModule, MiddlewaresConsumer, RequestMethod } from '@nestjs/common';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';
import { TemaryController } from './temary.controller';
import { TemaryService } from './temary.service';

import { SharedModule } from './../shared/shared.module';

@Module({
	components: [TemaryService],
	controllers: [TemaryController],
	modules: [SharedModule]
})
export class TemaryModule {
	public configure(consumer: MiddlewaresConsumer) {
		consumer.apply(AuthMiddleware).forRoutes(TemaryController);
	}
}