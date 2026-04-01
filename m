Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AE3DD529
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038193; cv=none; b=m61fTXjEAAVioRLA84zL28MgBOzZicfdYEivjFwtmM1xv8/kc3/XvK0TGUZ7b1iburaS+2QQphHSIWZUb0lFVMExIn9vKXHEmrHTmOW5Ta0qcv0bjzI54QQ/+rtRzlCJa+cl/wEFifovsaK6scqgNSGIkDA3aHd/7XgtFu9NRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038193; c=relaxed/simple;
	bh=EmYHCGGb5n9Eebhf4oCJFDI8+SAuNykVRsaMkOlstK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNBpyS3HVgm9TFfwWF31xyewgnYPZln34iI+G1sITf9i1ITaShyRWlLVp2inS09HxSKxsHmqpjgUFll1wNYrHtQHQaol/L4nNadoChXRQidJ8iyUZGViDasrIRMjJWne8KaTQX4BLfTh7JYN/CrsPSufE+wl+b3N9u0i++jhEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pxY0Ww6A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pxY0Ww6A"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6318ihNu3405202;
	Wed, 1 Apr 2026 10:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IVOmmSeQzLcJkGps8Jbnz4aqkHKX0UQkQKKas9zY0
	+U=; b=pxY0Ww6A06w5OQ4mUyJAXgcq7d+D5w7xzS7ET/cGqwTf456pjxgyvB2lU
	jzp8DayLGFOc9h8sWnl+vylyKwMPy2cLYjOaHtafXP4/0hMuaBuRIe1u6NJenGDf
	I4KJ1HyRM7MzyC6qAn8ETnIy5OewXccORHuuB62JcXDsAhEI2yV142v9IxAag9LA
	K49wmlKGiShXlnM9de9ackFohBQg4br/6ENWfW4LZ1+0R5Q4/S32nrrQ3OC8whxP
	c2FqE1QGbjmq6SZNg0zRyjFcgvG5ctGZjlNn1Od8ZjB2n5B8IzsJgH668s3o5QVK
	mgPPwOexyOyd1JuG1T8ILqkuoqQ4Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1yk8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:09:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6317U9Ax013922;
	Wed, 1 Apr 2026 10:09:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkmyk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:09:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631A9ic652625706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 10:09:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF892004E;
	Wed,  1 Apr 2026 10:09:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77452004B;
	Wed,  1 Apr 2026 10:09:42 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 10:09:42 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v2] ext4/307: Calculate donor size to avoid failures for 64k bs
Date: Wed,  1 Apr 2026 15:39:41 +0530
Message-ID: <20260401100941.76082-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cceeed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=tD7rXHGb4Pc0dLWloNUA:9
X-Proofpoint-ORIG-GUID: vVvIhF76PIHy00PzcATJSjxTHfftELgY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4OSBTYWx0ZWRfX/RKzK6Y+VESB
 fO/KDHl3fgBSKuASOQk3+zCT+ODIOu0AZClDmJ6gRh7ThOXGPlgM99E0EdIgqKsoyzni0br3X+F
 1d8Zi0pE05oaHOoJqtooVJPzaa765csXJx+HetcVNhxJzGkK6olhqpR+TUVp77a1sAkb7geYGrJ
 RAJPhuNWIrBEDf83q9vIXuufZv9KWm0PV3QaeBT0niKTmFUw99VLWwFO0CFZZWA7XrgoZeKUam+
 tKNw5C8ZOlV2dHitoQDP+BQ2Nwh2L8lJxV36kYooLpJJaFB1RQbA3D5JvgI3YPzNKGgkFe1+w+c
 Qt/Y00e5Z5KlEF7iwS/U6kT7GXeyc7gVA247+MS8JdYCWyPJS0iW2NAgIiX2OwNx7IPB4PTVWRu
 YpFBGo0yWSqEJDo6Y+IMC5Hf94aKPezmeaDSSvLwyet5ucJkM/NVjCu8XOV5fwqApccMNku2zwR
 CwSDWacZa8t+zpmKDmw==
X-Proofpoint-GUID: vVvIhF76PIHy00PzcATJSjxTHfftELgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010089

Calculating size of donor file based on du output causes the following
issue:

e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
./common/rc: line 4616: 1583182 Aborted                 (core dumped)

The issue is that e4compat asserts that the stat.st_size of all files
combined shouldn't be more than that of the donor file. In case of 64k
blocksize, fsstress often creates sparse files which have >3G size even
though their disk utilization is <100M. Since donor file is not big
enough, this trips e4compat causing the failure.

Fix this by using stat.st_size rather than du value to get the size.
Also, make some changes to avoid future ENOSPC like reducing the -n
passed to fsstress to keep the size around 2G and making sure we use the
whole SCRATCH disk instead of 500M.

While we are at it, add some new lines to make the code bit more
readable.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/307 | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/ext4/307 b/tests/ext4/307
index 48073347..ed6fc664 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -19,18 +19,26 @@ _workout()
 	echo ""
 	echo "Run fsstress"
 	out=$SCRATCH_MNT/fsstress.$$
-	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
+	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
 	echo "fsstress $args" >> $seqres.full
 	_run_fsstress $args
+
 	find $out -type f > $out.list
 	cat $out.list | xargs  md5sum > $out.md5sum
-	# Use -m to get integer MB size to avoid decimals (e.g. 1.5M) which xfs_io rejects
-	usage=$(du -sm $out | awk '{print $1}')
+
+	# Get the total of stat.st_size of each file to determine the
+	# size of donor file. We use st_size here instead of blocks used
+	# because thats what e4compat.c checks against.
+	bytes=$(xargs -r stat -c %s < $out.list | awk '{s+=$1} END{print s}')
+	echo "Total bytes used: $bytes" >> $seqres.full
+
 	echo "Allocate donor file"
-	$XFS_IO_PROG -c "falloc 0 ${usage}m" -f $SCRATCH_MNT/donor | _filter_xfs_io
+	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
+
 	echo "Perform compacting"
 	cat $out.list | run_check $here/src/e4compact \
 		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
+
 	echo "Check data"
 	run_check md5sum -c $out.md5sum
 }
@@ -42,7 +50,7 @@ _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
 
-_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 
 _workout
-- 
2.52.0

