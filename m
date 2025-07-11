Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8C27A927
	for <fstests@vger.kernel.org>; Fri, 11 Jul 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230387; cv=none; b=CyYlNJV6MdlSO7JV/IR6VmoXLnCXEE5MlnKymNLoWHbzXdVaKdd4mj8pr8M55wjWYl9d88XzQa13yzev7pfcSENCdJP78arXfoJl7bnowdqQCSDARUELMt0UuRPEXe+u+2uUGgc/3YJI52Cvap9/14yarCDKdqYPg7ynMm2Ruhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230387; c=relaxed/simple;
	bh=8ZSk2pL9d/vS1ClT7YIesG9lAXaz9XYS5wqxYOgMULA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR2RdFR/g58i99YctDt1DMMA+WmOJnDP23eG/RG/aHj5PrXGnwA96Bm2jQ0muj3BpGm6LmHLT++kPiuC9DNE4Y16HkidpbCJTRFTOJFMwZPacA0oDipuarVO2OZQ2CMD4FLk4xvu64OxiGTXhTqkO73SINjY5mbAP2eRJvYB73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qq1LNTiX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qq1LNTiX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8Hk2u009277;
	Fri, 11 Jul 2025 10:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xGCDxwSuTWWxJh3LZk09brHq3oVJKU
	b9waQnSOdWc88=; b=Qq1LNTiXGA5hZnzaGrsPy161cmZXQ0G1iuA7rxgz/WrEzH
	oXx4FhgDDo6zAa5Xq4mXOPwNyqN+PytASU571LVD8Sxi8CeWrWfPvyXhvGIEMuEs
	fEVGPaRdgQyIzWQavKMteI/Fv6FmuM3b1ljigIFmAn3czJGVsxC5ZduhPuV4A05s
	b6qprzivSU9/UocRT1ltZKNXK0+N/tZYzTZxOV3C3JwdV/lDen5zpWJOk+zJl/Ns
	NeGpMcTwrfncB4b61GnOnalgm/EST6btxlC+Cx2/oQX1OnniDq0tE8FW6BNNLaaC
	kQ8TwJkSIkCRlJ53kRwCgH3TvS7xWXgSbm3tDD2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb2adpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 10:39:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56BAWseX022168;
	Fri, 11 Jul 2025 10:39:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb2adpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 10:39:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAb3kP010918;
	Fri, 11 Jul 2025 10:39:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0jewf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 10:39:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56BAdTBN52625840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 10:39:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACBCF20043;
	Fri, 11 Jul 2025 10:39:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 445A22004B;
	Fri, 11 Jul 2025 10:39:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.28.227])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 11 Jul 2025 10:39:28 +0000 (GMT)
Date: Fri, 11 Jul 2025 16:09:20 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aHDaoiuxxTuI_9uS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
 <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7b79cd75-317c-4b64-b98d-2f35a014deb8@oracle.com>
 <aG0IsTJ88ia4TWmn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2678a0c0-e075-41dc-aad5-3191703c7359@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2678a0c0-e075-41dc-aad5-3191703c7359@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MiBTYWx0ZWRfX4vchufmdL07H zvBYLKQN6dG1G9VmKTqszrvpfOS9LHl0CeJhfUJIn3pAwLRGEO+7DwWakJHDO29Q4kNmqCE5FwF tUCxvImqKAAGjvYyYEsO4bklKh+QbH+d12yKXwqMdWM8VxcsWZKeM0PGWTVKf61UachTsZGxZ8I
 xm6BO6sG3GJ+BuSGGTySJ5cumiRT0r78DCEXj5OQY6OLr+8m4GjDBh0U/pRnZ/EVZx+qJkJ5hEp LqOmPF6A5YWz/wC8MdiGhK7sqjxctAJ7pORNU/uxPRlPnBeZo2ZDPP36sN9585oTAU5NWSZ5hd7 DUApZBVYaIxAP6cnd8nbRmgeGRe8M1mwoJl9+t5zpVoQYfTjcHHnrlxcr6CADsIbQN1EzHoNPCh
 JdDuvEE5oQGQWLFl1lBd50WDNVg0KPkx6i/Y0JOEQIOZ7ShShcjTT0P9S7jHXiAZySlwlbtC
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=6870e9e5 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=Q-rH1QunMN6UOXzKRjsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xyP360XFs79znXEt5UKcTAwrL8PCSVge
X-Proofpoint-GUID: y3HWmLf0j3r0NKJXrj-BaxrzxAs1igeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110072

On Tue, Jul 08, 2025 at 01:34:39PM +0100, John Garry wrote:
> On 08/07/2025 13:01, Ojaswin Mujoo wrote:
> > > You could do the statx call on the mounted bdev, and see if atomics are
> > > supported there. If not, skip the test.
> > > 
> > > But even for xfs when HW support is available, we can still use software
> > > fallback when HW support is not possible, i.e. misaligned. So, in that
> > > regard, we really should only test this on ext4.
> > Hmm, okay so I'm a bit confused now. What is different in ext4 vs xfs.
> > Why does the software fallback for xfs matter in this case?
> 
> For xfs, software fallback-based atomic writes are not even serialized
> against other software fallback-based atomic writes. They can trample on one
> another. That is a reason I say that this test should only be for HW-based
> atomic writes.
> 
> But even if the bs <= HW limit, on xfs may rarely still use atomic write
> software fallback if HW-based atomic write is not possible, e.g. misaligned,
> multiple extents, etc. I will emphasis that this would be rare, but it is
> still possible.
> 
> For ext4, since alignment is always guaranteed, and HW-based atomics will
> only ever be used.
> 
> > If we limit
> > io to 16KB hoping that reads don't break, then either ways the fio
> > verify should work. And if reads break then both ext4 and xfs suffer
> > irrespective of hardware or software fallback. (We also saw that
> > hardware atomic writes also suffer with same issue when max_sectors is
> > low)
> > 
> > > > Im not sure if returning non-zero for ext4 is also correct as per the
> > > > documented behavior from 5d894321c49e613.
> > > > 
> > > >      When zero, it means that there is no such performance boundary.
> > > > 
> > > > Anyways, I think there might be a simpler solution...
> > > > > > The simplest way seems to be to just limit the $blocksize to
> > > > > > something like $(_min 16KB awu_max) and hope that 16KB is small enough
> > > > > > to not be split during reads. We anyways have other tests like
> > > > > > generic/1230 that can be used to test larger atomic write sizes
> > > > > > 
> > > > > > Thoughts?
> > > > > As I said at the start, we never had guarantees of serialization of reads
> > > > > and atomic writes.
> > > > > 
> > > > > However I still think that this is a useful test. It's just it is
> > > > > theoretically possible to give false positives.
> > > > > 
> > > > > You could get the test to read max_sectors_kb, and check whether it is
> > > > > greater than the bs. Again, more complexity.
> > > > I think this might work. So i can set the iosize as 16kb which is
> > > > already low enought. Incase the max_sectors is < than 16kb then we bail
> > > > out. (but then maybe there is a very small chance of read split still)
> > > Sure, that seems fine.
> > > 
> > > > OR another approach is to do the verify at the very end when all threads
> > > > are done writing so the reads don't race. The tradeoff is that this
> > > > will reduce the effictiveness of the test though to some extent.
> > > Yeah, right. We would want this test to prove that atomic writes are not
> > > getting split by the block stack, so racing reads can help prove that.
> > Yeahh, but now i'm leaning towards this approach of keeping verify at
> > the very end instead of parallel.
> 
> I don't think that fio supports such a mode. Or does it?

Yes we can achieve it via combination of write job with verify=crc,do_verify=0 followed by
verify job with verify=crc,verify_only=1. I'm testing this right now to
see if it can survive max_sectors_kb = 4 (which i think it should since
there are no races now). If everything is fine I'll use this approach
for the fio tests in the next revision.
> 
> > Yes, it is a bit less effective but
> > then having a data integrity test that can theoretically return false
> > positives is not good, it'll always keep me guessing about any failure.
> > Having verify at end will not have false failures for sure. Even though
> > it comes at a cost of less coverage.
> > 
> > Maybe we can also get some other prespectives on this.
> > @Zorro, @Darrick, can you please give your thoughts on this?
> > 
> > As a sidenote, with this issue of fio's verify read splitting, it seems
> > like the parallel verify feature in fio itself is flawed for non-atomic
> > writes as well since the read can always split and race with the writes.
> 
> fio does warn that multiple read and writers in verify mode is unsafe.
Right.

> 
> > 
> > Not sure what the solution is here, maybe time for non splittable atomic
> > writes (:p)
> 
> I just think that fio in verify mode for ext4 is ok, as long as
> max_sectors_kb is large.

Yes but i'd rather have the write followed by verify version to avoid
false positives in case the read bio does end up splitting for whatever
reason.

Thanks for catching this issue in the test!

Regards,
ojaswin
