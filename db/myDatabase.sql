CREATE DATABASE  IF NOT EXISTS `movie_ticketing` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `movie_ticketing`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: movie_ticketing
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cinemas`
--

DROP TABLE IF EXISTS `cinemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinemas` (
  `cinema_id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  PRIMARY KEY (`cinema_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinemas`
--

LOCK TABLES `cinemas` WRITE;
/*!40000 ALTER TABLE `cinemas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cinemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concessions`
--

DROP TABLE IF EXISTS `concessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concessions` (
  `concession_id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`concession_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concessions`
--

LOCK TABLES `concessions` WRITE;
/*!40000 ALTER TABLE `concessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `concessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` char(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_genres` (
  `movie_id` char(36) NOT NULL,
  `genre_id` char(36) NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `movie_genres_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE,
  CONSTRAINT `movie_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_genres`
--

LOCK TABLES `movie_genres` WRITE;
/*!40000 ALTER TABLE `movie_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_producers`
--

DROP TABLE IF EXISTS `movie_producers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_producers` (
  `movie_id` char(36) NOT NULL,
  `producer_id` char(36) NOT NULL,
  PRIMARY KEY (`movie_id`,`producer_id`),
  KEY `producer_id` (`producer_id`),
  CONSTRAINT `movie_producers_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE,
  CONSTRAINT `movie_producers_ibfk_2` FOREIGN KEY (`producer_id`) REFERENCES `producers` (`producer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_producers`
--

LOCK TABLES `movie_producers` WRITE;
/*!40000 ALTER TABLE `movie_producers` DISABLE KEYS */;
/*!40000 ALTER TABLE `movie_producers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `movie_id` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `trailer_url` varchar(255) DEFAULT NULL,
  `poster_url` varchar(255) DEFAULT NULL,
  `duration` int NOT NULL,
  `age_restriction` int NOT NULL,
  `release_date` date DEFAULT NULL,
  `status` enum('now_showing','coming_soon') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` char(36) NOT NULL,
  `booking_id` char(36) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('bank_card','e_wallet','qr_code') NOT NULL,
  `payment_status` enum('pending','completed','failed','refunded','cancelled') NOT NULL DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `booking_id` (`booking_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `tickets` (`ticket_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producers`
--

DROP TABLE IF EXISTS `producers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producers` (
  `producer_id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`producer_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producers`
--

LOCK TABLES `producers` WRITE;
/*!40000 ALTER TABLE `producers` DISABLE KEYS */;
/*!40000 ALTER TABLE `producers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` char(36) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `movie_id` char(36) DEFAULT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `user_id` (`user_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` char(36) NOT NULL,
  `cinema_id` char(36) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `total_seats` int NOT NULL,
  PRIMARY KEY (`room_id`),
  KEY `cinema_id` (`cinema_id`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`cinema_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seats` (
  `seat_id` char(36) NOT NULL,
  `room_id` char(36) DEFAULT NULL,
  `seat_number` varchar(10) NOT NULL,
  `type` enum('standard','vip') NOT NULL DEFAULT 'standard',
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showtimes`
--

DROP TABLE IF EXISTS `showtimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showtimes` (
  `showtime_id` char(36) NOT NULL,
  `movie_id` char(36) DEFAULT NULL,
  `room_id` char(36) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `ticket_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`showtime_id`),
  KEY `movie_id` (`movie_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `showtimes_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE,
  CONSTRAINT `showtimes_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showtimes`
--

LOCK TABLES `showtimes` WRITE;
/*!40000 ALTER TABLE `showtimes` DISABLE KEYS */;
/*!40000 ALTER TABLE `showtimes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_logs`
--

DROP TABLE IF EXISTS `system_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_logs` (
  `log_id` char(36) NOT NULL,
  `admin_id` char(36) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `system_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_logs`
--

LOCK TABLES `system_logs` WRITE;
/*!40000 ALTER TABLE `system_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_concessions`
--

DROP TABLE IF EXISTS `ticket_concessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_concessions` (
  `ticket_id` char(36) NOT NULL,
  `concession_id` char(36) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`ticket_id`,`concession_id`),
  KEY `concession_id` (`concession_id`),
  CONSTRAINT `ticket_concessions_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_concessions_ibfk_2` FOREIGN KEY (`concession_id`) REFERENCES `concessions` (`concession_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_concessions`
--

LOCK TABLES `ticket_concessions` WRITE;
/*!40000 ALTER TABLE `ticket_concessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_concessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_seats`
--

DROP TABLE IF EXISTS `ticket_seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_seats` (
  `ticket_id` char(36) NOT NULL,
  `seat_id` char(36) NOT NULL,
  PRIMARY KEY (`ticket_id`,`seat_id`),
  KEY `seat_id` (`seat_id`),
  CONSTRAINT `ticket_seats_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_seats_ibfk_2` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_seats`
--

LOCK TABLES `ticket_seats` WRITE;
/*!40000 ALTER TABLE `ticket_seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `ticket_id` char(36) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `showtime_id` char(36) DEFAULT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `qr_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`),
  KEY `showtime_id` (`showtime_id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`showtime_id`) REFERENCES `showtimes` (`showtime_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` char(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `role` enum('guest','customer','staff','admin') NOT NULL DEFAULT 'guest',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('550e8400-e29b-41d4-a716-446655440001','nguyen.van.a@gmail.com','password123','Nguyễn Văn A','0905123456','customer','2025-05-26 15:56:53','2025-05-26 15:56:53'),('550e8400-e29b-41d4-a716-446655440002','tran.thi.b@gmail.com','securepass456','Trần Thị B','0916234567','staff','2025-05-26 15:56:53','2025-05-26 15:56:53'),('550e8400-e29b-41d4-a716-446655440003','sonvd74@gmail.com','anhyeuem12','Ngô Minh Sơn','0927345678','admin','2025-05-26 15:56:53','2025-05-26 15:56:53'),('550e8400-e29b-41d4-a716-446655440004','pham.thi.d@gmail.com','pass789','Phạm Thị D','0938456789','customer','2025-05-26 15:56:53','2025-05-26 15:56:53'),('550e8400-e29b-41d4-a716-446655440005','hoang.van.e@gmail.com','strongpass101','Hoàng Văn E','0949567890','staff','2025-05-26 15:56:53','2025-05-26 15:56:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlists` (
  `wishlist_id` char(36) NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  `movie_id` char(36) DEFAULT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wishlist_id`),
  KEY `user_id` (`user_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `wishlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `wishlists_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists`
--

LOCK TABLES `wishlists` WRITE;
/*!40000 ALTER TABLE `wishlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'movie_ticketing'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-28  0:16:08
