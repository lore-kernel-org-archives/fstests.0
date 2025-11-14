Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756730147C
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115855; cv=none; b=eCSrVtszL7CBkdaiPRz/6odhBfMjKIHFlIwbfqCxwaAb1URvsgLG7Yp0r4qLG/YHt6UlT0xS5pJ0+ij1xMZ1+0BqRlNrEja/pZEuoWhXpQCLppugr33PX0EvzSSAPsUl2CaG+YT53HogHNfFFvPdFI8y5sIXTb2cVrxxYR+oxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115855; c=relaxed/simple;
	bh=jmrilkVImHu52MOJQYi74XPpAGNSf20E2UMyRNOhXlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHWiwtb3akLuE4y26qi3BSqf2LzPFHRDHIj8IiY0SGtCfq0sUKEDHA6E9bHeNQx8I8PIBsubx63o3xWPyhLhA+Pt6eKpiNDVLq6Vsyv7b5Dyd3KdaFd/9YGx30ppuBaOLkhJbM0WGrQRNv/KEyD4ArCqMlvOjM5oGCzRX1uAMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NWmw1R4Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NWmw1R4Z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMlWRG007978;
	Fri, 14 Nov 2025 10:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9necESlKJe2YRK6bafzLXnw3o6tLat
	sgFFSQneeFkXc=; b=NWmw1R4ZVm8ztD+TZTaarQy08NjyfcppkeLhVTPk/eJDhE
	O3XUwK8IlcLetrKjwz0/48uH52v8xf0ohgQkg8DRaDARv6Qcjv9Pen7+XVBTinYf
	GO4pJRrmVCFpjQbPL5+t6qcxmtQNFDUzTuykrYdtj8aQgAF4daELtcsrC5bmrYo8
	mmZKr0Ifdyyr1JQmwvj0XhUZ3ZuonnbPMxfw/W4reuvhJ64dl4MS6v2bI1YJ7ew8
	93vf7FNdUyIhFvuri+6C9RqER8WtN6zwwca2ygsNn+IKzU5Jts6lwe+vEnfwZtaS
	QclayEEliVSnOviNDU0LjvYdC+pzxPtmymdN2ESg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adreda3uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 10:24:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AE8LEcX014755;
	Fri, 14 Nov 2025 10:24:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpkjphh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 10:24:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AEAO4xK42533132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 10:24:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8CA220067;
	Fri, 14 Nov 2025 10:24:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE6F420063;
	Fri, 14 Nov 2025 10:24:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Nov 2025 10:24:03 +0000 (GMT)
Date: Fri, 14 Nov 2025 15:54:00 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH] common/atomicwrites: fix _require_scratch_write_atomic
 when awu_max_fs is empty
Message-ID: <aRcDQDDhbBX6oHz6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250906131722.1333025-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906131722.1333025-1-zlang@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KNZXzVFo c=1 sm=1 tr=0 ts=69170347 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=XtmQZLEbBBZLUo-M36cA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: JMX_39iqwtYeXv3chotr915ps30I25IE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX7h3ubDxszsYb
 0jcw07ByjiHsym5Cbuh+Gw3x5avo5q+nJQy5ER2f0YmNopOpn51UrDkdVQ2FnIMSWMEtjsXVIN0
 8pqzCG8V6dCt/H4em29R7SwfvmENUdkB9z2YxpLhhFxXHXwgWi/+7+vsVQsja3WhLjmYIgtgZYw
 3viWob7epsiAE/nfV/mKd/jkJ3XGq3kq8ft9q/443RXQAqvh9BYCvnUnLx3x/bw1jb9DdYRn+8R
 kAJ3YUNMgCzWmcNy0rAubLX3tywAj5PQ1nsB802xDjjpHVhitxaNrnQ/0dRc2K/5jgf/AMKRBSG
 mpx99tN5Hm5Aw84w4H05MXa9Atb3WCKaQgQZxT77sCmK6OmD/AVkuj757f+rZN22HCHwP+H3Hl8
 ZVzuVEf+SfooEWEzepdviV0BZbJVxg==
X-Proofpoint-GUID: JMX_39iqwtYeXv3chotr915ps30I25IE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511130179

On Sat, Sep 06, 2025 at 09:17:22PM +0800, Zorro Lang wrote:
> If a kernel doesn't support atomic write, _get_atomic_write_unit_min
> and _get_atomic_write_unit_max will get nothing.
> 
>   local awu_min_bdev=$(_get_atomic_write_unit_min $SCRATCH_DEV)
>   local awu_max_bdev=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> 
> If $awu_min_bdev and $awu_max_bdev are empty, then the logic likes
> "[ $awu_min_bdev -eq 0 ] && [ $awu_max_bdev -eq 0 ]" is meaningless,
> and it causes g/767 hang on system which doesn't support atomic
> write.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

I can confirm that this fixes the hang seen when xfs_io doesn't report
atomic write limits.

Feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
