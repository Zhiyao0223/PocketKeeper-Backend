-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 30, 2024 at 03:42 PM
-- Server version: 10.6.18-MariaDB-log
-- PHP Version: 8.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `xiaowupr_pocketkeeper`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` tinyint(2) NOT NULL COMMENT '0:Expenses, 1:Income',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0:Active,1:Deleted',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `user_id`, `name`, `type`, `status`, `created_date`, `updated_date`) VALUES
(1, 1, 'Food', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(2, 1, 'Grocery', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(3, 1, 'Transportation', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(4, 1, 'Clothing', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(5, 1, 'Entertainment', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(6, 1, 'Sports', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(7, 1, 'Home', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(8, 1, 'E-commerce', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(9, 1, 'Tools', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(10, 1, 'Events', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(11, 1, 'Dessert', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(12, 1, 'Books', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(13, 1, 'Shoes', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(14, 1, 'Games', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(15, 1, 'Medical', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(16, 1, 'Others', 0, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(17, 1, 'Salary', 1, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(18, 1, 'Bonus', 1, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(19, 1, 'Gift', 1, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(20, 1, 'Investment', 1, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59'),
(21, 1, 'Others', 1, 0, '2024-07-17 13:39:59', '2024-07-17 13:39:59');

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE `config` (
  `config_id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `value` varchar(50) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `config`
--

INSERT INTO `config` (`config_id`, `description`, `value`, `created_date`, `updated_date`) VALUES
(1, 'appname', 'PocketKeeper', '2024-05-26 07:31:46', '2024-05-26 07:31:46');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `sync_status` tinyint(4) NOT NULL COMMENT '0:Sync,1:Unsync',
  `status` tinyint(4) NOT NULL COMMENT '0:Active,1:Deleted',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses_goal`
--

CREATE TABLE `expenses_goal` (
  `goal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(250) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0:Active,1:Deleted',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses_limit`
--

CREATE TABLE `expenses_limit` (
  `limit_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0:Active, 1: Delete',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `financial_blog`
--

CREATE TABLE `financial_blog` (
  `blog_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `author_name` varchar(250) NOT NULL,
  `url` varchar(250) NOT NULL COMMENT 'Blog url',
  `average_reading_time` int(11) NOT NULL COMMENT 'In minute',
  `image` varchar(250) DEFAULT NULL COMMENT 'Blog image url',
  `author_image` varchar(250) DEFAULT NULL COMMENT 'Author image url',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0:Active, 1: Inactive',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `financial_blog`
--

INSERT INTO `financial_blog` (`blog_id`, `title`, `author_name`, `url`, `average_reading_time`, `image`, `author_image`, `status`, `created_date`, `updated_date`) VALUES
(1, 'How To Manage Your Money: 19 Tips To Do It Right', 'Sarah Sharkey', 'https://www.clevergirlfinance.com/how-to-manage-your-money/', 10, NULL, NULL, 0, '2024-07-16 13:42:19', '2024-07-16 13:42:46'),
(2, '5 Ways to Manage Your Personal Finances', 'Rakshitha Arni Ravishankar', 'https://hbr.org/2022/11/5-ways-to-manage-your-personal-finances', 8, 'https://hbr.org/resources/images/article_assets/2022/11/1122_21_Finance_1360192291_v2.pg_.jpg', NULL, 0, '2024-07-16 13:43:50', '2024-07-16 14:36:56'),
(3, '43 Ways to Drastically Cut Expenses and Save Serious Money', 'Anna Barker', 'https://logicaldollar.com/drastically-cut-expenses/', 20, 'https://th.bing.com/th/id/OIP.wxFJXU4MSHj7mRqqo-wfGwHaE8', 'https://secure.gravatar.com/avatar/413fff457aad22cd34f5f45d05222e53?s=80&d=mm&r=g', 0, '2024-07-16 13:47:14', '2024-07-16 13:47:14'),
(4, 'How to Reduce Expenses and Save Money', 'Maureen Milliken', 'https://www.debt.org/advice/how-to-cut-expenses/', 12, 'https://www.debt.org/wp-content/uploads/2020/10/Cut-credit-card.jpg', 'https://secure.gravatar.com/avatar/5dde97b0247ab89bfbdfb652ed7f1e79?s=150&d=mm&r=g', 0, '2024-07-16 13:48:07', '2024-07-16 13:48:07'),
(5, 'Ways to Save Money for a Financial Goal in 5 Steps That Everyone Can Do', 'Julie Jaggernath', 'https://nomoredebts.org/blog/budgeting-saving/ways-to-save-for-financial-goal-5-steps-everyone-can-do', 5, 'https://nomoredebts.org/wp-content/uploads/2020/09/couple-budgeting-and-saving-for-the-future_hero.jpg', NULL, 0, '2024-07-16 13:49:35', '2024-07-16 13:49:35');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `image_id` int(11) NOT NULL,
  `image_name` varchar(250) NOT NULL,
  `reference_id` int(11) NOT NULL COMMENT 'Reference to each PK based on type',
  `type` tinyint(4) NOT NULL COMMENT '0:Receipt, 1:ProfilePic',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0:Active,1:Deleted',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`image_id`, `image_name`, `reference_id`, `type`, `status`, `created_date`, `updated_date`) VALUES
(10, '17222792023957.jpg', 17, 1, 0, '2024-07-29 18:53:22', '2024-07-29 18:53:22'),
(11, '17222802022788.jpg', 19, 1, 0, '2024-07-29 19:10:02', '2024-07-29 19:10:02'),
(12, '17222803372223.jpg', 20, 1, 0, '2024-07-29 19:12:17', '2024-07-29 19:12:17'),
(13, '17222865955917.jpg', 25, 1, 0, '2024-07-29 20:56:35', '2024-07-29 20:56:35');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `log_id` int(11) NOT NULL,
  `description` varchar(250) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0:info, 1:warning, 2:error, 3:success, 4:none',
  `read_status` tinyint(4) NOT NULL COMMENT '0:Read,1:Unread,2:Draft',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0:Active, 1:Disable',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `name`, `status`, `created_date`, `updated_date`) VALUES
(1, 'admin', 0, '2024-05-27 02:57:23', '2024-05-27 02:57:23'),
(2, 'normal_user', 0, '2024-05-27 02:57:32', '2024-05-27 02:57:32'),
(3, 'premium_user', 0, '2024-05-27 02:57:40', '2024-05-27 02:57:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(254) NOT NULL,
  `firebase_token` varchar(200) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0:Active, 1:Inactive, 2: Deleted',
  `roleId` int(11) NOT NULL DEFAULT 2,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `firebase_token`, `status`, `roleId`, `created_date`, `updated_date`) VALUES
(1, 'sysadmin', '$2y$12$DWv1Pc9JlJMc8f.iQuVzkOBQY1s9AltrZ7Q02ACBWaP9YtQgCqZvW', 'zhiyao0223@gmail.com', NULL, 0, 1, '2024-05-26 08:22:52', '2024-05-28 06:39:26'),
(25, 'zhiyao', '$2y$10$2xDAsddUeletCoTYDTb47uZQO3peaXP.KjDpCBKdxUSWXleRNjYde', 'xiaowu0223@gmail.com', NULL, 0, 2, '2024-07-29 19:35:41', '2024-07-29 19:35:41');

-- --------------------------------------------------------

--
-- Table structure for table `user_discord`
--

CREATE TABLE `user_discord` (
  `ud_id` int(11) NOT NULL,
  `discord_id` varchar(200) DEFAULT NULL,
  `authorization_code` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0:Active, 1:Pending, 2:Expired',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `user_discord`
--

INSERT INTO `user_discord` (`ud_id`, `discord_id`, `authorization_code`, `user_id`, `status`, `created_date`, `updated_date`) VALUES
(3, NULL, '1507', 25, 1, '2024-07-29 20:56:44', '2024-07-29 20:56:44');

-- --------------------------------------------------------

--
-- Table structure for table `verification_code`
--

CREATE TABLE `verification_code` (
  `code_id` int(11) NOT NULL,
  `code` int(4) NOT NULL,
  `email` varchar(254) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `verification_code`
--

INSERT INTO `verification_code` (`code_id`, `code`, `email`, `created_date`, `updated_date`) VALUES
(1, 9731, 'zhiyao0223@gmail.com', '2024-05-27 07:27:02', '2024-07-11 18:34:03'),
(2, 3413, 'xiaowu0223@gmail.com', '2024-07-21 17:48:59', '2024-07-27 19:04:35'),
(3, 6776, 'xiiaowu0223@gmail.com', '2024-07-22 16:25:49', '2024-07-25 14:24:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `c_u` (`user_id`);

--
-- Indexes for table `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`config_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`),
  ADD KEY `e_u` (`user_id`),
  ADD KEY `e_c` (`category_id`);

--
-- Indexes for table `expenses_goal`
--
ALTER TABLE `expenses_goal`
  ADD PRIMARY KEY (`goal_id`),
  ADD KEY `eg_u` (`user_id`);

--
-- Indexes for table `expenses_limit`
--
ALTER TABLE `expenses_limit`
  ADD PRIMARY KEY (`limit_id`),
  ADD KEY `el_u` (`user_id`),
  ADD KEY `el_c` (`category_id`);

--
-- Indexes for table `financial_blog`
--
ALTER TABLE `financial_blog`
  ADD PRIMARY KEY (`blog_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `l_u` (`user_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `n_u` (`user_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `u_r` (`roleId`);

--
-- Indexes for table `user_discord`
--
ALTER TABLE `user_discord`
  ADD PRIMARY KEY (`ud_id`),
  ADD KEY `ud_u` (`user_id`);

--
-- Indexes for table `verification_code`
--
ALTER TABLE `verification_code`
  ADD PRIMARY KEY (`code_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `config`
--
ALTER TABLE `config`
  MODIFY `config_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `expenses_goal`
--
ALTER TABLE `expenses_goal`
  MODIFY `goal_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses_limit`
--
ALTER TABLE `expenses_limit`
  MODIFY `limit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `financial_blog`
--
ALTER TABLE `financial_blog`
  MODIFY `blog_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user_discord`
--
ALTER TABLE `user_discord`
  MODIFY `ud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `verification_code`
--
ALTER TABLE `verification_code`
  MODIFY `code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `c_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `e_c` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `e_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `expenses_goal`
--
ALTER TABLE `expenses_goal`
  ADD CONSTRAINT `eg_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `expenses_limit`
--
ALTER TABLE `expenses_limit`
  ADD CONSTRAINT `el_c` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `el_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `l_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `n_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `u_r` FOREIGN KEY (`roleId`) REFERENCES `role` (`role_id`);

--
-- Constraints for table `user_discord`
--
ALTER TABLE `user_discord`
  ADD CONSTRAINT `ud_u` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
