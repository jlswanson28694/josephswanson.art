<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Project;

class ProjectsController extends Controller
{
    public function index()
    {
        $thumbnails = [];

        if(request('type')) {
            $projects = Project::where('type', request('type'))->get();
        } else {
            $projects = Project::all();
        }
        
        foreach ($projects as $project) {

            $thumbnail = new Thumbnail($project, $project->getFirstImage());

            $thumbnails[] = $thumbnail;
        }

        return [ 'projects' => $thumbnails ];
    }

    public function show(Project $project) {
        // Just loading the relationship makes it send with the Project model. I don't even have to return this images variable.
        $images = $project->images;
        return [ 'project' => $project ];
    } 
}

class Thumbnail {

    public function __construct($project, $firstImage) {
        $this->id = $firstImage->id;
        $this->project_id = $project->id;
        $this->imageCount = $project->imageCount();
        $this->path = $firstImage->path;
        $this->height = $firstImage->height;
        $this->width = $firstImage->width;
    }
}
