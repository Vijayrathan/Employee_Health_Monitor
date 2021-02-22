<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class HealthController extends Controller
{
    public function healthInfo() {

    	$response = Http::get('http://127.0.0.1:5001/mongodb/sorted');
    	$employeeHealthData = json_decode($response);


    	$ascEmployeeHealthData = array_reverse($employeeHealthData);

    	return view('health-info', ['employeeHealthData' => $ascEmployeeHealthData]);
    }
}
