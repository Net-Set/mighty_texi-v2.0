<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataTables\NotificationDataTable;
use App\Models\Notification;
class NotificationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(NotificationDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.notification')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = '';
        return $dataTable->render('global.datatable', compact('assets','pageTitle','button','auth_user'));
    }

    public function notificationList(Request $request)
    {
        $user = auth()->user();

        $user->last_notification_seen = now();
        $user->save();

        $type= $request->type;
        if($type == 'markas_read')
        {
            if(count($user->unreadNotifications) > 0 ) {
                $user->unreadNotifications->markAsRead();
            }
        }
        $notifications = $user->notifications->take(5);
        $all_unread_count = isset($user->unreadNotifications) ? $user->unreadNotifications->count() : 0;
        $response = [
            'status'     => true,
            'data'       => view('notification.list', compact('notifications', 'all_unread_count','user'))->render()
        ];

        return json_custom_response($response);
    }

    public function notificationCounts(Request $request)
    {
        $user = auth()->user();

        $unread_count = 0;
        $unread_total_count = 0;

        if(isset($user->unreadNotifications)){
            $unread_count = $user->unreadNotifications->where('created_at', '>', $user->last_notification_seen)->count() ;
            $unread_total_count = $user->unreadNotifications->count();
        }
        $response = [
            'status'            => true,
            'counts'            => $unread_count,
            'unread_total_count'=> $unread_total_count
        ];

        return json_custom_response($response);
    }
}