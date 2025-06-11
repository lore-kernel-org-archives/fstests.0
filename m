Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EA2641E3
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634509; cv=none; b=svqheO3Ue6steG2P5foWA+AQjF9ATKS2siTFukDMpzjsmi+1q193gYBezumosVmUF3x9s9XmNZl4Du1uqAFZa4ryKlxFAwHzsI7v0WOI7j9jslbI0DnBNOs9kJmu+IqIFCjAPHYy5MzkUn54+41O8RJcoWdOuZr+5A4iQokcMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634509; c=relaxed/simple;
	bh=XWNlTB9ocbZhvxV0k3q+bbMUx1U1A04Vz3eHiHeM0iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d63Jc+O38XnFWtIEsXe2g1DacQSX/E8qIbVJoAgyq4CMZokiAhbeFO0Kj21Hj8x3TBaWYf/C2I0BqHQlaDm3ZBz2T5c9cbrsoeoXUqJwMu6ySea80hJ9lbUX6GHY2yeZrWMrPUkUGoBosIFE5Mq21aBxATusPvph6XpwOAWd860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nlnsRLj/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nlnsRLj/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8oVDm029630;
	Wed, 11 Jun 2025 09:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sPhmretFW5YM8TVyN
	IQSEGlSoPKzLFAA8+ijOmeWlmo=; b=nlnsRLj/QrZxRqfmipCjeNvWOiy2cSSwZ
	IfmXBcmXRplWKGXb8cs756YbFAUjb/Vpo1tSwnPknrX+764KOfOjn8EmYRmWV0u1
	kAcHa45vVxGaxJuuAONEXFiamU/wme1DW67wWpcfNTKNdI05jnIzpq9ZaZPkorf4
	ljqtEZRLSVCYQkawmSIw3PlqSxet/2+UtgRXrZC/vUDl9Xk+nUD97dE+SKggIA/m
	sMOf/6JuFBRpl7MliWbORSb1Bwsi887grZqtI1lK/ElZylnnlq7Eh9x+4cC7gUpa
	wfQOWRz/ATrkpHshFhGebx7yuAWZukjgMi6FZ9dhU2JjGGzlFPTPg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7kg0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9WVBA003064;
	Wed, 11 Jun 2025 09:35:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7kg0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B5MXfV027957;
	Wed, 11 Jun 2025 09:35:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mewtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9Z06Z45744530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE9F520043;
	Wed, 11 Jun 2025 09:34:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01B42004B;
	Wed, 11 Jun 2025 09:34:58 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:34:58 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Date: Wed, 11 Jun 2025 15:04:44 +0530
Message-ID: <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Ax06Rotb8BlHqKRFyZzQK1sv_NrqtWHQ
X-Proofpoint-GUID: 0f7M0SEBLGJpK7bHefwygcsJEDsyyPY1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX86hRg9kA7YEx /ATPJSvMXYIhEmsuQNZuuUeFmsMKKu+Cs3Xfhu3o02ZkZy/jTYXjMv+S4T15nxTkUsI+o7cIavl mqA1EhjWjZqDD2sLIRL8x7QxCxYl5GMGeynnxPAXAYnZALxDRGxGPxSo7uiOslbMsRgi3i02BRC
 Y3n0itRML+Kuk3MSMOdds06s/baVckBQsXd4EfEQPo6S1zQVrRYNac/zn9BvHJz8XKMDwy4uk5q cgmTtoNesyLw5uqFRn1xwATH2vHlu4qOlASAWbBoDJbB+IdHJnzLrm63eDnXEhAvgdkxDi63DoT 0sOGeuBIePDxobMauC/9qhih5YSsQNeYUHf/ASBvP3CcSJEmFDqH8eEsAL+mMkBdF03EPfn9V78
 OYHJAu10iio2gJS98vWTYb0nPvO6EGzGam1W4qa4jGEb1LdISj74jOEFlautZ6tzT4gNSVb2
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=68494dc7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=hJ8b0eEnM4KluABJDUwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=798 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Insert range and collapse range only works with bigalloc in case
the range is cluster size aligned, which fsx doesnt take care. To
work past this, disable insert range and collapse range on ext4, if
bigalloc is enabled.

This is achieved by defining a new function _setup_fs_options
which can serve as a mechanism to apply FS-wide options to
the tests.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/preamble | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/preamble b/common/preamble
index ba029a34..2bccff74 100644
--- a/common/preamble
+++ b/common/preamble
@@ -24,6 +24,20 @@ _register_cleanup()
 	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
 }
 
+# setup FS options only to be available for each test run
+_setup_fs_options() {
+	case "$FSTYP" in
+	"ext4")
+		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
+			export FSX_AVOID="-I -C"
+		fi
+		;;
+	# Add other filesystem types here as needed
+	*)
+		;;
+	esac
+}
+
 # Prepare to run a fstest by initializing the required global variables to
 # their defaults, sourcing common functions, registering a cleanup function,
 # and removing the $seqres.full file.
@@ -55,4 +69,6 @@ _begin_fstest()
 	# remove previous $seqres.full before test
 	rm -f $seqres.full $seqres.hints
 
+	# setup filesystem options for a given test execution
+	_setup_fs_options
 }
-- 
2.49.0

