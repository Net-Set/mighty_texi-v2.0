<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWalletHistoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wallet_histories', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->string('type')->nullable()->comment('credit,debit');
            $table->string('transaction_type')->nullable()->comment('credit- ,debit');
            $table->string('currency')->nullable();
            $table->double('amount')->nullable()->default('0');
            $table->double('balance')->nullable()->default('0');
            $table->datetime('datetime')->nullable();
            $table->unsignedBigInteger('ride_request_id')->nullable();
            $table->text('description')->nullable();
            $table->text('data')->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
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
        Schema::dropIfExists('wallet_histories');
    }
}
