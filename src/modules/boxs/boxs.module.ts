import { Module } from '@nestjs/common';
import { BoxsController } from './boxs.controller';

import { BoxsService } from './boxs.service';
import { UsersService } from '../users/users.service';
import { ScoreService } from '../score/score.service';

import { Box } from '../../providers/box.provider';

import { SharedModule } from './../shared/shared.module';

@Module({
    components: [BoxsService, Box, UsersService, ScoreService],
    controllers: [BoxsController],
    modules: [SharedModule]
})
export class BoxsModule { }