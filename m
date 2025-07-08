Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544E21FF29
	for <fstests@vger.kernel.org>; Tue,  8 Jul 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976129; cv=none; b=Fm/FSIMHqIYhlIod3W3XfoRgADLY+Mg5AbODmhzWQHY5tMz6BdOJYQskaG5HuNQbHBBEPz48YYYSEz0ujAfo5BjEvVicIWbcBwBE3WmGd61KbkD9i/TNhecnyxsIOr90WBtBhOUM3MMZ41UVvk7BjiV8bZL2dyWR4RukfUjkb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976129; c=relaxed/simple;
	bh=2sbrT6b6pXPX82Kkwoe5aHcKlbptuOkjjTaACrhSHVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7we6j6DwtZMvMfqYd7UkrbNY1i1LjEN0NPT55NW4mNX6QxV7hz6VKfDQ14qZ7G0xSjQr08u+2VumtYAyv0l/x8nq+akGKBGvUSmZp66eYmZ+oVGc6u+N6jEYT1dhVlmkTkapa1ZKmZBVIV7oO40x4MY36NhSuu7U7JBy2bOeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eiQzSrzv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eiQzSrzv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5688nPId010419;
	Tue, 8 Jul 2025 12:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=i8SX5oLyAQ7gktrQVXywhIiYg+B+9H
	+6RZwOnFMalFk=; b=eiQzSrzvQkuE9ThXpLaNFDasnJV6dIxXSgjxd3t8orZ1qM
	34+K/4Dqr/7bOUd3ouyOaMNN5OHzPNTX+XskHT9O+CvG+3UV+TMW7is3C/8NbLyz
	DqGfx2+qGmlDlWVcVRWJzsVghRfQ6RQYt+rDRi6I41bPHn2uD0BiZ+Ylvy9FxnCb
	3ZM70m1RVPHuGvPrv9XbqtfYGLkupkngVkQlBTEf+8ufYu/WRiIzZnIj3V1Aphtt
	smgNuUjC1kpK4fGDy8wuunhHXd8KroICFQREwer+0sX/wo7kCjV41NIsmOr/p+km
	3XtZrLN2QZfoiEhjjdY0+UpVGRKCFvm5r7hUrtEw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3yq4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 12:02:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 568BksLp022436;
	Tue, 8 Jul 2025 12:02:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3yq44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 12:02:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568BHYBm002865;
	Tue, 8 Jul 2025 12:01:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmapgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 12:01:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 568C1vN751839302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 12:01:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDA320043;
	Tue,  8 Jul 2025 12:01:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9778C20040;
	Tue,  8 Jul 2025 12:01:55 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Jul 2025 12:01:55 +0000 (GMT)
Date: Tue, 8 Jul 2025 17:31:53 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aG0IsTJ88ia4TWmn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
 <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
 <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7b79cd75-317c-4b64-b98d-2f35a014deb8@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b79cd75-317c-4b64-b98d-2f35a014deb8@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5OCBTYWx0ZWRfX4JJKvQV7ckh+ E2cGJm+TL30uN9WkRDbiR23jjtvlqJerQsopPnTeT9Vm2d6XZayKDnj6rNOGj5DVqGTwe2CKg7d KF/qU1/Y/F/4C0EKz2H6aQ/lDgnBUgJGvBm4CUPx+QkcLVPdmG2y/1OFvR3qwjFsLtCtIxTy2UC
 ZGhG3WGOjzxi7rRiLSTp664rL114SXEAjenTTFR3G0sCLMCZSZrikzIzqYdRRUPowMPLWV69rNY Y2OUrrPWmhwhxhY1oXVoRHRCs9lbAq8paM9m/YVJqkYKCJgor9rz4UjOYV1Q/JwuinGP0iuFAiQ up30A0c/bzcDFJKHLSduDlqfpw5nxoLv/hZk7YaYj34Gq7m0KUasYfEJhil0ydkE+yM8cd8imlr
 sZ/WS9E0d+CF8uHOcJkwyyIzxCqnGOopdhtgDkCPgMPZ7k/YBwSMvmvJWvSdbHnI0lOKiNFi
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686d08b9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GRVpjaXnTuXacJ_C3_kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vJLLK-ig8thVq9m96HjSudaHFYz6wm07
X-Proofpoint-GUID: 63cUFzaAuAYdPqDqtVF96p0RNjd47PTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080098

On Tue, Jul 08, 2025 at 12:11:06PM +0100, John Garry wrote:
> On 08/07/2025 07:50, Ojaswin Mujoo wrote:
> > > > Further, handling awu_max vs awu_max_opt and their different
> > > > interpretations for XFS vs EXT4 etc are adding uneccessary complexity.
> > > You could assume awu max opt == awu max for ext4, as we no there are no
> > > software-based atomic writes. That could be simpler than my previous
> > > suggestion, which involves a kernel change.
> > I want to avoid adding something like
> > 
> > iosize = FSTYP == "ext4" ? awu_max : awu_max_opt
> > 
> > in the test iteslf, because it is a bit difficult to remember changing
> > this in case things change in the kernel later, eg if ext4 gets a
> > fallback.
> 
> You could do the statx call on the mounted bdev, and see if atomics are
> supported there. If not, skip the test.
> 
> But even for xfs when HW support is available, we can still use software
> fallback when HW support is not possible, i.e. misaligned. So, in that
> regard, we really should only test this on ext4.

Hmm, okay so I'm a bit confused now. What is different in ext4 vs xfs.
Why does the software fallback for xfs matter in this case? If we limit
io to 16KB hoping that reads don't break, then either ways the fio
verify should work. And if reads break then both ext4 and xfs suffer
irrespective of hardware or software fallback. (We also saw that
hardware atomic writes also suffer with same issue when max_sectors is
low)

> 
> > 
> > Im not sure if returning non-zero for ext4 is also correct as per the
> > documented behavior from 5d894321c49e613.
> > 
> >     When zero, it means that there is no such performance boundary.
> > 
> > Anyways, I think there might be a simpler solution...
> > > > The simplest way seems to be to just limit the $blocksize to
> > > > something like $(_min 16KB awu_max) and hope that 16KB is small enough
> > > > to not be split during reads. We anyways have other tests like
> > > > generic/1230 that can be used to test larger atomic write sizes
> > > > 
> > > > Thoughts?
> > > As I said at the start, we never had guarantees of serialization of reads
> > > and atomic writes.
> > > 
> > > However I still think that this is a useful test. It's just it is
> > > theoretically possible to give false positives.
> > > 
> > > You could get the test to read max_sectors_kb, and check whether it is
> > > greater than the bs. Again, more complexity.
> > I think this might work. So i can set the iosize as 16kb which is
> > already low enought. Incase the max_sectors is < than 16kb then we bail
> > out. (but then maybe there is a very small chance of read split still)
> 
> Sure, that seems fine.
> 
> > 
> > OR another approach is to do the verify at the very end when all threads
> > are done writing so the reads don't race. The tradeoff is that this
> > will reduce the effictiveness of the test though to some extent.
> 
> Yeah, right. We would want this test to prove that atomic writes are not
> getting split by the block stack, so racing reads can help prove that.

Yeahh, but now i'm leaning towards this approach of keeping verify at
the very end instead of parallel. Yes, it is a bit less effective but
then having a data integrity test that can theoretically return false
positives is not good, it'll always keep me guessing about any failure. 
Having verify at end will not have false failures for sure. Even though
it comes at a cost of less coverage.

Maybe we can also get some other prespectives on this. 
@Zorro, @Darrick, can you please give your thoughts on this?

As a sidenote, with this issue of fio's verify read splitting, it seems
like the parallel verify feature in fio itself is flawed for non-atomic
writes as well since the read can always split and race with the writes.

Not sure what the solution is here, maybe time for non splittable atomic
writes (:p)

> 
> > 
> > > As an alternative, maybe it's better to maintain this test out-of-tree. I'm
> > > not sure.
> > That'll be a hassle for everyone :p Does any of the above 2 approaches
> > seem acceptable for upstreaming this test?
> 
> Sure, I think ether are fine, but I am still a bit hesitant to even have
> this test for xfs (and not just ext4).

> 
> Thanks,
> John
> 
> 
