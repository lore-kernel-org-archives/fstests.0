Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77062367A8
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408009; cv=none; b=uwlZRwHikZJFL3HNmUli5Dw5vbkd3shW5uNNJquyl6FNMWZ00+lyC74jREVOZGaHnvRwSQ2h3PmGrSknKLOZ0Ns/6KpelAHUG21meZ8uoMK+7eX8GDyuZIMNgD47LyALEfgjJin2GQbmb/CmSAUpfgGygvuezUr0IR5t3WJ/3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408009; c=relaxed/simple;
	bh=uTx6ZFfw2ckmIQq516y7Ik1oCUonobPfTF4oBs5ZTXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HraMmoogSZCpg8pM4zA4Af+/4rcohPfORBi26aZ+v8Oll0w3NwWBbbYvU6UT4IwXt2QV7WPATMzTuY0PZ+td4rdDX68ZeEnyOpuWXQM+gaCBR2xDGt68WHpD8XSPnGhUekoLl5jcLZLg5jUOv7ku4biNkANAivb10a3HibRl408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mrop+Moq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mrop+Moq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JLmakW022864;
	Fri, 20 Jun 2025 08:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=I9nnHmMsyRiXRkcpYLJrv+S6lB2PvN
	AO1TJ07gZ5uYQ=; b=Mrop+Moq1I6LIfMnwbQ1TRE60i7cF/m37swJHtKfAaecr+
	YvY6nrWeHqgSvm9XYD2j+h0eBkx10lzmtROV35tj9Cpz5+6PfLXAOy9OQKrkEx6O
	0Wrpumd8SxN6IzDYuliajxkKXAo6k6bjHq1Eyc2h3URimTkfuwFxKQqLKT39KvU0
	RESgYRvDli2ctZ+XgM1GP++vj7TlU7lNjtIcdZ0e3qaeGY/y2i+twOKPXLVhe+qZ
	zXZhkbYwMs+91jfX2/BFhAVIuLwp6NllCSDm1SBFwfB9o5fGQn7FyNjEGGwdmUxK
	iuzfvyIF021LGHJinFFuOopA7DiO68KHq7dzxwYQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qps446-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:26:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55K8PCqw010221;
	Fri, 20 Jun 2025 08:26:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qps444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:26:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K5081h021628;
	Fri, 20 Jun 2025 08:26:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47cahwe1n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:26:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55K8Qcrh57606418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 08:26:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC622004B;
	Fri, 20 Jun 2025 08:26:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 903AE20040;
	Fri, 20 Jun 2025 08:26:36 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.221.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 08:26:36 +0000 (GMT)
Date: Fri, 20 Jun 2025 13:56:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 07/12] generic/771: Stress fsx with atomic writes enabled
Message-ID: <aFUbOnm76rl3XamP@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>
 <20250618202741.dziguhshlq2cqj5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618202741.dziguhshlq2cqj5b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JOb3_gWoG2sK-seafFlqnFctDHHoizvL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA2MCBTYWx0ZWRfXwdgV/C7+00/b bQNVHsoFWsvcsnEcoLNfPN7lDk7YXpHxO0NIh7jRkisS5jz+vuJls/thLcK8sV0zdt4kE+IQe/p FqhEJVZPtx6fvu+nK7JcJUsZUs10C1Gu6sSqMqoCj2B17FRMfduZR/s2vAeRbvKWt/OOE+hqFtQ
 qTCtu0wIRx+RiNTt/k+q4uC2zyWk0yJqZFqPF/gUz/LTqHYtTtWSGvuGyQv2s+WnL685tFmPQrD S/EnagkutfaUo3Sdy9+gOZZyxzeMJtljBwqF5aQc+BYyT2f17hgX94PRNlVkVaN5nBu4XRVpdFQ obyZU+/QmQ8fDC/a+KbCnHgWlDeI59j21YMWv2QTXP/RVMqz5ygElnY4A0DRZ04ynR+ZKLj39RC
 ylEM4pON7hGCYOHusLcJhFfmQDGOvjTIbjbG85ebOBHzy63JsX5qnYMpxf5rk93o3u+7T2/f
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=68551b41 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=ps6BuoL1OYYfNGA6jUQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: mEJoPNkHUHtAfFJzsi06_fUVRGF5TVmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200060

On Thu, Jun 19, 2025 at 04:27:41AM +0800, Zorro Lang wrote:
> On Wed, Jun 11, 2025 at 03:04:50PM +0530, Ojaswin Mujoo wrote:
> > Stress file with atomic writes to ensure we excercise codepaths
> > where we are mixing different FS operations with atomic writes
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/771     | 49 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/771.out |  2 ++
> >  2 files changed, 51 insertions(+)
> >  create mode 100755 tests/generic/771
> >  create mode 100644 tests/generic/771.out
> > 
> > diff --git a/tests/generic/771 b/tests/generic/771
> > new file mode 100755
> > index 00000000..690dfa0a
> > --- /dev/null
> > +++ b/tests/generic/771
> > @@ -0,0 +1,49 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 771
> > +#
> > +# fuzz fsx with atomic writes
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest rw auto quick atomicwrites
> > +
> > +# Import common functions.
> > +. ./common/filter
> 
> I think this's useless for this case.
> 
> > +
> > +_require_test
> 
> Do you use TEST_DEV or TEST_MNT ?

No we dont, thanks for pointing this out. I'll change that and remove
common/filter as wel..
> 
> > +_require_odirect
> > +_require_scratch_write_atomic
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount  >> $seqres.full 2>&1
> > +
> > +testfile=$SCRATCH_MNT/testfile
> > +touch $testfile
> > +
> > +awu_max=$(_get_atomic_write_unit_max $testfile)
> > +blksz=$(_get_block_size $SCRATCH_MNT)
> > +bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> 
> Do you need _require_block_device? Or is nfs, cifs or overlay... good for this test?

I think it should be okay to not use _require_block_device since all we care about is the
underlying device support atomic write, which we already ensure via
_require_scratch_write_atomic.

> 
> > +
> > +# fsx usage:
> > +#
> > +# -N numops: total # operations to do
> > +# -l flen: the upper bound on file size
> > +# -o oplen: the upper bound on operation size (64k default)
> > +# -w writebdy: $psize would make writes page aligned (on i386)
> > +# -Z: O_DIRECT (use -R, -W, -r and -w too)
> > +# -W: mapped write operations DISabled
> > +
> > +_run_fsx_on_file $testfile -N 10000 -a -o $awu_max  -l 500000 -r $bsize -w $bsize -Z -W $FSX_AVOID >> $seqres.full
> > +status=$?
> 
> Generally we _exit directly after changing $status.
> 
> > +
> > +if [[ "$status" != "0" ]]
> > +then
> > +	echo "Somthing went wrong, check $seqres.full"
> > +fi
> 
> but you don't _exit ...
> 
> > +
> > +echo "Silence is golden"
> > +status=0
> 
> Then the status will be set to 0 again. So above "status=$?" is useless.
> You can check "$?" directly, or exit directly if _run_fsx fails.
> 
> Thanks,
> Zorro

Yes, this seems like a mistake. I will directly _fail in case _run_fsx
returns error.

Thanks for the review!
Ojaswin
> 
> > +exit
> > diff --git a/tests/generic/771.out b/tests/generic/771.out
> > new file mode 100644
> > index 00000000..c2345c7b
> > --- /dev/null
> > +++ b/tests/generic/771.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 771
> > +Silence is golden
> > -- 
> > 2.49.0
> > 
> > 
> 
