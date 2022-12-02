<?php

namespace App\View\Components;

use Illuminate\View\Component;

class AppLayout extends Component
{
    public $layout;

    public function __construct($layout = '')
    {
        $this->layout = $layout;
    }

    /**
     * Get the view / contents that represents the component.
     *
     * @return \Illuminate\View\View
     */
    public function render()
    {
        switch($this->layout){
            case 'dashboard2':
                return view('layouts.dashboard2');
            break;
            case 'dashboard3':
                return view('layouts.dashboard3');
                break;
            default:
                return view('layouts.dashboard');
            break;
        }
    }
}
