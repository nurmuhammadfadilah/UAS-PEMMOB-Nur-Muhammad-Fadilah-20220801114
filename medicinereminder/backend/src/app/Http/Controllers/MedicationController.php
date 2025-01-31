<?php

namespace App\Http\Controllers;

use App\Models\Medication;
use Illuminate\Http\Request;

class MedicationController extends Controller
{
    public function index()
    {
        return Medication::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'time' => 'required|string',
        ]);

        $medication = Medication::create([
            'name' => $request->name,
            'time' => $request->time,
        ]);

        return response()->json(['message' => 'Obat berhasil ditambahkan', 'data' => $medication], 201);
    }
}
