type coreRowModel
type filteredRowModel
type paginationRowModel

@module("@tanstack/react-table")
external getCoreRowModel: unit => coreRowModel = "getCoreRowModel"
@module("@tanstack/react-table")
external getFilteredRowModel: unit => filteredRowModel = "getFilteredRowModel"
@module("@tanstack/react-table")
external getPaginationRowModel: unit => paginationRowModel = "getPaginationRowModel"

type paginationState = {
  pageIndex: int,
  pageSize: int,
}

type rowSelectionState = Js.Dict.t<bool>

type tableState = {pagination: paginationState, rowSelection: rowSelectionState}
type tableInitialState = {pagination?: paginationState, rowSelection?: rowSelectionState}

module ColumnDef = {
  type t
}

type columnDef = {
  header: ColumnDef.t,
  cell: ColumnDef.t,
  footer: ColumnDef.t,
}

module Column = {
  type t<'tableData>

  type tableOptions = {
    getIsAllRowsSelected: unit => bool,
    getIsSomeRowsSelected: unit => bool,
    getToggleAllRowsSelectedHandler: unit => ReactEvent.Form.t => unit,
  }

  type header = {table: tableOptions}

  type rowOptions = {
    getIsSelected: unit => bool,
    getCanSelect: unit => bool,
    getIsSomeSelected: unit => bool,
    getToggleSelectedHandler: unit => ReactEvent.Form.t => unit,
  }

  type cellOptions<'value> = {
    getValue: unit => 'value,
    row: rowOptions,
  }

  @obj
  external make: (
    ~header: header => React.element=?,
    ~footer: unit => React.element=?,
    ~cell: cellOptions<'columnData> => React.element=?,
    ~id: string,
    ~accessorFn: 'tableData => 'columnData=?,
    ~columns: array<t<'tableData>>=?,
  ) => t<'tableData> = ""
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
  getIsSorted: unit => bool,
  getCanFilter: unit => bool,
  getCanSort: unit => bool,
  getToggleSortingHandler: unit => unit,
  id: string,
}
and headerColumn = {columnDef: columnDef}

type rec tableInstance<'tableData> = {
  getHeaderGroups: unit => array<headerGroup>,
  getRowModel: unit => rowModel,
  getFooterGroups: unit => array<headerGroup>,
  getPageCount: unit => int,
  getCanPreviousPage: unit => bool,
  getCanNextPage: unit => bool,
  getIsAllRowsSelected: unit => bool,
  getIsSomeRowsSelected: unit => bool,
  getToggleAllRowsSelectedHandler: unit => ReactEvent.Form.t => unit,
  setPageIndex: int => unit,
  setPageSize: int => unit,
  previousPage: unit => unit,
  nextPage: unit => unit,
  getState: unit => tableState,
  setOptions: (tableOptions<'tableData> => tableOptions<'tableData>) => unit,
}
and tableOptions<'tableData> = {
  data: array<'tableData>,
  columns: array<Column.t<'tableData>>,
  getCoreRowModel: coreRowModel,
  getFilteredRowModel?: filteredRowModel,
  getPaginationRowModel?: paginationRowModel,
  onPaginationChange?: (paginationState => paginationState) => paginationState,
  onRowSelectionChange?: (rowSelectionState => rowSelectionState) => unit,
  pageCount?: int,
  state?: tableInitialState,
  manualPagination?: bool,
  enableRowSelection?: bool,
  enableMultiRowSelection?: bool,
  debugTable?: bool,
}

@module("@tanstack/react-table")
external useReactTable: tableOptions<'tableData> => tableInstance<'tableData> = "useReactTable"

@module("@tanstack/react-table")
external flexRender: (ColumnDef.t, groupContext) => React.element = "flexRender"
