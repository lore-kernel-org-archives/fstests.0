Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104225F965
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634513; cv=none; b=iLNwYXwaElQ/p13C6xrux0dHvPR13oDqliyRrqfitUPrIexi4MqUXYxOUScsH0U2l5A2E3IS7kBvTkTeCnkna0jdWX11ZtkLFOYZbIy0v7LrVrJiGEo9juDZYprUOpDoueF0DO0MjP7fZrloYnanJ3FFAqxMJoD1OUnKYB7i2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634513; c=relaxed/simple;
	bh=YP7zFdHDbKMbJDm/YRP97bEqEuLmRIQaFl3kc5zOoU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+wt+tP77MjE7VjYPZyOmspD152HS7ezxEcdr6Gm7poXZtve045vC6WjKi+lb6OTtxQZwG9ciYT/ZtqFJkAzGNFoin1hJ/egBDWGtBPMLJpZZ2Y1lvqq+4yB5W6pnyIrqMWvmH585tOpSLqHaTitQvXqSR+QIzbZLp9W7oRAX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hISRrxtT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hISRrxtT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B6UHFZ021238;
	Wed, 11 Jun 2025 09:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NUMxAm0Csx24Wh7LK
	sdp9NgZNXFsx1oDmF7c9WYZXCY=; b=hISRrxtTQG/C5yNNamLqujFmFB0ebvfVu
	Yz9xd6xfrR649My4cKO6d7cUzDjLLX1LF8RqeGwjtL1UxqdbYwpPvrvGR5xmw0y7
	H1EZ+RePCyPRfIJO2ETCY3/ndiuCB0rP0SJE1UNqwKCmiFr78zVPa5uqSW+fndJL
	Rf4Z4qc4WtcpD5mTJJa9ctFQP26iW5rXptiAAev5dIibsHmDV6gp7aGeRX0wt6gi
	44q+WGByy/V26FUBSCSx8L+euWbx/kZRLkTBVqkKRZznCbyTTppQI65MoTwOv8fX
	zqiq+k9x1cs4SxQoH+87QnLD7ytOTb/gpMYzzV7HvVld61SoHlcYg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m8qaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:06 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9LEDe022235;
	Wed, 11 Jun 2025 09:35:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m8qah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8ti3K021879;
	Wed, 11 Jun 2025 09:35:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47504yy4ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9Z3mk30998898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A38D2004B;
	Wed, 11 Jun 2025 09:35:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C28220043;
	Wed, 11 Jun 2025 09:35:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:01 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 03/12] ltp/fsx.c: Add atomic writes support to fsx
Date: Wed, 11 Jun 2025 15:04:46 +0530
Message-ID: <07d5d00e4ebc24b4dd4c718b29dd14867fefdd70.1749629233.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749629233.git.ojaswin@linux.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=68494dca cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=T5_vRgAD47iBWrMonTEA:9
X-Proofpoint-GUID: BdzyPnsc3NjuqU1G_R49lT5iWu7NEKIz
X-Proofpoint-ORIG-GUID: WrJrqNj16IFdRBqmDP_RhJLZSYZ7HFbh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX7rDWAVmuDvIX SsJGQjH2U//KcTPy6vhLjF7lybjvXZGDRIRynBbeGr01OM3F5ZudlV8BX8HUhWXijU4HcCDjCMf tdd6nhGvUhIZQEc4fyAnWC0FdxRFeGD8I6CiYoy4Yix0dFpy0thhskb3ji50qM7H/vK2++HzBG0
 aRYf/TwyUI7oX7Dl87UyjWTpB2z+YcxxY/9tvYyZFOSh4Xoae20Npc4DMs+TsUB458b+lo3FOVi jzWxFFmYP9Ece8CBUCMM5fE++jORhyDB3cNS4UD/6gYNa0qJOnoS4ZcZQ8B7iVFEof66Mn6T+NJ 6+7MofhkPUZB+UnWk5KQ6hMEbngKjD5G8lSfPCSldE1GxHqvORWr0cpek6A5yW1Ja6NO5SdwcLf
 VUO047xFhFrXkUVTWotvRntyf0lQTlxqhEs3LMZinTrwSJWD5reYR9HIaL604kOaf6nt9P9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

Implement atomic write support to help fuzz atomic writes
with fsx.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 ltp/fsx.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 5 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 163b9453..9353fe6f 100644
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
+int	do_atomic_writes = 0;		/* -a flag */
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
@@ -2385,6 +2466,14 @@ have_op:
 			dowrite(offset, size, 0);
 		break;
 
+	case OP_WRITE_ATOMIC:
+		TRIM_OFF_LEN(offset, size, maxfilelen);
+		if (do_atomic_writes)
+			dowrite(offset, size, RWF_ATOMIC);
+		else
+			dowrite(offset, size, 0);
+		break;
+
 	case OP_MAPREAD:
 		TRIM_OFF_LEN(offset, size, file_size);
 		domapread(offset, size);
@@ -2511,13 +2600,14 @@ void
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
+	-a: enable atomic writes if IO stack supports it\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -3059,9 +3149,12 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
+		case 'a':
+			do_atomic_writes = 1;
+			break;
 		case 'b':
 			simulatedopcount = getnum(optarg, &endp);
 			if (!quiet)
@@ -3475,6 +3568,8 @@ main(int argc, char **argv)
 		exchange_range_calls = test_exchange_range();
 	if (dontcache_io)
 		dontcache_io = test_dontcache_io();
+	if (do_atomic_writes)
+		do_atomic_writes = test_atomic_writes();
 
 	while (keep_running())
 		if (!test())
-- 
2.49.0

