<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateComplaintsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('complaints', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('driver_id')->nullable();
            $table->unsignedBigInteger('rider_id')->nullable();
            $table->string('complaint_by')->nullable()->comment('rider, driver');
            $table->text('subject')->nullable();
            $table->text('description')->nullable();
            $table->unsignedBigInteger('ride_request_id')->nullable();
            $table->string('status')->nullable()->default('pending')->comment('pending, investigation, resolved');
            $table->foreign('rider_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('ride_request_id')->references('id')->on('ride_requests')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('complaints');
    }
}
