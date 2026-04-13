Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77E3AB271
	for <fstests@vger.kernel.org>; Mon, 13 Apr 2026 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071066; cv=none; b=qyENkiwlFN0qbBlPOOErFs3U5Z7ioAmts3rnJcT+Lge+ewqLsV9nITlXcVtb4hfPHejel6rrFGbUvtdzJwmr0N1SD4xMR3gBVA9l+Td8qB9Yt3kZ4vJyFZ4j1aUUawDHSiHSH3t81TxBrbr8AZLcYUp8d7CBRU0H4PjFFvf+jG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071066; c=relaxed/simple;
	bh=pgCpm94iGW82QRXIdKfgfVGWgjVBi2Mqp5Wro6MWtg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRs8pPwgg+tH4a4bPEXKn2SkUnQH3HxY548Lue+vUQtu6NeGpQW+cpwz9nH5yz0J2c/iVJd/w3zEbngAYm/DUL9kFH8hCm6Zbdy55O8JEujYoltjoXfff/plRNvJLg1rvzGXWn5U0HnkXdIit0tGe48Ko9o00JcV56AX0bUkxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o+N9IZC1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o+N9IZC1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CBux602068455;
	Mon, 13 Apr 2026 09:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tT39bzpOGvSQDfy2C7e/XiCNz29T1J
	I8/ReNYYdn8GQ=; b=o+N9IZC1demQbjyEyCxJ+2hX/QZTfan19ZaVLGfFVvLKlY
	f0itA6kTe50WFKza4PkVAxum52RfAGKSBf0EpFISzcAfg7paXdXSOuW//Ufubl3n
	SBtShCwHUZUZHS562L0GDU/OMNJOKJa0tVchCMWGqEYqgudtlboFG5Z2lYTa8uDH
	8t+Mt9nV6i5l8u8Udp3KuYZQzvX3ENPVmK0jc4sC5u0DItg3IQwWDXlfpbfIBkmH
	pMC+AlLb53nCzCQdZS6PfAr3xtZeFp1CFGb6fbL8CZ305wTQUlDxpMU7K88SyG91
	CarsRXtmT0IPZf4wZoDGjC2I4XEiyc2NJIngW/tQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqptmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:04:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D88MLO015666;
	Mon, 13 Apr 2026 09:04:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mscjsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:04:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63D94GqD45875600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 09:04:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 538C52004F;
	Mon, 13 Apr 2026 09:04:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49AD520040;
	Mon, 13 Apr 2026 09:04:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Apr 2026 09:04:14 +0000 (GMT)
Date: Mon, 13 Apr 2026 14:34:11 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, fdmanana@suse.com,
        ritesh.list@gmail.com, naohiro.aota@wdc.com, wqu@suse.com,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/6] generic/765: Ignore mkfs warning
Message-ID: <adyxi7156VAbL-G1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
 <20260410165435.GU6212@frogsfrogsfrogs>
 <advRgjl1tG4PMc6V@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <advRgjl1tG4PMc6V@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dcb193 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=JyrihxrMJP5rmaNOQCwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Q8HOuFATPLiHLbmGc900ldGXMjOFGNkF
X-Proofpoint-GUID: Hhv61rZh6ZZ4lfWJnlR8uD38V628S0_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4NSBTYWx0ZWRfXx1XsdspPAMCh
 usoBGeGiACnlVZlgPqJaXtRJfApcEIFjisgp9mR7jLHsMTJKgS9UPV7QjDemTi7yDhi8svgt6Qk
 4+2S9HGnHLqaCqEXu4Bz/0hESpRnQpy9faz02aLZTSDQptV3ZKv3lpinLdrCVPyYRc4/4onQRAh
 PuiyalMdkbgK15oxkRSI8qoEzri9TUB/AU3hP8jTuY/cyHjivZ7KTU2DN1VnQ2eh92TXLTLjbVp
 AksBl3VLjpXZU4HEIYvXmbdkWvKMsTneBb0cwVRBYdogB72Oxd94pVEH15C0XqxxYjZkUNtj3ek
 HQeHd2Q9f8qIzkQruj2g76gwRQPai3qck+kxGVBlu0NuNS3xLh3E+SIoCPOy5w4OBHvouyczIbS
 gOySzaGSIrQT7Me/jDlhd3nlckKB9dV9+nMUc76f1FOB7koIAHXaMQBjYejoO3DCtpe3mNJj76W
 2M4dZPgH/CHqxHnh+hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130085

On Sun, Apr 12, 2026 at 10:38:18PM +0530, Ojaswin Mujoo wrote:
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
> Hi Darrick, yes I'm preparing a quick patch for this. We might still
> need this so people on older distro who wont have the e2fsprogs fix dont
> see the failure.

Hi Darrick,

Looking at it again, I am just wondering if its really an issue that
mke2fs is printing this warning to stderr. Isn't stderr the right place
for errors and warning (even non critical ones)?

Futher, mke2fs has multiple instances where we print warnings to stderr,
should we go and fix all of them as well?

Regards,
ojaswin

> 
> Regards,
> ojaswin
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
> > >      _scratch_mount
> > >  
> > >      test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
> > > -- 
> > > 2.53.0
> > > 
> > > 
