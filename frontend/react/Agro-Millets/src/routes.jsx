import React from "react";

import {Icon} from "@chakra-ui/react";
import {
    MdPerson,
    MdOutlineShoppingCart, MdSupervisedUserCircle,
} from "react-icons/md";

import MainDashboard from "./views/admin/default";
import Shop from "./views/shop/presentation";
import Profile from "./views/profile/detail/index.jsx";

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
        name: "Admin",
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
        icon: <Icon as={MdPerson} width='20px' height='20px' color='inherit'/>,
        component: Profile,
    },
];

export default routes;
