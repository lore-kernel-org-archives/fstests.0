Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902C274FFD
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939174; cv=none; b=Laj+ARzMVVGMDvWmjxsusXXEWcp3uQbO8pOgaGFI9vvYfwDum8r1FiLwQ56Ao7PITLqON+sJsvqoeIX0EWvReByrMf5EOeE6U0mmDp7megcmzdfCNmrGcU5OrbkN0O+s6uCIbpWu+3u212vYR7ZYs23KwHRRr30S8Ykq/Rbw5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939174; c=relaxed/simple;
	bh=BARby1LIEPzQRi3qphU1K95iaw/XIHXJK7LLggB3KaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAPrmWqs2etWdDagVwRrxpILWRuOgpqRygrJuVphspS7ZyOzOQJvpxJ20pAbhadvb+AulIsgwcOv8JC2Tk3COS7bWd4ciNWAUnnLqOIUnU/lq6+MbHZB47W88lKIQTs5AO0gTp8FCHhWNF0ZXJbM9L5A9SJmGP2fk9wWqByZKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SEM16ZRn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SEM16ZRn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4B3vS030891;
	Thu, 26 Jun 2025 11:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8C/SIjXH9tLfHJU5j
	Vf7nmDnsHi4fDAayGE6ts1c0/A=; b=SEM16ZRnDhkVc1/+yQlwDc6hiZcfS1DeH
	b+4mk7EQTQrnBu6vDDY9K/OFiY48SBHbS2cODY9d3srtsFZzEwC4EuCUZLx7VRoP
	j8iumxcoSBo5fOJUGma41XE/5IR7IEz9xabStOZqdoCV+z7/KQF6r98E92K8qBkb
	zRGJFmVYN+zey0InWWW/9/fFeVGoas41eK5JlcTXyK2TWdCaNwMi7uhIQKEdzbBK
	UGkwvKZTdFfdkKNll35j4mX2HJv1AvYUL6VKk4sQzDZN6bHReJ2nXqBAT+9ipvoe
	1PMJOpdDOyh3pJkROZ8tnTwtsgOzmOuWk3Dq3HR8pvnNIQJ0sbp4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk645vnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55QBv18e009447;
	Thu, 26 Jun 2025 11:59:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk645vn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55QBZ6LP014988;
	Thu, 26 Jun 2025 11:59:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72txwu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:59:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55QBxESx46137764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 11:59:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77B1A2004F;
	Thu, 26 Jun 2025 11:59:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F073B20040;
	Thu, 26 Jun 2025 11:59:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.22.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 11:59:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: [PATCH v2 04/13] ltp/fsx.c: Add atomic writes support to fsx
Date: Thu, 26 Jun 2025 17:28:55 +0530
Message-ID: <57935a496fa360a81f2b36873640f3a7a7bf3681.1750924903.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750924903.git.ojaswin@linux.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5OSBTYWx0ZWRfX34qP8eCMEah+ +cqXaxOOSs6+AUY8X2eZbXPf71q7YsbO5m7jCeVAUsKJjnIqkMxQcJ27uvg46RStm4juMhGJHt/ Xp+dydbJfYG6p5EZBeOx+QP/Ult4McmsowMWRwnnx7wKeAe/Y6zM3hmisQrRh+SQri/O4G7H4Fd
 pC4eWkbxe4UdqmVwPUBcQ9fdSd72Fmm81SIP4edJ+BtApvpM8mz6cXfJ9wp4zsHXOeS4gR1UvWc soQy7lckEZ5qvJZOTGeIVWYupdUxClQFmFT+HAgwd6Sq1y8BrhT5iHFE8khNx6kILI+fSQB37Sy 4h8zYqXLzWE6wQjxfLApwDKSM/2uW64mSIYZVTFCMFXVd9d47fIuN6cnHMiu3s3exxhD7l8DAtR
 cEqW30visRDNpo3HzZ30DyHFEkqwRVlmSqG6Ct247FqM36ddu4Eq8P7JhCl5GLORzgS9Tcz8
X-Proofpoint-ORIG-GUID: C2LKgPofmNALfNhX6BIhP8lR6Ctqd2oF
X-Proofpoint-GUID: AxRThpmTe1O7VqMO2UzYlvNLnn3rNQwT
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685d3615 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=T5_vRgAD47iBWrMonTEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260099

Implement atomic write support to help fuzz atomic writes
with fsx.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 ltp/fsx.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 163b9453..8e9011f4 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -40,6 +40,7 @@
 #include <liburing.h>
 #endif
 #include <sys/syscall.h>
+#include "statx.h"
 
 #ifndef MAP_FILE
 # define MAP_FILE 0
@@ -49,6 +50,10 @@
 #define RWF_DONTCACHE	0x80
 #endif
 
+#ifndef RWF_ATOMIC
+#define RWF_ATOMIC	0x40
+#endif
+
 #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
 
 /* Operation flags (bitmask) */
@@ -110,6 +115,7 @@ enum {
 	OP_READ_DONTCACHE,
 	OP_WRITE,
 	OP_WRITE_DONTCACHE,
+	OP_WRITE_ATOMIC,
 	OP_MAPREAD,
 	OP_MAPWRITE,
 	OP_MAX_LITE,
@@ -200,6 +206,11 @@ int	uring = 0;
 int	mark_nr = 0;
 int	dontcache_io = 1;
 int	hugepages = 0;                  /* -h flag */
+int	do_atomic_writes = 1;		/* -a flag disables */
+
+/* User for atomic writes */
+int awu_min = 0;
+int awu_max = 0;
 
 /* Stores info needed to periodically collapse hugepages */
 struct hugepages_collapse_info {
@@ -288,6 +299,7 @@ static const char *op_names[] = {
 	[OP_READ_DONTCACHE] = "read_dontcache",
 	[OP_WRITE] = "write",
 	[OP_WRITE_DONTCACHE] = "write_dontcache",
+	[OP_WRITE_ATOMIC] = "write_atomic",
 	[OP_MAPREAD] = "mapread",
 	[OP_MAPWRITE] = "mapwrite",
 	[OP_TRUNCATE] = "truncate",
@@ -422,6 +434,7 @@ logdump(void)
 				prt("\t***RRRR***");
 			break;
 		case OP_WRITE_DONTCACHE:
+		case OP_WRITE_ATOMIC:
 		case OP_WRITE:
 			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
 			    lp->args[0], lp->args[0] + lp->args[1] - 1,
@@ -1073,6 +1086,25 @@ update_file_size(unsigned offset, unsigned size)
 	file_size = offset + size;
 }
 
+static int is_power_of_2(unsigned n) {
+	return ((n & (n - 1)) == 0);
+}
+
+/*
+ * Round down n to nearest power of 2.
+ * If n is already a power of 2, return n;
+ */
+static int rounddown_pow_of_2(int n) {
+	int i = 0;
+
+	if (is_power_of_2(n))
+		return n;
+
+	for (; (1 << i) < n; i++);
+
+	return 1 << (i - 1);
+}
+
 void
 dowrite(unsigned offset, unsigned size, int flags)
 {
@@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
 	offset -= offset % writebdy;
 	if (o_direct)
 		size -= size % writebdy;
+	if (flags & RWF_ATOMIC) {
+		/* atomic write len must be inbetween awu_min and awu_max */
+		if (size < awu_min)
+			size = awu_min;
+		if (size > awu_max)
+			size = awu_max;
+
+		/* atomic writes need power-of-2 sizes */
+		size = rounddown_pow_of_2(size);
+
+		/* atomic writes need naturally aligned offsets */
+		offset -= offset % size;
+
+		/* Skip the write if we are crossing max filesize */
+		if ((offset + size) > maxfilelen) {
+			if (!quiet && testcalls > simulatedopcount)
+				prt("skipping atomic write past maxfilelen\n");
+			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
+			return;
+		}
+	}
 	if (size == 0) {
 		if (!quiet && testcalls > simulatedopcount && !o_direct)
 			prt("skipping zero size write\n");
@@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
 		return;
 	}
 
-	log4(OP_WRITE, offset, size, FL_NONE);
+	if (flags & RWF_ATOMIC)
+		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
+	else
+		log4(OP_WRITE, offset, size, FL_NONE);
 
 	gendata(original_buf, good_buf, offset, size);
 	if (offset + size > file_size) {
@@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
 		       (monitorstart == -1 ||
 			(offset + size > monitorstart &&
 			(monitorend == -1 || offset <= monitorend))))))
-		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
-		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
+		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
+		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
+		    (flags & RWF_ATOMIC) != 0);
 	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
 	if (iret != size) {
 		if (iret == -1)
@@ -1785,6 +1842,30 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
 }
 #endif
 
+int test_atomic_writes(void) {
+	int ret;
+	struct statx stx;
+
+	ret = xfstests_statx(AT_FDCWD, fname, 0, STATX_WRITE_ATOMIC, &stx);
+	if (ret < 0) {
+		fprintf(stderr, "main: Statx failed with %d."
+			" Failed to determine atomic write limits, "
+			" disabling!\n", ret);
+		return 0;
+	}
+
+	if (stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC &&
+	    stx.stx_atomic_write_unit_min > 0) {
+		awu_min = stx.stx_atomic_write_unit_min;
+		awu_max = stx.stx_atomic_write_unit_max;
+		return 1;
+	}
+
+	fprintf(stderr, "main: IO Stack does not support"
+			"atomic writes, disabling!\n");
+	return 0;
+}
+
 #ifdef HAVE_COPY_FILE_RANGE
 int
 test_copy_range(void)
@@ -2356,6 +2437,12 @@ have_op:
 			goto out;
 		}
 		break;
+	case OP_WRITE_ATOMIC:
+		if (!do_atomic_writes) {
+			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
+			goto out;
+		}
+		break;
 	}
 
 	switch (op) {
@@ -2385,6 +2472,11 @@ have_op:
 			dowrite(offset, size, 0);
 		break;
 
+	case OP_WRITE_ATOMIC:
+		TRIM_OFF_LEN(offset, size, maxfilelen);
+		dowrite(offset, size, RWF_ATOMIC);
+		break;
+
 	case OP_MAPREAD:
 		TRIM_OFF_LEN(offset, size, file_size);
 		domapread(offset, size);
@@ -2511,13 +2603,14 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
+		"fsx [-adfhknqxyzBEFHIJKLORWXZ0]\n\
 	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
 	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
 	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
 	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
 	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
 	   ... fname\n\
+	-a: disable atomic writes\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -3059,9 +3152,13 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
+		case 'a':
+			prt("main(): Atomic writes disabled\n");
+			do_atomic_writes = 0;
+			break;
 		case 'b':
 			simulatedopcount = getnum(optarg, &endp);
 			if (!quiet)
@@ -3475,6 +3572,8 @@ main(int argc, char **argv)
 		exchange_range_calls = test_exchange_range();
 	if (dontcache_io)
 		dontcache_io = test_dontcache_io();
+	if (do_atomic_writes)
+		do_atomic_writes = test_atomic_writes();
 
 	while (keep_running())
 		if (!test())
-- 
2.49.0

