Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2161F0E2E
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709443; cv=none; b=b2pii+DLorznXhAo2j6eqDHCG47uhy5ZGBwmT9sR/02YJjhbKCa1jH7603kbVsSHmOMUvYamKWCliXF35kuqCM2YkJMNJu8KxbC/lkjdQqLq76zfGM/KrLxw2aC8LwTj4eJyV0Ee3cuIYhU3CE0soDxhspYSP1rJt1eFtTy5W6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709443; c=relaxed/simple;
	bh=TFLJWyxWS3WYXfti+2Xr1DSlrVztNogzeiayySBTaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+bcKGChzoOPP8Wih4VUonYduVi5GdJAoZAYcOHVZQrJathv5wAtZ/EmipVf6bVP+AcsnE+87B31mVn+0fAjTbPyjcOnEhzwbJpbVtfHs9v2D8kgl5jBwZu1UvPouuS3lx2cpOiJpcuPpnr5V5UqwotdeHyvDO8z2GcmJxb2fEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F0YBnu3w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F0YBnu3w"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C2aUs2011492;
	Thu, 12 Jun 2025 06:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Gyw0vblu5K09KR0y+vpFEk9ywIJkNE
	+4EL7Kh0kBBiU=; b=F0YBnu3wWrmLrKcYGrDTZAAkzpSu9iZe7cyerfU8yeuqX+
	CCDaNy2ISdyFvFtXS6t7WfbyqTE95/ZxGMN1tOt3p1WN7CBX4KtBkb4fzgiZ6e5K
	YL9lzhnrB/+rB7C8HFfpceQnKPeY+f0o/9Uw2BHzDPtDxVVp8XDPprfGVIV+W0LP
	hsKAOnlO8qX2L8XzG1TrGYOQmBkyLNXEEymWt9cwZZWUExN5zg7PYYtDP8jbJG2s
	5x+Don2Ge/ilqPlb3gt58m6vqZw23Q6p4lyu0vNB5daHwciYWNhNK71Y1Bk3HWIv
	TUfRtRboLL+vKj80TCBrTZhOcGDx6kMwVHmNSmSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjh125-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:23:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C6Mlkt022507;
	Thu, 12 Jun 2025 06:23:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjh120-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:23:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C2aHC8014904;
	Thu, 12 Jun 2025 06:23:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpbcc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:23:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C6NYal50856348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 06:23:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB76520043;
	Thu, 12 Jun 2025 06:23:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACBA520040;
	Thu, 12 Jun 2025 06:23:33 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 06:23:33 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:53:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [RFC 06/12] generic/770: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <aEpyYzuPaa6XyN5v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <5503061a800eaff9fc182e68c3030c1ef07410f3.1749629233.git.ojaswin@linux.ibm.com>
 <20250611153623.GM6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611153623.GM6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jkROsXyX1tUlXFehLdSIECzf7M9VfU-L
X-Proofpoint-GUID: 0zKYspzeXyYjTd00Vurj2VjrvH5valqs
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684a726a cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=_wi3ixc5KFYvsc4_4zwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0NiBTYWx0ZWRfX3Qo2Gwc6GLNP 2edINVyY7iq/VGnV7Hlr0iRp16Jf4NminKOc9Ky9TvMa3to1YiOBMp7WfbRvVPoubUVMoADSE9L fEnv/nHCFYMo9wwLkbfnP5QAE/K/7Gv3emeTLiGxj0Jey2CqBNFxyl8z6/WSvvn6ghQnwk/n/Vi
 V7DuqVbWCiiqUTRwmgkxJV5PJUKQ7Xbj7hXmAoA10UNsoewrz8+Wqxv/szeBm3+htAtoAhgAGgk /BWnYLlzgln4RpoAolmBgfd5nn319JL95y4xUWHmJVdNE24hbS//t7Cv2dBoaWq+BkiUPeBrPKM jUpgnXeWtDtArm3LXMFFbnEf49ESCXyAkD+4L3MzFmBwavHquP+dhErNnGaA3EA4YOZSI/BoZdZ
 wHtx4y4yOXbklVLGNKDNewQUkPQw7S5gUgomwtgJvJVSTZUSO8L0fRjQYnXKaoocYdk7L88Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=842
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120046

On Wed, Jun 11, 2025 at 08:36:23AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 11, 2025 at 03:04:49PM +0530, Ojaswin Mujoo wrote:
> > This adds various atomic write multi-fsblock stresst tests
> > with mixed mappings and O_SYNC, to ensure the data and metadata
> > is atomically persisted even if there is a shutdown.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/770     | 161 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/770.out |   2 +
> >  2 files changed, 163 insertions(+)
> >  create mode 100755 tests/generic/770
> >  create mode 100644 tests/generic/770.out
> > 
> > diff --git a/tests/generic/770 b/tests/generic/770
> > new file mode 100755
> > index 00000000..2b98b3b3
> > --- /dev/null
> > +++ b/tests/generic/770
> > @@ -0,0 +1,161 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 770
> > +#
> > +# Atomic write multi-fsblock data integrity tests with mixed mappings
> > +# and O_SYNC
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest auto quick rw atomicwrites
> > +
> > +_require_scratch_write_atomic_multi_fsblock
> > +_require_atomic_write_test_commands
> 
> _require_shutdown?
> 
> --D

I'll add that to v2, thanks!

Regards,
ojaswin
