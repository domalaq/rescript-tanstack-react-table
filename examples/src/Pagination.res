open ReactTable

type person = {
  firstName: string,
  age: int,
  lastName: string,
  visits: int,
  status: string,
  progress: int,
}

let defaultData: array<person> = Belt.Array.makeBy(500, i => {
  firstName: "tanner",
  lastName: "linsley",
  age: i,
  visits: 100,
  status: "In Relationship",
  progress: 50,
})

@react.component
let make = () => {
  let table = useReactTable({
    data: defaultData,
    columns: [
      Column.make(
        ~id="age",
        ~header=() => "Age"->React.string,
        ~accessorFn=test => test.age,
        ~cell={
          cell => {
            <p> {cell.getValue()->React.int} </p>
          }
        },
      ),
      Column.make(~id="firstName", ~accessorFn=test => test.firstName),
      Column.make(~id="lastName", ~accessorFn=test => test.lastName),
      Column.make(~id="visits", ~accessorFn=test => test.visits),
      Column.make(~id="status", ~accessorFn=test => test.status),
      Column.make(~id="progress", ~accessorFn=test => test.progress),
    ],
    getCoreRowModel: getCoreRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
  })

  <div className="p-2">
    <table>
      <thead>
        {table.getHeaderGroups()
        ->Array.map(headerGroup =>
          <tr key={headerGroup.id}>
            {headerGroup.headers
            ->Array.map(header =>
              <th key={header.id}>
                {header.isPlaceholder
                  ? React.null
                  : flexRender(header.column.columnDef.header, header.getContext())}
              </th>
            )
            ->React.array}
          </tr>
        )
        ->React.array}
      </thead>
      <tbody>
        {table.getRowModel().rows
        ->Array.map(row =>
          <tr key={row.id}>
            {row.getVisibleCells()
            ->Array.map(cell =>
              <td key={cell.id}> {flexRender(cell.column.columnDef.cell, cell.getContext())} </td>
            )
            ->React.array}
          </tr>
        )
        ->React.array}
      </tbody>
      <tfoot>
        {table.getFooterGroups()
        ->Array.map(footerGroup =>
          <tr key={footerGroup.id}>
            {footerGroup.headers
            ->Array.map(header =>
              <th key={header.id}>
                {header.isPlaceholder
                  ? React.null
                  : flexRender(header.column.columnDef.footer, header.getContext())}
              </th>
            )
            ->React.array}
          </tr>
        )
        ->React.array}
      </tfoot>
    </table>
    <div className="h-2" />
    <div className="flex items-center gap-2">
      <button
        className="border rounded p-1"
        onClick={_ => table.setPageIndex(0)}
        disabled={!table.getCanPreviousPage()}>
        {"<<"->React.string}
      </button>
      <button
        className="border rounded p-1"
        onClick={_ => table.previousPage()}
        disabled={!table.getCanPreviousPage()}>
        {"<"->React.string}
      </button>
      <button
        className="border rounded p-1"
        onClick={_ => table.nextPage()}
        disabled={!table.getCanNextPage()}>
        {">"->React.string}
      </button>
      <button
        className="border rounded p-1"
        onClick={_ => table.setPageIndex(table.getPageCount() - 1)}
        disabled={!table.getCanNextPage()}>
        {">>"->React.string}
      </button>
      <span className="flex items-center gap-1">
        <div> {"Page"->React.string} </div>
        <strong>
          {(table.getState().pagination.pageIndex + 1)->React.int}
          {" of"->React.string}
          {table.getPageCount()->React.int}
        </strong>
      </span>
      <span className="flex items-center gap-1">
        {"| Go to page:"->React.string}
        <input
          type_="number"
          defaultValue={(table.getState().pagination.pageIndex + 1)->Int.toString}
          onChange={e => {
            let page = (e->ReactEvent.Form.target)["value"]
              ? (e->ReactEvent.Form.target)["value"] - 1
              : 0
            table.setPageIndex(page)
          }}
          className="border p-1 rounded w-16"
        />
      </span>
      <select
        value={table.getState().pagination.pageSize->Int.toString}
        onChange={e => {
          table.setPageSize((e->ReactEvent.Form.target)["value"])
        }}>
        {[10, 20, 30, 40, 50]
        ->Array.map(pageSize =>
          <option key={pageSize->Int.toString} value={pageSize->Int.toString}>
            {`Show ${pageSize->Int.toString}`->React.string}
          </option>
        )
        ->React.array}
      </select>
    </div>
    <div>
      {table.getRowModel().rows->Array.length->React.int}
      {"Rows"->React.string}
    </div>
  </div>
}
