import { Module} from '@nestjs/common';
import { BoxsController } from './boxs.controller';

import { BoxsService } from './boxs.service';
import { UsersService } from '../users/users.service';

import { Box } from '../../providers/box.provider';
import { User } from '../../providers/user.provider';

import { SharedModule } from './../shared/shared.module';

@Module({
    components: [BoxsService, Box, UsersService, User],
    controllers: [BoxsController],
    modules: [SharedModule]
})
export class BoxsModule { }