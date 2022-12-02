<?php

namespace App\DataTables;

use App\Models\Document;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

use App\Traits\DataTableTrait;

class DocumentDataTable extends DataTable
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
                return '<div class="custom-control custom-switch custom-switch-text custom-switch-color custom-control-inline">
                    <div class="custom-switch-inner">
                        <input type="checkbox" class="custom-control-input bg-primary change_status" data-type="document_status" '.($query->status ? "checked" : "").' value="'.$query->id.'" id="'.$query->id.'" data-id="'.$query->id.'">
                        <label class="custom-control-label" for="'.$query->id.'"></label>
                    </div>
                </div>';
            })
            ->editColumn('is_required', function($query) {
                return '<div class="custom-control custom-switch custom-switch-text custom-switch-color custom-control-inline">
                    <div class="custom-switch-inner">
                        <input type="checkbox" class="custom-control-input bg-primary change_status" data-type="document_required" data-name="is_required" '.($query->is_required ? "checked" : "").' value="'.$query->id.'" id="r'.$query->id.'" data-id="'.$query->id.'">
                        <label class="custom-control-label" for="r'.$query->id.'" data-on-label="'.__("message.yes").'" data-off-label="'.__("message.no").'"></label>
                    </div>
                </div>';
            })
            ->editColumn('has_expiry_date', function($query) {
                return '<div class="custom-control custom-switch custom-switch-text custom-switch-color custom-control-inline">
                    <div class="custom-switch-inner">
                        <input type="checkbox" class="custom-control-input bg-primary change_status" data-type="document_has_expiry_date" data-name="has_expiry_date" '.($query->has_expiry_date ? "checked" : "").' value="'.$query->id.'" id="e'.$query->id.'" data-id="'.$query->id.'">
                        <label class="custom-control-label" for="e'.$query->id.'" data-on-label="'.__("message.yes").'" data-off-label="'.__("message.no").'"></label>
                    </div>
                </div>';
            })
            ->addIndexColumn()
            ->addColumn('action', 'document.action')
            ->rawColumns([ 'action', 'status', 'is_required', 'has_expiry_date' ]);
    }

    /**
     * Get query source of dataTable.
     *
     * @param \App\Models\Document $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query()
    {
        $model = Document::query();
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
            Column::make('is_required')->title( __('message.is_required') ),
            Column::make('has_expiry_date')->title( __('message.has_expiry_date') ),
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
        return 'Documents_' . date('YmdHis');
    }
}
