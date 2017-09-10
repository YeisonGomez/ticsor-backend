import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';
import { User } from '../../providers/user.provider';
import { SharedModule } from './../shared/shared.module';

@Module({
    components: [UsersService, User],
    controllers: [UsersController],
    modules: [SharedModule]
})
export class UserModule { }