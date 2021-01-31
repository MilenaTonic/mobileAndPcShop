import * as Validator from 'class-validator';

export class UserRegistrationDto {
    @Validator.IsNotEmpty()
    @Validator.IsEmail({
        allow_ip_domain: false, // Ne moze biti email => mladen@127.0.0.1
        allow_utf8_local_part: true,
        require_tld: true, // Mora biti mladenvts@gmail.com ( MORA IMATI TLD => Top Level Domen)
    })
    email: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(6, 128)
    password: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 64)
    forename: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 64)
    surname: string;

    @Validator.IsNotEmpty()
    @Validator.IsPhoneNumber(null) // Korisnik mora da unese +381 ...
    phoneNumber: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(10, 512)
    postalAddress: string;
}
