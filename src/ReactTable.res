type coreRowModel
type filteredRowModel
type paginationRowModel

@module("@tanstack/react-table")
external getCoreRowModel: unit => coreRowModel = "getCoreRowModel"
@module("@tanstack/react-table")
external getFilteredRowModel: unit => filteredRowModel = "getFilteredRowModel"
@module("@tanstack/react-table")
external getPaginationRowModel: unit => paginationRowModel = "getPaginationRowModel"

type cell<'value> = {getValue: unit => 'value}

module Column = {
  type t<'tableData>

  @obj
  external make: (
    ~header: unit => React.element=?,
    ~footer: unit => React.element=?,
    ~cell: cell<'columnData> => React.element=?,
    ~id: string,
    ~accessorFn: 'tableData => 'columnData,
  ) => t<'tableData> = ""
}

type tableOptions<'tableData> = {
  data: array<'tableData>,
  columns: array<Column.t<'tableData>>,
  getCoreRowModel: coreRowModel,
  getFilteredRowModel?: filteredRowModel,
  getPaginationRowModel?: paginationRowModel,
}

module ColumnDef = {
  type t
}

type columnDef = {
  header: ColumnDef.t,
  cell: ColumnDef.t,
  footer: ColumnDef.t,
}

type groupContext

type rec rowModel = {rows: array<row>}
and row = {
  getVisibleCells: unit => array<rowModelCell>,
  id: string,
}
and rowModelCell = {
  id: string,
  isPlaceholder: bool,
  column: cellColumn,
  getContext: unit => groupContext,
}
and cellColumn = {columnDef: columnDef}

type rec headerGroup = {headers: array<header>, id: string}
and header = {
  isPlaceholder: bool,
  column: headerColumn,
  getContext: unit => groupContext,
  id: string,
}
and headerColumn = {columnDef: columnDef}

type rec tableState = {pagination: pagination}
and pagination = {pageIndex: int, pageSize: int}

type tableInstance = {
  getHeaderGroups: unit => array<headerGroup>,
  getRowModel: unit => rowModel,
  getFooterGroups: unit => array<headerGroup>,
  getPageCount: unit => int,
  getCanPreviousPage: unit => bool,
  getCanNextPage: unit => bool,
  setPageIndex: int => unit,
  setPageSize: int => unit,
  previousPage: unit => unit,
  nextPage: unit => unit,
  getState: unit => tableState,
}

@module("@tanstack/react-table")
external useReactTable: tableOptions<'data> => tableInstance = "useReactTable"

@module("@tanstack/react-table")
external flexRender: (ColumnDef.t, groupContext) => React.element = "flexRender"
