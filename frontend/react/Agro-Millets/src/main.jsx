import React from "react";
import { createRoot } from "react-dom";
import { BrowserRouter, Route, Link, HashRouter, Switch, Redirect } from "react-router-dom";
import Home from "./pages/Home/presentation/Home";
import Shop from "./pages/shop/presentation/Shop";
import About from "./pages/About/presentation/About";
import ItemDetail from "./pages/shop/presentation/ItemDetail";
import "@fortawesome/fontawesome-free/css/all.css";

import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import Search from "./pages/Search/presentation/Search";
import Profile from "./pages/Profile/presentation/Profile";
import CartPage from "./pages/Cart/presentation/Cart";
import appState from "./data/AppState";
import AdminLayout from "./layouts/admin";
import ShopLayout from "./layouts/shop";
import LoginLayout from "./layouts/login";
import ProfileLayout from "./layouts/profile";
import Login from "./pages/Login/presentation/Login.jsx";
import "./../src/assets/css/App.css";
import "./index.css";
import { ChakraProvider } from "@chakra-ui/react";
import theme from "./theme/theme";
import { ThemeEditorProvider } from "@hypertheme-editor/chakra-ui";
import AuthLayout from './layouts/auth';
import ReactDOM from 'react-dom';

ReactDOM.render(
  <ChakraProvider theme={theme}>
    <React.StrictMode>
      <ThemeEditorProvider>
        <HashRouter>
          <Switch>
            <Route path="/" exact component={Login}/>
            {/*<Route path="/" exact component={Login}/>*/}
            <Route path="/shop" component={ShopLayout}/>
            <Route path="/login" component={LoginLayout}/>
            <Route path="/profile" component={ProfileLayout}/>
            <Route path="/about" component={About}/>
            <Route path="/shop" component={Shop}/>
            <Route path="/item/:id" component={ItemDetail}/>
            <Route path="/search" component={Search}/>
            {/*<Route path="/profile" component={Profile}/>*/}
            {/*<Route path="/cart" component={CartPage}/>*/}
            <Route path="/admin" component={AdminLayout} />
          </Switch>
        </HashRouter>
      </ThemeEditorProvider>
    </React.StrictMode>
  </ChakraProvider>,
    document.getElementById('root')
);
