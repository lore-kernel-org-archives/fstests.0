Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06F1C84D3
	for <fstests@vger.kernel.org>; Thu,  3 Jul 2025 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751524946; cv=none; b=N+E8YKEftFocSN3g6JuLN2axSVovwYARg3acblI/9pFOorTJZQWj/OJZNXUusmrazt/p2HJJcnLwNwrR0HakUrogyeV5At9yFM+GrzIRvo4D29Qms+AhfvGaUlUqwB0HP4mMYmsZFcRv4rMhHIMHvjPLB141Cqcc6PqmuqYShUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751524946; c=relaxed/simple;
	bh=3FLrNH1fLqllY3wQbRFJb8x8xoXb068IlQn0ghAb9XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwyheq2i4p9YlDynEWMFL5DZIbWxC/tMDnXu+Dj9AqYfkHDd/rNKQH/XaWKn8bNpwi2czKhBlqqIcFSAZ4UadHT1oMrUw0+ojpW0fgCH87KXvxr6hLt90c88LGENZ/a2hkF7iPFC0Bi9GPBt9V0PmxXbREEGEXVU6W8AyUfXZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qv9zcA0x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qv9zcA0x"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56317d3P029408;
	Thu, 3 Jul 2025 06:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FQ2o2rnvGMjjtFh0Bq1lonMOaS2iyi
	fasvRXqd5tFKY=; b=Qv9zcA0x/rz8X1V5z4Ec6LhlKaxZGdChTQA5ArARM38uWY
	7/A6ixmCzs+sUCKjESyzTaDWB8yvJFl1MYMIVBcE5D2OmNHp8k5eg/o0wMUTrvJN
	zA/QoKRrXMHu48mi0mAAz7KO942czG9gr78OVR4/V9ZbNbPsNEHjrEoFAVJDAB3V
	XrhiUnqqSmdN3M4+5Oz6dxUNQWGmkC9HSOoULQshY23MiF+FMS0cqqp6nvAHEq3o
	AnfDt7jIZWD/8y6N43D+VCfR1Trjr9h5mtDCf/+vx3KSyLVqmqL7iwCzq8c6DaTW
	xB8KA0cPd9tFGjyClK3D10O4TLeZTJ9POy8zTtow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrt183-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:42:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5636gHap011215;
	Thu, 3 Jul 2025 06:42:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrt181-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:42:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5635AZ0j021109;
	Thu, 3 Jul 2025 06:42:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqukmrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:42:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5636gEGn10486136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:42:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E70A20040;
	Thu,  3 Jul 2025 06:42:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE80820043;
	Thu,  3 Jul 2025 06:42:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 06:42:12 +0000 (GMT)
Date: Thu, 3 Jul 2025 12:12:10 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
 <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
 <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=68662649 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=zlpP-P51Rln0S9o4DoAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: uvfRqXEU2LvG6zLh0ZrC6-x1MqTzvase
X-Proofpoint-ORIG-GUID: ESHk2Z71ZlPyTuhnPKSILzVEV0ilKI7L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0OCBTYWx0ZWRfX7TSU2NAFNPTn ujTwC9J2o66QjMzuo/leyxs8wrcHWyXV6T+ip76sbE7bocu+lR+3stZHyu38CROzTVgudjm+pZo pagCANIvwygBnn8LbDg+I8GJTCSlJTvHEfc4Hab2xAqzTmnZm8LuE0FYAU/26FJNiz1cXaU8YVj
 48OoOvpOnU6LqRiRNZJNsq7Lgai3Ve9fI4O3Ez/g/yPs0kKAP+T4zlIYleliENyn1fGcKe5Cxkd kvmKHjNaxuPscBBZGW7nC0OJMTFHxMUwirf4AwzgZMeADjHioSnQ38pwv8F8plFGRaW6D2rWhFc oYXtl0FashdEeGcxzFAhqRF5E1nUTwiojnq5SFJdlfOcyswEZeCUypO+gpALFKZUwl/OiEb/ZBh
 nVdAqxXrmgObHSW2OQntcmYToEXo+YNLNpwxtSmm70u6oKDmRlkriNGfkFATBelrK/+tAERO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030048

On Wed, Jul 02, 2025 at 08:46:39AM +0100, John Garry wrote:
> On 01/07/2025 17:18, Ojaswin Mujoo wrote:
> > On Fri, Jun 27, 2025 at 03:09:09PM +0100, John Garry wrote:
> > > 
> > > > +touch "$SCRATCH_MNT/f1"
> > > > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > > > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > > > +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> > > > +
> > > > +# XFS can have high awu_max_write due to software fallback. Cap it at 64k
> > > 
> > > This test fails on xfs due for this reason. software fallback -based atomic
> > > writes have no serialization against reads or other writes.
> > 
> > Okay so Im still not understanding why serialization is affecting
> > anything here? Lets assume the IO never breaks,
> 
> That's a false assumption.
> 
> An atomic write should never be split into multiple requests for REQ_ATOMIC
> set. However, regular reads and writes may be split in the block stack for
> any reason. We can easily force a split in regular reads and writes by
> setting max_sectors_kb to a value less than the read/write size.
> 
> Check blk_mq_submit_bio() -> __bio_split_to_limits() -> bio_split_rw()
> 
> > from what I understand
> > in fio code, we do the write and then once it is complete we try to read
> > it back and verify it.
> > 
> > Why serialization matters here, because even if device reorders our read
> > before the atomic write, we still fetch an older $blocksize chunk which
> > should have the data and the header.
> 
> Yes, we fetch $blocksize, but it may be as multiple read requests,
> so we can have:
> 
> partial read $blocksize request, atomic write request, partial read
> $blocksize request

Ahh now I get the picture. Since software atomic writes might have a
value way higher than the max_sectors that the bio may split at, this
causes the reads to split which is the issue happnes, as you mentioned.

> 
> > The data crc should match the
> > header because it would have gone atomically. What am I missing?
> > 
> > (Or do you mean that max_sectors_kb is not big enough to support
> > reads after software atomic writes and thats the issue?)
> > 
> > > 
> > > Can you cap at atomic write unit max opt? That will mean that we get
> > > serialization from atomic write HW support.
> > > 
> > > BTW, to repeat what I said before, it can also fail for atomic write bios
> > > using HW support, as reads may be split.
> > 
> > This one I can understand, the fio's read is split causing a short read
> > and seems like fio is not requeing short read properly for the verify
> > step(?) so it tries to verify against short read itself.
> 
> this is not an fio problem, as above.

Yep got it, its the block layer splitting the reads.

So as a solution, do you think it is okay to cap  $blocksize to
max_sectors_kb or would you suggest it would be better to just stick to
awu max opt? 

Thanks,
ojaswin
> 
> I would like to repeat that the test should be ok to use, as long as we
> don't try to use an atomic write size > HW support (and we also have
> max_sectors_kb > $blocksize, which it would normally be).
> 
> Thanks,
> John
