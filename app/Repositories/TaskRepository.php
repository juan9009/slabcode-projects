<?php

namespace App\Repositories;

use App\Models\Task;
use App\Repositories\BaseRepository;

/**
 * Class TaskRepository
 * @package App\Repositories
 * @version April 4, 2021, 2:54 pm UTC
*/

class TaskRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        'name',
        'description',
        'execution_date',
        'status',
        'projects_id'
    ];

    /**
     * Return searchable fields
     *
     * @return array
     */
    public function getFieldsSearchable()
    {
        return $this->fieldSearchable;
    }

    /**
     * Configure the Model
     **/
    public function model()
    {
        return Task::class;
    }

    /**
     * Get tasks with filters
     **/
    public function search($search = [], $skip = null, $limit = null)
    {
        $query = $this->model->newQuery();
        /*$query->with('stocks', function ($query) {
            $query->selectRaw("product_id, stock.sku as sku, (stock.precio + (stock.precio * stock.iva)) as precio, url_foto, stock.iva as iva, (select case when (sum(stock.cantidad) - sum(items_factura.cantidad)) is null then sum(stock.cantidad) else (sum(stock.cantidad) - sum(items_factura.cantidad)) end as disponibles from items_factura where items_factura.sku = stock.sku and deleted_at is null) as disponibles")
            ->groupBy('product_id','stock.sku', 'stock.precio', 'url_foto', 'stock.iva');
        });*/
        $query = $this->model->newQuery();

        if (count($search)) {
            foreach($search as $key => $value) {
                if (in_array($key, $this->getFieldsSearchable())) {
                    if(is_array($value)){
                        $query->where($key, $value[0], $value[1]);
                    } else {                        
                        $query->where($key, $value);
                    }
                }
            }
        }

        if (!is_null($skip)) {
            $query->skip($skip);
        }

        if (!is_null($limit)) {
            $query->limit($limit);
        }

        return $query;
    }
}
