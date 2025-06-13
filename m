Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE2253B7B
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792018; cv=none; b=RHZVzW2JmbiX8K6hAEZ6HHedFG0lbjf9KJzDFJsmZsatGdni7ZLZmS2OqO8H8d51/6gQ/umDxiETnpOzSGwLTUPqsjSHrUKNkKxh63xLYlJsovumbgt2IbJSo923zk8Y+Mq7CRUtIOdWJvbi2x2uGLs19n8YzDKbBN6Ral3uyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792018; c=relaxed/simple;
	bh=mfK899ce9CtOKvrgXpZHn8wpcX07UYUBguHkAQWafUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k79M+UmrxCviY9L4FWzWRU6aXqSITdNPXZxjxe0Y9NJikLhnMZ4/MDngmdZJMr+OkKr9fx+BNpNF+uhRkXoknC8/H1TxZyuS8Rl0jmkesMsn3heVoUFrfHGNRlx/K8I5M+iNIUdjrwntrVZQ7moebamuigJuTmrruGp8rUINOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHuJ4haA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHuJ4haA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CH0Ocn002403;
	Fri, 13 Jun 2025 05:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NRmjHbxXeCzmWz925UAMDVlTTT7CXu
	pMM0h0NT6lB4w=; b=sHuJ4haAyXxM2ooEOtaAES5rc45z1rHs1jOMMUD20LNVDd
	2C9nKRBQG+hLXGd361MGy2EdXNJjFWYyePWYZpbKFLCgqF0uA+8/n588Vzb0cnYQ
	M16/NkcOOoPZbypLR3apLgffeY5YjC/eZBoaqejmJpiYmXMlDjgUy8O/MfX5rHDR
	pMHvu1d3otmkPbgasAezmaCL8GWBTjGhrFx0TQrtgqLAcklk0CAQ2C4r+an1VOZL
	okcudu9ts7yt07i3tOYmfsxiKO1S55oBzjHkt5TlBeMM3Lh/m/X48O90dubeC/gg
	AJBx7Isoq4GPtlrH8WuGNDAtprIEawKpYADsEXuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 477vyw502b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:20:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55D5KAO5024752;
	Fri, 13 Jun 2025 05:20:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 477vyw5029-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:20:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55D2mOd5028076;
	Fri, 13 Jun 2025 05:20:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mrc2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:20:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55D5K7uA25428604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 05:20:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7262620043;
	Fri, 13 Jun 2025 05:20:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D453F2004B;
	Fri, 13 Jun 2025 05:20:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.30.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Jun 2025 05:20:05 +0000 (GMT)
Date: Fri, 13 Jun 2025 10:50:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [RFC 07/12] generic/771: Stress fsx with atomic writes enabled
Message-ID: <aEu1At9-wn01Tjfn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>
 <20250611144558.GJ6143@frogsfrogsfrogs>
 <aEpzYbXmPf1X4-MI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250612151435.GT6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612151435.GT6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=F5RXdrhN c=1 sm=1 tr=0 ts=684bb50a cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=duuU5AyR_J3BDYLfT2IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 04pETm6QgJ3pdYUWrq-BlAX7SVn21KqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAyOSBTYWx0ZWRfX//T3e5G3c1HD 0zGi4C5ySCO7xHzIi/nzGGXti8HAYZcO4dgAW8ZsRF5V0t5h1edskh9mUjnolVB9Ah3O1ovCh3l deH9xE5ih53NPqGxDKjNg5dby0jd5+408uOVj+Dy7w2uGES2KgpgwvO45VD0L4Et+2QPXtTnbVi
 DuHjqO0xpyGQjh5x4WSEnL6gWel4J4M3PeJF6D/bBFyFQNxUdyup6kvDwIPiHzzJeXsjp0rwJs3 itt2nwhu/zbxTU/lu4GZyyELM34lrm1a8Lkod5uQQ0hoyBM4F1YteffRk52DyJlklsvwRNvxUMO mIEfeB17EaJiscSCrKgO2pA2xlTeQQD0PCiNJGY2kBizi3K3LW+rlp7ZcziBhndGmJYH2A6NOvY
 bKM4AbYyWPhlGABTn0uK/zK0PHfBS9FWwCEAnIt0aplEHQ3o/nQEImUmxe4wyJrLKL32uB/E
X-Proofpoint-ORIG-GUID: Vjssdl219L1IPL-swta0lRBuQbDPZ5ds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=806
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130029

On Thu, Jun 12, 2025 at 08:14:35AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 12, 2025 at 11:57:45AM +0530, Ojaswin Mujoo wrote:
> > On Wed, Jun 11, 2025 at 07:45:58AM -0700, Darrick J. Wong wrote:
> > > On Wed, Jun 11, 2025 at 03:04:50PM +0530, Ojaswin Mujoo wrote:

<...>

> > > > +# -N numops: total # operations to do
> > > > +# -l flen: the upper bound on file size
> > > > +# -o oplen: the upper bound on operation size (64k default)
> > > > +# -w writebdy: $psize would make writes page aligned (on i386)
> > > > +# -Z: O_DIRECT (use -R, -W, -r and -w too)
> > > > +# -W: mapped write operations DISabled
> > > > +
> > > > +_run_fsx_on_file $testfile -N 10000 -a -o $awu_max  -l 500000 -r $bsize -w $bsize -Z -W $FSX_AVOID >> $seqres.full
> > > 
> > > Don't we already get fsx stress testing RWF_ATOMIC through generic/521
> > > and generic/522?
> > 
> > So for RWF_ATOMIC we need to pass the -a flag to fsx which the other tests
> > don't do. This test specifically passes -a to make sure we stress the
> > RWF_ATOMIC code path intermixed with other operations. Further, other
> > tests run FSX on test device whereas for our atomic write tests we
> > generally assume the scratch dev is the one with atomic capabilities.
> 
> Oh, I overlooked the part where it's not enabled by default if its
> presence can be detected by fsx.  Can we flip the polarity of -a, that
> way RWF_ATOMIC will get tested with all the other fsx soak tests?

Sure Darrick, I'll do that in next revision.

> 
> > > Also why is mmap write disabled?
> > 
> > I thought it'd be better to not mix mmap writes with direct writes but I
> > can add it back if that's preferred.
> 
> It's not unreasonable that some dumb program is going to try that some
> day, even though we all scream for ice crea^W^W^Wnot to mix the two IO
> paths.

haha makes sense, i'll enable it as well.

> 
> --D
> 
> > Regards,
> > ojaswin
> > > 
> > > --D
> > > 
> > > > +status=$?
> > > > +
> > > > +if [[ "$status" != "0" ]]
> > > > +then
> > > > +	echo "Somthing went wrong, check $seqres.full"
> > > > +fi
> > > > +
> > > > +echo "Silence is golden"
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/generic/771.out b/tests/generic/771.out
> > > > new file mode 100644
> > > > index 00000000..c2345c7b
> > > > --- /dev/null
> > > > +++ b/tests/generic/771.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 771
> > > > +Silence is golden
> > > > -- 
> > > > 2.49.0
> > > > 
> > > > 
> > 
