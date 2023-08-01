import React from "react";

import {Icon} from "@chakra-ui/react";
import {
    MdPerson,
     MdApps, MdAdd,
} from "react-icons/md";

import MainDashboard from "./pages/admin/default";
import Shop from "./pages/shop/presentation";
import Profile from "./pages/profile/detail/index.jsx";

const routes = [
    {
        name: "Product",
        layout: "/shop",
        path: "/presentation",
        icon: (
            <Icon
                as={MdAdd}
                width='20px'
                height='20px'
                color='inherit'
            />
        ),
        component: Shop,
        secondary: true,
    },
    {
        name: "App Details",
        layout: "/admin",
        path: "/default",
        icon: <Icon
            as={MdApps}
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
        icon: <Icon as={MdPerson} width='20px' height='20px' color='inherit'/>,
        component: Profile,
    },
];

export default routes;
