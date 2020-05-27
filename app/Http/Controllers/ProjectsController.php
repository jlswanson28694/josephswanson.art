<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Project;
use App\Thumbnail;

class ProjectsController extends Controller
{
    public function index()
    {
        // To get an array of thumbnails back, a type must be specified so the program knows whether to send back the Concept Art projects or the 3D projects. Concept Art is the default.
        // Sending the type throught the query string is a bit messy. Maybe send it in the uri instead?
        $type = 'Concept Art';

        if(request('type')) {
            $type = request('type');
        }

        // Grab the thumbnails, ordered by the order column, only eager loading the type of the project it belongs to
        $thumbnails = Thumbnail::with('project:id,type')->orderBy('order')->get();

        // Filter the collection so I only get the thumbnails of the specified project type.
        $thumbnails = $thumbnails->filter(function ($thumbnail) use ($type) {
            return $thumbnail->project->type == $type;
        });

        // I think this might be really ineffecient but I don't really know how to fix it
        // From what I understand, when I call project->imageCount(), I am running a query to find the project model I want, then running a query to find the id's of the images that belong to that project. That's a lot of queries.
        // Well, does it actually run a query to find the project model? I have the projects eager loaded already, so I'm not sure if it does.
        // If I somehow eager load the images table (just the id's), would that eliminate the need for a new query when I call imageCount()?
        // Is there a way to see when new database queries are being executed so I know what's happening?
        $thumbnails = $thumbnails->map(function ($thumbnail) {
            // Add the imageCount property so I know whether or not to display the "multiple images" icon
            $thumbnail->imageCount = $thumbnail->project->imageCount();

            // I don't need the project information sent over
            unset($thumbnail->project);

            return $thumbnail;
        });

        // Reindex the collection. I need the indexes to go 0,1,2,3 not 1,2,5,8.
        $thumbnails = $thumbnails->values();

        return [ 'projects' => $thumbnails ];
    }

    public function show(Project $project) {
        // This eager loads the image information for the project so I can send it to the front-end along with the Project model
        $images = $project->images;
        return [ 'project' => $project ];
    } 
}
