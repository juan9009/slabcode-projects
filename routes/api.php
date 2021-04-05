<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/*Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});*/

// Versión 1.0 del API rest
Route::group([
    'prefix' => 'v1'
], function () {

    Route::post('login', 'v1\AuthController@login');

    // Para validar que sólo sean usuarios verificados, basta con agregar el middleware 'verified' después de 'auth:api'
    Route::middleware(['auth:api'])->group(function () {
        Route::get('logout', 'v1\AuthController@logout');
        Route::post('signup', 'v1\AuthController@signUp');
        Route::get('user', 'v1\AuthController@user');
        Route::delete('user/{id}/disable', 'v1\AuthController@disableUser');
        Route::put('user/changepassword', 'v1\AuthController@changePassword');

        Route::resource('projects', v1\ProjectAPIController::class);
        Route::put('projects/{id}/finish', 'v1\ProjectAPIController@finish');
        Route::resource('tasks',v1\TaskAPIController::class);
        Route::put('tasks/{id}/finish', 'v1\TaskAPIController@finish');
    });
});

