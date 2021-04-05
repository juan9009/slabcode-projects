<?php

namespace App\Http\Requests\API\v1;

use App\Models\Project;
use InfyOm\Generator\Request\APIRequest;

class UpdateProjectAPIRequest extends APIRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $newRules = Project::$rules;
        $project = Project::find($this->route('project'));
        $newRules["name"] = 'nullable|string';
        $newRules["description"] = 'nullable|string';
        // Validamos que se pueda actualizar la fecha de inicio del proyecto pero que no sea inferior a la fecha de creación del registro
        $newRules["start_date"] = 'nullable|date|after:'.$project->created_at->format('Y-m-d').'|date_format:Y-m-d';
        if($this->has('start_date')){
            $newRules["end_date"] = 'required|date|after:start_date|date_format:Y-m-d';
        } else {
            $newRules["end_date"] = 'nullable|date|date_format:Y-m-d|after:'.$project->start_date;
        }
        return $newRules;
    }
}
