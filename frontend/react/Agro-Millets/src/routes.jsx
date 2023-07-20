import React from "react";

import { Icon } from "@chakra-ui/react";
import {
  MdBarChart,
  MdPerson,
  MdHome,
  MdLock,
  MdOutlineShoppingCart, MdSupervisedUserCircle,
} from "react-icons/md";
import Home from "./pages/Home/presentation/Home";

// Admin Imports
import MainDashboard from "./views/admin/default";
// import NFTMarketplace from "./views/admin/marketplace";
// import Profile from "./views/admin/profile";
// import DataTables from "./views/admin/dataTables";
import Shop from "./views/shop/presentation";
import Login from "./views/Login/signIn/index.jsx";
import Profile from "./views/profile/detail/index.jsx";
// import  from "./views/admin/rtl";

// Auth Imports
// import SignInCentered from "./views/auth/signIn";

const routes = [
  {
    name: "Shop",
    layout: "/shop",
    path: "/presentation",
    icon: (
      <Icon
        as={MdOutlineShoppingCart}
        width='20px'
        height='20px'
        color='inherit'
      />
    ),
    component: Shop,
    secondary: true,
  },
  {
    name: "Users",
    layout: "/admin",
    path: "/default",
    icon: <Icon
        as={MdSupervisedUserCircle}
        width='20px'
        height='20px'
        color='inherit'
    />,
    component: MainDashboard,
  },

  {
    name: "Profile",
    layout: "/profile",
    path: "/detail",
    icon: <Icon as={MdPerson} width='20px' height='20px' color='inherit' />,
    component: Profile,
  },
  {
    name: "Sign In",
    layout: "/login",
    path: "/signIn",
    icon: (
      <Icon as={MdLock} width='20px' height='20px' color='inherit' />
    ),
    component: Login,
    secondary: true,
  },
  // {
  //   name: "Data Tables",
  //   layout: "/admin",
  //   icon: <Icon as={MdBarChart} width='20px' height='20px' color='inherit' />,
  //   path: "/data-tables",
  //   component: DataTables,
  // },

  // {
  //   name: "Sign In",
  //   layout: "/auth",
  //   path: "/sign-in",
  //   icon: <Icon as={MdLock} width='20px' height='20px' color='inherit' />,
  //   component: SignInCentered,
  // },
  // {
  //   name: "RTL Admin",
  //   layout: "/rtl",
  //   path: "/rtl-default",
  //   icon: <Icon as={MdHome} width='20px' height='20px' color='inherit' />,
  //   component: RTL,
  // },
];

export default routes;
