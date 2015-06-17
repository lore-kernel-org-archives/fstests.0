Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34072 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752442AbbFQSiK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2015 14:38:10 -0400
Received: from pps.filterd (m0044008 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id t5HIaefP007384
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2015 11:38:09 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 1v380vgy2j-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2015 11:38:09 -0700
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] fstests: convert fiemap-tester to use O_DIRECT
Date: Wed, 17 Jun 2015 11:37:57 -0700
Message-ID: <1434566277-28967-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We want to test fiemap, so we want to lay out a file exactly a certain way.  XFS
tries to be smart and will allocate data in a hole if the write pattern is

[data][hole][data]

where the hole is small enough.  This screws with fiemap-tester sometimes, so
make it easy and just do O_DIRECT so that we get the layout we want and can get
back to testing fiemap.  Thanks,

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 src/fiemap-tester.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/fiemap-tester.c b/src/fiemap-tester.c
index 8e633ab..5cb58fc 100644
--- a/src/fiemap-tester.c
+++ b/src/fiemap-tester.c
@@ -92,8 +92,7 @@ create_file_from_mapping(int fd, char *map, int blocks, int blocksize)
 	int i = 0;
 
 	bufsize = sizeof(char) * blocksize;
-	buf = malloc(bufsize);
-	if (!buf)
+	if (posix_memalign((void **)&buf, 4096, bufsize))
 		return -1;
 
 	memset(buf, 'a', bufsize);
@@ -562,7 +561,7 @@ main(int argc, char **argv)
 	if (!fname)
 		usage();
 
-	fd = open(fname, O_RDWR|O_CREAT|O_TRUNC, 0644);
+	fd = open(fname, O_RDWR|O_CREAT|O_TRUNC|O_DIRECT, 0644);
 	if (fd < 0) {
 		perror("Can't open file");
 		exit(1);
-- 
2.1.0

