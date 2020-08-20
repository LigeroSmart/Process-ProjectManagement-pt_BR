package var::processes::examples::Project_Management_post;
## nofilter(TidyAll::Plugin::OTRS::Perl::PerlCritic)

use strict;
use warnings;

use utf8;

our @ObjectDependencies = (
    "Kernel::Config",
    "Kernel::System::SysConfig",
);

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

    my @Data = (
        {
            'Ticket::Frontend::AgentTicketZoom' => {
                'ProcessWidgetDynamicField' => {
				'projKickoffcliente' => '1',
				'projKickoffrealizada' => '1',
				'projCanceladosimnao' => '1',
				'projMotivocanelamento' => '1',
				'projImpedimentoAdm' => '1',
				'projImpedimentoCom' => '1',
				'projCronogramacriado' => '1',
				'projCriartarefa' => '1',
				'projTitulo' => '1',
				'projDescricaoTarefa' => '1',
				'projKickoffplanejado' => '1',
				'projKickoffinternoplanejado' => '1',
				'projCliente' => '1',
				'projContatodoCliente' => '1',
				'projGerente' => '1',
				'projInicioProjeto' => '1',
				'projEscopo' => '1',
				'projProposta' => '1',
				'projHorasPrevistas' => '1',
				'projFormapagamento' => '1',
				'projDescricaopagamento' => '1',
				'projPasta' => '1',
				'projKickoffinternorealizado' => '1',
				'projKickoffinterno' => '1',
				'projDataEncerramento' => '1',
			},
			'ProcessWidgetDynamicFieldGroups' => {
			}
		}
	);
    my $ConfigObject    = $Kernel::OM->Get("Kernel::Config");
    my $SysConfigObject = $Kernel::OM->Get("Kernel::System::SysConfig");

    for my $Item (@Data) {
        my $ItemName     = ( keys %{$Item} )[0];
        my $CurrentValue = $ConfigObject->Get($ItemName);

        for my $Key ( sort keys %{ $Item->{$ItemName} } ) {

            for my $InnerKey ( sort keys %{ $Item->{$ItemName}->{$Key} } ) {

                my $Value = $Item->{$ItemName}->{$Key}->{$InnerKey};

                if (
                    !$CurrentValue->{$Key}->{$InnerKey}
                    || $CurrentValue->{$Key}->{$InnerKey} ne $Value
                    )
                {
                    $CurrentValue->{$Key}->{$InnerKey} = $Value;
                }
            }
        }

        $ConfigObject->Set(
            Key   => $ItemName,
            Value => $CurrentValue,
        );

        $SysConfigObject->ConfigItemUpdate(
            Valid        => 1,
            Key          => $ItemName,
            Value        => $CurrentValue,
            NoValidation => 1,
        );
    }

    return %Response;
}

1;
