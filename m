Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DA1917D6
	for <fstests@vger.kernel.org>; Fri,  4 Jul 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642616; cv=none; b=m8CxPwNgTHD0zQ+12ZRcOWFJfF4seyTrY4d41JUsFSdnAkgeOr6FexOC6nwVocKhG1hdQ+Pmx9H/hkLu9DjB+fBU2ll0FICZvNfZF8s8DIUCBFQj1+ank3AfhU99V1iJckirp6DIrTJTWbbrO1iMxB9hRhRtrFHc1e6ll55J2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642616; c=relaxed/simple;
	bh=uyV17QRY7wf4i4aBj+GLrcPREixZ/4MNaquEh/FkyI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hqwu4ig8z+aGc2i9eWzE/VgUUwD8NoQ1C0jVzYExgzwSIf5v72Rcusj9BDWoQTB0HV7AltptPQCfPLf5BQzmlQ+oHe6pZcc0DNzKr9hhpP4XHe1KIr4rL78ppBMic4e+EyE9wHgwWlFP21DYzj/MaQ83Y7hbLfK68qnUPAKi5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ogdSNc78; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ogdSNc78"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564AXBJv017214;
	Fri, 4 Jul 2025 15:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gVscMfjiWnayGNSSaY7z7pYeXW5QBN
	n75DVL7XrbUxs=; b=ogdSNc78HgMkiDV3w5v2dZWhheVlxpDS+8y80pZtlyysTU
	RFfT1kcjdXShbIOQwBVsKsvpS7zF36fA6ASf5Qt9HOLWHHDDUpz9vUvWOBARouc/
	Fyb6X8m2Z9Tt+5WY8dIg1YtRXbl2s/9zla5KVppuIbYewVKKUMhpnZa5OLIIxEdX
	T6orQ6cOJLUYXJQ0cX/wv7G9VP8/ilc2AENsDes193JAJMZFX0DTpXNohc0gJ9N/
	oD7VEbaZB4/6Chp1p0bNu2+fZFg+JvoNmZk6yUuYcYc5Bdg6aj5GiezumPrq5AAi
	IO1pTRaT3IFkl1VVm4MIihM80umLN/zicP1zbT3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dtg27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 15:23:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 564FNRhX021217;
	Fri, 4 Jul 2025 15:23:28 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dtg24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 15:23:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 564C0ScZ021430;
	Fri, 4 Jul 2025 15:23:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3t4hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 15:23:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 564FNPK446793128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 15:23:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 456752004B;
	Fri,  4 Jul 2025 15:23:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2F8120040;
	Fri,  4 Jul 2025 15:23:23 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.214.115])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Jul 2025 15:23:23 +0000 (GMT)
Date: Fri, 4 Jul 2025 20:53:21 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
 <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
 <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UOA7ASpfCw3NTXh4x5k0uwyFaylriEQu
X-Proofpoint-GUID: nWI6aaSJV9RGG4pG9sUyX45zfQu5ZtjA
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6867f1f0 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=Y8Viin0YC-EERjkA_mkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDExNiBTYWx0ZWRfX4elzCUO4z0H/ j1dV3RF5kxQ1gW2xzwyxi/RxsdB0OfC1yr0tDgzxWRGWtkTqtsz0bw/RJCHJ50wHUwoBdYseR4e WEAjZnsc++8Nd7KX3Fv5uTNyyDbPS+ULDelFnmKAKiNSDCM1g36DtWHaGkJOFLhGwzrU/Dd8Ww5
 DAy0Cp5vsmejmDk8u4+9vILk9nRH4gz6Xyuu6cvkCw8S90wZFgpia/RiIqWOeEMseZ+DPxa0wyt TvgG8a3BkCXW6IHK5N8wO1ZS6hm9Cc+auMNLDlLWIQso8/2P1C5QYLmWka5mjEv3fw7730QAErK tL4NPWlXIV9S12bVszqLb/56wc3OXAKvxBXzPevDZNhnnO8PgpdHADnD9i70zCPXmmjBiKzVuV+
 be6Em9qZngIo0TV84yRT5aQeO7jAp77OJ+K6lIqqCY4GWCCoH+dtiVPCMq+LcKlP/YRVfAYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=965 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040116

On Fri, Jul 04, 2025 at 08:05:36PM +0530, Ojaswin Mujoo wrote:
> On Thu, Jul 03, 2025 at 05:26:49PM +0100, John Garry wrote:
> > On 03/07/2025 07:42, Ojaswin Mujoo wrote:
> > > > > Why serialization matters here, because even if device reorders our read
> > > > > before the atomic write, we still fetch an older $blocksize chunk which
> > > > > should have the data and the header.
> > > > Yes, we fetch $blocksize, but it may be as multiple read requests,
> > > > so we can have:
> > > > 
> > > > partial read $blocksize request, atomic write request, partial read
> > > > $blocksize request
> > > Ahh now I get the picture. Since software atomic writes might have a
> > > value way higher than the max_sectors that the bio may split at, this
> > > causes the reads to split which is the issue happnes, as you mentioned.
> > 
> > This issue also exists for atomic writes based on REQ_ATOMIC.
> 
> Yep got it now, thanks.
> 
> 
> > 
> > > 
> > > > > The data crc should match the
> > > > > header because it would have gone atomically. What am I missing?
> > > > > 
> > > > > (Or do you mean that max_sectors_kb is not big enough to support
> > > > > reads after software atomic writes and thats the issue?)
> > > > > 
> > > > > > Can you cap at atomic write unit max opt? That will mean that we get
> > > > > > serialization from atomic write HW support.
> > > > > > 
> > > > > > BTW, to repeat what I said before, it can also fail for atomic write bios
> > > > > > using HW support, as reads may be split.
> > > > > This one I can understand, the fio's read is split causing a short read
> > > > > and seems like fio is not requeing short read properly for the verify
> > > > > step(?) so it tries to verify against short read itself.
> > > > this is not an fio problem, as above.
> > > Yep got it, its the block layer splitting the reads.
> > > 
> > > So as a solution, do you think it is okay to cap  $blocksize to
> > > max_sectors_kb or would you suggest it would be better to just stick to
> > > awu max opt?
> > 
> > I tend to think that it is better to cap at awu max opt. If zero, then don't
> > do the test.
> 
> Hmm yep this makes sense but seems like we don't expose it yet in
> xfs_io. Will need to add that support as well.

Okay so thinking about it a bit more, Im not sure if capping to
awu_max_opt is the right thing to do. 

There is no guarantee in kernel that awu_max_opt or even awu_max would
be smaller than lim->max_sectors so why to derive our io size based on
that. Further, handling awu_max vs awu_max_opt and their different
interpretations for XFS vs EXT4 etc are adding uneccessary complexity.

The simplest way seems to be to just limit the $blocksize to 
something like $(_min 16KB awu_max) and hope that 16KB is small enough
to not be split during reads. We anyways have other tests like
generic/1230 that can be used to test larger atomic write sizes

Thoughts?
> 
> > 
> > What awu max opt is reported for ext4 (for awu max > FS block size)? Is
> > min(bigalloc size, bdev awu max)?
> 
> For awu_max_opt is returned as 0 for ext4, since 0 indicates there
> is no such slow fallback. From commit 
> 
>   5d894321c49e fs: add atomic write unit max opt to statx
> 
>   ...
>   When zero, it means that there is no such performance boundary.
> 	...
> 
> Regards,
> ojaswin
> 
> > 
> > Thanks,
> > John
> > 
