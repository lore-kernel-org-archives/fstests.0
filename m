Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918382C60
	for <fstests@vger.kernel.org>; Fri,  4 Jul 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639752; cv=none; b=roAsS8ptt8uivkFkcPyWRONfojLB16tGXLRgzb25x7L1d6nKTs88l1yJis+9w+3IAbMR8RtJHT6cncfGrkHG4MUQS2uHrp4fA+beuT/qAdK9N7igJ+X/wbJIgC9VzpHG5ggGoy8TwphOG2Dxsr3+RMmZvUmE9Br0vtq2OnZ2dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639752; c=relaxed/simple;
	bh=SThattQ0KY+h2+a2JeTXc/uspNHI6/3la37yN2g6S2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlkN9d98GWcCm7jMMPmdFBQEEa2Vv0nVwzq9R8G6CsANzpuh3LB+x+mYPDSnwZ40ftKGvF9EH6rdi4b5EHAGLVVUVumNWtJj1yonH/CfL6vNqXMIMJOIotSReq9ILzDyPfzaIHpkYicBSYsrDo7i4OHC0Zw3QzllUJejtabBzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RvWGItT6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RvWGItT6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56464twg019886;
	Fri, 4 Jul 2025 14:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=O5tJycZYUexJajHMMypCOWyI2nyWIL
	bc9aNJj6UKUDw=; b=RvWGItT6jSaghw0WcN2DemysQGp0lCc9uT0uhGwAWpoxJv
	Y5X/V91bO2cYvSY4MpGR7PxW22Dm0s1xxUTFQ3D07Ti+k5XOtcikdc5q0YrjGcaT
	Mz/jspFKEJK9fVppR+zGpzKgnA8jICRlCkZ88Y2Z7gtQiUjZCTv3Qol671sYaqyO
	mgESAd+cTO7lObvKDEkTq6VQrzbv5sL8iP5JJY+omZWX3iCuR2vo7caZ2BVZMWlG
	VkXDz9iQ5XAp8pEbtmsJEhluqlxnGrf5oymcMaax/aO+MtH6dpsAmtnqQbg9ux9h
	0ZeJMi70eus/+aDmbalpZ9CfWpeW4b7Mt2d7m4bQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j831a9r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 14:35:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 564EZh2J007580;
	Fri, 4 Jul 2025 14:35:43 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j831a9r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 14:35:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 564ECh5j021078;
	Fri, 4 Jul 2025 14:35:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqutg8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 14:35:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 564EZfJD17629488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 14:35:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB9782004B;
	Fri,  4 Jul 2025 14:35:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EA5F20043;
	Fri,  4 Jul 2025 14:35:39 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.214.115])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Jul 2025 14:35:39 +0000 (GMT)
Date: Fri, 4 Jul 2025 20:05:36 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
 <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
 <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CgFFQuiC91Tjy5Ani5YT6MNWzia_44Ox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwOCBTYWx0ZWRfX/J3wr50AbogH IG6UcMUz+vPVmn100dPiEUOdImy54tGlwubfavV/aLFkjUYgWVdvWfpheE27gOGZQuViK1aN9N/ uKLwPTtjaVInHVodMRvA9iW5VPlTWiTEkvwuhnDqjxjFevySmAL3Z3giDp6vrQXaIn6dlSx/PZv
 KoAIoDRwjqPrcLS4C8NfZf7RPk+ep8FZnrlCJuhq7b3Im2RWA52GO9iNN6HhxE8QwoOeCtwXBg+ o/Z+p+qUX8uE0sJzpYYC2cP+gc96H4ZSX+M4kAH2XPueSa3bBipMo7atP6/35xg18Af/JDq3WRp hdkdukKmGDlQ35Ky8mguw50CwgdGlwjrgkAa4P+GetW8IkrQL0x22o53Xj2n8HflVxly3CfA28t
 viVo8JadfTOyLaiE+kx84anMS69OV6LQPzcwh6Fs4SYyzj8Frrr5/mUhRiKtrVI2bplsltOm
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=6867e6c0 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=7Bei65VzZemJ5l0PBlsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LKBnvY3_EBKr8Nz5dcdGVxyXvSv73Bor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=965 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040108

On Thu, Jul 03, 2025 at 05:26:49PM +0100, John Garry wrote:
> On 03/07/2025 07:42, Ojaswin Mujoo wrote:
> > > > Why serialization matters here, because even if device reorders our read
> > > > before the atomic write, we still fetch an older $blocksize chunk which
> > > > should have the data and the header.
> > > Yes, we fetch $blocksize, but it may be as multiple read requests,
> > > so we can have:
> > > 
> > > partial read $blocksize request, atomic write request, partial read
> > > $blocksize request
> > Ahh now I get the picture. Since software atomic writes might have a
> > value way higher than the max_sectors that the bio may split at, this
> > causes the reads to split which is the issue happnes, as you mentioned.
> 
> This issue also exists for atomic writes based on REQ_ATOMIC.

Yep got it now, thanks.


> 
> > 
> > > > The data crc should match the
> > > > header because it would have gone atomically. What am I missing?
> > > > 
> > > > (Or do you mean that max_sectors_kb is not big enough to support
> > > > reads after software atomic writes and thats the issue?)
> > > > 
> > > > > Can you cap at atomic write unit max opt? That will mean that we get
> > > > > serialization from atomic write HW support.
> > > > > 
> > > > > BTW, to repeat what I said before, it can also fail for atomic write bios
> > > > > using HW support, as reads may be split.
> > > > This one I can understand, the fio's read is split causing a short read
> > > > and seems like fio is not requeing short read properly for the verify
> > > > step(?) so it tries to verify against short read itself.
> > > this is not an fio problem, as above.
> > Yep got it, its the block layer splitting the reads.
> > 
> > So as a solution, do you think it is okay to cap  $blocksize to
> > max_sectors_kb or would you suggest it would be better to just stick to
> > awu max opt?
> 
> I tend to think that it is better to cap at awu max opt. If zero, then don't
> do the test.

Hmm yep this makes sense but seems like we don't expose it yet in
xfs_io. Will need to add that support as well.

> 
> What awu max opt is reported for ext4 (for awu max > FS block size)? Is
> min(bigalloc size, bdev awu max)?

For awu_max_opt is returned as 0 for ext4, since 0 indicates there
is no such slow fallback. From commit 

  5d894321c49e fs: add atomic write unit max opt to statx

  ...
  When zero, it means that there is no such performance boundary.
	...

Regards,
ojaswin

> 
> Thanks,
> John
> 
