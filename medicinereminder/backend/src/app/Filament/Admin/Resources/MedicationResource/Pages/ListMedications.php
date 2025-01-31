<?php

namespace App\Filament\Admin\Resources\MedicationResource\Pages;

use App\Filament\Admin\Resources\MedicationResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListMedications extends ListRecords
{
    protected static string $resource = MedicationResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
