<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAlbumSettingTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('album_setting', function (Blueprint $table) {
            $table->id();
            $table->string('appname')->default('');
            $table->string('phototitle')->default('');
            $table->integer('zimu')->default(0);
            $table->integer('touxiang')->default(0);
            $table->string('sharetitle')->default('');
            $table->string('shareimg')->default('');
            $table->string('indexbtn')->default('');
            $table->string('flowerbtn')->default('');
            $table->string('sharebtn')->default('');
            $table->string('savebtn')->default('');
            $table->string('editbtn')->default('');
            $table->string('addapp')->default('');
            $table->string('addapp1')->default('');
            $table->string('llads')->default('');
            $table->string('userllads')->default('');
            $table->string('albumllads')->default('');
            $table->string('skinllads')->default('');
            $table->string('albumads')->default('');
            $table->string('albumconads')->default('');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('album_setting');
    }
}
