<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('first_name')->nullable();
            $table->string('last_name')->nullable();
            $table->string('email')->unique();
            $table->string('username')->unique();
            $table->string('password');
            $table->string('contact_number')->nullable();
            $table->enum('gender',['male', 'female', 'other'])->nullable();
            $table->timestamp('email_verified_at')->nullable();
            $table->text('address')->nullable();
            $table->string('user_type')->nullable();
            $table->string('player_id')->nullable();
            $table->unsignedBigInteger('service_id')->nullable();
            $table->unsignedBigInteger('fleet_id')->nullable();
            $table->string('latitude')->nullable();
            $table->string('longitude')->nullable();
            $table->rememberToken();
            $table->timestamp('last_notification_seen')->nullable();
            $table->string('status', 20)->default('active');
            $table->tinyInteger('is_online')->nullable()->default('0');
            $table->tinyInteger('is_available')->nullable()->default('1');
            $table->tinyInteger('is_verified_driver')->nullable()->default('0');
            $table->string('uid')->nullable();
            $table->string('display_name')->nullable();
            $table->string('login_type')->nullable();
            $table->string('timezone')->nullable()->default('UTC');
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
        Schema::dropIfExists('users');
    }
}
