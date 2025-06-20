Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288D136988
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438179; cv=none; b=vAwFiJAtOqIMWKohdniKj825p2/sAOhk9Qwr7v4/l8sQMQzTOcW/lwjLlupsiNqEq/Ovn9nvGoKVn2nAcVDqtL6qiKhal8CGMJnbxYqNQCk2Kshu7/d5ya4zLSSGoxKVsuMi2aXL5HlQCg5x6GSrEti5XYAvbq2uh4uJ4Hx8tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438179; c=relaxed/simple;
	bh=Xv79lwKSI4OzX/j4/UnsTLxA6NTw7gocqa3bx6rVOB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqvErU9N50B4gV4KnHbcf406UIODUPNY/JhXG16QBVsGLKNVWPcPx/QGU/Ua/HJOLoHeakMGgRS0R2SEAnnc8L0JqnAA0YTS4jjpEWBb2km0y9vMppvo5gYyZBFy/yJxHHOTa5mUZxn1eN+v4gNvYgveDixwajFTEs2MdQ6lBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dIlSDF2V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dIlSDF2V"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDvlDd016161;
	Fri, 20 Jun 2025 16:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vSpDmXwRE17y/R/r79PRvL0V4BwTbr
	dqCRLpWZIVNyk=; b=dIlSDF2VxBBkeU5NAGmcsh081R+tEhtJ6e+6c5d5At7TOk
	tBU/ambczTZi1vCH/qffNke2hdQjiqqX442hoHBRIU2vF8TH3uXZSymeh4eTnl6W
	iiDfViZ8juWzt6m8sdw1hUouEe+jzZU1+tiifE8mKuxzKxd5w+XAysvcs+vaclse
	WeMrCX4+Km7ikfR1KB8B6Sh0QzS575nXor2Trewkf1PG6TN8+WeDT7Qbelh2ZF2x
	qp3ylBvfJfIl5lZTMI+O91C7Iek1PXvwZAfLBU8G0j5REr5rjE3PSf18vha89Ksx
	QWkCwFU657p1eh+lNfWXGlYsp6Ox5cJJs7AWv5sA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnvguh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 16:49:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55KGlssY001829;
	Fri, 20 Jun 2025 16:49:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygnvgud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 16:49:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KGWseP021600;
	Fri, 20 Jun 2025 16:49:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47cahwg0p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 16:49:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KGnNYl45809996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 16:49:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A81C120043;
	Fri, 20 Jun 2025 16:49:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D06020040;
	Fri, 20 Jun 2025 16:49:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.222.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 16:49:21 +0000 (GMT)
Date: Fri, 20 Jun 2025 22:19:19 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org
Subject: Re: [RFC 10/12] ext4/062: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
Message-ID: <aFWRD14piqQxSL38@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>
 <05005921-517b-4286-be24-eeef625e488f@oracle.com>
 <aEu5KcCAkOrjiLDb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87a683a7-9e81-4495-94e7-675627397c16@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a683a7-9e81-4495-94e7-675627397c16@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExOCBTYWx0ZWRfX2ydzzoNkk9RD CbZP+VSDOJzgeNF2ZNk3jxx3gJS0hP+aWJ1SdmEtOGQmolvgT8Zrg4wQTr7jRNqFwfU7121Aeer bnGAAjA8JRy6icv54tDrz2ZAv191S9HxEJ9btc/hh9hVcto6rwYAgro7gZN2fcknbb+GMPtheD1
 d/c5kVev1NzfCI3cZGiFwocnFBJbl+F0qtlTWlGU5qeGWjgtOZome7gojg+jVGiryO6wW2E6npx q4HX0xFnqbiXtnq9yYSdMbpiw2jq8ZN1++ZvVTPJPknX0jsuj9xK1+DQpU7WZHrJsZQdappWhgj 1NZJuiWRMqkTr8d+cG7x3kK9T2jGL71bntiLH/3BQPUic0TdfNV8AXlu5c8vMjgHKPMcDh3HRdb
 2NqWzLkYs3ix3mJbDU6cJoWfgAfiuFF9NuRW4W9emziFousleOQnKGAaI431FA3UXaaANmRb
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=68559117 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=G6eapHUxyhEpgTMLOpgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: pcRrZ2ac5PBCGbRFlyutdsfzeuXC2y0C
X-Proofpoint-GUID: EClcIJmjXqGX2Z64ZCadWIba7Ynb2aBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200118

On Fri, Jun 20, 2025 at 03:01:40PM +0100, John Garry wrote:
> On 13/06/2025 06:37, Ojaswin Mujoo wrote:
> > On Thu, Jun 12, 2025 at 11:26:17AM +0100, John Garry wrote:
> > > On 11/06/2025 10:34, Ojaswin Mujoo wrote:
> > > > From: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
> > > > 
> > > > Brute force all possible blocksize clustersize combination on a bigalloc
> > > > filesystem for stressing atomic write using fio data crc verifier. We run
> > > > multiple threads in parallel with each job writing to its own file. The
> > > > parallel jobs running on a constrained filesystem size ensure that we stress
> > > > the ext4 allocator to allocate contiguous extents.
> > > > 
> > > > Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> > > > Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
> > > 
> > > RWF_ATOMIC does not guarantee that racing atomic writes and reads are
> > > serialised. That is what you are testing here, right?
> > > 
> > > NVMe and SCSI do guarantee this (serialisation). However, reads in the block
> > > layer may be split into multiple requests, even though unlikely.
> > 
> > Hey John,
> > 
> > We are not really testing the serialization here
> > (verify_write_sequence=0) but rather that multiple threads atomically
> > writing to the same file should never tear the write.
> > 
> > In the test, for each job, multiple threads are doing the write on the
> > same file with the same iosize so they should always overwrite each
> > other completely.  The verifier then ensures that the whole iosize chunk
> > written matches the checksum, which will only happen if the write is not
> > torn. That way we are able to ensure that even with multiple threads
> > writing the same ranges, we don't break the writes (the sequence doesn't
> > matter as long as it is not breaking)
> 
> So the threads are overwriting the same data range, right?
> 
> If so, as an experiment, try setting /sys/block/DEV/queue/max_sectors_kb
> lower than the bsize and see what happens...

Okay so I tried this flow:

1. mount ext4 FS
2. max_sectors_kb = 4
3. Do a fio atomic write of 64k (awu_max = 64k in this case)

And I'm able to see checksum issues that means the write is getting
torn. I'm not sure of the exact block layer code around max_sectors_kb, but
I do see max_sectors_kb -- sets --> max_user_sectors --> max_sectors
But then get_max_io_size() ignores max_sectors for atomic writes and
uses atomic_write_max_sectors, which should be correctly set.

Hmm.. I must be missing something, what is splitting the bio?

Regards,
ojaswin

> 
> Thanks,
> John
