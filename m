Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB92191F91
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334516; cv=none; b=To/eGhC9zrjfkiDMAn6pxNwjM4VlU6KIL9fbuIb/Tc7cmk7gLOPv5jXHZ2g8RY+PStC9w6fzB2RLxjMteOBYdAt0+7LYYmYhSZJ3v9noUn1IAeAeKu9sfDYQV8hrZGhNEr/yroBkBD6BCnFdmXqptngSKuyWdFXiy2sM/zyP+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334516; c=relaxed/simple;
	bh=3suPJxjig9DLOJgCE03khOOsWS6+lwmfcwTH6NBKPOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW6Kp/U06JRmhMqJ2jHa6YXWxvoSED8KFq9SIk5Tl+pAqyjRN+iMyo+tPYq/f4OlqfUrOdPJZp3ucbpthDCp9CYxEZ1qTEuFQWTsSctBuvULMvF9Paak8YeOEyekmMndgM6rFjP3Qw8+2fMrTZJnbGGzSsihp7LKpi94/Lso5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=V4GMTL8S; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=AdqYREzO; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="V4GMTL8S";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="AdqYREzO"
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VbPg207145
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 03:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=8
	uWBD/iZE6fk2/Zg1GdAgyJuYuPi3UhI3l/HQl+piQY=; b=V4GMTL8S5F/icG/8d
	nEwnmDp4MFSNaWtsPtnTikOYqsRqvEotW26nXKPeW5VqBWmGCyyThuwUh5Nagbab
	Y9S1m8LeCDWFfQPdhGhDVtWHEdOihx6xI8s9mBpQovSQ/Xy1Aia8HsZUxFCnDH2f
	zM11Pl5HDZcZ4gzKn7nqeSqLbuJLN0TFpdoHJN46sHHB4RDmcHmg/+C90zTyWf7E
	z8dqhFTBT1/nPZ8ea8dfrCkdTLZwbiMb0LpWlPeWy5Rg6fFxjbMjtjf1wDW4rQV9
	si/lHShj8L12ds65N3rFaiwrZYZmncyjgXUlZ/aH52TPyJQmsXY2SlrS8tcZvRdn
	EP/ag==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtk78cc0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 03:35:13 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826WY1e2744546
	for <fstests@vger.kernel.org>; Wed, 2 Sep 2026 03:35:12 -0400
Received: from esapsmtpat05.us.dell.com (esapsmtpat05.us.dell.com [143.166.211.154])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ge8vc4d7x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 03:35:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788334513; x=1819870513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8uWBD/iZE6fk2/Zg1GdAgyJuYuPi3UhI3l/HQl+piQY=;
  b=AdqYREzOeb605LRR9dFhCx8gW527Slmda0SDfBW9xdaWeRAQfJ6SLYh0
   Mgq9G9bHaqXUuAja1mkPoUX6MVGy6JI/pCn3/69hN0pT8JUowGNpwgPKb
   2Xo9/h+U/mdUCg7facd2wLLwL9PPe5idxtAW8KpfxdxiRi7NOuOonFJde
   uc2w+rl0+ndSjQq4mHFjLo2p7CzUqg/4v7sKfKhqFx5WV+R/jM3yCBUDX
   P3vVnZ+DRfCFNktTXKw9BnpGwWpLLrM1qCW6luPk2Lr8AsauWo8V2kSBk
   QsSnFckPLflPcbflE5+Y1LSe/fOtUIpLnNf0UH4IHANIdMPqgA+00kVip
   g==;
X-CSE-ConnectionGUID: LssTErpzTLuiQbpEelPAcg==
X-CSE-MsgGUID: xbpcvp3uSQKQg52pAMAdnw==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtpat05.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2026 07:35:11 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: Zorro Lang <zlang@kernel.org>
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, fstests@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] overlay/081: add missing _require_scratch check
Date: Wed,  2 Sep 2026 07:35:07 +0000
Message-ID: <20260902073507.5074-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ape4hyfwsv5LrYxB@zlang-mailbox>
References: <20260901132438.759-1-prabhakar.pujeri@dell.com> <ape4hyfwsv5LrYxB@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020066
X-Proofpoint-ORIG-GUID: o2Mk4WEDn968RTxWgY5KuxyqzLM-AZtf
X-Authority-Analysis: v=2.4 cv=PL0/P/qC c=1 sm=1 tr=0 ts=6a97d1b1 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=uswt3CficuEu8DJvSCSroA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22
 a=jRo2XLh-ulI_c8mEkXIA:9 a=QEXdDO2ut3YA:10 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA2NiBTYWx0ZWRfX1SnHGmpjwWWS
 e8DaJWTNWUb1jiUVdt6HkWcc0NAjrPHn5Tvire7OJO47sHVvmQy34PupYJtcdMCKoNIMPciUO/C
 EhP2DC8I5E9rz3GO/NvW2p+cMlUNb/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA2NiBTYWx0ZWRfX7Cezx0h5eiDf
 4KdQAqdoN7LWb/B3WlkLxkGq9eYI08fmnB0iKxa3Vy4XTCm2im6VBOj2kY8YQTQ4GNXcPPlxWG2
 6HgS6lmvu+2LO87ZxkV2Qm92wulwRAhQEtSN7JhAAYsn1kBF0kYkC27bjuXAyR8Xtn4SYKI5hoq
 jlMcVr/F33CaWdD+8nVsxuYCaXRGHKfBdkVjOSLOjj5tKi/FO6c8fqs6PBNKHkXU2Ihm0huHyBB
 usr/6uRavYYXVvrAviLqw/XfQRti1/oOTy08m1YIewg9NsXGGVQZZ1dxvhoHPcYIK6noINVTB/S
 wwdUOdp8EXsIvw8tPTIp8zCY6YZUYWDLC+lH7s69p8/r+70I2wC2SHZRoijsxPhEP+Ce+SFLk/f
 zC5giG/Hfwo/IQ94C2ORFxDVI+FOGBMwg4cBucDNDQNr6EkvyVMw1cALMM6h2feongXIYGe6i6l
 kvqWoGO+YZvuQdQ5ZLg==
X-Proofpoint-GUID: o2Mk4WEDn968RTxWgY5KuxyqzLM-AZtf
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020066

On Wed, Sep 02, 2026 at 01:51:08PM +0800, Zorro Lang wrote:
> As you're fixing this patch, I'm wondering if we need a _require_* helper to
> make sure the mount options *uuid=null/auto/on* is supported by current system?
> Due to the comment says "mount options uuid=null/auto/on introduced in kernel
> v6.6" :)

Thanks for looking.  That case is already covered a few lines below the
change, at the first use of the uuid= option (line 40):

	_overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o uuid=null \
		2>/dev/null || \
		_notrun "Overlayfs does not support unique fsid feature"

overlayfs rejects unknown mount options with EINVAL, so on kernels older
than v6.6 that probe mount fails and the test skips with the _notrun
reason instead of failing.  The uuid= options are also exercised only by
this test (it is the sole user of uuid=null/on/auto in the tree), so a
dedicated _require_* helper would have exactly one call site.  Happy to
factor it out anyway if you would rather have an explicit requirement.

Cheers,
Prabhakar
