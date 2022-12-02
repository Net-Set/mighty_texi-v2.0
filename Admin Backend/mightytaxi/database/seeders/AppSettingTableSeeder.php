<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AppSettingTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        DB::table('app_settings')->delete();
        
        DB::table('app_settings')->insert(array (
            0 => 
            array (
                'id' => 1,
                'site_name' => 'Mighty Taxi',
                'site_email' => NULL,
                'site_logo' => NULL,
                'site_favicon' => NULL,
                'site_description' => NULL,
                'site_copyright' => NULL,
                'facebook_url' => NULL,
                'instagram_url' => NULL,
                'twitter_url' => NULL,
                'linkedin_url' => NULL,
                'language_option' => '["en"]',
                'contact_email' => NULL,
                'contact_number' => NULL,
                'help_support_url' => NULL,
            ),
        ));
        
        
    }
}