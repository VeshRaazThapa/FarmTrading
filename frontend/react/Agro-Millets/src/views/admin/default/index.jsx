/*!
  _   _  ___  ____  ___ ________  _   _   _   _ ___   
 | | | |/ _ \|  _ \|_ _|__  / _ \| \ | | | | | |_ _| 
 | |_| | | | | |_) || |  / / | | |  \| | | | | || | 
 |  _  | |_| |  _ < | | / /| |_| | |\  | | |_| || |
 |_| |_|\___/|_| \_\___/____\___/|_| \_|  \___/|___|
                                                                                                                                                                                                                                                                                                                                       
=========================================================
* Horizon UI - v1.1.0
=========================================================

* Product Page: https://www.horizon-ui.com/
* Copyright 2023 Horizon UI (https://www.horizon-ui.com/)

* Designed and Coded by Simmmple

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*/

// Chakra imports
import {
  Avatar,
  Box,
  Flex,
  FormLabel,
  Icon,
  Select,
  SimpleGrid,
  useColorModeValue,
} from "@chakra-ui/react";
// Assets
import Usa from "../../../assets/img/dashboards/usa.png";
// Custom components
// import MiniCalendar from "../../../components/calendar/MiniCalendar";
import MiniStatistics from "../../../components/card/MiniStatistics";
import IconBox from "../../../components/icons/IconBox";
import React, {useEffect} from "react";
import {
    MdAddTask,
    MdAttachMoney,
    MdBarChart, MdBroadcastOnPersonal, MdCategory,
    MdFileCopy, MdOutlinePersonOutline, MdOutlineStayPrimaryLandscape, MdPersonOutline, MdProductionQuantityLimits,
} from "react-icons/md";
import CheckTable from "../../../views/admin/default/components/CheckTable";
import {
  columnsDataCheck,
  columnsDataComplex,
} from "./variables/columnsData.jsx";
import tableDataCheck from "../../../views/admin/default/variables/tableDataCheck.json";
// import tableDataComplex from "../../../views/admin/default/variables/tableDataComplex.json";
import appState from "../../../data/AppState.js";
import {toast} from "react-toastify";

export default function UserReports() {
  // Chakra Color Mode
  const brandColor = useColorModeValue("brand.500", "white");
  const boxBg = useColorModeValue("secondaryGray.300", "whiteAlpha.100");
  useEffect(() => {
    if (!appState.isUserLoggedIn()) {
      history.push("/");
      toast("Your are not Logged in " );
    }
  }, []);
  return (
    <Box pt={{ base: "130px", md: "80px", xl: "80px" }}>
      <SimpleGrid
        columns={{ base: 1, md: 2, lg: 3, "2xl": 6 }}
        gap='20px'
        mb='20px'>
        <MiniStatistics
          startContent={
            <IconBox
              w='56px'
              h='56px'
              bg={boxBg}
              icon={
                <Icon w='32px' h='32px' as={MdBarChart} color={brandColor} />
              }
            />
          }
          name='Total Users'
          value='4'
        />
        <MiniStatistics
          startContent={
            <IconBox
              w='56px'
              h='56px'
              bg={boxBg}
              icon={
                <Icon w='32px' h='32px' as={MdCategory} color={brandColor} />
              }
            />
          }
          name='Total Products'
          value='10'
        />
        <MiniStatistics name='Total Farmers' startContent={
            <IconBox
              w='56px'
              h='56px'
              bg={boxBg}
              icon={
                <Icon w='32px' h='32px' as={MdPersonOutline} color={brandColor} />
              }
            />
          }  value='3' />
        {/*<MiniStatistics*/}
        {/*  endContent={*/}
        {/*    <Flex me='-16px' mt='10px'>*/}
        {/*      <FormLabel htmlFor='balance'>*/}
        {/*        <Avatar src={Usa} />*/}
        {/*      </FormLabel>*/}
        {/*      <Select*/}
        {/*        id='balance'*/}
        {/*        variant='mini'*/}
        {/*        mt='5px'*/}
        {/*        me='0px'*/}
        {/*        defaultValue='usd'>*/}
        {/*        <option value='usd'>USD</option>*/}
        {/*        <option value='eur'>EUR</option>*/}
        {/*        <option value='gba'>GBA</option>*/}
        {/*      </Select>*/}
        {/*    </Flex>*/}
        {/*  }*/}
        {/*  name='Your balance'*/}
        {/*  value='$1,000'*/}
        {/*/>*/}
        {/*<MiniStatistics*/}
        {/*  startContent={*/}
        {/*    <IconBox*/}
        {/*      w='56px'*/}
        {/*      h='56px'*/}
        {/*      bg='linear-gradient(90deg, #4481EB 0%, #04BEFE 100%)'*/}
        {/*      icon={<Icon w='28px' h='28px' as={MdAddTask} color='white' />}*/}
        {/*    />*/}
        {/*  }*/}
        {/*  name='New Tasks'*/}
        {/*  value='154'*/}
        {/*/>*/}
        {/*<MiniStatistics*/}
        {/*  startContent={*/}
        {/*    <IconBox*/}
        {/*      w='56px'*/}
        {/*      h='56px'*/}
        {/*      bg={boxBg}*/}
        {/*      icon={*/}
        {/*        <Icon w='32px' h='32px' as={MdFileCopy} color={brandColor} />*/}
        {/*      }*/}
        {/*    />*/}
        {/*  }*/}
        {/*  name='Total Projects'*/}
        {/*  value='2935'*/}
        {/*/>*/}
      </SimpleGrid>

      {/*<SimpleGrid columns={{ base: 1, md: 2, xl: 2 }} gap='20px' mb='20px'>*/}
      {/*  <TotalSpent />*/}
      {/*  <WeeklyRevenue />*/}
      {/*</SimpleGrid>*/}
        <CheckTable columnsData={columnsDataCheck} tableData={tableDataCheck} />

      <SimpleGrid columns={{ base: 1, md: 1, xl: 2 }} gap='20px' mb='20px'>
        {/*<SimpleGrid columns={{ base: 1, md: 2, xl: 2 }} gap='20px'>*/}
        {/*  <DailyTraffic />*/}
        {/*  <PieCard />*/}
        {/*</SimpleGrid>*/}
      </SimpleGrid>
      {/*<SimpleGrid columns={{ base: 1, md: 1, xl: 2 }} gap='20px' mb='20px'>*/}
      {/*  <ComplexTable*/}
      {/*    columnsData={columnsDataComplex}*/}
      {/*    tableData={tableDataComplex}*/}
      {/*  />*/}
      {/*  <SimpleGrid columns={{ base: 1, md: 2, xl: 2 }} gap='20px'>*/}
      {/*    <Tasks />*/}
      {/*    <MiniCalendar h='100%' minW='100%' selectRange={false} />*/}
      {/*  </SimpleGrid>*/}
      {/*</SimpleGrid>*/}
    </Box>
  );
}
