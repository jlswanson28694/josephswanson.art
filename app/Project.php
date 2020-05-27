<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    public function imageCount() {
        // All I need is the number of images in the project, so I only need to get the id column instead of returning the whole model
        return $this->images()->pluck('id')->count();
    }

    public function images()
    {
        return $this->hasMany('App\Image');
    }
}
