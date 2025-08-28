Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE012259C98;
	Thu, 28 Aug 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393275; cv=none; b=J3X3YWlwnDhPBc8ZuESC7PaN/kqvj3FTMJDbIwlr/SfWuQNXez1GgxTOJvUINm6GSvcR1EaxkJfoVYvNLQgFyLo31ZthOJuh330+ilYZ0jmQGb9hA1LxxH9YApsSVP/EyFT9UWjvR/5dKz9tYsdoPmmHpa9kbw0I7kzjPEm4Xuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393275; c=relaxed/simple;
	bh=nnyzKFMJqFPIfreZmiSGFpp3ppdpNE2MXAhHsiG1EgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKsb3q2inTp5fO58jCs8r6h8mkQyHb8/WgjeWes9/1xBC6snWGVFCNHbH8cSrmyjv2J1lE9Rq4nVPZf39rXeC942eNlP+VTsWUYzt3aD7Ks6pidTOBJG3lnFNOiKi+dWMOAw18/mRMD4afViNUc9G3gFGKTn+kyxcrpbCU2eDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BPnyKGNR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BPnyKGNR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S6Lhxo007760;
	Thu, 28 Aug 2025 15:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cgddzrKR0TbeUSm7dvufIWFhwQXntc
	LdcnTydMIArtU=; b=BPnyKGNRIbS4Rf2yZArj5vfD1g7/MMpeMkowGqP3twj4RO
	bgSgP7bn9NXGXqFSc/rISrdeA4tnwIYpogs9JteqMasyeWRBVVkqlG7vbIOTG+EA
	VGqXVDa6M32CjRuaNxSQkOdaM5CDQdi7NnlRY+h+NX9uz7Ewf8BuT2dL1BoERzBL
	MTgANcgCJ00asd1r0kmBh6VwngVTawjGOj4DO3KTyRIkb51GFeP/91IIHFXEVqnv
	nHiwYbB6eQV+qW32RHK4HPAJv1dARvRlnBYbCQxucR/f90as5Rs18Y4wJmypMGH+
	6Ih288Kd/O/PFmtes8L+15L+D4/QbMGrT9CQK7Zw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hqaaf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 15:01:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57SF179V032021;
	Thu, 28 Aug 2025 15:01:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hqaaf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 15:01:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SErFuo017974;
	Thu, 28 Aug 2025 15:01:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3n58k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 15:01:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57SF15g349938766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 15:01:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 162FE20043;
	Thu, 28 Aug 2025 15:01:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7C5620040;
	Thu, 28 Aug 2025 15:01:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 28 Aug 2025 15:01:03 +0000 (GMT)
Date: Thu, 28 Aug 2025 20:30:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic/365: Fix false failure when mapping ends with
 free space
Message-ID: <aLBvK4I7uhYI3bsZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>
 <20250825152925.tcbbn5rxbjpk4ts7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825152925.tcbbn5rxbjpk4ts7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX04b5vyxUm44s
 Nt1Dum9X0STioHNUG5j8Kgk27jdQidImPyvDNdwQGcuTFEzso3WzG0UIKnumwaRW3DuaO5Gd31o
 vOU3vNPyTyVv2zXMgImjJyz2h5+cC+t7PJyUVppn6MW2UWOihKNyuXehlcZraX6sUGh84YZDmP/
 kB28BsCup03tamQ2sVNNROjY3AC4wO+b7mdUWE2bFTMY/WJQEV/x6jygOIYlqINxbUh9weHrWiV
 lBcqAHFB/552MJum/DEruyDgZB3GZyVG0l7xIyLGZRksw1O8sOeAUeyNU0gSdYmH8fiFdrnbWzD
 7V3x0kIDXRk3hQSnZVgKdWCqY0fEiPf3vHnZa8/rBbfez4eAaUfRsFnFBST3hoeKM92sycIOqz/
 c431eApc
X-Proofpoint-ORIG-GUID: dDEDpZoRQV_4l-u0URC7JQRE7HV0DCxU
X-Proofpoint-GUID: JxuHPFIPS6Es-TvYZBHU_HTNpw-ALbEE
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68b06f34 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=rB8oEQgLNWtF0VYQdTUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

On Mon, Aug 25, 2025 at 11:29:25PM +0800, Zorro Lang wrote:
> On Tue, Aug 05, 2025 at 02:55:56PM +0530, Ojaswin Mujoo wrote:
> > If we have a small FS where the first free space mapping is also the
> > last mapping of the FS, then the following sub-test fails:
> > 
> >   echo "test whatever came after freesp"
> >   $XFS_IO_PROG -c "fsmap -d $((freesp_end + 2)) $((freesp_end + 3))" $SCRATCH_MNT
> > 
> > since there is nothing after the freespace. Fix this by punching a 1M
> > hole in a 3M file to ensure that the first free space is always
> > surrounded by allocated blocks.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/365 | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tests/generic/365 b/tests/generic/365
> > index 36cb2530..bbadae71 100755
> > --- a/tests/generic/365
> > +++ b/tests/generic/365
> > @@ -32,6 +32,10 @@ if ((blksz < 2048)); then
> >  	_notrun "test requires at least 4 bblocks per fsblock"
> >  fi
> >  
> > +# This makes sure there is free space surrounded by allocated blocks, which
> > +# is needed for some sub tests.
> > +$XFS_IO_PROG -fc 'falloc 0 3M' -c 'fpunch 1M 1M' -c 'fsync' $SCRATCH_MNT/f
> 
> If you add "falloc" and "fpunch" operations, you need to:
> 
> _require_xfs_io_command "falloc"
> _require_xfs_io_command "fpunch"

Hey Zorro thanks for the review and sorry I keep missing this helper :/ 
I'll fix it.

> 
> Due to not all fileystems support these two fs operations.
> 
> BTW, I'm wondering how small (and what kind of) the fs you use, cause there's only
> one unused region, even this's a clean fs, there're some still many different
> metadatas. I even tried a 100M ext2 fs (which doesn't has log space), there're
> many free space regions. So I'm curious, how can you hit this issue? And if the
> SCRATCH_DEV is too small (e.g. 10M), do we really need to test with that fs size:)

Right so actually we used the standard 5G SCRATCH_DEV however we were
testing for 64kb blocksize as well as ext4 bigalloc:

 $ mkfs.ext4 -b 65536 -O bigalloc $SCRATCH_DEV

which can actually format an ext4 FS that can hold 65528 * 64KB = ~40G
in a single block group, so we end up with 1 block group where metadata
is at the top and free space is in the end.

Adding a small file like above seems like a easy and universal way of
getting around this issue.

Regards,
ojaswin

> 
> Thanks,
> Zorro

> 
> > +
> >  $XFS_IO_PROG -c 'fsmap' $SCRATCH_MNT >> $seqres.full
> >  
> >  find_freesp() {
> > -- 
> > 2.49.0
> > 
> 
