Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F19D2E1
	for <fstests@vger.kernel.org>; Thu, 21 Dec 2023 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="taiX/0N+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL5eCA9025980
	for <fstests@vger.kernel.org>; Thu, 21 Dec 2023 06:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KlSRMoSGX1LzE149zQpmYVylWjyY0qj+wAjVR2LlpAg=;
 b=taiX/0N+g0jMQLqzRSU5kCffHELhbjaoKG7xmRwK6DV6W90kaVVlpp0qdLm8JLYqDyN0
 TYiaRZ0niHNnL4YeNZJNaS2nMXuCvQ2WPISs2uiWkPSYHlTOFB0/o5R+Ti8ZMIv9OqsU
 tEOIdCQAEkLBedYk+2/4aIyG9LtVUrEpMqcKsz3IPuZjGXTTnEfpEZI7rGOoR+5HJR9J
 3mkA0GccFO59vXJ2Pv6npXWieUSPUwWgepZSbKZiimHWuHmhPfSZADNlLD1MHPx2mHzZ
 qR/fnWNk8Ts9PU9uBr0hmpe8ht6zz/rE1t5JricKW2WwrivnddDGnnC2Z5CrizY4XWCB 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4d645t1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Thu, 21 Dec 2023 06:12:44 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BL5rKJI022510
	for <fstests@vger.kernel.org>; Thu, 21 Dec 2023 06:12:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4d645t14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 06:12:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL34A3V010840;
	Thu, 21 Dec 2023 06:12:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nu5p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 06:12:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BL6CdNu25756338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 06:12:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F3120040;
	Thu, 21 Dec 2023 06:12:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 480B92004B;
	Thu, 21 Dec 2023 06:12:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.87.88])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Dec 2023 06:12:38 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH] xfstests: replace custom __u64 definition with uint64_t
Date: Thu, 21 Dec 2023 11:42:31 +0530
Message-Id: <20231221061231.44347-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Di8GXZ-c8M-BQroh1UiLYyjvRaY4uS9
X-Proofpoint-ORIG-GUID: OVs9fj1Whjck1QtcNpNpi3xOeBLBjnm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_02,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxlogscore=789 clxscore=1011 bulkscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210044

In some distributions, __u64 is already defined in system header files,
causing compilation errors when building xfstest.

	# make
	    [CC]    ext4_resize
	ext4_resize.c:17:28: error: conflicting types for '__u64'
	 typedef unsigned long long __u64;
	                            ^~~~~
	In file included from /usr/include/asm/types.h:26:0,
	                 from /usr/include/linux/types.h:5,
	                 from /usr/include/linux/mount.h:4,
	                 from /usr/include/sys/mount.h:32,
	                 from ext4_resize.c:15:
	/usr/include/asm-generic/int-l64.h:30:23: note: previous declaration of '__u64' was here
	 typedef unsigned long __u64;
                       ^~~~~

To address this issue, replace the custom definition of __u64 with the
standard uint64_t type from <stdint.h>. uint64_t is part of the C99
standard, offering a standardised approach for representing unsigned
64-bit integers. This modification enhances code consistency and
ensures compatibility with standard types.

Tested on various distributions on Power architecture, by successfully
compiling xfstest. Additionally, verified the compatibility by running
ext4/033 and ext4/056 tests, both of which use ext4_resize and
observed successful test execution.

        # make
            [CC]    detached_mounts_propagation
            [CC]    ext4_resize
            [CC]    t_readdir_3

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 src/ext4_resize.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/ext4_resize.c b/src/ext4_resize.c
index 78b66432..6e60ee5b 100644
--- a/src/ext4_resize.c
+++ b/src/ext4_resize.c
@@ -14,10 +14,8 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 
-typedef unsigned long long __u64;
-
 #ifndef EXT4_IOC_RESIZE_FS
-#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
+#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, uint64_t)
 #endif
 
 #define pr_error(fmt, ...) do { \
@@ -31,7 +29,7 @@ static void usage(void)
 
 int main(int argc, char **argv)
 {
-	__u64	new_size;
+	uint64_t	new_size;
 	int	error, fd;
 	char	*mnt_dir = NULL, *tmp = NULL;
 
-- 
2.39.1

