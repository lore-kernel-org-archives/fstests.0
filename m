Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C369D0A
	for <fstests@vger.kernel.org>; Fri,  1 Mar 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280969; cv=none; b=LCSr45yxM61sC3RCsFgH3xEreQwuAiW6zYLxcO8sicki6uLpASTJtypmBFjs0tJUytUbBw7mGItXCSX3pAw7rRDGk1Zo/e7wfg8jdfnVuvKr/eBOCIlahcDbhdxul6YGnZhh8q4BkwqpHu1+4K87HI9BycAQlSnwXbAC1iPAB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280969; c=relaxed/simple;
	bh=uVFBqaMaxktm+G+3zG/BkrY9PkZNu/2mvE9jNRmYVy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QnmSXxQevvczSS+nUKm6R3KnJrWMwVnBihTvMPerhRV8ue79p88lRNJv9n/wAET9RuyycAHCTCAnAeWleiXmRuO6w8zhdhoX6pF4bvj2UZN7a57ROxtTiVl0JfCk0ApRxzDNw3nV9WojGvF6D9rupwB8GPRW8vF5CoWR5UogjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dtmf6kPz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dtmf6kPz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42187BOA014713
	for <fstests@vger.kernel.org>; Fri, 1 Mar 2024 08:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=AxSTkyfbJC27lVKwozbxKwWu/Mt6fjNhWExQE/Uhrk8=;
 b=Dtmf6kPzaxG3O4CF2viHV3NQc5rRuZJ+amT0nZg6BJ7/Z97UxH/HJ5/J8NJfuECy4dM8
 KajsZ3NBYaPL9mgwI4unxac2OeDUX0yc6N/7BK9d7mmM7N1MiJheNwLw72/A9s65kwlT
 wTKJT1RVQSItXn6CPirtfKS26ci4SEDhu2uaZIQB62tKKhWIjtu8bUmPG5l5B7wDS67B
 MjmVg9uXOEHbc3grY7f/fjcogSXuNVNsTWgyQ6YasFXAMfzgV+UK6V62RTAY/V5QW7HC
 f/PD+0F6q1mmSJHBlpw9sEL8+T348cXMkhq3UPPwE64QJlUKNsedYtrwlqXpGaBUCmt/ FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkb7s8987-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Fri, 01 Mar 2024 08:16:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421885pA019808
	for <fstests@vger.kernel.org>; Fri, 1 Mar 2024 08:16:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkb7s8984-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 08:16:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4215s03Q024154;
	Fri, 1 Mar 2024 08:16:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0kts7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 08:16:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4218Fxhr38011350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 08:16:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9419A20040;
	Fri,  1 Mar 2024 08:15:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A7F020043;
	Fri,  1 Mar 2024 08:15:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.89])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 08:15:57 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v4] xfstest: add detection for ext4.h presence in configure.ac
Date: Fri,  1 Mar 2024 13:45:40 +0530
Message-Id: <20240301081540.30236-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s82y-zCyO4fge735vBMyRCirARM_tv57
X-Proofpoint-GUID: ckXaloga2rkCq4ZM2kIKcJrfKmqFO5e0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_05,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010068

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

To address this issue, configure.ac now checks for the presence and
compilability of <linux/ext4.h>. If found and compilable, the macro
HAVE_LINUX_EXT4_H is defined. The commit also updates src/ext4_resize.c
to conditionally include <linux/ext4.h> based on the presence of the
header, ensuring compatibility with systems where ext4.h is either
present or not. Also include <linux/types.h> which gets __u64
definition on systems where ext4.h is not present. This change
enhances the configure process and improves code consistency.

The changes were tested on various distributions on Power
architecture, by successfully compiling xfstest. Additionally,
verified the compatibility by running ext4/033 and ext4/056
tests, both of which use ext4_resize and observed successful
test execution.

        # make
	checking linux/ext4.h usability... yes
        checking linux/ext4.h presence... yes
        checking for linux/ext4.h... yes
            [CC]    detached_mounts_propagation
            [CC]    ext4_resize
            [CC]    t_readdir_3

        # make
        checking linux/ext4.h usability... no
        checking linux/ext4.h presence... no
        checking for linux/ext4.h... no
            [CC]    detached_mounts_propagation
            [CC]    ext4_resize
            [CC]    t_snapshot_deleted_subvolume

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---

Changelog:
v3 -> v4
Addressed review comment from Darrick by incorporating autoconf
best practices by only using AC_CHECK_HEADERS which is by default
going to define header file, to align with autoconf documentation.

v2 -> v3
Addressed below review comments from Darrick.
Replaced the explicit AC_COMPILE_IFELSE block with a simplified
check using AC_CHECK_HEADERS for <linux/ext4.h>.
Added unconditional inclusion of <linux/types.h> regardless of
the presence of <linux/ext4.h> in ext4_resize.c file.

v1 -> v2
Drop usage of uint64_t to match the definition in the kernel uapi
headers. Use <linux/ext4.h> or <linux/types.h> based on the
presence of the header to get the __u64 definition as suggested
by Darrick.

Link to v1:
https://lore.kernel.org/fstests/20231221061231.44347-1-disgoel@linux.ibm.com/T/#u

Link to v2:
https://lore.kernel.org/fstests/20240103184208.80772-1-disgoel@linux.ibm.com/T/#u

Link to v3:
https://lore.kernel.org/fstests/20240109111105.28836-1-disgoel@linux.ibm.com/

 configure.ac      | 1 +
 src/ext4_resize.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b22fc52b..f45bc68e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,6 +33,7 @@ AC_CHECK_HEADERS([	assert.h		\
 			btrfs/ioctl.h		\
 			cifs/ioctl.h		\
 			sys/mman.h		\
+			linux/ext4.h		\
 ])
 
 AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
diff --git a/src/ext4_resize.c b/src/ext4_resize.c
index 78b66432..31779225 100644
--- a/src/ext4_resize.c
+++ b/src/ext4_resize.c
@@ -13,8 +13,11 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
+#include <linux/types.h>
 
-typedef unsigned long long __u64;
+#ifdef HAVE_LINUX_EXT4_H
+#include <linux/ext4.h>
+#endif
 
 #ifndef EXT4_IOC_RESIZE_FS
 #define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
-- 
2.39.1

