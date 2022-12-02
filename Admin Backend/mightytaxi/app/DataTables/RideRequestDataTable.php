<?php

namespace App\DataTables;

use App\Models\RideRequest;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

use App\Traits\DataTableTrait;

class RideRequestDataTable extends DataTable
{
    use DataTableTrait;
    /**
     * Build DataTable class.
     *
     * @param mixed $query Results from query() method.
     * @return \Yajra\DataTables\DataTableAbstract
     */
    public function dataTable($query)
    {
        return datatables()
            ->eloquent($query)
            
            ->editColumn('driver_id' , function ( $riderequest ) {
                return $riderequest->driver_id != null ? optional($riderequest->driver)->display_name : '';
            })

            ->filterColumn('driver_id', function( $query, $keyword ){
                $query->whereHas('driver', function ($q) use($keyword){
                    $q->where('display_name', 'like' , '%'.$keyword.'%');
                });
            })

            ->editColumn('rider_id' , function ( $riderequest ) {
                return $riderequest->rider_id != null ? optional($riderequest->rider)->display_name : '';
            })

            ->editColumn('payment_status', function ( $riderequest ) {
                return isset($riderequest->payment) ? __('message.'.$riderequest->payment->payment_status) : __('message.pending');
            })

            ->editColumn('payment_type', function($riderequest) {
                return isset($riderequest->payment_type) ? __('message.'.$riderequest->payment_type) : __('message.cash');
            })

            ->editColumn('payment_status', function($riderequest) {
                
                $status = 'warning';
                $payment_status = isset($riderequest->payment) ? $riderequest->payment->payment_status : __('message.pending');
                
                switch ($payment_status) {
                    case 'pending':
                        $status = 'warning';
                        break;
                    case 'failed':
                        $status = 'danger';
                        break;
                    case 'paid':
                        $status = 'success';
                        break;
                }
                return '<span class="text-capitalize badge bg-'.$status.'">'.$payment_status.'</span>';
            })
            
            ->filterColumn('payment_status', function( $query, $keyword ){
                $query->whereHas('payment', function ($q) use($keyword){
                    $q->where('payment_status', 'like' , '%'.$keyword.'%');
                });
            })

            ->filterColumn('rider_id', function( $query, $keyword ){
                $query->whereHas('rider', function ($q) use($keyword){
                    $q->where('display_name', 'like' , '%'.$keyword.'%');
                });
            })

            ->editColumn('status', function($query) {
                return __('message.'.$query->status);
            })

            ->editColumn('status', function($riderequest) {
                
                $status = 'primary';
                $ride_status = $riderequest->status;
                
                switch ($ride_status) {
                    case 'pending':
                        $status = 'warning';
                        break;
                    case 'canceled':
                        $status = 'danger';
                        break;
                    case 'completed':
                        $status = 'success';
                        break;
                    default:
                        // $ride_status = '-';
                        break;
                }
                return '<span class=" badge bg-'.$status.'">'.__('message.'.$riderequest->status).'</span>';
            })

            ->addIndexColumn()
            ->addColumn('action', 'riderequest.action')
            ->rawColumns([ 'action', 'status', 'payment_status' ]);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \App\Models\RideRequest $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query()
    {
        $model = RideRequest::myRide()->orderBy('id','desc');
        return $this->applyScopes($model);
    }

    /**
     * Get columns.
     *
     * @return array
     */
    protected function getColumns()
    {
        return [
            // Column::make('DT_RowIndex')
            //     ->searchable(false)
            //     ->title(__('message.srno'))
            //     ->orderable(false)
            //     ->width(60),
            Column::make('id')->title( '#' ),
            Column::make('rider_id')->title( __('message.rider') ),
            Column::make('driver_id')->title( __('message.driver') ),
            Column::make('datetime')->title( __('message.datetime') ),
            // Column::make('total_amount')->title( __('message.total_amount') ),
            Column::make('payment_type')->title( __('message.payment_method') ),
            Column::make('payment_status')->title( __('message.payment') ),
            Column::make('status')->title( __('message.status') ),
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
        return 'RideRequests_' . date('YmdHis');
    }
}
