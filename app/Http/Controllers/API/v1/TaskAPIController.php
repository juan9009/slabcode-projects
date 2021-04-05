<?php

namespace App\Http\Controllers\API\v1;

use App\Http\Requests\API\v1\CreateTaskAPIRequest;
use App\Http\Requests\API\v1\UpdateTaskAPIRequest;
use App\Models\Task;
use App\Repositories\TaskRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\AppBaseController;
use Response;
use App\Repositories\ProjectRepository;

/**
 * Class TaskController
 * @package App\Http\Controllers\API\v1
 */

class TaskAPIController extends AppBaseController
{
    /** @var  TaskRepository */
    private $taskRepository;

    /** @var  ProjectRepository */
    private $projectRepository;

    public function __construct(TaskRepository $taskRepo, ProjectRepository $projectRepo)
    {
        $this->taskRepository = $taskRepo;
        $this->projectRepository = $projectRepo;
    }

    /**
     * @param Request $request
     * @return Response
     *
     * @SWG\Get(
     *      path="/tasks",
     *      summary="Get a listing of the Tasks.",
     *      tags={"Task"},
     *      description="Get all Tasks",
     *      produces={"application/json"},
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  type="array",
     *                  @SWG\Items(ref="#/definitions/Task")
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function index(Request $request)
    {
        $tasks = $this->taskRepository->all(
            $request->except(['skip', 'limit']),
            $request->get('skip'),
            $request->get('limit')
        );

        return $this->sendResponse($tasks->toArray(), 'Tasks retrieved successfully');
    }

    /**
     * @param CreateTaskAPIRequest $request
     * @return Response
     *
     * @SWG\Post(
     *      path="/tasks",
     *      summary="Store a newly created Task in storage",
     *      tags={"Task"},
     *      description="Store Task",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Task that should be stored",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Task")
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  ref="#/definitions/Task"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function store(CreateTaskAPIRequest $request)
    {
        $input = $request->all();

        $project = $this->projectRepository->find($request->projects_id);
        if (empty($project)) {
            return $this->sendError('Project not found');
        }
        if ($this->check_in_range($project->start_date, $project->end_date, $request->execution_date)) {
            $task = $this->taskRepository->create($input);
            return $this->sendResponse($task->toArray(), 'Task saved successfully');
        } else {
            return $this->sendError('The execution date is invalid, check if the date is between '.$project->start_date.' and '.$project->end_date, 400);
        }
    }

    
    function check_in_range($start_date, $end_date, $date) {
        // Convert to timestamp
        $start = strtotime($start_date);
        $end = strtotime($end_date);
        $check = strtotime($date);
    
        // Check that user date is between start & end
        return (($start <= $check ) && ($check <= $end));
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Get(
     *      path="/tasks/{id}",
     *      summary="Display the specified Task",
     *      tags={"Task"},
     *      description="Get Task",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Task",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  ref="#/definitions/Task"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function show($id)
    {
        /** @var Task $task */
        $task = $this->taskRepository->find($id);

        if (empty($task)) {
            return $this->sendError('Task not found');
        }

        return $this->sendResponse($task->toArray(), 'Task retrieved successfully');
    }

    /**
     * @param int $id
     * @param UpdateTaskAPIRequest $request
     * @return Response
     *
     * @SWG\Put(
     *      path="/tasks/{id}",
     *      summary="Update the specified Task in storage",
     *      tags={"Task"},
     *      description="Update Task",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Task",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Task that should be updated",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Task")
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  ref="#/definitions/Task"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function update($id, UpdateTaskAPIRequest $request)
    {
        $input = $request->all();

        /** @var Task $task */
        $task = $this->taskRepository->find($id);

        if (empty($task)) {
            return $this->sendError('Task not found');
        }

        $project = $this->projectRepository->find($request->projects_id);
        if (empty($project)) {
            return $this->sendError('Project not found');
        }

        if ($this->check_in_range($project->start_date, $project->end_date, $request->execution_date)) {
            $task = $this->taskRepository->update($input, $id);    
            return $this->sendResponse($task->toArray(), 'Task updated successfully');
        } else {
            return $this->sendError('The execution date is invalid, check if the date is between '.$project->start_date.' and '.$project->end_date, 400);
        }
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Delete(
     *      path="/tasks/{id}",
     *      summary="Remove the specified Task from storage",
     *      tags={"Task"},
     *      description="Delete Task",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Task",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  type="string"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function destroy($id)
    {
        /** @var Task $task */
        $task = $this->taskRepository->find($id);

        if (empty($task)) {
            return $this->sendError('Task not found');
        }

        $task->delete();

        return $this->sendSuccess('Task deleted successfully');
    }
    

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Put(
     *      path="/tasks/{id}/finish",
     *      summary="Finish the specified Task in storage",
     *      tags={"Task"},
     *      description="Finish Task",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Task",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Task that should be finished",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Task")
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  ref="#/definitions/Task"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function finish(Task $id){
        if($id->status != 'Finalizado'){
            $task = $this->taskRepository->update(['status' => 3], $id->id);
            return $this->sendResponse($task->toArray(), 'Task finished successfully');
        }
        return $this->sendError("This project has already been completed previously", 400);
    }
}
