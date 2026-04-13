Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C83AEF59
	for <fstests@vger.kernel.org>; Mon, 13 Apr 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071387; cv=none; b=RCig5EC7/y/BO29f1YhbmYplH2MW4cd0g99FhWONwRjqvBpA9VlO/TeK1sWHdJEpf/l1usmLkxggWBfJ41ZS3NWp+Yn986YukBXW01Sh1122y5I8w6Gt67V+lte9nDjLMaDzXKxQQMkUK8X7ID3RnJ2Qk10F8ONkCvrHsqYp9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071387; c=relaxed/simple;
	bh=kAIHgOg6mDqWFDRNj7cM+r6fU19eVV/d7kGZ89AXtLg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUWIJxFzj4JoCLDIBDMoLHcHPBCj+XDaeljE9fzeZ9vn7Hw93iMsV8JQKxSwWIiwKOJqRqTcaT/xg8hKdH1OCdm5cV30ehIrf7TNwWGtCxDoccU4ImLtLAOCtYc84RzU1W1OGmEXw9GlRx3RDR76GgowSQkAlBE4o1X9eMKTmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LQsUI2mO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LQsUI2mO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CCmqsK2164393;
	Mon, 13 Apr 2026 09:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A/vuPoDL2UhNhy37osxt1y8E2QBMvC
	cazc8uYsR5Gzw=; b=LQsUI2mOoRjurOLyolYB+DLpf436OoQzHeodS/ylKx7Mbm
	/bYN+q0OZQ6T5DsSrPqnpyl9Ze3MydQ8rRhUsGn1BwLnYsOfF1vN8im2tLoitmQ9
	+ttUeoLHklnBGyv4exBY39BnVrHKppqCikI2/ogYc35cU11pTOEAWriOj+wleHJx
	gSrxVSlvpf3RuPkdpEc663ySQMMX58ykvADSb88HgqeMu0qg8jjYHXn7++ilkVG8
	UsuDFGL2BxvF1MmRgQsMLz1tYLsSUxRXiWIyIqoc5XsBDzZ1Pd5TuQaHA7XUyVNK
	F3jzrEiOgUtElVAbBOUaej1IjG9taXrgqlE6zBiA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqpuak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:09:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D4Cu0g004175;
	Mon, 13 Apr 2026 09:09:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k4cjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:09:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63D99dcx52953500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 09:09:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7363A20043;
	Mon, 13 Apr 2026 09:09:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8968C2004B;
	Mon, 13 Apr 2026 09:09:37 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Apr 2026 09:09:37 +0000 (GMT)
Date: Mon, 13 Apr 2026 14:39:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com,
        wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/6] generic/765: Ignore mkfs warning
Message-ID: <adyyzhJr4gavZTaR@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
 <20260410165435.GU6212@frogsfrogsfrogs>
 <advsFWodVwUXDrVS@zlang-laptop>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <advsFWodVwUXDrVS@zlang-laptop>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dcb2d7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=2iQqaHqKdbrptKz-vmkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: y2wyzAr-9wiUw6kkvvHxu9B0Nr5ar4F8
X-Proofpoint-GUID: c0rNfK5ZNNMcpc2LTDTbNpWiH_DitUyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4NSBTYWx0ZWRfX9aL+U6a9tYsY
 S8V2/z9TL6CUG1yYpQQjdTsu+6SFt6HwjGjYq7DVNMnO9fFVWesrQP8lAJT0fO3WYSUY7Fg8owe
 qq5lMOAwR7qYsA5jXGwZdEeI+QYYgbuVG9+6CwnYc/bUmrIlyNprmMs79ieuo11q5hJDd8JfNQ7
 B6epLyAJ5SZfEmtN1Wf7T5Ei+PnsAdeSrzMQOyJLFmUuF7gZy8WixzQbMaitx7LgJ3lqqeehPS9
 lYvzng7II/vyXMpYv+kX397nlgXjuRmZyemb7R3fUUTYR7jwozT3BAvqYH6oanDzaj/C9NeOXyg
 AX/97m9N6iwvl+QacSJz5QZy0NsczESfD89dgaIsgFT48GiIuKKoUHbf4M8Y2KhkYtVykbJqesd
 10+dWRTMLjFBLBP1wCv8fx/+CoX9/YiKBe6w9TBt+5hxwKO78gU+TW09C9M+jwf9n7jSYGK7zxQ
 18Ix1f8eOy9vcEIF/MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130085

On Mon, Apr 13, 2026 at 03:23:51AM +0800, Zorro Lang wrote:
> On Fri, Apr 10, 2026 at 09:54:35AM -0700, Darrick J. Wong wrote:
> > On Fri, Apr 10, 2026 at 12:06:04PM +0530, Ojaswin Mujoo wrote:
> > > This test validates atomic writes for all possible block sizes. In ext4, for
> > > smaller block sizes with configurations like:
> > > 
> > > export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"
> > > 
> > > The output can get corrupted with warnings like below because clustersize
> > > more than 16xbs is experimental:
> > > 
> > > + 16 times the block size is considered experimental
> > > 
> > > Hence pipe these to seqres.full to avoid false negatives.
> > > 
> > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > 
> > Seems fine, though I think I'd rather mke2fs get patched to fix this.
> > 
> > I'd let the maintainer decide if he wants this, but ... I'm not sure if
> > he's actually going to receive this message. :/
> 
> Hi Darrick and folks,
> 
> I'm back.
> 
> I apologize for the silence these days. I had planned to do a release last
> week, but a sudden big regional layoff and immediate cutoff of all connections
> caught me completely off guard. Beyond losing my account, I lost everything on
> the company servers, all my documents (including a book I was halfway through
> writing), my code, and my entire environment for handling emails, patches, and
> system workflows. (This is a painful reminder to never leave your things on
> company server..)
> 
> Amidst the shock and grief, I am now struggling to rebuild and reconfigure my
> local environment from scratch. I have redirected my zlang@kernel.org alias to
> my personal email -- zorro.lang@gmail.com. *Please do not send any more emails
> to my old zlang@redhat.com address*. 
> 
> Starting tomorrow, I will begin reviewing and merging last week's patches bit by
> bit. I still need long time to get my environment and workflows back in order, in
> the meantime, I will also be focusing my energy on finding a new job. So I
> appreciate everyone's patience and understanding.

Hey Zorro, very sad to hear and hope you are able to sort everything out
at your end. Very grateful for your effors in maintaining fstests and always
helping with reviews and suggestions!
> 
> > 
> > --D
> > 
> > > ---
> > >  tests/generic/765 | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/765 b/tests/generic/765
> > > index 09be53db..b7cc70f1 100755
> > > --- a/tests/generic/765
> > > +++ b/tests/generic/765
> > > @@ -64,7 +64,8 @@ test_atomic_writes()
> > >      local bsize=$1
> > >  
> > >      get_mkfs_opts $bsize
> > > -    _scratch_mkfs $mkfs_opts >> $seqres.full
> > > +    _scratch_mkfs $mkfs_opts &>> $seqres.full || \
> > > +        echo "mkfs $mkfs_opts failed"
> 
> Now for this patch, I think we can have it for unfixed e2fsprogs testing,
> as this test case isn't related with this e2fsprogs "bug", except you hope
> to uncover it by this test case :)
> 
> Reviewed-by: Zorro Lang <zlang@kernel.org>

Thank you! 

> 
> > >      _scratch_mount
> > >  
> > >      test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> > > -- 
> > > 2.53.0
> > > 
> > > 
> > 
