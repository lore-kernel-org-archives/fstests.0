Received: from mail-wm0-f66.google.com ([74.125.82.66]:37080 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbdIGKCw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2017 06:02:52 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 2/8] replay-log: add validations for corrupt log entries
Date: Thu,  7 Sep 2017 13:03:07 +0300
Message-Id: <1504778593-12071-3-git-send-email-amir73il@gmail.com>
In-Reply-To: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
References: <1504778593-12071-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Check for all zeros entry and for non zero padded entry
and report log offset of corrupted log entry.

Also report log offsets with -v and -vv debug prints.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 src/log-writes/log-writes.c | 84 ++++++++++++++++++++++++++++++++++-----------
 src/log-writes/log-writes.h |  2 ++
 src/log-writes/replay-log.c |  7 ++--
 3 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/src/log-writes/log-writes.c b/src/log-writes/log-writes.c
index a215fef..dbfeef7 100644
--- a/src/log-writes/log-writes.c
+++ b/src/log-writes/log-writes.c
@@ -118,6 +118,26 @@ int log_discard(struct log *log, struct log_write_entry *entry)
 }
 
 /*
+ * @entry: entry to be replayed.
+ *
+ * @return: 1 if the entry is sane, 0 if it is invalid.
+ *
+ * Check if this is a sane log entry.
+ */
+int log_entry_valid(struct log_write_entry *entry)
+{
+	u64 flags = le64_to_cpu(entry->flags);
+
+	/* Suspect all zeroes entry */
+	if (!flags && !entry->nr_sectors)
+		return 0;
+	/* Suspect non zero padded entry */
+	if (flags != LOG_MARK_FLAG && entry->data[0] != 0)
+		return 0;
+	return 1;
+}
+
+/*
  * @log: the log we are replaying.
  * @entry: where we put the entry.
  * @read_data: read the entry data as well, entry must be log->sectorsize sized
@@ -146,24 +166,32 @@ int log_replay_next_entry(struct log *log, struct log_write_entry *entry,
 		fprintf(stderr, "Error reading entry: %d\n", errno);
 		return -1;
 	}
+	if (!log_entry_valid(entry)) {
+		fprintf(stderr, "Malformed entry @%llu\n",
+				log->cur_pos / log->sectorsize);
+		return -1;
+	}
 	log->cur_entry++;
 
 	size = le64_to_cpu(entry->nr_sectors) * log->sectorsize;
 	if (read_size < log->sectorsize) {
-		if (lseek(log->logfd,
-			  log->sectorsize - sizeof(struct log_write_entry),
-			  SEEK_CUR) == (off_t)-1) {
+		log->cur_pos = lseek(log->logfd,
+			log->sectorsize - sizeof(struct log_write_entry), SEEK_CUR);
+		if (log->cur_pos == (off_t)-1) {
 			fprintf(stderr, "Error seeking in log: %d\n", errno);
 			return -1;
 		}
+	} else {
+		log->cur_pos += read_size;
 	}
 
-	if (log_writes_verbose)
-		printf("replaying %d: sector %llu, size %llu, flags %llu\n",
-		       (int)log->cur_entry - 1,
+	if (log_writes_verbose) {
+		printf("replaying %d@%llu: sector %llu, size %llu, flags %llu\n",
+		       (int)log->cur_entry - 1, log->cur_pos / log->sectorsize,
 		       (unsigned long long)le64_to_cpu(entry->sector),
 		       (unsigned long long)size,
 		       (unsigned long long)le64_to_cpu(entry->flags));
+	}
 	if (!size)
 		return 0;
 
@@ -183,6 +211,7 @@ int log_replay_next_entry(struct log *log, struct log_write_entry *entry,
 		free(buf);
 		return -1;
 	}
+	log->cur_pos += size;
 
 	offset = le64_to_cpu(entry->sector) * log->sectorsize;
 	ret = pwrite(log->replayfd, buf, size, offset);
@@ -212,7 +241,8 @@ int log_seek_entry(struct log *log, u64 entry_num)
 	}
 
 	/* Skip the first sector containing the log super block */
-	if (lseek(log->logfd, log->sectorsize, SEEK_SET) == (off_t)-1) {
+	log->cur_pos = lseek(log->logfd, log->sectorsize, SEEK_SET);
+	if (log->cur_pos == (off_t)-1) {
 		fprintf(stderr, "Error seeking in file: %d\n", errno);
 		return -1;
 	}
@@ -229,9 +259,14 @@ int log_seek_entry(struct log *log, u64 entry_num)
 			fprintf(stderr, "Error reading entry: %d\n", errno);
 			return -1;
 		}
+		if (!log_entry_valid(&entry)) {
+			fprintf(stderr, "Malformed entry @%llu\n",
+					log->cur_pos / log->sectorsize);
+			return -1;
+		}
 		if (log_writes_verbose > 1)
-			printf("seek entry %d: %llu, size %llu, flags %llu\n",
-			       (int)i,
+			printf("seek entry %d@%llu: %llu, size %llu, flags %llu\n",
+			       (int)i, log->cur_pos / log->sectorsize,
 			       (unsigned long long)le64_to_cpu(entry.sector),
 			       (unsigned long long)le64_to_cpu(entry.nr_sectors),
 			       (unsigned long long)le64_to_cpu(entry.flags));
@@ -240,7 +275,8 @@ int log_seek_entry(struct log *log, u64 entry_num)
 		if (!(flags & LOG_DISCARD_FLAG))
 			seek_size += le64_to_cpu(entry.nr_sectors) *
 				log->sectorsize;
-		if (lseek(log->logfd, seek_size, SEEK_CUR) == (off_t)-1) {
+		log->cur_pos = lseek(log->logfd, seek_size, SEEK_CUR);
+		if (log->cur_pos == (off_t)-1) {
 			fprintf(stderr, "Error seeking in file: %d\n", errno);
 			return -1;
 		}
@@ -277,29 +313,37 @@ int log_seek_next_entry(struct log *log, struct log_write_entry *entry,
 		fprintf(stderr, "Error reading entry: %d\n", errno);
 		return -1;
 	}
+	if (!log_entry_valid(entry)) {
+		fprintf(stderr, "Malformed entry @%llu\n",
+				log->cur_pos / log->sectorsize);
+		return -1;
+	}
 	log->cur_entry++;
 
 	if (read_size < log->sectorsize) {
-		if (lseek(log->logfd,
-			  log->sectorsize - sizeof(struct log_write_entry),
-			  SEEK_CUR) == (off_t)-1) {
+		log->cur_pos = lseek(log->logfd,
+			log->sectorsize - sizeof(struct log_write_entry), SEEK_CUR);
+		if (log->cur_pos == (off_t)-1) {
 			fprintf(stderr, "Error seeking in log: %d\n", errno);
 			return -1;
 		}
+	} else {
+		log->cur_pos += read_size;
 	}
 	if (log_writes_verbose > 1)
-		printf("seek entry %d: %llu, size %llu, flags %llu\n",
-		       (int)log->cur_entry - 1,
+		printf("seek entry %d@%llu: %llu, size %llu, flags %llu\n",
+		       (int)log->cur_entry - 1, log->cur_pos / log->sectorsize,
 		       (unsigned long long)le64_to_cpu(entry->sector),
 		       (unsigned long long)le64_to_cpu(entry->nr_sectors),
 		       (unsigned long long)le64_to_cpu(entry->flags));
 
-	flags = le32_to_cpu(entry->flags);
-	read_size = le32_to_cpu(entry->nr_sectors) * log->sectorsize;
+	flags = le64_to_cpu(entry->flags);
+	read_size = le64_to_cpu(entry->nr_sectors) * log->sectorsize;
 	if (!read_size || (flags & LOG_DISCARD_FLAG))
 		return 0;
 
-	if (lseek(log->logfd, read_size, SEEK_CUR) == (off_t)-1) {
+	log->cur_pos = lseek(log->logfd, read_size, SEEK_CUR);
+	if (log->cur_pos == (off_t)-1) {
 		fprintf(stderr, "Error seeking in log: %d\n", errno);
 		return -1;
 	}
@@ -369,8 +413,8 @@ struct log *log_open(char *logfile, char *replayfile)
 	log->nr_entries = le64_to_cpu(super.nr_entries);
 	log->max_zero_size = 128 * 1024 * 1024;
 
-	if (lseek(log->logfd, log->sectorsize - sizeof(super), SEEK_CUR) ==
-	    (off_t) -1) {
+	log->cur_pos = lseek(log->logfd, log->sectorsize - sizeof(super), SEEK_CUR);
+	if (log->cur_pos == (off_t) -1) {
 		fprintf(stderr, "Error seeking to first entry: %d\n", errno);
 		log_free(log);
 		return NULL;
diff --git a/src/log-writes/log-writes.h b/src/log-writes/log-writes.h
index 6cadb66..c89b119 100644
--- a/src/log-writes/log-writes.h
+++ b/src/log-writes/log-writes.h
@@ -50,6 +50,8 @@ struct log_write_entry {
 	__le64 nr_sectors;
 	__le64 flags;
 	__le64 data_len;
+	/* Read extra byte when seeking to verify that header is zero padded */
+	char data[1];
 };
 
 #define LOG_IGNORE_DISCARD (1 << 0)
diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
index c3de9c4..cf67931 100644
--- a/src/log-writes/replay-log.c
+++ b/src/log-writes/replay-log.c
@@ -75,7 +75,7 @@ static int should_stop(struct log_write_entry *entry, u64 stop_flags,
 	u64 flags = le64_to_cpu(entry->flags);
 	int check_mark = (stop_flags & LOG_MARK_FLAG);
 	/* mark data begins after entry header */
-	char *buf = (char *)(entry + 1);
+	char *buf = entry->data;
 	/* entry buffer is padded with at least 1 zero after data_len */
 	u64 buflen = le64_to_cpu(entry->data_len) + 1;
 
@@ -293,8 +293,9 @@ int main(int argc, char **argv)
 			num_entries++;
 			if ((run_limit && num_entries == run_limit) ||
 			    should_stop(entry, stop_flags, end_mark)) {
-				printf("%llu\n",
-				       (unsigned long long)log->cur_entry - 1);
+				printf("%llu@%llu\n",
+				       (unsigned long long)log->cur_entry - 1,
+				       log->cur_pos / log->sectorsize);
 				log_free(log);
 				return 0;
 			}
-- 
2.7.4

