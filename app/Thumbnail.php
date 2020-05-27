<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Project;

class Thumbnail extends Model
{
    public function project() {
        return $this->belongsTo('App\Project');
    }
}
