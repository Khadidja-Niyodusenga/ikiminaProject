-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 24, 2024 at 03:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ikimina_iprckarongi`
--

-- --------------------------------------------------------

--
-- Table structure for table `contribution`
--

CREATE TABLE `contribution` (
  `contri_id` int(3) NOT NULL,
  `mid` int(3) NOT NULL,
  `contribution_date` date NOT NULL,
  `amount` varchar(40) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contribution`
--

INSERT INTO `contribution` (`contri_id`, `mid`, `contribution_date`, `amount`, `status`) VALUES
(3, 8, '2024-08-02', '5000.0', 'Pending'),
(4, 26, '2024-08-02', '30000.0', 'Cancelled'),
(5, 7, '2024-08-10', '700.0', 'Cancelled'),
(6, 7, '2024-08-06', '900.0', 'pending'),
(7, 7, '2024-08-25', '780.0', 'pending'),
(8, 7, '2024-08-23', '0.0', 'Completed'),
(9, 7, '2024-08-08', '800.0', 'pending'),
(10, 7, '2024-08-03', '9.0', 'pending'),
(11, 7, '2024-08-27', '1.0', 'pending'),
(12, 12, '2024-08-29', '60.0', 'pending'),
(13, 12, '2024-08-21', '800.0', 'pending'),
(14, 12, '2024-08-22', '300.0', 'pending'),
(15, 12, '2024-08-07', '6.0', 'pending'),
(16, 9, '2024-08-19', '300.0', 'pending'),
(17, 17, '2024-08-11', '10.0', 'pending'),
(18, 17, '2024-08-11', '12.0', 'pending'),
(19, 17, '2024-08-04', '450.0', 'pending'),
(20, 20, '2024-08-25', '123.0', 'pending'),
(21, 20, '2024-09-04', '2.0', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_id` int(3) NOT NULL,
  `mid` int(3) NOT NULL,
  `loan_amount` double NOT NULL,
  `interest` double NOT NULL,
  `request_loan_date` date NOT NULL,
  `loan_status` varchar(50) NOT NULL,
  `reason_for_loan` varchar(50) NOT NULL,
  `approval` varchar(50) NOT NULL,
  `payment_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_id`, `mid`, `loan_amount`, `interest`, `request_loan_date`, `loan_status`, `reason_for_loan`, `approval`, `payment_date`) VALUES
(1, 7, 12000, 400, '2024-08-18', 'pending', 'jgj', 'Approved', '2024-08-25'),
(2, 7, 120, 89, '2024-08-11', 'pending', 'hjgj', 'Approved', '2024-08-18'),
(3, 9, 120, 89, '2024-08-25', 'pending', 'jkgfhdjk', 'Approved', '2024-08-31'),
(4, 9, 12000, 500, '2024-08-08', 'pending', 'tdfghj', 'Approved', '2024-08-30'),
(5, 7, 12000, 500, '2024-08-11', 'pending', 'hyfghjk', 'Approved', '2024-08-25'),
(6, 9, 2000, 78, '2024-08-11', 'pending', 'fghj', 'Approved', '2024-08-31'),
(7, 9, 2000, 78, '2024-08-10', 'pending', 'fghjk', 'Approved', '2024-08-31'),
(8, 26, 12000, 43, '2024-08-11', 'pending', 'rfdsa', 'Approved', '2024-08-23');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `mid` int(3) NOT NULL,
  `rmid` int(3) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `approved_date` date NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(200) NOT NULL,
  `position` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`mid`, `rmid`, `firstname`, `lastname`, `email`, `phone`, `approved_date`, `username`, `password`, `position`) VALUES
(2, 10, 'mwebaze', 'ivan', 'ivan@gmail.com', '0789654322', '2024-07-02', 'ab', '12', ''),
(6, 6, 'azidha', 'niyonkuru', 'niyokhad@gmail.com', '0780131456', '2024-08-08', 'ziada', '12345', 'member'),
(7, 5, 'azidha', 'niyonkuru', 'niyokhad@gmail.com', '0780131456', '2024-08-22', 'ziada', 'ziada', 'member'),
(9, 7, 'nzayiramya', 'eric', 'jenniferishimwe03@gmail.com', '0780131489', '2024-08-21', 'eric', 'eric', 'president'),
(12, 9, 'tuyizere', 'sumaire', 'jenniferishimwe03@gmail.com', '0780131482', '2024-08-07', 'big boss', 'boss', 'normal staff'),
(17, 8, 'tuyizere', 'sumaire', 'jenniferishimwe03@gmail.com', '0780131482', '2024-08-19', 'sumaire', '456', 'credit commit'),
(20, 11, 'Niyodusenga', 'Khadidja', 'jenniferishimwe03@gmail.com', '0780131993', '2024-08-15', 'gh', 'gh', 'vice president'),
(21, 12, 'nzayiramya', 'eric', 'jenniferishimwe03@gmail.com', '0780131489', '2024-08-08', 'fg', 'fg', 'member'),
(23, 14, 'Niyodusenga', 'Khadidja', 'niyokhad@gmail.com', '0780131993', '2024-08-08', 'dfgh', 'hbkjb', 'member'),
(25, 16, 'niyomugenga', 'princess', 'hasleyprincess1@gmail.com', '0780131234', '2024-08-17', 'nina', '123', 'staff'),
(26, 2, 'Niyodusenga', 'Khadidja', 'mizeroit860@gmail.com', '0780131993', '2024-08-02', 'niha', '123', 'admin'),
(27, 3, 'mwebaze', 'ivan', 'mwebazeivan01@gmail.com', '0780131489', '2024-08-23', 'ivan', '123', 'accountant'),
(28, 1, 'Niyodusenga', 'Khadidja', 'mizeroit860@gmail.com', '0780131993', '2024-09-05', 'khad', 'khad', 'normal staff'),
(29, 1, 'Niyodusenga', 'Khadidja', 'mizeroit860@gmail.com', '0780131993', '2024-08-25', 'gfd', 'gfds', 'credit commit'),
(30, 1, 'Niyodusenga', 'Khadidja', 'mizeroit860@gmail.com', '0780131993', '2024-08-25', 'fdgvdf', 'xcsd', 'vice president');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(3) NOT NULL,
  `loan_id` int(3) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_amount` double NOT NULL,
  `payment_frequency` varchar(30) NOT NULL,
  `remain_loan` varchar(50) NOT NULL,
  `payment_date` date NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `profit`
--

CREATE TABLE `profit` (
  `profit_id` int(3) NOT NULL,
  `mid` int(3) NOT NULL,
  `balance` double NOT NULL,
  `profit` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_membership`
--

CREATE TABLE `request_membership` (
  `rmid` int(3) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `request_date` date NOT NULL,
  `reason_to_join` varchar(50) NOT NULL,
  `status` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request_membership`
--

INSERT INTO `request_membership` (`rmid`, `firstname`, `lastname`, `email`, `phone`, `request_date`, `reason_to_join`, `status`) VALUES
(1, 'Niyodusenga', 'Khadidja', 'mizeroit860@gmail.com', '0780131993', '2024-08-20', 'to be membership', 'approved'),
(2, 'Niyodusenga', 'Khadidja', 'mizeroit860@gmail.com', '0780131993', '2024-08-20', 'to be membership', 'approved'),
(3, 'mwebaze', 'ivan', 'mwebazeivan01@gmail.com', '0780131489', '2024-08-21', 'just for becoming member.', 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(3) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `position` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `firstname`, `lastname`, `email`, `phone`, `position`, `status`, `created_at`) VALUES
(0, 'd', ' w', 'w', ' w', ' m', ' w', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw`
--

CREATE TABLE `withdraw` (
  `rwid` int(3) NOT NULL,
  `mid` int(3) NOT NULL,
  `request_date` date NOT NULL,
  `amount_requested` varchar(40) NOT NULL,
  `reason_to_withdraw` varchar(50) NOT NULL,
  `withdraw_method` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdraw`
--

INSERT INTO `withdraw` (`rwid`, `mid`, `request_date`, `amount_requested`, `reason_to_withdraw`, `withdraw_method`, `status`) VALUES
(1, 7, '2024-08-01', '8.0', 'weeeeeeeee', 'v123', 'Rejected'),
(2, 7, '2024-09-04', '100.0', 'wrwrw', 'code', 'approved'),
(3, 7, '2024-09-03', '100.0', 'sgcjhs', 'smhb', 'approved'),
(4, 7, '2024-09-03', '100.0', 'sgcjhs', 'smhb', 'approved'),
(5, 12, '2024-08-21', '900.0', 'i need my money back', 'bank', 'pending'),
(6, 12, '2024-08-23', '350.0', 'hello', 'bank', 'pending'),
(7, 12, '2024-09-08', '450.0', 'dhgkdjf', 'kdjbf', 'pending'),
(8, 12, '2024-08-30', '200.0', 'skjfhck', 'jsh', 'pending'),
(9, 14, '2024-08-21', '40.0', 'jksfbjesb', 'hsafdkjs', 'pending'),
(10, 6, '2024-08-17', '32.0', 'ksdfhks', 'shfc', 'approved'),
(11, 12, '2024-08-16', '89.0', 'gjh', 'gjh', 'pending'),
(12, 9, '2024-08-16', '100.0', 'jkfgkj', 'kfhkj', 'pending'),
(13, 9, '2024-08-18', '100.0', 'jhjk', 'khk', 'pending'),
(14, 9, '2024-09-01', '70.0', 'jkgkj', 'code', 'pending'),
(15, 17, '2024-08-18', '678.0', ',knl', 'klj', 'pending'),
(16, 17, '2024-08-22', '100.0', 'dsgfdsh', 'dfdgg', 'pending'),
(17, 20, '2024-08-25', '57.0', 'ghjjk', 'hj', 'pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contribution`
--
ALTER TABLE `contribution`
  ADD PRIMARY KEY (`contri_id`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`mid`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `profit`
--
ALTER TABLE `profit`
  ADD PRIMARY KEY (`profit_id`);

--
-- Indexes for table `request_membership`
--
ALTER TABLE `request_membership`
  ADD PRIMARY KEY (`rmid`);

--
-- Indexes for table `withdraw`
--
ALTER TABLE `withdraw`
  ADD PRIMARY KEY (`rwid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contribution`
--
ALTER TABLE `contribution`
  MODIFY `contri_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `loan_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `mid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profit`
--
ALTER TABLE `profit`
  MODIFY `profit_id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_membership`
--
ALTER TABLE `request_membership`
  MODIFY `rmid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `withdraw`
--
ALTER TABLE `withdraw`
  MODIFY `rwid` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
