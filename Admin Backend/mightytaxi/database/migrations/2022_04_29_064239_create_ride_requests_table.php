<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRideRequestsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ride_requests', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('rider_id')->nullable();
            $table->unsignedBigInteger('service_id')->nullable();
            $table->dateTime('datetime')->nullable();
            $table->boolean('is_schedule')->default(0)->comment('0-regular, 1-schedule');
            $table->integer('ride_attempt')->default(0)->nullable();
            $table->string('distance_unit')->nullable();
            $table->double('total_amount')->nullable()->default('0');
            $table->double('subtotal')->nullable()->default('0');
            $table->double('extra_charges_amount')->nullable()->default('0');
            $table->unsignedBigInteger('driver_id')->nullable();
            $table->unsignedBigInteger('riderequest_in_driver_id')->nullable();
            $table->dateTime('riderequest_in_datetime')->nullable();
            $table->string('start_latitude')->nullable();
            $table->string('start_longitude')->nullable();
            $table->text('start_address')->nullable();
            $table->string('end_latitude')->nullable();
            $table->string('end_longitude')->nullable();
            $table->text('end_address')->nullable();
            $table->double('distance')->nullable();
            $table->double('base_distance')->nullable();
            $table->double('duration')->nullable();
            $table->double('seat_count')->nullable();
            $table->text('reason')->nullable();
            $table->string('status', 20)->default('active');
            $table->double('base_fare')->nullable();
            $table->double('minimum_fare')->nullable();
            $table->double('per_distance')->nullable();
            $table->double('per_distance_charge')->nullable();
            $table->double('per_minute_drive')->nullable();
            $table->double('per_minute_drive_charge')->nullable();
            $table->json('extra_charges')->nullable();
            $table->double('coupon_discount')->nullable();
            $table->unsignedBigInteger('coupon_code')->nullable();
            $table->json('coupon_data')->nullable();
            $table->string('otp')->nullable();
            $table->enum('cancel_by', ['rider','driver','auto'])->nullable();
            $table->double('cancelation_charges')->nullable();
            $table->double('waiting_time')->nullable();
            $table->double('waiting_time_limit')->nullable();
            $table->double('tips')->nullable();
            $table->double('per_minute_waiting')->nullable();
            $table->double('per_minute_waiting_charge')->nullable();
            $table->string('payment_type')->nullable(); 
            $table->boolean('is_driver_rated')->default(0);
            $table->boolean('is_rider_rated')->default(0);
            $table->text('cancelled_driver_ids')->nullable();
            $table->json('service_data')->nullable();
            $table->double('max_time_for_find_driver_for_ride_request')->nullable();
            $table->foreign('rider_id')->references('id')->on('users')->onDelete('cascade');
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
        Schema::dropIfExists('ride_requests');
    }
}
