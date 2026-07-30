Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F1401484
	for <fstests@vger.kernel.org>; Thu, 30 Jul 2026 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409430; cv=none; b=Zaa01zHsFckgy2zbrQwgcEk5ggJZIP0ZAhVIsqlQNX6XYSMbePT0/03vV8hkODs1PVUvZzUyUk/pA2WFcwMBw5a7Ce6o26ZiMFDX/QD7SQYbp/ayf/w/qQOkYRhwwlWVBvE17gGz3H4VXBKXNpJO6TiOxywxm0jRwMbGVmXJ/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409430; c=relaxed/simple;
	bh=gz6eCFx3nggcKDxg4iN5gZd4Y0YZASUX0p03MSjWjes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIkp1LPoPg6WVZhuZdJLAQZmI40zDqyzQS6UBub3o4N8lBfzDau0K8yn+MaMVEbxl2o6vF/4TfnR5J9zt3vV1hSgEVovtwKILJ5yj0XnfYAaqD/wjToOV9lqG5q9ZjUhpbkBDsWL0KmYJ2vumpp5VNg6u5wJb4uI5i4TD278ON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Axn9XG9A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Axn9XG9A"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAIZor2761702;
	Thu, 30 Jul 2026 11:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2Pu8npLzZ1Uc32eKyNTv4TXyunHBOK
	zBMzrIvyBdTLQ=; b=Axn9XG9AUPSbt9UqYvGaftubPHxWy7c8HV8gJHYc45LHV6
	dhUaZCtsOTs0XVtpvMVREPZ/sWUncE18OMfL4BxkOkMhDiOq8GqCtKT+4ngRo10+
	AWIspRwOZ0C6NwWroY05NxC10E+aH5OXqpcA3qI8heqelvLTyi65hhlLOJqMBCkO
	CYKPM0ynhVmF/h3CCl6zbnHga1wq06KIYC/uvbtktcCqbjvlNUt6oXynPCClDC1j
	zhfcavC5DmqeGeV/KoeEWoxQuvFE23fjjGhJxAxpwPQS8gIQtaVtfrxQKI5cdXUm
	kKNMSwSaS1c8hqb53do4Do2mN8/mz4MrCyx9fhJg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd6fwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:03:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UAuUHE002593;
	Thu, 30 Jul 2026 11:03:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yaqds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 11:03:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UB3fD927394370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 11:03:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F64820040;
	Thu, 30 Jul 2026 11:03:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B0132004E;
	Thu, 30 Jul 2026 11:03:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.25.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 11:03:39 +0000 (GMT)
Date: Thu, 30 Jul 2026 16:33:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] generic/645: Confirm availability of free inodes
Message-ID: <amsviaOypNwLCtnM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260617054216.3186441-1-ojaswin@linux.ibm.com>
 <20260625184259.GP6070@frogsfrogsfrogs>
 <ammQvzfsFTx9EEmm@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20260729154451.GB7371@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729154451.GB7371@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yd44lk5BwHyJDfmNmGCYvXtONMe1K_aF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX2LWDXFwEod5g
 zz+9K2fSLMmtMZlVvXPJeUaXr91k8eJvuAiUwCVLxNkqmklSMI4474e25tol/4Rkx7EPRNmQiUl
 OgYFtKeiTsseDKPthEFe23CRRYo6AYg=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b2f90 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=G4Q8l6HB2Q3NXiakdPIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX+FPik2xls116
 PfstPdiFUi8ramYSlXD2Bus9aT3pB9ew+gpNzUHR2hEAeRya1stz6K+PMTS1sHXg56aHjeDLZRP
 WiNNtEhtPCHaiIQvTWKq2oojw8GM0X3rdyLP8b37HZ1+JHpYgpQ47eMtTV/NX4OubjukFi1EJju
 BQhBZAgL8G1O+44yErudKU8XLA9FSvDkuWKmFKIWXC+5DRTawUWMj5/eyQJ62cjqUhwMCb+zeYP
 ZZplwsdadIFjVSWTLN00umLeMaiBSCT7IyNE7AC+Y811eL37jlmEU+EOJh8TbwEqvQz32H4qdDD
 kSrgJJsRLryqmYJ1izJsN2WFHu3tuR/20fgcqsK5COGnKPKtxhVjThYK3HPH0SWZiCcabbfTi0N
 wSGcwQWYUXUahN4vqAtfBIRUFLvfngGKuVmOGNjsWDfxz4wHuai/lKgDsjCU0TA3EUvxFOsujaj
 hOIJhNSc17cu00lXLwQ==
X-Proofpoint-GUID: Yd44lk5BwHyJDfmNmGCYvXtONMe1K_aF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

On Wed, Jul 29, 2026 at 08:44:51AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 29, 2026 at 11:06:57AM +0530, Ojaswin Mujoo wrote:
> > On Thu, Jun 25, 2026 at 11:42:59AM -0700, Darrick J. Wong wrote:
> > > On Wed, Jun 17, 2026 at 11:12:16AM +0530, Ojaswin Mujoo wrote:
> > > > When running generic/645 with ext4 using 64k block size + bigalloc, the
> > > > test fails with ENOSPC because the filesystem runs out of inodes before
> > > > the test completes.
> > > > 
> > > > The test creates approximately 10,001 files, however, in this particular
> > > > configuration a standard 5G FS only has around ~5100 inodes resulting in
> > > > the ENOSPC failure.
> > > > 
> > > > Add a check using _get_free_inode() to verify sufficient inodes are
> > > > available before running the test, else skip it.
> > > > 
> > > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >  tests/generic/645 | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/tests/generic/645 b/tests/generic/645
> > > > index d6eb75e6..944b33db 100755
> > > > --- a/tests/generic/645
> > > > +++ b/tests/generic/645
> > > > @@ -19,6 +19,12 @@ _require_chown
> > > >  _wants_kernel_commit dacfd001eaf2 \
> > > >  	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
> > > >  
> > > > +_free_inodes=$(_get_free_inode $TEST_DIR)
> > > > +if [ $_free_inodes -ne 0 ] && [ $_free_inodes -lt 10001 ]; then
> > > 
> > > I'm assuming the > 0 check here is to cover weird filesystems like fat
> > > that don't advertise any inodes?  /me wonders if that ought to be a
> > 
> > Hey Darrick, sorry I missed this email earlier. Yes that's the idea. I
> > see there is a helper already
> > 
> > _require_inode_limits()
> > {
> > 	if [ $(_get_free_inode $TEST_DIR) -eq 0 ]; then
> > 		_notrun "$FSTYP does not have a fixed number of inodes available"
> > 	fi
> > }
> > 
> > But this will end up skipping the FSes that don't have a concept of
> > free inodes.
> > 
> > > common helper where we can record that justification:
> > > 
> > > _require_free_inodes() {
> > > 	local path="$1"
> > > 	local nr="$2"
> > > 
> > > 	local _free_inodes=$(_get_free_inode "$path")
> > > 
> > > 	# Weird filesystems like vfat don't report any inodes, so we
> > > 	# can't check for sufficient free inodes; IOWs, FAFO.
> > > 	test "$_free_inodes" -eq 0 && return
> > 
> > If we do this, won't we pass the check for the case where say xfs has 0
> > free inodes. It's a rare chance IMObut still wondering if we want to
> > keep that edge case open.
> > 
> > What do you think in these options:
> > - use the above check
> > - use _require_free_inodes which will cause notruns on some FSes
> > - Maybe have a new helper to check if FS advertises free inodes and then
> >   use somthing like
> > 
> >   if ! __fs_advertises_free_inodes
> >     return
> >   else
> >     test "$_free_inodes" -lt "$nr" && \
> >     _notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
> > 
> 
> Hmmm.  This is getting complicated, because generic tests can run on any
> filesystem and we have no idea how much space an inode actually
> consumes, or if the filesystem even has any real concept of inodes.
> 
> Can we instead check the vfstest output for the ENOSPC error message and
> _notrun it if that is found?

Yes this sounds simple enough. The below diff works for me:

  diff --git a/tests/generic/645 b/tests/generic/645
  index d6eb75e6..3d8ca905 100755
  --- a/tests/generic/645
  +++ b/tests/generic/645
  @@ -22,7 +22,14 @@ _wants_kernel_commit dacfd001eaf2 \
   echo "Silence is golden"
  
   $here/src/vfs/vfstest --test-nested-userns \
  -       --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
  +       --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP" \
  +       > $tmp.vfstest 2>&1
  
  +if grep -q "No space left on device" $tmp.vfstest; then
  +       _notrun "No space left on device"
  +fi
  +
  +cat $tmp.vfstest
   status=$?

If this looks good I cans send a formal patch.

Regards,
ojaswin 

> 
> --D
> 
> > Regards,
> > ojaswin
> > 
> > > 
> > > 	test "$_free_inodes" -lt "$nr" && \
> > > 		_notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
> > > }
> > > 
> > > 
> > > _require_free_inodes $TEST_DIR 10001
> > > 
> > > (maybe clean up the comment a bit)
> > 
> > > 
> > > --D
> > > 
> > > > +	_notrun "Insufficient free inodes ($_free_inodes), need at least 10001"
> > > > +fi
> > > > +
> > > >  echo "Silence is golden"
> > > >  
> > > >  $here/src/vfs/vfstest --test-nested-userns \
> > > > -- 
> > > > 2.53.0
> > > > 
> > > > 
> > 
