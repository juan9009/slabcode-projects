<?php namespace Tests\APIs;

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;
use App\Models\Project;

class ProjectApiTest extends TestCase
{
    use ApiTestTrait, WithoutMiddleware, DatabaseTransactions;

    /**
     * @test
     */
    public function test_create_project()
    {
        $project = Project::factory()->make()->toArray();

        $this->response = $this->json(
            'POST',
            '/api/projects', $project
        );

        $this->assertApiResponse($project);
    }

    /**
     * @test
     */
    public function test_read_project()
    {
        $project = Project::factory()->create();

        $this->response = $this->json(
            'GET',
            '/api/projects/'.$project->id
        );

        $this->assertApiResponse($project->toArray());
    }

    /**
     * @test
     */
    public function test_update_project()
    {
        $project = Project::factory()->create();
        $editedProject = Project::factory()->make()->toArray();

        $this->response = $this->json(
            'PUT',
            '/api/projects/'.$project->id,
            $editedProject
        );

        $this->assertApiResponse($editedProject);
    }

    /**
     * @test
     */
    public function test_delete_project()
    {
        $project = Project::factory()->create();

        $this->response = $this->json(
            'DELETE',
             '/api/projects/'.$project->id
         );

        $this->assertApiSuccess();
        $this->response = $this->json(
            'GET',
            '/api/projects/'.$project->id
        );

        $this->response->assertStatus(404);
    }
}
