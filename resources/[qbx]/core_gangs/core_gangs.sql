CREATE TABLE `bounties` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `bounty` int(11) NOT NULL,
  `setby` varchar(100) NOT NULL,
  `accepted` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `bounties`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `bounties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

CREATE TABLE `criminals` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `organization` varchar(100) NOT NULL,
  `role` int(11) NOT NULL,
  `stats` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `criminals`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `criminals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

CREATE TABLE `organizations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `owner` varchar(100) NOT NULL,
  `color` varchar(10) NOT NULL,
  `zones` longtext NOT NULL,
  `picture` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `organizations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;