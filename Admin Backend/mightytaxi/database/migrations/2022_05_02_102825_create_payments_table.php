<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePaymentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('rider_id');
            $table->unsignedBigInteger('ride_request_id');
            $table->dateTime('datetime')->nullable();
            $table->double('total_amount')->nullable()->default('0');
            $table->double('admin_commission')->nullable()->default('0');
            $table->string('received_by')->nullable();
            $table->double('driver_fee')->nullable()->default('0');
            $table->double('driver_tips')->nullable()->default('0');
            $table->double('driver_commission')->nullable()->default('0');
            $table->double('fleet_commission')->nullable()->default('0');
            $table->string('payment_type')->nullable()->default('cash');
            $table->string('txn_id')->nullable();
            $table->string('payment_status')->nullable()->comment('pending, paid, failed');
            $table->json('transaction_detail')->nullable();
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
        Schema::dropIfExists('payments');
    }
}
