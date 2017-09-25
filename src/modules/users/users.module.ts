import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';
//import { ScoreService } from '../score/score.service';
import { BoxsService } from '../boxs/boxs.service';

import { SharedModule } from './../shared/shared.module';

@Module({
    components: [UsersService, BoxsService],
    controllers: [UsersController],
    modules: [SharedModule]
})
export class UserModule { }