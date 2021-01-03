import { Body, Controller, Get, Param, Post, Put } from "@nestjs/common";
import { Administrator } from "entities/administrator.entity";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { AdministratorService } from "src/services/administrator/administrator.service";

@Controller('api/administrator')
export class AdministratorController {
    constructor(
        private administratorService: AdministratorService
    ) { }

    @Get() // GET: http://localhost:3000/api/administrator/
    getAll(): Promise<Administrator[]> {
        return this.administratorService.getAll();
    }

    @Get(':id') // GET: http://localhost:3000/api/administrator/1/
    getById(@Param('id') administratorId: number): Promise<Administrator> {
        return this.administratorService.getById(administratorId);
    }

    // Dodavanje novog administratora
    // PUT Metod => koristimo kada radimo dodavanje novog zapisa
    // PUT: http://localhost:3000/api/administrator/
    @Put()
    add(@Body() data: AddAdministratorDto): Promise<Administrator> {
        return this.administratorService.add(data);
    }

    // POST Metoda sluzi za editovanje
    // PUT: http://localhost:3000/api/administrator/1/
    // POST Metodom se salje telo sa sadrzajem novog admina njih dobijamo kroz @Body
    @Post(':id')
    edit(@Param('id') id: number, @Body() data: EditAdministratorDto): Promise<Administrator> {
        return this.administratorService.editById(id, data);
    }

}