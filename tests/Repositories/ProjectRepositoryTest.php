<?php namespace Tests\Repositories;

use App\Models\Project;
use App\Repositories\ProjectRepository;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;

class ProjectRepositoryTest extends TestCase
{
    use ApiTestTrait, DatabaseTransactions;

    /**
     * @var ProjectRepository
     */
    protected $projectRepo;

    public function setUp() : void
    {
        parent::setUp();
        $this->projectRepo = \App::make(ProjectRepository::class);
    }

    /**
     * @test create
     */
    public function test_create_project()
    {
        $project = Project::factory()->make()->toArray();

        $createdProject = $this->projectRepo->create($project);

        $createdProject = $createdProject->toArray();
        $this->assertArrayHasKey('id', $createdProject);
        $this->assertNotNull($createdProject['id'], 'Created Project must have id specified');
        $this->assertNotNull(Project::find($createdProject['id']), 'Project with given id must be in DB');
        $this->assertModelData($project, $createdProject);
    }

    /**
     * @test read
     */
    public function test_read_project()
    {
        $project = Project::factory()->create();

        $dbProject = $this->projectRepo->find($project->id);

        $dbProject = $dbProject->toArray();
        $this->assertModelData($project->toArray(), $dbProject);
    }

    /**
     * @test update
     */
    public function test_update_project()
    {
        $project = Project::factory()->create();
        $fakeProject = Project::factory()->make()->toArray();

        $updatedProject = $this->projectRepo->update($fakeProject, $project->id);

        $this->assertModelData($fakeProject, $updatedProject->toArray());
        $dbProject = $this->projectRepo->find($project->id);
        $this->assertModelData($fakeProject, $dbProject->toArray());
    }

    /**
     * @test delete
     */
    public function test_delete_project()
    {
        $project = Project::factory()->create();

        $resp = $this->projectRepo->delete($project->id);

        $this->assertTrue($resp);
        $this->assertNull(Project::find($project->id), 'Project should not exist in DB');
    }
}
