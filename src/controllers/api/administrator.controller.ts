import { Body, Controller, Get, Param, Patch, Post, Put, UseGuards } from "@nestjs/common";
import { Administrator } from "src/entities/administrator.entity";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { AdministratorService } from "src/services/administrator/administrator.service";
import { RoleCheckedGuard } from "src/misc/role.checker.guard";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";

@Controller('api/administrator')
export class AdministratorController {
    constructor(
        private administratorService: AdministratorService
    ) { }

    @Get() // GET: http://localhost:3000/api/administrator/
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    getAll(): Promise<Administrator[]> {
        return this.administratorService.getAll();
    }

    @Get(':id') // GET: http://localhost:3000/api/administrator/1/
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    getById(@Param('id') administratorId: number): Promise<Administrator | ApiResponse> {
        return new Promise(async (resolve) => {
            let admin = await this.administratorService.getById(administratorId);

            if(admin === undefined) {
                resolve(new ApiResponse("error", -1002)); // Admin ne postoji
            }

            resolve(admin);
        })
    }

    // Dodavanje novog administratora
    // POST Metod => koristimo kada radimo dodavanje novog zapisa
    // POST: http://localhost:3000/api/administrator/
    @Post()
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    add(@Body() data: AddAdministratorDto): Promise<Administrator | ApiResponse> {
        return this.administratorService.add(data);
    }

    // Patch Metoda sluzi za editovanje
    // Patch: http://localhost:3000/api/administrator/1/
    // Patch Metodom se salje telo sa sadrzajem novog admina njih dobijamo kroz @Body
    @Patch(':id')
    @UseGuards(RoleCheckedGuard)
    @AllowToRoles('administrator')
    edit(@Param('id') id: number, @Body() data: EditAdministratorDto): Promise<Administrator | ApiResponse> {
        return this.administratorService.editById(id, data);
    }

}