Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CBE1C84BC
	for <fstests@vger.kernel.org>; Thu,  1 Jan 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767289181; cv=none; b=Ol/XVixGefDIZVNqBZ2374/rnyOT0ITlKudSCY6LlFG9lQPpMFCOQqQPRDLBXSBwZ3f3LoAXvibNWbMm6cZMzMi6Nd30YGbEJ/zM2QcIRTzC0fQrbHXdM2KIVCpdIknjupaYtv4g2+a26xnpe+kMWxwxl/nKkDfKJnYjjqKLBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767289181; c=relaxed/simple;
	bh=gOPWFxHOUSVO6IYM/LZS1zyqanhPfe9kUfFHNlWgIVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tue76lblomR09M9OtkvU099QAR9pauTCpLQ5HuYFAHMC//ePn+OxwID7bzeL9fER7r6MMK0qsYJRqptYGaIiSgVOn74zqp/yOSg4mKdwb9G3mEIyJhJeJj2ic8zx2JdJ4ixyBDZz/GTrEybZoou11T4dlO6uCiOQTSFLlPIPdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IWIp59bI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IWIp59bI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6010MnXN025359;
	Thu, 1 Jan 2026 17:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+soHp3vgevCCwfCI6czDYnnvFxD/NG
	IosSjvUjc3BP0=; b=IWIp59bIwCDNLvaENwRgR9ayPF+SMt1JvZmpTl5sUiKZuR
	wAoHGSLdUT0+W9YuHkdGiiZ/Nf3isi/T0Se+KsmxenHo4jmuRBU7/ZQZeOCL/kYU
	sQkMvjYMi9HXdATu+C5BGOToY0IB1lrlmJO/ahKvtjOjgXpzyOqSmKqv7pJ13X+P
	QQU87W+s6RPHLmOSuPqbZ8OFBEi6+aKIgR6187hTMyzw62Dcoc+Hmtg2bfWTOeII
	fgqS0Y9pdXZ6rZrJc9Ju2R5ihbEJimYKscBqF4opeAwEQneh1u8d1wBqB49vWVT+
	2C4ozQlGxrjC4L/ThkyKoIw42G8FvYJ3gQu0k2Hg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bb46xs30b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Jan 2026 17:39:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 601Gi8ft026897;
	Thu, 1 Jan 2026 17:39:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4batsnkenc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Jan 2026 17:39:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 601HdXuI44892550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Jan 2026 17:39:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C32FD20040;
	Thu,  1 Jan 2026 17:39:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 094322004B;
	Thu,  1 Jan 2026 17:39:33 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.212.80])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Jan 2026 17:39:32 +0000 (GMT)
Date: Thu, 1 Jan 2026 23:09:30 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/108: fix test hand upon failure to create LV
Message-ID: <aVaxUvBtTx1KMkIW@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <79202ac8855a232c678bb9bddabda8c1866bc400.1766387606.git.ojaswin@linux.ibm.com>
 <20251231205903.rrasjy7t3b42uhfc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231205903.rrasjy7t3b42uhfc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAxMDE1NiBTYWx0ZWRfXzHQygKnEoNiT
 w9/rh6IqeT83UyYFI2Zwyi0ALFeCUVaVYESyXh85hhwr+kCXjo6qXg8fpON9b6qVBFAvqPSJPue
 y6YZDQVhBKdD787dtnXc2DBtX3Ro3QYMMaIBM/Wygx4PXtNBVOuW9vlxrTxlwfAcbIWaDE8q+mP
 0/JGoUbyBT3430dzBoH+XZjYtkZ5mof51+jdtIrCJwoR03Qu83CR5C9GpmgLoy9PeQswpivjf1O
 r8pzE0LWHCCTXWy0aoNYwCDcZuDo9+0P1te5Eo8B2KmziaKWFMYaxjdGQM/ZpVFKtY1d7CvCb65
 3ireON2rAtrCG0muJpJQLifRhQlzHp9xXJSRs2sasssZxQHCxQX2T6oJ0UkOdkb86jdGAhf4i+I
 yeblfzZgqXY5ee0POt4PHXsHf3pADhpSYZjiy0KlQsd+5MuuMaDH3g79ZemwehON+A7KkKltBtB
 rG9YlVwSt39O5g1ZGSw==
X-Proofpoint-ORIG-GUID: vqtTKsAW-6OCJPq1fFNLH4QZv5QXa2H1
X-Authority-Analysis: v=2.4 cv=L7AQguT8 c=1 sm=1 tr=0 ts=6956b159 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VXZ5DhXvHXO4zUIKH3AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: vqtTKsAW-6OCJPq1fFNLH4QZv5QXa2H1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601010156

On Thu, Jan 01, 2026 at 04:59:03AM +0800, Zorro Lang wrote:
> On Mon, Dec 22, 2025 at 12:44:09PM +0530, Ojaswin Mujoo wrote:
> > In case the lvcreate operation fails, we don't catch the error and
> > proceed as usual. The test then tries to wait for the LV to come up
> > but it never does, causing a hang.
> > 
> > Fix this by catching any errors while creating the LV.
> > 
> > Context for completeness:
> > 
> > This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
> > of =m, causing it to create an 8MB SCSI debug device. This led to the
> > lvcreate operation to fail with:
> > 
> >   Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
> > 
> > However the test never caught this resulting in a hang.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/108 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/108 b/tests/generic/108
> > index 4f86ec94..308afe20 100755
> > --- a/tests/generic/108
> > +++ b/tests/generic/108
> > @@ -60,7 +60,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
> >  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
> >  # (like 2.02.95 in RHEL6) don't support --yes option
> >  yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
> > -	>>$seqres.full 2>&1
> > +	>>$seqres.full 2>&1 || _notrun "Failed to create LVM lv"
> 
> Hi,
> 
> Thanks for finding this issue. I think if the issue you hit is
> "not big enough" SCSI debug device, we can _notrun after checking
> the required device size. But if lvcreate fails, we'd better to
> _fail the whole test directly, to help the tester notice that.
> 
> Thanks,
> Zorro

Hi Zorro,

Sure, makes sense. I'll make the changes in v2.

Thanks,
ojaswin
> 
> >  _udev_wait /dev/mapper/$vgname-$lvname
> >  
> >  # _mkfs_dev exits the test on failure, this makes sure test lv is created by
> > -- 
> > 2.51.0
> > 
> 
