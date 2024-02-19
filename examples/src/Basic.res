open ReactTable

type person = {
  firstName: string,
  age: int,
  lastName: string,
  visits: int,
  status: string,
  progress: int,
}

let defaultData: array<person> = [
  {
    firstName: "tanner",
    lastName: "linsley",
    age: 24,
    visits: 100,
    status: "In Relationship",
    progress: 50,
  },
  {
    firstName: "tandy",
    lastName: "miller",
    age: 40,
    visits: 40,
    status: "Single",
    progress: 80,
  },
  {
    firstName: "joe",
    lastName: "dirte",
    age: 45,
    visits: 20,
    status: "Complicated",
    progress: 10,
  },
]

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
  </div>
}
