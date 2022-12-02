<?php


namespace App\Traits;

use Yajra\DataTables\Services\DataTable;

trait DataTableTrait {

    /**
     * Optional method if you want to use html builder.
     *
     * @return \Yajra\Datatables\Html\Builder
     */
    public function html()
    {
        return $this->builder()
            ->columns($this->getColumns())
            ->ajax('')
            ->parameters($this->getBuilderParameters());
    }


    public function getBuilderParameters()
    {
        return [
            'lengthMenu'   => [[10, 50, 100, 500, -1], [10, 50, 100, 500, "All"]],
            //"sDom"         =>  "<'row p-3 '<'col-md-5' l><'col-md-7 d-flex align-items-center justify-content-end' <'' B><'mr-2' f>>> <'row' <'col-md-12 table-responsive' rt>>" .
                "<'row'<'col-sm-6 d-flex' <'pt-1' ><'ml-2 mb-3' i>><'col-sm-6 text-sm-center' <'mb-3' p>>>",
            
            'sDom'          => '<"row align-items-center"<"col-md-2" l><"col-md-6" B><"col-md-4"f>><"table-responsive my-3" rt><"row align-items-center" <"col-md-6" i><"col-md-6" p>><"clear">',
            'buttons' => [
                [
                    'extend' => 'print',
                    'text' => '<i class="fa fa-print"></i> Print',
                    'className' => 'btn btn-primary btn-sm',
                ],
                [
                    'extend' => 'csv',
                    'text' => '<i class="fa fa-file"></i> CSV',
                    'className' => 'btn btn-primary btn-sm',
                ]
            ],
            'drawCallback' => "function () {
                $('.dataTables_paginate > .pagination').addClass('justify-content-end mb-0');
            }",
            'language' => [
                'search' => '',
                'searchPlaceholder' => 'Search',
            ],
            'initComplete' => "function () {
                $('#dataTableBuilder_wrapper .dt-buttons button').removeClass('btn-secondary');
                this.api().columns().every(function () {

                });
            },
            createdRow: (row, data, dataIndex, cells) => {

            }"
        ];
    }
}
