import NavBar from "@components/NavBar";
import React from "react";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { Home, Drinks, Rooms, Promos, Branches } from "@/routes";

const router = createBrowserRouter([
  {
    element: <NavBar />,
    children: [
      {
        path: "/",
        element: <Home />,
      },
      {
        path: "/drinks",
        element: <Drinks />,
      },
      {
        path: "/rooms",
        element: <Rooms />,
      },
      {
        path: "/promos",
        element: <Promos />,
      },
      {
        path: "/branches",
        element: <Branches />,
      },
    ],
  },
]);

const App = () => {
  return (
    <div>
      <RouterProvider router={router} />
    </div>
  );
};

export default App;
