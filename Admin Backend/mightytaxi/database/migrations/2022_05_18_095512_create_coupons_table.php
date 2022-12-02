<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCouponsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('coupons', function (Blueprint $table) {
            $table->id();
            $table->string('code')->nullable();
            $table->string('title')->nullable();
            $table->string('coupon_type')->nullable()->comment('all,first_ride,region_wise,service_wise');
            $table->unsignedBigInteger('usage_limit_per_rider')->nullable();
            $table->string('discount_type')->nullable()->comment('fixed,percentage');
            $table->double('discount')->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->double('minimum_amount')->nullable();
            $table->double('maximum_discount')->nullable();            
            $table->text('description')->nullable();
            $table->tinyInteger('status')->nullable();
            $table->text('region_ids')->nullable();
            $table->text('service_ids')->nullable();
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
        Schema::dropIfExists('coupons');
    }
}
