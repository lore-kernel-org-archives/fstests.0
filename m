Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1833E0C61
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040064; cv=none; b=kCCqgR1P2rk6SI1WfYSoxGf8BD0Rt6UzNr95ysRuoGFeZQ01/twQTf9AdpM39bU4NUXMxVfT0BwvKT5p1AGK5JcFybzAednRomFSf+Yus3D+RAC68O+zQcBTBiPhYY5RQSLXYO0NKFYJTZpXjp055zuz2N6Qo83MbSENciJD/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040064; c=relaxed/simple;
	bh=JPLjIk5fADkT4iUqUrKFjZS3BGhagZ7I0OD8uJWMvbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qq6un5mnzUCWlmXK1tz2UdVBcsUqKtSvf/iuoNUk5Mt4pfRqpM2JvF62FiA6FCuGS526oYx2fpX1qKc8YKjqS2iNhLhR6mT5JeVnAzQydXUi4T7yaLfAF8CjRPDHooYx3D6PX5TFAkUyGndPdpX/QOVZDBG/HH6p2ZiCMNmU1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E23oFEOz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E23oFEOz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63166vNx3415434;
	Wed, 1 Apr 2026 10:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q7Lz3gjkpdyllIdma
	IEtLaXA540imSrFY5xEAO1cch8=; b=E23oFEOzFvdxoiC0VUVrlctvAv1y5lkwa
	sCiOQ3sEObMra0L9XsYT516mP6/KbaqTevfjMUvR6ZlLoWuSOX2pyKdKnYFvPLQV
	vFaXR3647WXQ47rHA+7q50v0KuKGAtMzvcnROfGvdYRh+OsCpaxn/E+arBDTqQ+6
	0EA867fuE1yaSytJOFpazJ0AN5CskeYgFBB+lJ42vnBaZaNihFHFLfKBqAtmcCp3
	FthHjElW7ulPMYny1MWOrIWiS0ONGNAX9g8zKKnUOqAn0j7EYM7G+DLdKAy0hi9L
	rY8yAtwpYuaX/N1NBIQwv/PlB8xmWVNKF2ydJNQySnXGbygEhUTmQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q37mxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:40:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6316oKxf013936;
	Wed, 1 Apr 2026 10:40:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkn2ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:40:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631AesAC30212584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 10:40:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF502004B;
	Wed,  1 Apr 2026 10:40:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33FE120040;
	Wed,  1 Apr 2026 10:40:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 10:40:52 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 2/4] generic/765: Fix sysfs path for nvme partitions
Date: Wed,  1 Apr 2026 16:10:48 +0530
Message-ID: <7fe6154353d38b2dc308db16d8125b83a8ed7daf.1775039135.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w1EGyXRfDilFZZRScQ6CCIW7qJHoSsJk
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ccf63b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=N2XrvNo2RXe1pFHzyEwA:9
X-Proofpoint-ORIG-GUID: w1EGyXRfDilFZZRScQ6CCIW7qJHoSsJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NCBTYWx0ZWRfX6nhIRimzPeG3
 jY3jHXwGdwQM/SCj0SHAC9+p/k2mJq2pOkffey+FuKzMHJ9nAJ2LWIflx14odxRbwMjymnLolI2
 +//hlH/gs+Vo9+kA20DN2jRsWChuTsnY/WdNspbiqN8pneFLtEPn/3/WVtwL16PAX/AGA/sBIvx
 hdcJ7GMvM9UDJ5vEdTcyvAHPSmffhBxGjR9+rtzx0ujizjDG7ALkwODGexgyWpHhoepuh1dMjZE
 hT3ZBZQa/P85uMHLD4OtKPt346nPgZWD1hU8YBqpJYdMctuaXgkiCz3Q8qkmgPCZXyj+dCq1xrv
 7hlzx1IHIDu1NMWMr32U0ajtnnARwxbm/TA9rdR9IHC3ZJSkcrw3qbKNMwonKzprCcyizEg5jHo
 FoELO9a9ZvWRwzG3YBatRUo/tCjBJFdu77MfNHsxygh9H6UKsw/9HjlSUl9rAva+kHNZ/C5MfA/
 QYikDe1Wfy24leub9YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010094

This tests checks atomic write limits reported by statx() are same as
the ones reported by sysfs, however nvme partitions don't have the
/sys/block/nvme0n1p1 style entry and also use the namespace's queue
limits for atomic writes. This causes the test to fail because it
expects /sys/block/nvme0n*p* to be present.

Hence, in this case, just check against the parent namespace.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/765 | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tests/generic/765 b/tests/generic/765
index 8c4e0bd0..4c768783 100755
--- a/tests/generic/765
+++ b/tests/generic/765
@@ -94,16 +94,31 @@ test_atomic_writes()
     _scratch_unmount
 }
 
-sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
-sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
+# Get the right sysfs dev for the atomic write device
+get_aw_dev() {
+    local dev
+    dev=$(_short_dev "$1")
+
+    # Special case: nvme partitions don't have the /sys/block/nvme0n1p1 style
+    # entry and also use the namespace's queue limits for atomic writes, hence
+    # just return the parent namespace.
+    if [[ $dev == nvme* ]]; then
+        echo "${dev%%p[0-9]*}"
+    else
+        echo "$dev"
+    fi
+}
+
+sys_min_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
+sys_max_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
 
 bdev_min_write=$(_get_atomic_write_unit_min $SCRATCH_DEV)
 bdev_max_write=$(_get_atomic_write_unit_max $SCRATCH_DEV)
 
 echo "sysfs awu_min $sys_min_write" >> $seqres.full
-echo "sysfs awu_min $sys_max_write" >> $seqres.full
+echo "sysfs awu_max $sys_max_write" >> $seqres.full
 echo "bdev awu_min $bdev_min_write" >> $seqres.full
-echo "bdev awu_min $bdev_max_write" >> $seqres.full
+echo "bdev awu_max $bdev_max_write" >> $seqres.full
 
 # Test that statx atomic values are the same as sysfs values
 if [ "$sys_min_write" -ne "$bdev_min_write" ]; then
-- 
2.53.0

