CREATE TABLE Dieta (
  idDieta INTEGER NOT NULL,
  Diagnostico VARCHAR(50) NULL,
  Descripcion VARCHAR(50) NULL,
  Menu VARCHAR(50) NULL,
  PRIMARY KEY(idDieta)
);

CREATE TABLE Sede (
  idSede INTEGER NOT NULL,
  PRIMARY KEY(idSede)
);

CREATE TABLE HistoriaPaciente (
  idHistoriaPaciente int IDENTITY(1,1) PRIMARY KEY
);

CREATE TABLE Telefono (
  idTelefono INTEGER NOT NULL,
  Numero INTEGER NOT NULL,
  PRIMARY KEY(idTelefono)
);

CREATE TABLE Area (
  idArea INTEGER NOT NULL IDENTITY(1,1),
  Cargo VARCHAR(50) NULL,
  Espacialidad VARCHAR(50) NULL,
  PRIMARY KEY(idArea)
);

CREATE TABLE Departamento (
  idDepartamento INTEGER NOT NULL,
  PRIMARY KEY(idDepartamento)
);

CREATE TABLE Municipio (
  idMunicipio INTEGER NOT NULL,
  Departamento_idDepartamento INTEGER NOT NULL,
  PRIMARY KEY(idMunicipio, Departamento_idDepartamento),
  FOREIGN KEY(Departamento_idDepartamento)
    REFERENCES Departamento(idDepartamento)
);

CREATE TABLE Personal (
  idPersonal INTEGER NOT NULL,
  Area_idArea INTEGER NOT NULL,
  PRIMARY KEY(idPersonal, Area_idArea),
  FOREIGN KEY(Area_idArea)
    REFERENCES Area(idArea)
);

CREATE TABLE Paciente (
  idPaciente INTEGER NOT NULL IDENTITY(1,1),
  HistoriaPaciente_idHistoriaPaciente INTEGER NOT NULL,
  PRIMARY KEY(idPaciente, HistoriaPaciente_idHistoriaPaciente),
  FOREIGN KEY(HistoriaPaciente_idHistoriaPaciente)
    REFERENCES HistoriaPaciente(idHistoriaPaciente)
);

CREATE TABLE Espacio (
  idEspacio INTEGER NOT NULL,
  Sede_idSede INTEGER NOT NULL,
  PRIMARY KEY(idEspacio, Sede_idSede),
  FOREIGN KEY(Sede_idSede)
    REFERENCES Sede(idSede)
);

CREATE TABLE Examen (
  idExamen INTEGER NOT NULL,
  HistoriaPaciente_idHistoriaPaciente INTEGER NOT NULL,
  Sintomas VARCHAR(250) NULL,
  Resumen VARCHAR(250) NULL,
  Fecha_examen DATE NULL,
  PRIMARY KEY(idExamen, HistoriaPaciente_idHistoriaPaciente),
  FOREIGN KEY(HistoriaPaciente_idHistoriaPaciente)
    REFERENCES HistoriaPaciente(idHistoriaPaciente)
);

CREATE TABLE Familiar (
  idFamiliar INTEGER NOT NULL,
  Telefono_idTelefono INTEGER NOT NULL,
  Parentesco VARCHAR(50) NULL,
  PRIMARY KEY(idFamiliar, Telefono_idTelefono),
  FOREIGN KEY(Telefono_idTelefono)
    REFERENCES Telefono(idTelefono)
);

CREATE TABLE Servicio (
  idServicio INTEGER NOT NULL IDENTITY(1,1),
  Personal_Area_idArea INTEGER  NOT NULL,
  Personal_idPersonal INTEGER NOT NULL,
  Espacio_idEspacio INTEGER NOT NULL,
  Espacio_Sede_idSede INTEGER NOT NULL,
  CanalServicio VARCHAR(20) NULL,
  PRIMARY KEY(idServicio, Personal_Area_idArea, Personal_idPersonal, Espacio_idEspacio, Espacio_Sede_idSede),
  FOREIGN KEY(Personal_idPersonal, Personal_Area_idArea)
    REFERENCES Personal(idPersonal, Area_idArea),
  FOREIGN KEY(Espacio_idEspacio, Espacio_Sede_idSede)
    REFERENCES Espacio(idEspacio, Sede_idSede)
);

CREATE TABLE Receta (
  IdReceta INTEGER NOT NULL IDENTITY(1,1),
  Examen_HistoriaPaciente_idHistoriaPaciente INTEGER NOT NULL,
  Examen_idExamen INTEGER NOT NULL,
  Dieta_idDieta INTEGER NOT NULL,
  Horario VARCHAR(50) not NULL,
  Duracion VARCHAR(50) not NULL,
  Reclamada Bit not NULL,
  PRIMARY KEY(IdReceta, Examen_HistoriaPaciente_idHistoriaPaciente, Examen_idExamen, Dieta_idDieta),
  FOREIGN KEY(Examen_idExamen, Examen_HistoriaPaciente_idHistoriaPaciente)
    REFERENCES Examen(idExamen, HistoriaPaciente_idHistoriaPaciente),
  FOREIGN KEY(Dieta_idDieta)
    REFERENCES Dieta(idDieta)
);

CREATE TABLE Registro (
  idRegistro INTEGER NOT NULL IDENTITY(1,1),
  Paciente_idPaciente INTEGER NOT NULL,
  Servicio_Personal_idPersonal INTEGER NOT NULL,
  Servicio_Personal_Area_idArea INTEGER NOT NULL,
  Servicio_idServicio INTEGER NOT NULL,
  Paciente_HistoriaPaciente_idHistoriaPaciente INTEGER  NOT NULL,
  Servicio_Espacio_idEspacio INTEGER NOT NULL,
  Servicio_Espacio_Sede_idSede INTEGER NOT NULL,
  Fecha_ingreso DATE NULL,
  PRIMARY KEY(idRegistro, Paciente_idPaciente, Servicio_Personal_idPersonal, Servicio_Personal_Area_idArea, Servicio_idServicio, Paciente_HistoriaPaciente_idHistoriaPaciente, Servicio_Espacio_idEspacio, Servicio_Espacio_Sede_idSede),
  FOREIGN KEY(Paciente_idPaciente, Paciente_HistoriaPaciente_idHistoriaPaciente)
    REFERENCES Paciente(idPaciente, HistoriaPaciente_idHistoriaPaciente),
  FOREIGN KEY(Servicio_idServicio, Servicio_Personal_Area_idArea, Servicio_Personal_idPersonal, Servicio_Espacio_idEspacio, Servicio_Espacio_Sede_idSede)
    REFERENCES Servicio(idServicio, Personal_Area_idArea, Personal_idPersonal, Espacio_idEspacio, Espacio_Sede_idSede)
);

CREATE TABLE Usuario (
  Cedula INTEGER NOT NULL,
  Departamento_idDepartamento INTEGER NOT NULL,
  Paciente_idPaciente INTEGER NOT NULL,
  Personal_Area_idArea INTEGER NOT NULL,
  Personal_idPersonal INTEGER NOT NULL,
  Paciente_HistoriaPaciente_idHistoriaPaciente INTEGER  NOT NULL,
  Familiar_idFamiliar INTEGER NOT NULL,
  Familiar_Telefono_idTelefono INTEGER NOT NULL,
  IdTipoDocumento INTEGER NULL,
  IdEps INTEGER NULL,
  TipoSangre VARCHAR(5) NULL,
  Nombre VARCHAR(50) NULL,
  Apellido VARCHAR(50) NULL,
  FechaNacimiento DATE NULL,
  Genero VARCHAR(5) NULL,
  Edad INTEGER NULL,
  Correo VARCHAR(50) NULL,
  PRIMARY KEY(Cedula, Departamento_idDepartamento, Paciente_idPaciente, Personal_Area_idArea, Personal_idPersonal, Paciente_HistoriaPaciente_idHistoriaPaciente, Familiar_idFamiliar, Familiar_Telefono_idTelefono),
  FOREIGN KEY(Departamento_idDepartamento)
    REFERENCES Departamento(idDepartamento),
  FOREIGN KEY(Paciente_idPaciente, Paciente_HistoriaPaciente_idHistoriaPaciente)
    REFERENCES Paciente(idPaciente, HistoriaPaciente_idHistoriaPaciente),
  FOREIGN KEY(Personal_idPersonal, Personal_Area_idArea)
    REFERENCES Personal(idPersonal, Area_idArea),
  FOREIGN KEY(Familiar_idFamiliar, Familiar_Telefono_idTelefono)
    REFERENCES Familiar(idFamiliar, Telefono_idTelefono)
);

CREATE TABLE Alergias (
  idAlergias INTEGER NOT NULL,
  Examen_HistoriaPaciente_idHistoriaPaciente INTEGER  NOT NULL,
  Examen_idExamen INTEGER NOT NULL,
  TipoAlergia VARCHAR(100) NULL,
  Descripcion VARCHAR(100) NULL,
  PRIMARY KEY(idAlergias, Examen_HistoriaPaciente_idHistoriaPaciente, Examen_idExamen),
  FOREIGN KEY(Examen_idExamen, Examen_HistoriaPaciente_idHistoriaPaciente)
    REFERENCES Examen(idExamen, HistoriaPaciente_idHistoriaPaciente)
);

CREATE TABLE Medicamento (
  idMedicamento INTEGER  NOT NULL IDENTITY(1,1),
  Receta_Examen_idExamen INTEGER NOT NULL,
  Receta_Examen_HistoriaPaciente_idHistoriaPaciente INTEGER  NOT NULL,
  Receta_IdReceta INTEGER  NOT NULL,
  Descripcion VARCHAR(100) NULL,
  Precauciones VARCHAR(100) NULL,
  Receta_Dieta_idDieta varchar(100) not null,
  Fecha_expiracion DATE NULL,
  Dosis INTEGER  NULL,
  PRIMARY KEY(idMedicamento, Receta_Examen_idExamen, Receta_Examen_HistoriaPaciente_idHistoriaPaciente, Receta_IdReceta),
 
);

