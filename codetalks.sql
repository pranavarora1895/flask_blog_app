-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 11, 2021 at 04:40 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codetalks`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `mes` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `mes`, `date`) VALUES
(1, 'first post', 'firstpost@gmail.com', '1234567890', 'first post', '2021-07-10 19:35:09'),
(2, 'naam', 'mail@gmail.com', '390940439', 'name', '2021-07-10 00:00:00'),
(3, 'Karan', 'karan@gmail.com', '4990239', 'Post', '2021-07-10 00:00:00'),
(4, 'Meher', 'meher@gmail.com', '390949', 'mailing', '2021-07-10 00:00:00'),
(5, 'Harish', 'harish@gmail.com', '390902909', 'Hello Bir', '2021-07-10 00:00:00'),
(6, 'Garima', 'garima@gmail.com', '49039030', 'garima', '2021-07-10 00:00:00'),
(7, 'Garima', 'garima@gmail.com', '49039030', 'garima', '2021-07-10 00:00:00'),
(8, 'Garima', 'garima@gmail.com', '3290324029', 'dmd;lmdd', '2021-07-10 00:00:00'),
(9, 'karan', 'kaaa@gmail.com', '3987209', 'd;mf;ldm', '2021-07-10 00:00:00'),
(10, 'nana', 'nana@gmail.com', '3323', 'sldmlsm', '2021-07-10 00:00:00'),
(11, 'garima', 'garima@gmail.com', '304343', 'sklmfdd', '2021-07-10 00:00:00'),
(12, 'garima', 'garima@gmail.com', '49333290', 'fjalfmv', '2021-07-10 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_url` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `date`, `img_url`) VALUES
(1, 'Quickstart to Flask SQL Alchemy', 'first-post', 'Pranav Arora As you can see, there is no need to add the Post objects to the session. Since the Category is part of the session all objects associated with it through relationships will be added too. It does not matter whether db.session.add() is called before or after creating these objects. The association can also be done on either side of the relationship - so a post can be created with a category or it can be added to the list of posts of the category.', '2021-07-11 00:00:00', 'post-bg.jpg'),
(4, 'Python Bot', 'python-bot', 'At its core, Buildbot is a job scheduling system: it queues jobs, executes the jobs when the required resources are available, and reports the results.\r\n\r\nYour Buildbot installation has one or more masters and a collection of workers. The masters monitor source-code repositories for changes, coordinate the activities of the workers, and report results to users and developers. Workers run on a variety of operating systems.\r\n\r\nYou configure Buildbot by providing a Python configuration script to the master. This script can be very simple, configuring built-in components, but the full expressive power of Python is available. This allows dynamic generation of configuration, customized components, and anything else you can devise.\r\n\r\nThe framework itself is implemented in Twisted Python, and compatible with all major operating systems.', '2021-07-11 00:00:00', 'about-bg.jpg'),
(5, 'Venus and Moon', 'venus-and-moon', 'Just nine months ago, Mars came to within 38.8 million miles (62.43 million kilometers) of Earth, the closest it had been to us since August 2003, and it will not be that close again until September 2035. Mars appeared three times brighter than Sirius, the brightest star in our sky and even rivaled Jupiter in brilliance. In fact, Mars ranked as the third brightest nighttime object behind the moon and Venus.', '2021-07-11 00:00:00', 'blog-bg.jpg'),
(6, 'Virgin Galgatic', 'virgin-galgatic', 'Virgin Galactic is counting down to launch its Unity 22 astronauts on the company\'s first fully crewed suborbital spaceflight Sunday (July 11) and the mission\'s crew took some time out from training to answer questions about what they expect from space.', '2021-07-11 00:00:00', 'post-bg.jpg'),
(7, 'On July 11', 'july-11', 'On July 11, 1979, the abandoned U.S. space station Skylab made a spectacular return to Earth as it burned up in the atmosphere, showering debris over the Indian Ocean and Western Australia.\r\n\r\nThe last crew left the space station in 1974. Over time, it began to deorbit, slowly sinking closer and closer to Earth. Skylab actually fell back to Earth a little sooner than NASA anticipated. Strong solar storms were blamed for this premature plunge, because solar activity had warmed up Earth\'s atmosphere.\r\n\r\nAs pieces of Skylab broke up in the atmosphere, residents and pilots in the area saw dozens of colorful firework-like flares.', '2021-07-11 00:00:00', 'home-bg.jpg'),
(8, 'Login Form', 'login-form', 'I made a login form using HTML, CSS only.', '2021-07-11 00:00:00', 'login_form.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
