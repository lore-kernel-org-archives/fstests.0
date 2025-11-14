Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9C2F28E9
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763102636; cv=none; b=noFwp1qfVd8eZhIrfVtHi5gDj6O7qZ0PWWh0uOVt5xpU3stl61dpcMMEHQrqysT1XJxkAqEaau2//wVCl8DYOvNGPaY/j26SzctLgCxKrm3XAQmlsjPHOgcnIAGQYaFwBOQgfkJNaI4f9rhIj+X/CwVWFDJVulixr4iqUAyqOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763102636; c=relaxed/simple;
	bh=k9ewlDBYnayLgz+xO4nUh0XsW4SSMIErTly7C85dCas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgh2a/zLtVONSMnjC2eHZNiOXiavMBbEeyBgR/QWeaQrA3pWfiZzWhp7AwvslovrAoZXlpsWHyl/QipkDJIKJmPqhDQLQg/wILTLglZ5UgY1+RWpgJlEWb/KZD9pQXATlrGUhsiHdTt7241WOe31sNj11qWoQ3jagMjpMwEeCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qnrMiUmV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qnrMiUmV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMlgQI028903;
	Fri, 14 Nov 2025 06:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ATeFzP7YAoS9vOTDjHYrhIYfRsKy5K
	ztmBt5IySp+7g=; b=qnrMiUmVNccK48Iyqr/TphsVC1E0uuE08gAFl66r9nNSoG
	5/fHkog3gpm+KwU3Er3NyuKE5nwIlCQ/dA6ShLz4ILJx0tLVCYMtcr/kFgiyTc/k
	2JevrNa1H223m8mwyKl3c4v/AISVdcZQQGmvlW+oI3VJe/7LGL31qDHVMkKupiC5
	5PUQ4Uo4Y1dbv6pCsDGmWBBWJEHtlQKqnOBnoYxAC2MwtxMiYq9pv1mOCDqt7QVI
	Xz2ycAVVQqWBQ0u3oGG0nlGGp0W5wzFz9yi9MKtYNHV1NCUxnwz2UV0Z4AtfZ5Q5
	/PXzH2EGRP0DLx1sfDTvyWX8vZ3APUFQINimG9oA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adree16x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:43:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AE44MCk007368;
	Fri, 14 Nov 2025 06:43:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjsrhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:43:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AE6heIS49283544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 06:43:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CC3420043;
	Fri, 14 Nov 2025 06:43:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 520F520040;
	Fri, 14 Nov 2025 06:43:39 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.212.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Nov 2025 06:43:39 +0000 (GMT)
Date: Fri, 14 Nov 2025 12:13:36 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH] generic/773: fix expected output "QA output created by
 1226"
Message-ID: <aRbPmAAkeRrCzvUn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251114010238.2173413-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114010238.2173413-1-tytso@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX1bI6dxla6RVm
 2CTKon8EpT5uVaYvr4MqbPYRj9kM6uoQzPOe2mt3qTzzll/EZ0z03KH3USHzAD2Ia2AHg3POpv8
 sBQzsT1SkELH6pGwbURjhFv1LjHXVxnIML7qazKI32xM6Vf1TxiUvuReJeat4lRk1pdCG4N/Cws
 XZPlAAOTxWDqCAa6WVZo1njsoiSJwl3rC6syNMe7XQsfOeizEnuldQvy016zrMjSBdXP+ZQwgS+
 n2RssXEJRK9f2r61jcA8YZTZezQg9z+tEbvwPgzF5xBNtxZ+5HjniOFqxSIWRc80jXDSLL/sn1U
 BnkZELvRurqKXOThe2cSwlzSa7QrReQo/NmzVG1KP7BJKnj1giY7DgbpJIZF5g2JinpebrKGYgU
 Lv5nnmL9z+c+a9uiljYk1/IIVZ26+w==
X-Proofpoint-ORIG-GUID: DPlivwhu5EPGfdc595mAeWUSB8wm85na
X-Proofpoint-GUID: DPlivwhu5EPGfdc595mAeWUSB8wm85na
X-Authority-Analysis: v=2.4 cv=J/GnLQnS c=1 sm=1 tr=0 ts=6916cf9f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=LGKaG6NU_EC1eXOf60UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130179

On Thu, Nov 13, 2025 at 08:02:38PM -0500, Theodore Ts'o wrote:
> The test generic/773 was apparently submitted as generic/1226, but
> when it was renamed to pack the test namespace, apparently the test
> output wasn't adjusted to reflect the new test name, leading to the
> test failing on sytems that have devices that support atomic writes.
> 
> Fixes: 1499d4ff2365 ("generic: Add atomic write test using fio crc ...")
> Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Cc: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> ---
>  tests/generic/773     | 2 +-
>  tests/generic/773.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/773 b/tests/generic/773
> index 7ad745546..0a30ac7f4 100755
> --- a/tests/generic/773
> +++ b/tests/generic/773
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2025 IBM Corporation. All Rights Reserved.
>  #
> -# FS QA Test 1226
> +# FS QA Test 773
>  #
>  # Validate FS atomic write using fio crc check verifier.
>  #
> diff --git a/tests/generic/773.out b/tests/generic/773.out
> index 6dce0ea52..8626114df 100644
> --- a/tests/generic/773.out
> +++ b/tests/generic/773.out
> @@ -1,2 +1,2 @@
> -QA output created by 1226
> +QA output created by 773
>  Silence is golden
> -- 
> 2.51.0
> 
