<?php

namespace App\Http\Requests\API\v1;

use App\Models\Task;
use InfyOm\Generator\Request\APIRequest;

class UpdateTaskAPIRequest extends APIRequest
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
        $rules = Task::$rules;
        $rules["name"] = 'nullable|string|max:100';
        $rules["description"] = 'nullable|string';
        $rules["execution_date"] = 'nullable|date|date_format:Y-m-d';
        
        return $rules;
    }
}
