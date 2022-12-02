<?php

namespace App\DataTables;

use App\Models\Sos;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

use App\Traits\DataTableTrait;

class SosDataTable extends DataTable
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
            ->editColumn('status', function($query) {
                $status = 'warning';
                switch ($query->status) {
                    case 1:
                        $status = 'primary';
                        $status_label =  __('message.active');
                        break;
                    case 0:
                        $status = 'danger';
                        $status_label =  __('message.inactive');
                        break;
                    default:
                        $status_label = null;
                        break;
                }
                return '<span class="text-capitalize badge bg-'.$status.'">'.$status_label.'</span>';
            })
            ->editColumn('region_id' , function ( $service ) {
                return $service->region_id != null ? optional($service->region)->name : '';
            })

            ->filterColumn('region_id', function( $query, $keyword ){
                $query->whereHas('region', function ($q) use($keyword){
                    $q->where('name', 'like' , '%'.$keyword.'%');
                });
            })
            
            ->addIndexColumn()
            ->addColumn('action', 'sos.action')
            ->rawColumns([ 'action', 'status' ]);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \App\Models\Sos $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query()
    {
        $model = Sos::mySos();
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
            Column::make('DT_RowIndex')
                ->searchable(false)
                ->title(__('message.srno'))
                ->orderable(false)
                ->width(60),
            Column::make('title')->title( __('message.title') ),
            Column::make('region_id')->title( __('message.region') ),
            Column::make('contact_number')->title( __('message.contact_number') ),
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
        return 'sos_' . date('YmdHis');
    }
}
