import { Module } from '@nestjs/common';
import { BoxsController } from './boxs.controller';
import { BoxsService } from './boxs.service';
import { Box } from '../../providers/box.provider';
import { SharedModule } from './../shared/shared.module';

@Module({
    components: [BoxsService, Box],
    controllers: [BoxsController],
    modules: [SharedModule]
})
export class BoxsModule { }