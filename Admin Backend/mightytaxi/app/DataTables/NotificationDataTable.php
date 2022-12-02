<?php

namespace App\DataTables;

use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

use App\Traits\DataTableTrait;

class NotificationDataTable extends DataTable
{
    use DataTableTrait;
    /**
     * Build DataTable class.
     *
     * @param mixed $query Results from query() method.
     * @return \Yajra\DataTables\DataTableAbstract
     */
    public function dataTable()
    {
        return datatables( $this->query() )
            ->addColumn('action', function($row){
                return '<a href="'.route('riderequest.show', $row->data['id']) .'"><span class="badge bg-info mr-2">'.__('message.view').'</span></a>';
            })
            
            ->addColumn('message', function ($row) {
                return $row->data['message'];
            })
            
            ->editColumn('created_at', function ($row) {
                return dateAgoFormate($row->created_at, true);
            })
            
            ->editColumn('updated_at', function ($row) {
                return dateAgoFormate($row->updated_at, true);
            })

            ->addIndexColumn()
            ->rawColumns(['action']);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \App\Models\Notification $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query()
    {
        $userdata = auth()->user();
        $notifications = $userdata->notifications;

        return $this->applyScopes($notifications);
    }

    /**
     * Get columns.
     *
     * @return array
     */
    protected function getColumns()
    {
        return [
            Column::make('DT_RowIndex')
                ->searchable(false)
                ->title(__('message.srno'))
                ->orderable(false)
                ->width(60),
            Column::make('message')->title( __('message.message') ),
            Column::make('created_at')->title( __('message.created_at') ),
            Column::make('updated_at')->title( __('message.updated_at') ),
            Column::computed('action')
                  ->exportable(false)
                  ->printable(false)
                  ->width(60)
                  ->addClass('text-center'),
        ];
    }

    /**
     * Get filename for export.
     *
     * @return string
     */
    protected function filename()
    {
        return 'Notifications_' . date('YmdHis');
    }
}
