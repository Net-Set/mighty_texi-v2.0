<?php

namespace App\Jobs;

use PhpMqtt\Client\Facades\MQTT;
use Illuminate\Support\Facades\Log;

class NotifyViaMqtt
{
    protected $event;
    protected $message;
    

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($event, $message)
    {
        $this->event = $event;
        $this->message = $message;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        try {
            // Log::info($this->message);
            MQTT::publish($this->event, $this->message);
        } catch (\Exception $e) {
            Log::error($e);
        }
    }
}
