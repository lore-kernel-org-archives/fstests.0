Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA2171BB
	for <fstests@vger.kernel.org>; Sun,  5 Apr 2026 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775398325; cv=none; b=DsxCO2sqptYUMqv6jVXNE1l5H59BEYgHsXkGZ4eySayjaM2O52qgjlPMQsH29WMxqLT2nn1oj340/igImO+9sXUrqdg6rpYJ0gsSYhSl+nMabQvXIzPJ4hhPsxaozsGQjFJaa18kJfm+o2PX+sHWqGFPMeK5CAlqwELRRT2S/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775398325; c=relaxed/simple;
	bh=cj83DmnDxbuPh47aT+Mw93WrtlpsDU2jcHxy/yUdlNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge93a+ZNmU9lZ/7eGzDC+tMAjXoJa//FJpeoRE+RuIvEF04Sw8371q1+mMwT86SIkyFssPWw9kkCTTWLwiofrXpd7/m32u/jVnddxM00mRtBnMzh8NdaPtRbSVA8sJNeICOJ+filMZvon0isQBDYjLLCR1l1+8gNXnC3uRWHu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=feUSwsY4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="feUSwsY4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635Buj5o2463969;
	Sun, 5 Apr 2026 14:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aC6kiFe1lu0UL6mj53UmFmOegquL7p
	Fv9zGbOfOWAmI=; b=feUSwsY4Xj75/su3fOiP5pyYTCpk0O/tFX7KjuK3RVDt3B
	3XsdAlkZxRFo1MB43RF5Pa8LSebDUYTUmiLukKiSZ7Qz9R8if4YP2VO0HLy6W6er
	ljhoOlr0n1aQFuI2551U/g4OJYdUdx3WBX4peb9igu1GbEfoT+X5D5oXNsxhdX/r
	HYK68wvnX67GHI6o+7uxhjFZOLOn9A52xrjTEkkXRjqqU9Ysoxk695d73RVRmXgF
	OfBngQLt+zUEGBWIMPG8vqwwWb+JPcsLiWrqvpbpkfDzusK6+ACf2i40JAn6rSMy
	BMvFNp/A98n/5ZYDXHYM8C7R7XUqSnH0MKDw0N6g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2buey1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 14:11:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635AdN7w006360;
	Sun, 5 Apr 2026 14:11:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbfp1ha8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 14:11:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 635EAWeD44696018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 14:10:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A78C2004B;
	Sun,  5 Apr 2026 14:10:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC7420040;
	Sun,  5 Apr 2026 14:10:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.21])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  5 Apr 2026 14:10:30 +0000 (GMT)
Date: Sun, 5 Apr 2026 19:40:09 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Super User <root@ltcrain119-lp6.ltc.tadn.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 3/4] generic/765: Ignore mkfs warning
Message-ID: <adJtQX-KK6wsJ0AS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <1418f57e6115c93278a3891f075338163e2ec667.1775039135.git.ojaswin@linux.ibm.com>
 <20260401143018.GH6212@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401143018.GH6212@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ntBP_lyJp5vu1ppaq4sG7mSQNyncz-hw
X-Proofpoint-GUID: ntBP_lyJp5vu1ppaq4sG7mSQNyncz-hw
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d26da8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=inFcw62BZDIZG7_6twgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE0MyBTYWx0ZWRfX7OLyVLW1TzRG
 xuaezx1RadvzUmgc3qP7CUb819Z9qZx2eRBfIN0I2mFH+tB4NguiI7WTVKNqeXpMhK6RKxFomsy
 1tVmeZA451xOlujbV5WaIXhr/rrqau7YQXhX88Oa9BoQfbdS5w2l9+aUfJAnXbDE+Ht4aFNMkFp
 7VNHht+xs6AJ2inCWqHiN1qS8Q2QMBGcKlwsizGXXrC3+QQFwgC8+hJKc/xu88lOLNqmV0S3s45
 zF82avs+EBSzxglaPfthOlzayLnaFVOuFNpUrlzyJwQJruWS8ZOgPtRuGglmYb4rsPODzPtP2ca
 SDAai2SFfRiNEmMFteLT294FNeVtFaGSdqqIj0QtlONF256l5GAac9Jo6PIGrNRJdPI9N6DBTNc
 wakqA0dL62wgEZoVVOfjZ7XxD8yaaO/6h92LuT6ah6ShJKbXlcH3fDFfMAyWFRavFuzxBjvmBxJ
 627zxu+ZIgzn7d2dHMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050143

On Wed, Apr 01, 2026 at 07:30:18AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 01, 2026 at 04:10:49PM +0530, Ojaswin Mujoo wrote:
> > From: Super User <root@ltcrain119-lp6.ltc.tadn.ibm.com>
> 
> Who?

Ahh dang I'll fix this sorry about that.
> 
> > This test validates atomic writes for all possible block sizes. In ext4, for
> > smaller block sizes with configurations like:
> > 
> > export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"
> > 
> > The output can get corrupted with warnings like below because clustersize
> > more than 16xbs is experimental:
> > 
> > + 16 times the block size is considered experimental
> 
> Er... a message that doesn't fail the mkfs is printed to stderr?
> Maybe mke2fs should fix that...

Hmm yes makes sense, I'll try to make that change in e2fsprogs.
Hopefully noone is depending on such a message showing up in stderr.

> 
> > Hence pipe these to seqres.full to avoid false negatives.
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/765 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/765 b/tests/generic/765
> > index 4c768783..6794eb72 100755
> > --- a/tests/generic/765
> > +++ b/tests/generic/765
> > @@ -64,7 +64,7 @@ test_atomic_writes()
> >      local bsize=$1
> >  
> >      get_mkfs_opts $bsize
> > -    _scratch_mkfs $mkfs_opts >> $seqres.full
> > +    _scratch_mkfs $mkfs_opts >> $seqres.full 2>&1
> 
> I think we still want to check that the format succeeded as a
> precondition for the test round, right?
> 
> 	_scratch_mkfs $mkfs_opts &>> $seqres.full || \
> 		echo "mkfs $mkfs_opts" failed"
> 
> --D

Yes makes sense, I'll do that. 

Thanks for the review,
Ojaswin.
> 
> >      _scratch_mount
> >  
> >      test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> > -- 
> > 2.53.0
> > 
> > 
