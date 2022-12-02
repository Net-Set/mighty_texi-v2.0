<?php

namespace App\DataTables;

use App\Models\Region;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

use App\Traits\DataTableTrait;

class RegionDataTable extends DataTable
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

            ->addIndexColumn()
            ->addColumn('action', 'region.action')
            ->rawColumns(['action','status']);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \App\Models\Region $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query()
    {
        $model = Region::query();
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
            Column::make('name')->title( __('message.name') ),
            Column::make('distance_unit')->title( __('message.distance_unit') ),
            Column::make('timezone')->title( __('message.timezone') ),
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
        return 'Regions_' . date('YmdHis');
    }
}
