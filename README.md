# br-generator

![Codacy Grade](https://api.codacy.com/project/badge/Grade/ff2d63b44d78408a80e6ae2622468854)

br-generator is an API to generate and validate different types of things.

### 
Usage: [Wiki](https://github.com/lucasqueiroz/br-generator/wiki)

### What can it generate?

  - Valid CPF
  - Valid CNPJ
  - Valid RG
  - CEP
  - Name
  - Valid Bank Account
  
### What can it validate?

  - CPF
  - CNPJ
  - Bank Accounts

### CPF and CNPJ

BR-Generator uses the CPF/CNPJ validation algorithm to generate a random valid CPF/CNPJ. It is valid, since the verification digits are correct, but it might not be a real CPF/CNPJ.

### RG

The RG digit number is calculated based on SSP's algorithm. It might not be a real RG number, though.

### CEP

The CEP should be valid, since it's between 00000-000 and 99999-999, but it might not be a real CEP.

### Name

The name generation uses a list of different names and last names.

### Bank Account

The generator uses different bank account validation algorithms. The banks are:

 - Banco do Brasil
 - Bradesco
 - Citibank
 - HSBC
 - Itau
 - Santander
 
 ### Known Bugs
 - [X] ~~When generating a bank account from a bank that does not have the 
 agency check number, the result contains a null agency check number, instead
  of not having the field~~

### TODO List

 - [ ] Add more banks
 - [ ] Add specs
 - [ ] Add credit card generator/validator
 - [ ] Add phone number generator/validator
 - [ ] Add more options when generating bank account
 - [ ] Add more countries?
