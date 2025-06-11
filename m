Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28877264611
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634510; cv=none; b=LuCRZk3fcX8bXQQvPxGzvn5ZaLpT5kBkKECWQvJlKTpSm3yOafhruZkF5BPhuLIkNF5UuJp+Uir8+Uf+5T6VFrnv2ad5uS3H3XQTJcIdTjYifooiVnCQj55Wxw9qm4kPNroQg7GiYdFL3IOLjjz43PNCkm+br9NVnQIK4qHB99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634510; c=relaxed/simple;
	bh=gjgfD1N5Kz0TcBUBqhKInLX/6+8MHepzFTDXYyXMmU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHer06c8FdMEOSquNiAT8y5QqtaYrDusQEyVLV+Bxa1MzhCstNysL0/HfRhD8H6VEnvRMswZc2cSPPNBOnysYeCOrajoPQeSIiT7cpkvPyxE8ui97uLH0Ng24x5G+2YeTrjMyQC+tqyWunFdLR+4w8u0S98mSVhaT8TExToRWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y9VveekT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y9VveekT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8YBjb001248;
	Wed, 11 Jun 2025 09:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+n45heQaG7GKCWd7S
	SuuhAFEAlKBJDdW38d4ok1j5+4=; b=Y9VveekT3Bw3oIi2cUD+CSVZ8ddznMcnG
	BlEPi80lAEcud9fwenfq5wc7+osXJZCj0tK8r6IAf0QKqYt45T57Gg8/pnj32gFF
	nejVZ7mfJZpYtjmW71DuOjXCXB+A6J/LZsCmfEAy4+EiaGHaljOJvIXf/Crch4vc
	SJL6pivp3aejjqygfSzXXdirDytGvzBliCbcH5c5j+ZTYlKALz7ff0eJHIJwS4MR
	qMP5hpIm2AVCoB6OGFvolU64js0REwrDwUlYyp37PSGBWwWM0hm0Qcp/78h8asS6
	835hx/0nKdBE/nCkP94MSqxwh897X7qJ/KiDV4qzA4A4jJ88mXRvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyr8qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9LXl3031262;
	Wed, 11 Jun 2025 09:35:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyr8qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8Plv3015180;
	Wed, 11 Jun 2025 09:35:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtf8f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9Z1eK57934256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:35:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976D02004B;
	Wed, 11 Jun 2025 09:35:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E74D20043;
	Wed, 11 Jun 2025 09:35:00 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:35:00 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 02/12] common/rc: Add a helper to run fsx on a given file
Date: Wed, 11 Jun 2025 15:04:45 +0530
Message-ID: <0a0604215a992f0aaa4d8d6821b8c8051a0f8d80.1749629233.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZsK4uxzpy9rMVOPbHgZDfDsZYmU6sGmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX5hrnfvZOIJ/1 9hVK9vQ/kHVLIvUV99q5KZxWGcdOnR/N/8nABrOTKL/q3H9XrGPhtJWSINV6zzz8e4zjRe7bbsJ KLE9I18AgiOeT9ED3q5QDVnBp2AWc+qkVq4GTXYGb5CiuUql5j/2zLJfcPT5D1oeMPUfsxVjjid
 Yiv2TvWYGAcwWQQRzst3I366u71YXx5lBGO66iO0PKSN3LOuqiNJB8Z+Ni6SQt0Fk3udnNObqnq XmaqG7lNE1fOpsmra8iizZEy0Yoza4B+jG9gTq5UlMm81ky2rQELdX989WXi+/LzxTpnEBn2X73 mUHA5WHcjk/IhnQg9XsYXHNSd7j7o8XAa6pq7lL9MJMVeDednYPmxD1+YLoWvP0unmxcwKzWa/G
 dzjuuhTozV9lRiZSiTgMiONYcXE7MCB1kFuMlvY2taSGBj8ZXSUEOwtKl+qlh2/dDCZGAhkQ
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=68494dc8 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=u_VYNAqGXo6OSSAA:21 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=EfcJlRrZmV05EoLhlkQA:9
X-Proofpoint-GUID: IraZNi2UtmC6IT7qziupSki99frgLQrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=801
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110079

Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
Add a helper _run_fsx_on_file so that we can run fsx on any
given file including in $SCRATCH_MNT. Also, refactor _run_fsx
to use this helper.

No functional change is intended in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index cfbe2a5f..a5d811a1 100644
--- a/common/rc
+++ b/common/rc
@@ -5115,13 +5115,22 @@ _require_hugepage_fsx()
 		_notrun "fsx binary does not support MADV_COLLAPSE"
 }
 
-_run_fsx()
+_run_fsx_on_file()
 {
+	local testfile=$1
+	shift
+
+	if ! [ -f $testfile ]
+	then
+		echo "_run_fsx_on_file: $testfile doesn't exist. Creating" >> $seqres.full
+		touch $testfile
+	fi
+
 	echo "fsx $*"
 	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
-	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
+	set -- $FSX_PROG $args $FSX_AVOID $testfile
 	echo "$@" >>$seqres.full
-	rm -f $TEST_DIR/junk
+	rm -f $testfile
 	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
 	local res=${PIPESTATUS[0]}
 	if [ $res -ne 0 ]; then
@@ -5133,6 +5142,12 @@ _run_fsx()
 	return 0
 }
 
+_run_fsx()
+{
+	_run_fsx_on_file $TEST_DIR/junk $@
+	return $?
+}
+
 # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then skip
 # the test, but if any other error occurs then exit the test.
 _run_hugepage_fsx() {
-- 
2.49.0

