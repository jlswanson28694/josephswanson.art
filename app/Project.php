<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    public function getFirstImage()
    {
        if($this->images->count())
        {
            return $this->images[0];
        } else {
            return null;
        }
    }

    public function imageCount() {
        return $this->images->count();
    }

    public function images()
    {
        return $this->hasMany('App\Image');
    }
}
