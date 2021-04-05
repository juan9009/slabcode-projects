<?php

namespace App\Http\Requests\API\v1;

use App\Models\Project;
use InfyOm\Generator\Request\APIRequest;

class CreateProjectAPIRequest extends APIRequest
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
        
        $newRules["start_date"] = 'required|date|after:yesterday|date_format:Y-m-d';
        $newRules["end_date"] = 'required|date|after:start_date|date_format:Y-m-d';
        return $newRules;
    }
}
