Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3D25F965
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634508; cv=none; b=K/HVMRsSampbox9NeXQbUibkkhmEMGnqqhZdbccuVTBDcTcVVOxFAanSX+dTlrnJBI1Ru8oH2ufxXcn2Fw9ljZ5uHqtTmJIMwu+xvXrix60STqcAxaz2YBr5LwDIfH7ly3RBXy0ZTNyWwzNai4IkzzGh5P0TXgXKlxZqnAtEyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634508; c=relaxed/simple;
	bh=tZnfg+uzgbphyuNqFXbVMrse28btRR7drbr6CtjqL7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJHN8FwXzhJSjdlilJvt7g0uK1wpa2qmUd1+scUHDAxrFlTT+Zm34QF08WavA7W0P9aiFLFf4keN+bqapWuwywqo5d8Tyozfj9bZpzygchpFPOijRbY6KPDaIHBnnU9UWIRdCeJNP9h07RT/RIJBj6t6CcDeTkD+WGwgaA8J+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TPibipt8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TPibipt8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B4XGr6024365;
	Wed, 11 Jun 2025 09:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qvuiQbNhkDfNxsiLYdJcSB5ydiCn7riXzNIvENwQg
	Ms=; b=TPibipt8mWyvqwLwXd7l1Xbg+SVzor39aC9sKgpJxX8qTmVdIIIjzyJ3c
	ICi15DeA6jfrLlHICqUdkjuX2cIFnHc2FkZn3xZTfojCoKh19trZ4fEV81njztDI
	YDDuO5m4Gp/TjGZNNXbX9fX9P5QXiZYCVNgkDaYqwq5Oaz7NWC1Px8A81kgGQl13
	EqNzRB5wFODZdyo0LKHSgmrdwPDZpQQhcfm826ylJa6nWdhZvFreXy97YocGqPgN
	Xk13EYbNS3nMZ0L2r8hcH6bBeT3y61sfqKal7m05ecHKhMtG1owMSMCsaQaOst+N
	obO98yxbxzpsg89jmsFcs8t07DyQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgujpy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55B9YlnE005743;
	Wed, 11 Jun 2025 09:35:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgujpxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:35:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B6GRkK003333;
	Wed, 11 Jun 2025 09:35:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykpsun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 09:34:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B9YwUZ46137758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 09:34:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BD0A2004B;
	Wed, 11 Jun 2025 09:34:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0ACA20043;
	Wed, 11 Jun 2025 09:34:56 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.143])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 09:34:56 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: [RFC 00/12] Add more tests for multi fs block atomic writes
Date: Wed, 11 Jun 2025 15:04:43 +0530
Message-ID: <cover.1749629233.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=68494dc5 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=SIyZsos6TlCTxII2x8QA:9
X-Proofpoint-GUID: lpEQohjyREyocwKwGbdW8OqGu23BKttf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX/HmTDwYks+BB 1K5aapCm7N/59yIhD5K2PPVjkOmSppeTLU/tcJXmsqvdgNY246RsaqydMAy/JV3uok9SEeTZb/b vp/YYvltjKDeW7WisbhWPXtKiZGCs3oGJCjBZiTJfMmGX8yJkdlGBWsmRZkWRkrR6tgncVj1c60
 iYantq0eNHsSdx7yTqxqnccBUTKGi6x+MVKbEQfNyfymc9BqjjtHwhMjO4+NSaXJjbKj0hljdx5 aDkixuspQw/ZQXgRJCU+zyJKUQ96bxl2AFlc/x3ZFhk+bbtC4Y1w+heeC5RM+cTpgwPzVSHdOOn dlM/Epg+ElyjSf/lbw/hnAsR6lEpQ78H48CKEekoRfBtepaT3rIoECPoEz2niPbfhoGGXj6MGyu
 tnhwgPgip5G72rKuDzEwgeEvS483N7VuFA7QHlYrxZopI5Are/l/JXFyJR6S/btfNEmFHu8f
X-Proofpoint-ORIG-GUID: WLXQMOTZARxT89imoxwnnsJUrLqBlnXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=998
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110079

These are the tests we were using to verify that filesystems are not
tearing multi fs block atomic writes. Infact some of the tests like
generic/772 actually helped us catch and fix issues in ext4's early
implementations of multi fs block atomic writes and hence we feel these
tests are useful to have in xfstests.

We have tested these with scsi debug as well as a real nvme device
supporting multi fs block atomic writes.

Thoughts and suggestions are welcome!

(This is rebased over Darrick's atomic write tests:
https://lore.kernel.org/fstests/20250605040122.63131-1-catherine.hoang@oracle.com/T/#t)

Ojaswin Mujoo (7):
  common/rc: Add a helper to run fsx on a given file
  ltp/fsx.c: Add atomic writes support to fsx
  generic/770: Add atomic write multi-fsblock O_[D]SYNC tests
  generic/771: Stress fsx with atomic writes enabled
  generic/772: Add sudden shutdown tests for multi block atomic writes
  ext4/063: Atomic write test for extent split across leaf nodes
  ext4/064: Add atomic write tests for journal credit calculation

Ritesh Harjani (IBM) (5):
  common/preamble: Fix fsx for ext4 with bigalloc
  generic/767: Add atomic write test using fio crc check verifier
  generic/769: Add atomic write test using fio verify on file mixed
    mappings
  ext4/061: Atomic writes stress test for bigalloc using fio crc
    verifier
  ext4/062: Atomic writes test for bigalloc using fio crc verifier on
    multiple files

 common/preamble       |  16 ++
 common/rc             |  21 ++-
 ltp/fsx.c             | 105 +++++++++++-
 tests/ext4/061        | 107 +++++++++++++
 tests/ext4/061.out    |   2 +
 tests/ext4/062        | 131 +++++++++++++++
 tests/ext4/062.out    |   2 +
 tests/ext4/063        | 125 +++++++++++++++
 tests/ext4/063.out    |   2 +
 tests/ext4/064        |  75 +++++++++
 tests/ext4/064.out    |   2 +
 tests/generic/767     |  84 ++++++++++
 tests/generic/767.out |   2 +
 tests/generic/769     | 101 ++++++++++++
 tests/generic/769.out |   2 +
 tests/generic/770     | 161 +++++++++++++++++++
 tests/generic/770.out |   2 +
 tests/generic/771     |  49 ++++++
 tests/generic/771.out |   2 +
 tests/generic/772     | 360 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |   2 +
 21 files changed, 1345 insertions(+), 8 deletions(-)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out
 create mode 100755 tests/ext4/063
 create mode 100644 tests/ext4/063.out
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out
 create mode 100755 tests/generic/767
 create mode 100644 tests/generic/767.out
 create mode 100755 tests/generic/769
 create mode 100644 tests/generic/769.out
 create mode 100755 tests/generic/770
 create mode 100644 tests/generic/770.out
 create mode 100755 tests/generic/771
 create mode 100644 tests/generic/771.out
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

-- 
2.49.0

