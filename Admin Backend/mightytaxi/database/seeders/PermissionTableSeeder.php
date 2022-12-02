<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
class PermissionTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        DB::table('permissions')->delete();
        
        DB::table('permissions')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'role',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'role add',
                'guard_name' => 'web',
                'parent_id' => 1,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'role list',
                'guard_name' => 'web',
                'parent_id' => 1,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            3 => 
            array (
                'id' => 4,
                'name' => 'permission',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            4 => 
            array (
                'id' => 5,
                'name' => 'permission add',
                'guard_name' => 'web',
                'parent_id' => 4,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            5 => 
            array (
                'id' => 6,
                'name' => 'permission list',
                'guard_name' => 'web',
                'parent_id' => 4,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            6 => 
            array (
                'id' => 7,
                'name' => 'region',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            7 => 
            array (
                'id' => 8,
                'name' => 'region list',
                'guard_name' => 'web',
                'parent_id' => 7,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            8 => 
            array (
                'id' => 9,
                'name' => 'region add',
                'guard_name' => 'web',
                'parent_id' => 7,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            9 => 
            array (
                'id' => 10,
                'name' => 'region edit',
                'guard_name' => 'web',
                'parent_id' => 7,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            10 => 
            array (
                'id' => 11,
                'name' => 'region delete',
                'guard_name' => 'web',
                'parent_id' => 7,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            11 => 
            array (
                'id' => 12,
                'name' => 'service',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            12 => 
            array (
                'id' => 13,
                'name' => 'service list',
                'guard_name' => 'web',
                'parent_id' => 12,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            13 => 
            array (
                'id' => 14,
                'name' => 'service add',
                'guard_name' => 'web',
                'parent_id' => 12,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            14 => 
            array (
                'id' => 15,
                'name' => 'service edit',
                'guard_name' => 'web',
                'parent_id' => 12,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            15 => 
            array (
                'id' => 16,
                'name' => 'service delete',
                'guard_name' => 'web',
                'parent_id' => 12,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            16 => 
            array (
                'id' => 17,
                'name' => 'driver',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            17 => 
            array (
                'id' => 18,
                'name' => 'driver list',
                'guard_name' => 'web',
                'parent_id' => 17,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            18 => 
            array (
                'id' => 19,
                'name' => 'driver add',
                'guard_name' => 'web',
                'parent_id' => 17,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            19 => 
            array (
                'id' => 20,
                'name' => 'driver edit',
                'guard_name' => 'web',
                'parent_id' => 17,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            20 => 
            array (
                'id' => 21,
                'name' => 'driver delete',
                'guard_name' => 'web',
                'parent_id' => 17,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            21 => 
            array (
                'id' => 22,
                'name' => 'rider',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            22 => 
            array (
                'id' => 23,
                'name' => 'rider list',
                'guard_name' => 'web',
                'parent_id' => 22,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            23 => 
            array (
                'id' => 24,
                'name' => 'rider add',
                'guard_name' => 'web',
                'parent_id' => 22,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            24 => 
            array (
                'id' => 25,
                'name' => 'rider edit',
                'guard_name' => 'web',
                'parent_id' => 22,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            25 => 
            array (
                'id' => 26,
                'name' => 'rider delete',
                'guard_name' => 'web',
                'parent_id' => 22,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            26 => 
            array (
                'id' => 27,
                'name' => 'riderequest',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            27 => 
            array (
                'id' => 28,
                'name' => 'riderequest list',
                'guard_name' => 'web',
                'parent_id' => 27,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            28 => 
            array (
                'id' => 29,
                'name' => 'riderequest show',
                'guard_name' => 'web',
                'parent_id' => 27,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            29 => 
            array (
                'id' => 30,
                'name' => 'riderequest delete',
                'guard_name' => 'web',
                'parent_id' => 27,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            30 => 
            array (
                'id' => 31,
                'name' => 'pending driver',
                'guard_name' => 'web',
                'parent_id' => 17,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            31 => 
            array (
                'id' => 32,
                'name' => 'document',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            32 => 
            array (
                'id' => 33,
                'name' => 'document list',
                'guard_name' => 'web',
                'parent_id' => 32,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            33 => 
            array (
                'id' => 34,
                'name' => 'document add',
                'guard_name' => 'web',
                'parent_id' => 32,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            34 => 
            array (
                'id' => 35,
                'name' => 'document edit',
                'guard_name' => 'web',
                'parent_id' => 32,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            35 => 
            array (
                'id' => 36,
                'name' => 'document delete',
                'guard_name' => 'web',
                'parent_id' => 32,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            36 => 
            array (
                'id' => 37,
                'name' => 'driverdocument',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            37 => 
            array (
                'id' => 38,
                'name' => 'driverdocument list',
                'guard_name' => 'web',
                'parent_id' => 37,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            38 => 
            array (
                'id' => 39,
                'name' => 'driverdocument add',
                'guard_name' => 'web',
                'parent_id' => 37,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            39 => 
            array (
                'id' => 40,
                'name' => 'driverdocument edit',
                'guard_name' => 'web',
                'parent_id' => 37,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            40 => 
            array (
                'id' => 41,
                'name' => 'driverdocument delete',
                'guard_name' => 'web',
                'parent_id' => 37,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            41 => 
            array (
                'id' => 42,
                'name' => 'coupon',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            42 => 
            array (
                'id' => 43,
                'name' => 'coupon list',
                'guard_name' => 'web',
                'parent_id' => 42,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            43 => 
            array (
                'id' => 44,
                'name' => 'coupon add',
                'guard_name' => 'web',
                'parent_id' => 42,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            44 => 
            array (
                'id' => 45,
                'name' => 'coupon edit',
                'guard_name' => 'web',
                'parent_id' => 42,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            45 => 
            array (
                'id' => 46,
                'name' => 'coupon delete',
                'guard_name' => 'web',
                'parent_id' => 42,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            46 => 
            array (
                'id' => 47,
                'name' => 'additionalfees',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            47 => 
            array (
                'id' => 48,
                'name' => 'additionalfees list',
                'guard_name' => 'web',
                'parent_id' => 47,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            48 => 
            array (
                'id' => 49,
                'name' => 'additionalfees add',
                'guard_name' => 'web',
                'parent_id' => 47,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            49 => 
            array (
                'id' => 50,
                'name' => 'additionalfees edit',
                'guard_name' => 'web',
                'parent_id' => 47,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            50 => 
            array (
                'id' => 51,
                'name' => 'additionalfees delete',
                'guard_name' => 'web',
                'parent_id' => 47,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            51 => 
            array (
                'id' => 52,
                'name' => 'sos',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            52 => 
            array (
                'id' => 53,
                'name' => 'sos list',
                'guard_name' => 'web',
                'parent_id' => 52,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            53 => 
            array (
                'id' => 54,
                'name' => 'sos add',
                'guard_name' => 'web',
                'parent_id' => 52,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            54 => 
            array (
                'id' => 55,
                'name' => 'sos edit',
                'guard_name' => 'web',
                'parent_id' => 52,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            55 => 
            array (
                'id' => 56,
                'name' => 'sos delete',
                'guard_name' => 'web',
                'parent_id' => 52,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            56 => 
            array (
                'id' => 57,
                'name' => 'complaint',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            57 => 
            array (
                'id' => 58,
                'name' => 'complaint list',
                'guard_name' => 'web',
                'parent_id' => 57,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            58 => 
            array (
                'id' => 59,
                'name' => 'complaint add',
                'guard_name' => 'web',
                'parent_id' => 57,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            59 => 
            array (
                'id' => 60,
                'name' => 'complaint edit',
                'guard_name' => 'web',
                'parent_id' => 57,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            60 => 
            array (
                'id' => 61,
                'name' => 'complaint delete',
                'guard_name' => 'web',
                'parent_id' => 57,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            61 => 
            array (
                'id' => 62,
                'name' => 'pages',
                'guard_name' => 'web',
                'parent_id' => NULL,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            62 => 
            array (
                'id' => 63,
                'name' => 'terms condition',
                'guard_name' => 'web',
                'parent_id' => 62,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
            63 => 
            array (
                'id' => 64,
                'name' => 'privacy policy',
                'guard_name' => 'web',
                'parent_id' => 62,
                'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
                'updated_at' => NULL,
            ),
        ));
    }
}