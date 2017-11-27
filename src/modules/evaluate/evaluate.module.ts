import { Module, NestModule, MiddlewaresConsumer, RequestMethod } from '@nestjs/common';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';
import { EvaluateController } from './evaluate.controller';
import { EvaluateService } from './evaluate.service';

import { SharedModule } from './../shared/shared.module';

@Module({
	components: [EvaluateService],
	controllers: [EvaluateController],
	modules: [SharedModule]
})
export class EvaluateModule {
	public configure(consumer: MiddlewaresConsumer) {
		consumer.apply(AuthMiddleware).forRoutes(EvaluateController);
	}
}