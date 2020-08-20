package var::processes::examples::Project_Management_pre;
## nofilter(TidyAll::Plugin::OTRS::Perl::PerlCritic)

use strict;
use warnings;

use base qw(var::processes::examples::Base);

our @ObjectDependencies = ();

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my %Response = (
        Success => 1,
    );

	my @Types = (
		"Projetos",
		"Projetos::Tarefa"
	);

	for (@Types){
		$Kernel::OM->Get('Kernel::System::Type')->TypeAdd(
			Name    => $_,
			ValidID => 1,
			UserID  => 1,
		);
	}

	my @Queues = (
		"Gestão de Projetos"
	);
	for (@Queues){
		$Kernel::OM->Get('Kernel::System::Queue')->QueueAdd(
        Name                => $_,
        ValidID             => 1,
        GroupID             => 1,
        SystemAddressID     => 1,
        SalutationID        => 1,
        SignatureID         => 1,
        Comment             => $_,
        UserID              => 1,
    	);
	}

	my @States = (
		"Proj - Agendar kickoff",
		"Proj - Aguardando kickoff",
		"Proj - Avaliando compliance",
		"Proj - Pendencia compliance",
		"Proj - Avaliando comercial",
		"Proj - Pendencia comercial",
		"Proj - Aguardando cronograma",
		"Proj - Projeto em andamento",
		"Proj - Projeto cancelado",
		"Proj - Executando tarefas",
		"Proj - Sem tarefas em execução"
	);

	for (@States) {
		$Kernel::OM->Get('Kernel::System::State')->StateAdd(
        Name    => $_,
        Comment => $_,
        ValidID => 1,
        TypeID  => 2,
        UserID  => 1,
    	);
	}

    my @DynamicFields = (
	{
		Name => 'projKickoffcliente',
		Label => 'KickOff cliente realizado?',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '34',
		Config => {
			PossibleValues => {
				'Sim' => 'Sim',
				'Não' => 'Não',
			}
		}
	},
	{
		Name => 'projKickoffrealizada',
		Label => 'Data KickOff Realizada',
		FieldType => 'DateTime',
		ObjectType => 'Ticket',
		FieldOrder => '47',
		Config => {
		}
	},
	{
		Name => 'projCanceladosimnao',
		Label => 'Cancelar Projeto?',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '37',
		Config => {
			PossibleValues => {
				'Não' => 'Não',
				'Sim' => 'Sim',
			}
		}
	},
	{
		Name => 'projMotivocanelamento',
		Label => 'Motivo cancelamento',
		FieldType => 'TextArea',
		ObjectType => 'Ticket',
		FieldOrder => '38',
		Config => {
	Cols => '',
		}
	},
	{
		Name => 'projImpedimentoAdm',
		Label => 'Impedimento Administrativo?',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '31',
		Config => {
			PossibleValues => {
				'Sim' => 'Sim',
				'Não' => 'Não',
			}
		}
	},
	{
		Name => 'projImpedimentoCom',
		Label => 'Impedimento Comercial?',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '30',
		Config => {
			PossibleValues => {
				'Não' => 'Não',
				'Sim' => 'Sim',
			}
		}
	},
	{
		Name => 'projCronogramacriado',
		Label => 'Cronograma criado?',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '29',
		Config => {
			PossibleValues => {
				'Não' => 'Não',
				'Sim' => 'Sim',
			}
		}
	},
	{
		Name => 'projCriartarefa',
		Label => 'Criar tarefas',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '28',
		Config => {
			PossibleValues => {
				'Sim' => 'Sim',
				'Não' => 'Não',
			}
		}
	},
	{
		Name => 'projTitulo',
		Label => 'Titulo da Nova Tarefa',
		FieldType => 'Text',
		ObjectType => 'Ticket',
		FieldOrder => '27',
		Config => {
		}
	},
	{
		Name => 'projDescricaoTarefa',
		Label => 'Descrição da Tarefa',
		FieldType => 'TextArea',
		ObjectType => 'Ticket',
		FieldOrder => '26',
		Config => {
	Cols => '80',
		}
	},
	{
		Name => 'projKickoffplanejado',
		Label => 'Data KickOff Planejada',
		FieldType => 'DateTime',
		ObjectType => 'Ticket',
		FieldOrder => '48',
		Config => {
		}
	},
	{
		Name => 'projKickoffinternoplanejado',
		Label => 'Data KickOff Interno Planejado',
		FieldType => 'DateTime',
		ObjectType => 'Ticket',
		FieldOrder => '33',
		Config => {
		}
	},
	{
		Name => 'projCliente',
		Label => 'Cliente',
		FieldType => 'Text',
		ObjectType => 'Ticket',
		FieldOrder => '50',
		Config => {
		}
	},
	{
		Name => 'projContatodoCliente',
		Label => 'Contato do Cliente',
		FieldType => 'Text',
		ObjectType => 'Ticket',
		FieldOrder => '49',
		Config => {
		}
	},
	{
		Name => 'projGerente',
		Label => 'Gerente de Contas',
		FieldType => 'Text',
		ObjectType => 'Ticket',
		FieldOrder => '45',
		Config => {
		}
	},
	{
		Name => 'projInicioProjeto',
		Label => 'Inicio do Projeto',
		FieldType => 'DateTime',
		ObjectType => 'Ticket',
		FieldOrder => '46',
		Config => {
		}
	},
	{
		Name => 'projEscopo',
		Label => 'Escopo do Projeto',
		FieldType => 'TextArea',
		ObjectType => 'Ticket',
		FieldOrder => '44',
		Config => {
	Cols => '',
		}
	},
	{
		Name => 'projProposta',
		Label => 'Proposta Projeto',
		FieldType => 'File',
		ObjectType => 'Ticket',
		FieldOrder => '40',
		Config => {
			PossibleValues => {
			}
		}
	},
	{
		Name => 'projHorasPrevistas',
		Label => 'Horas Previstas',
		FieldType => 'Text',
		ObjectType => 'Ticket',
		FieldOrder => '43',
		Config => {
		}
	},
	{
		Name => 'projFormapagamento',
		Label => 'Forma de Pagamento',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '39',
		Config => {
			PossibleValues => {
				'3' => '3 - Por entrega',
				'1' => '1 - 50% Entrada + 50% 30 dias',
				'2' => '2 - 50% Entrada + 50% entrega',
				'4' => '5 - Outros',
				'5' => '4 - Não informado',
			}
		}
	},
	{
		Name => 'projDescricaopagamento',
		Label => 'Descrição Pagamento',
		FieldType => 'TextArea',
		ObjectType => 'Ticket',
		FieldOrder => '36',
		Config => {
	Cols => '',
		}
	},
	{
		Name => 'projPasta',
		Label => 'Pasta do Projeto',
		FieldType => 'Text',
		ObjectType => 'Ticket',
		FieldOrder => '42',
		Config => {
		}
	},
	{
		Name => 'projKickoffinternorealizado',
		Label => 'Data KickOff Interno Realizado',
		FieldType => 'DateTime',
		ObjectType => 'Ticket',
		FieldOrder => '32',
		Config => {
		}
	},
	{
		Name => 'projKickoffinterno',
		Label => 'KickOff interno realizado?',
		FieldType => 'Dropdown',
		ObjectType => 'Ticket',
		FieldOrder => '35',
		Config => {
			PossibleValues => {
				'Sim' => 'Sim',
				'Não' => 'Não',
			}
		}
	},
	{
		Name => 'projDataEncerramento',
		Label => 'Data encerramento do Projeto',
		FieldType => 'DateTime',
		ObjectType => 'Ticket',
		FieldOrder => '41',
		Config => {
		}
	},
    );	
    %Response = $Self->DynamicFieldsAdd(
        DynamicFieldList => \@DynamicFields,
    );

    return %Response;
}

1;
