Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840802F9C37
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802982; cv=none; b=gV1MRWeqb102e7LcuwWL6t0vbkWPCvGPtusxE8bs2ILsWS3zMvYpG/DigIgYMj0VlU1gnxHGn+7dGtpsPjw1waLskT1k86ZRIoxPuZwx67TtVEnHP4CPkOCy36f3len5MSIb+XhVXU7BMzFlyLdt7uleEdFpZj2+Gg3dnaUNL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802982; c=relaxed/simple;
	bh=JKFCE/LrsP/pmA2MibxOYWf18jweTfFXDZGk+3kwMiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jD6I7EtvGDT1M7+yz7rrKR9Iy+ALxRkUncN5t032CthBEl4ZVbulkZ0QZGtNcN1fKuKhas3mNC3iGy7aZ+GPXchR2JGCiUwrqpHREhF2VNOaNnRs3G3VVHSE0VrnPLImdDGKGmC1fSuwa5DUOxaI+qzZ9XZCdQT9tsGn/wqsMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qdnZ4ELV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qdnZ4ELV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A3nXcm665439;
	Fri, 10 Apr 2026 06:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F6mIpdkjr/Pd0yBE7
	3tnxZDe59D4iQ4UcT5T/LRHv/4=; b=qdnZ4ELVxqDVhbzQUCnVk4s3wkhMk2E5l
	C4V52DIosCj8GNmWDrIMst1aQ2XdC2TgukrRYYXWeK36/iBQkTsNeaLVjPXpq3PV
	/RV0ck3nwMc5o7VOPRXQo0nGObTTBvGrGWmHeDBjyFvRhQuoaEPDhRjTmJDCGfTP
	3DK+SfjIv8V6GG+1KWSfVKzuaUQ/HVfbHCzGXTUk8hnl9cxSauPpKF7MdDk6ykYY
	Oqs1W1ATp0SKbVO62L8EP1GJvq3uTf9pAS/5Js25qsk+yH+1m9v3QGzITsQEsPQF
	QKNzMNE7x69mQvVeKsKGQmLGZyOElIaYvaRx06ZBlIzNCAYkkJ9TA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2egp98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A36ueE018987;
	Fri, 10 Apr 2026 06:36:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9pvrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 06:36:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A6aDfN28115246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 06:36:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A575720043;
	Fri, 10 Apr 2026 06:36:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D138220040;
	Fri, 10 Apr 2026 06:36:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.bl1-in.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 06:36:11 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com
Subject: [PATCH 2/6] common/rc: Add _sysfs_queue_path helper with partition support
Date: Fri, 10 Apr 2026 12:06:02 +0530
Message-ID: <b88d249da588e8caf671088b34ced493e494d595.1775802601.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775802601.git.ojaswin@linux.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DmaW-eBNrskzdZ8UJQVER1jcQkVzpgia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NiBTYWx0ZWRfX313UwBaM2W+R
 iWsTArIG6h7hxWW4at7IVMdiSRHYtRdYx8AcJbJQaOwIe8GZMRvhlEpbp4mXSEtfsD5M/w0d0/v
 xSyTZF8m50y0pzYrBd7WVFjct4seTFRIEVBiWyzRHbhkXU3kJJmRmXPJzV18Drrc8GbdQw3bLwM
 yEYK4fThPuO/V8ZnJEdEHkLCa9/zyF979l/ho2PxDJbk0e997VXGBCFSBEBBQfvyquZy4tRMzrO
 j7J96tnTtj0kS1uunUbKWsEA2D9PHAdjJl+bgkLAvj+g5GlZiDnlv1K1/rMFJQ5IKVec0yGzvNL
 Z5ORsyJqiC2L9WOv8sKkvoR2yzyL7wTReqcuRtNLYMmbCG8m8cBbRN9nlSENKicg48NdoO8Yilp
 6IyAZRx6Uab4oS/YSd5GkpcnZlCurRhFL5ALWqkBwN9El/56Rz04dWRbsMUbLW/uL697Rhfkmkj
 tDq4PKxqp3UV6v/ttCw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d89a60 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UZRX7DcmRG9A2A2oSvEA:9
X-Proofpoint-GUID: DNWFN7tpUVTgWEZdCKN4cRSFEgGIFCKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100056

Add a generic helper function to get the sysfs queue path for block
devices, properly handling partitions. Partitions don't have their own
queue directory in sysfs - they inherit from their parent device.

This helper checks if a device is a partition and returns the parent
device's queue path accordingly, making it easier to access queue
attributes for both whole disks and partitions.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/common/rc b/common/rc
index 5fe44e21..d7db5db1 100644
--- a/common/rc
+++ b/common/rc
@@ -5172,6 +5172,30 @@ _sysfs_dev()
 	echo /sys/dev/block/$maj:$min
 }
 
+# Get the sysfs queue path for a block device, handling partitions correctly.
+_sysfs_queue_path()
+{
+	local dev parent
+	dev=$(_short_dev "$1")
+
+	# For partitions, queue details are in the parent device's sysfs dir
+	if [ -e "/sys/class/block/$dev/partition" ]; then
+		parent=$(basename "$(readlink -f /sys/class/block/$dev/..)")
+	else
+		parent="$dev"
+	fi
+
+	local queue_path="/sys/block/$parent/queue"
+
+	# Verify the path exists before returning
+	if [ -e "$queue_path" ]; then
+		echo "$queue_path"
+		return 0
+	else
+		return 1
+	fi
+}
+
 # Get the minimum block size of a file.  Usually this is the
 # minimum fs block size, but some filesystems (ocfs2) do block
 # mappings in larger units.
-- 
2.53.0

