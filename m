Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233BD3B52F4
	for <fstests@vger.kernel.org>; Wed, 29 Jul 2026 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303435; cv=none; b=uqc93h8jWWJcBzR4FoRCr4Oq6OHo7s5F7n9FF3Zy4wq/bAE16D9F9283ddec6CXUVvVlJfwrWptbAF8n25IiUgrElyzKv8qpSjnZIRxUEhOQrzGDhT7QQbzAvtQUka2D+sdo1GmoOSwgUMHE97eSicE0jergw7PiHMLBJvG/9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303435; c=relaxed/simple;
	bh=grnVtKxjvJBMykFe/tYEIKYJw0YqyY5clMYMNT1BllY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjVc3LqScKhm+4RK0AiqAxSZf1nEm19RtU9pOgBkOrPFnlmOhO8uWr89gfiuLNKUk/1abAQ5qE7BJgY/IvkpyfVlQsn7xDPITR5ssKG0I/ZC+Uq32xPo6PV9gs8Kp/4Um5PzHAIRn+j6E2+snTQF2MWYOgc7q3y4m6mgtqd6Q8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hMhRlRx8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hMhRlRx8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4m3nA3131123;
	Wed, 29 Jul 2026 05:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IXgycE/mRLCAYt3He11ghYayhnkI8r
	hWiAVAk9byWGE=; b=hMhRlRx8OakkugVZ8v3s+501AK+2oUvGZucnmNmMM0T440
	m9wnjP3MnwoIn+FwoIvW4i0dLd97S5/i/lKlfJMuqmnY3TrCN0rYZQIvqIRILwe9
	fryyn/muTMNu1dIxjYUAGeS1ZqFBy7dRjIRgLVSXuH4RVbW0zXPu7ma96mL6ykHE
	5+3RBjFVlSBcBnePtQ1yd4tLTIgbiujItoE2agovlLIHp2Iw3kvwm2pHwkhi/GdO
	ZrEXv9qA4dvc70IGK0dxcGZ/f9AVQ25fLUdQlcquORaGVoNS/33W1st+dGoRdshd
	FwMzhCx5MQUA5dNYlrO1rOMdkuM/yRu8OCJ70WTA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nr8xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 05:37:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T5QZ2g006777;
	Wed, 29 Jul 2026 05:37:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqdgan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 05:37:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T5b0Qm29884902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 05:37:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D40220043;
	Wed, 29 Jul 2026 05:37:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9683720040;
	Wed, 29 Jul 2026 05:36:59 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 05:36:59 +0000 (GMT)
Date: Wed, 29 Jul 2026 11:06:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] generic/645: Confirm availability of free inodes
Message-ID: <ammQvzfsFTx9EEmm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260617054216.3186441-1-ojaswin@linux.ibm.com>
 <20260625184259.GP6070@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625184259.GP6070@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0MCBTYWx0ZWRfX0dJQeQIb/g5F
 wbEurdUtot4qCH7yxQu1veupyBukvw1zfBM8yZmiOLHRBF89Ab0b8weQbTTq6nlKHhpBTX8oWpw
 /Ia5hcy/Dvd122hfxkmefpCeItXDzvc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0MCBTYWx0ZWRfXzJvdFs/wP64f
 PZHNfokrvyGO4e0A5qZvQ2FT0aD9t5P5qTstUZ8aIZuI3NUm3H5eOZvUbRuckrNls2Vd878WRqP
 gDxcsxW5Brecds4s3F/+X6SXtyZo8bTkl4T/E0Kvx4crXHmFf+bBMRzcO+sbaIIoWsjGkgUnqae
 w6dNpKTFdlsF8o1P7ki5sUji1NaKwiq3w1FxoUOlrPIq0cRkEsnN3ur+HBcTKvRZm0VQ2Vm0HHh
 VhL70gzcMywSmeIHW9GuZqxKy81SsyBM2clLTl9KBAHy8bmsO34xb9L9wLnOw6oN+JiRt+nzTyp
 M9FzF1HgvuMbpT/kf3FTtBdjWAirruHiDkzmsMWkGiNhGd+gPkU9UDIRyDcdF5loVoOaK9fmcI/
 UoVXntKK0cMepOp8KtthtXL1S2wvjaHut/Hwt8LwOiPIcvbaHddeSUcXaoy8t81uUDlW7YEDpEA
 IKeFPpgetdMsX5ZeKsw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69917f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=7-qt6Rif_XC_LU5olugA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Gxel6a3hBohUkVOqpI9KE_c8iwACoTC_
X-Proofpoint-ORIG-GUID: Gxel6a3hBohUkVOqpI9KE_c8iwACoTC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290040

On Thu, Jun 25, 2026 at 11:42:59AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 17, 2026 at 11:12:16AM +0530, Ojaswin Mujoo wrote:
> > When running generic/645 with ext4 using 64k block size + bigalloc, the
> > test fails with ENOSPC because the filesystem runs out of inodes before
> > the test completes.
> > 
> > The test creates approximately 10,001 files, however, in this particular
> > configuration a standard 5G FS only has around ~5100 inodes resulting in
> > the ENOSPC failure.
> > 
> > Add a check using _get_free_inode() to verify sufficient inodes are
> > available before running the test, else skip it.
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/645 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/generic/645 b/tests/generic/645
> > index d6eb75e6..944b33db 100755
> > --- a/tests/generic/645
> > +++ b/tests/generic/645
> > @@ -19,6 +19,12 @@ _require_chown
> >  _wants_kernel_commit dacfd001eaf2 \
> >  	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
> >  
> > +_free_inodes=$(_get_free_inode $TEST_DIR)
> > +if [ $_free_inodes -ne 0 ] && [ $_free_inodes -lt 10001 ]; then
> 
> I'm assuming the > 0 check here is to cover weird filesystems like fat
> that don't advertise any inodes?  /me wonders if that ought to be a

Hey Darrick, sorry I missed this email earlier. Yes that's the idea. I
see there is a helper already

_require_inode_limits()
{
	if [ $(_get_free_inode $TEST_DIR) -eq 0 ]; then
		_notrun "$FSTYP does not have a fixed number of inodes available"
	fi
}

But this will end up skipping the FSes that don't have a concept of
free inodes.

> common helper where we can record that justification:
> 
> _require_free_inodes() {
> 	local path="$1"
> 	local nr="$2"
> 
> 	local _free_inodes=$(_get_free_inode "$path")
> 
> 	# Weird filesystems like vfat don't report any inodes, so we
> 	# can't check for sufficient free inodes; IOWs, FAFO.
> 	test "$_free_inodes" -eq 0 && return

If we do this, won't we pass the check for the case where say xfs has 0
free inodes. It's a rare chance IMObut still wondering if we want to
keep that edge case open.

What do you think in these options:
- use the above check
- use _require_free_inodes which will cause notruns on some FSes
- Maybe have a new helper to check if FS advertises free inodes and then
  use somthing like

  if ! __fs_advertises_free_inodes
    return
  else
    test "$_free_inodes" -lt "$nr" && \
    _notrun "Insufficient free inodes ($_free_inodes), need at least $nr"


Regards,
ojaswin

> 
> 	test "$_free_inodes" -lt "$nr" && \
> 		_notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
> }
> 
> 
> _require_free_inodes $TEST_DIR 10001
> 
> (maybe clean up the comment a bit)

> 
> --D
> 
> > +	_notrun "Insufficient free inodes ($_free_inodes), need at least 10001"
> > +fi
> > +
> >  echo "Silence is golden"
> >  
> >  $here/src/vfs/vfstest --test-nested-userns \
> > -- 
> > 2.53.0
> > 
> > 
