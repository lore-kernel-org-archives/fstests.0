Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036361AC891
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709678; cv=none; b=scLh1cCVloiBaIkcHkqkdNi0QrObXFdAy94gqjb+IAaqI2GOF79UlRr3ntp2ubAjqODAOJ2uWPwNIlnhFuAkUNjI3a621tDOqvtl2F9in3lnC+1tThCjAkWIz5Qu5kJIOCFh8nepQFgdLS/zUB33NtrglQMMYFUO+S8RgvIaLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709678; c=relaxed/simple;
	bh=JdvkIkVRIqP7zsLZ53mmxAyQmC4puQobmKIaNbH9qOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrNmfz9uU1l5z8ThaXjdIcF5EvlditJb2YXtUYEGqhrzKf4v3paGmwPeXHhhz9ndEszgjzPMJiH4G6yX4ysg6G6kql+/1TdjLAkXyda9VU0bAPUxedq81nqQpL4NNWEp/X9YaID31rarOv8xq00EeUUSPAjDqyOqso4NPpCP9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aLFHVNNU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aLFHVNNU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BMXs3b027686;
	Thu, 12 Jun 2025 06:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1AI7zHfjF+YLZFFby9ZxG0sySzmLJS
	Xed9IuzMyqeBA=; b=aLFHVNNU9KLAu2Uuz+5yqRVvF8hEtcF6Q+6f3+rjtrM6Gc
	CVyylAorgqUwQqctP0IN7F85/7/9CStBQudRVpyEhqWuiAIVW33Vp592lLBGhdO6
	V8WmukcfDpIC0xZXy7vjNaQXXjoLQtzKspcDG2pwKvs8gju0ihVindLXS4QyqR9t
	G3yEDjA8nsSpQQgSNURHGc83X7Su5S2Xgcnj6N0B23TS7y+K8nUml9axFTwidvH4
	m9GsnIQ7Otg5a6MEOcg/3YavYY2QldcmiRAybZDdOd6AuVJ1otnw7VnIa3uoVluM
	gnlL69KO/AccJXdGplayqqE7Jm+90RcsPVE91nyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjh1hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:27:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C6NwOY024789;
	Thu, 12 Jun 2025 06:27:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjh1hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:27:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C5FtWK021905;
	Thu, 12 Jun 2025 06:27:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750503gb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:27:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C6RnaG9568704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 06:27:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BC9D20043;
	Thu, 12 Jun 2025 06:27:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5243520040;
	Thu, 12 Jun 2025 06:27:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 06:27:48 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:57:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [RFC 07/12] generic/771: Stress fsx with atomic writes enabled
Message-ID: <aEpzYbXmPf1X4-MI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>
 <20250611144558.GJ6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611144558.GJ6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2eEej6N0or0MM5K6Seap7sZZ16mhQfXZ
X-Proofpoint-GUID: 8zZ-jjHbGvOSDwRrhr-RUOT10lb1O9tk
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684a7369 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=5zQu9BTI8OY6W4F9bwsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0NiBTYWx0ZWRfXxf6vQwXUf1BD 67vAu6vSslvghP1CHYSqMo9C7IbTVtXP5veIKzFpgr/t8/TalVX/cx11kL16snjflLGRKv+1yTx HFpZNTz80gcVUwPXvICkKWAGNPvzd/mlgKrT9DDLL/jMNXWjqzAUCmVLQlzqpqlkxBM0/8MgDnm
 Ejwz1r28kpIT5eofmlp9W9UnB+v8ciMbvRHQ0s8j54r48926qDLPwzh1DqxhorULQyQFDOTlxkz mLZfpR9+0IM4e0gtfKzSz3XOe1abztVMyPCKYKo25hTcERjHiHY0vlhojjwNhUqWwl01yyrKM5q U3jAbxMOU6xlDatXVaZG3RpW4Tm4iHBlawbNfc/ssa/blY5e1NRt5b2xflPpY78CBmr8sdH83JH
 Io43s0yjeUbgnDzGc/kmD391blrG9DpHRZr5oTi7c9DeJodjyvBYyzMMNU0HZL9Yew2H7n74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120046

On Wed, Jun 11, 2025 at 07:45:58AM -0700, Darrick J. Wong wrote:
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
> > +
> > +_require_test
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
> 
> Don't we already get fsx stress testing RWF_ATOMIC through generic/521
> and generic/522?

So for RWF_ATOMIC we need to pass the -a flag to fsx which the other tests
don't do. This test specifically passes -a to make sure we stress the
RWF_ATOMIC code path intermixed with other operations. Further, other
tests run FSX on test device whereas for our atomic write tests we
generally assume the scratch dev is the one with atomic capabilities.

> 
> Also why is mmap write disabled?

I thought it'd be better to not mix mmap writes with direct writes but I
can add it back if that's preferred.

Regards,
ojaswin
> 
> --D
> 
> > +status=$?
> > +
> > +if [[ "$status" != "0" ]]
> > +then
> > +	echo "Somthing went wrong, check $seqres.full"
> > +fi
> > +
> > +echo "Silence is golden"
> > +status=0
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
