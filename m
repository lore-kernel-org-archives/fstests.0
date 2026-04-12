Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA728980F
	for <fstests@vger.kernel.org>; Sun, 12 Apr 2026 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776013747; cv=none; b=qDeO38U4R3yJcruT2Mtm3bg/qx5WcD2RJI0TpDv/aEHPisPcZ1JOtDu9n0c87fbWcZsxZNjg5VG0pArexLGg4P09jUWzrBGDpvXWEhaBK0yV4uNJnre99wtxgaHZEICX1upYdPikFfbLR16PsACog7VPnLyL/X0NWO4y6I1n5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776013747; c=relaxed/simple;
	bh=5iD7aUF3EZOeUVJWfpCaKjTacxYKC0YiQaXNdynUqRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTtFjXOLNyevEdTgmwvEF5iusAcC67FTxw26PapwPyeVhojo3J7iueCfi8jlhE1w6KhnUCDjWmBe1Rb2yWW0kQX89bU1NrvLcAlG5zKKaPUC7nWxpF7BOtdjNUS474dnW/D9nAkKnchUvysOqeHQuOfS4QaeUmsg5OVUweik/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dlZo2E5x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dlZo2E5x"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CAKcur1877219;
	Sun, 12 Apr 2026 17:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4s/XpzajbiTK13cbMDQUIBMaHe6C+q
	0MfGVn8amQfkM=; b=dlZo2E5xMEZpc5ux83P4aXlpubD8mGTi1EsB84gNOUmgUl
	/ucuI/PAbEXB/iIX2DeYX546lEx2zOiQp9IEvZ79QDMyF0hNEKdzsjLK4Ynpd8WK
	kbGIf9OKxttYhol9CQ5Lvnos2Y0E4SCDpPZmnTuSpE+TJByXkkQhf1o008Z/71Xi
	+uh+sClSqdGoPfLehW4aZOGM1tKcPiK2iDBn7Up9QJtqqil2Xkws7t5gUFzj8cpG
	9pTiB6phldyk0DjieQWHDBY1JKQJLFu+Qd1+7gEr+rVWNsOCjcixN7CX/kUosJGj
	BDORddPiDBBg5BA8GbcqDDOZlJK/i6/5kJM3opgQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17mgr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 17:08:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63CE0bDU031191;
	Sun, 12 Apr 2026 17:08:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y26yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Apr 2026 17:08:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63CH8o7216122148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Apr 2026 17:08:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96FE32004F;
	Sun, 12 Apr 2026 17:08:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B53520043;
	Sun, 12 Apr 2026 17:08:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.214.113])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 12 Apr 2026 17:08:48 +0000 (GMT)
Date: Sun, 12 Apr 2026 22:38:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, fdmanana@suse.com,
        ritesh.list@gmail.com, naohiro.aota@wdc.com, wqu@suse.com,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/6] generic/765: Ignore mkfs warning
Message-ID: <advRgjl1tG4PMc6V@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
 <20260410165435.GU6212@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410165435.GU6212@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE2NCBTYWx0ZWRfX4IFLHQ/kdffb
 KmA0xH7Vv4mevQtUUYcWVbqAI3T1zZUdqBjfBQPNcp//0SgH0ln+w1so0S3uYs6LbXJJotZTVKK
 Cz5AHKBTMEpYYXfbffFwdUMcfVHQQIoQCcRnrbgYEqADMIHYN5yuRm/5gkdTA1xaRFDumHvcOJ3
 DFudS2QUyuem/IHQcNP9iP6FVHtsJ9qoyJiTW9+zxzDBUzrhrPIIej9VJNNitlXirXw7h0p+cd9
 42ziS6w5kz0VEiNa/TNpJacsfkjwl13DFDJS7pNiuEn1Clz2Ra5U27z3mHAac5NP+nLEJrDRrz4
 zSzPmRMhd0+jV3NNB5AijXj5sXcVGd9xh7TdUXt9lgesqscX8+RcR3Wq/DDvbJTNlwdd6f1/rjf
 cZkDhlD2AeYLhnOg/zz5138E/EBSzqh/tHvZYDojZZF/uXp0DFd52vhPc38uLlJe2aSsFlKCH0C
 +Owu18PmEXl7KTPPszQ==
X-Proofpoint-ORIG-GUID: GvCt2Ulj4MRSj-75NcraHaxTioAnK-eT
X-Proofpoint-GUID: w6BhWcIidJgfPCOzfaJr9JFV-jprY1-t
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69dbd1a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=IldZAm_z1XGbSeK5CQ4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120164

On Fri, Apr 10, 2026 at 09:54:35AM -0700, Darrick J. Wong wrote:
> On Fri, Apr 10, 2026 at 12:06:04PM +0530, Ojaswin Mujoo wrote:
> > This test validates atomic writes for all possible block sizes. In ext4, for
> > smaller block sizes with configurations like:
> > 
> > export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"
> > 
> > The output can get corrupted with warnings like below because clustersize
> > more than 16xbs is experimental:
> > 
> > + 16 times the block size is considered experimental
> > 
> > Hence pipe these to seqres.full to avoid false negatives.
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Seems fine, though I think I'd rather mke2fs get patched to fix this.
> 
> I'd let the maintainer decide if he wants this, but ... I'm not sure if
> he's actually going to receive this message. :/

Hi Darrick, yes I'm preparing a quick patch for this. We might still
need this so people on older distro who wont have the e2fsprogs fix dont
see the failure.

Regards,
ojaswin

> 
> --D
> 
> > ---
> >  tests/generic/765 | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/765 b/tests/generic/765
> > index 09be53db..b7cc70f1 100755
> > --- a/tests/generic/765
> > +++ b/tests/generic/765
> > @@ -64,7 +64,8 @@ test_atomic_writes()
> >      local bsize=$1
> >  
> >      get_mkfs_opts $bsize
> > -    _scratch_mkfs $mkfs_opts >> $seqres.full
> > +    _scratch_mkfs $mkfs_opts &>> $seqres.full || \
> > +        echo "mkfs $mkfs_opts failed"
> >      _scratch_mount
> >  
> >      test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> > -- 
> > 2.53.0
> > 
> > 
