<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_details', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('car_model')->nullable();
            $table->string('car_color')->nullable();
            $table->string('car_plate_number')->nullable();
            $table->string('car_production_year')->nullable();
            $table->text('work_address')->nullable();
            $table->text('home_address')->nullable();
            $table->string('work_latitude')->nullable();
            $table->string('work_longitude')->nullable();
            $table->string('home_latitude')->nullable();
            $table->string('home_longitude')->nullable();
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
        Schema::dropIfExists('user_details');
    }
}
