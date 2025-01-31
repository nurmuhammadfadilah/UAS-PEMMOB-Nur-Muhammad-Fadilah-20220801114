<?php

namespace App\Filament\Admin\Resources\MedicationResource\Pages;

use App\Filament\Admin\Resources\MedicationResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateMedication extends CreateRecord
{
    protected static string $resource = MedicationResource::class;
}
