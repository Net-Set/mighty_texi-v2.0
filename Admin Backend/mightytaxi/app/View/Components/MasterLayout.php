<?php

namespace App\View\Components;

use Illuminate\View\Component;

class MasterLayout extends Component
{
    public $layout, $assets;

    public function __construct($layout = '', $assets = [])
    {
        $this->layout = $layout;
        $this->assets = $assets;
    }

    /**
     * Get the view / contents that represents the component.
     *
     * @return \Illuminate\View\View
     */
    public function render()
    {
        return view('components.master-layout');
    }
}
