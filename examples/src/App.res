@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  <React.Fragment>
    <nav className="flex flex-row gap-4 items-center bg-white mb-4 shadow p-4">
      <a href="/" className="text-blue-500 underline"> {"Basic"->React.string} </a>
      <a href="/pagination" className="text-blue-500 underline"> {"Pagination"->React.string} </a>
    </nav>
    {switch url.path {
    | list{} => <Basic />
    | list{"pagination"} => <Pagination />
    | _ => <p> {"Page not found"->React.string} </p>
    }}
  </React.Fragment>
}
