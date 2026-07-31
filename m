Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C1D3EF0A0
	for <fstests@vger.kernel.org>; Fri, 31 Jul 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497214; cv=none; b=urBp1C+KMuS3VDLDREmrWt5zXP9xu7A99EHXtg2vWg0P9Bi11G8tmgJUTKNuZlzQR13HygCpbnpqTtqgUW+Re5yZeK3wsHDxwAob0ruY5r32XoKm08tjay5jFMB7pzZH0ADTJzGab/lM/EY3AKZTp6WitYUeTlV8WEaMNvv/GUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497214; c=relaxed/simple;
	bh=te4diykADmiSqYmMBKQY07oCQ+FTFmJzURJ9jeCSv8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5fXVVKVL60G78WH94qUgpQnJTAWLiDIpD65e1bfZEucozUBrpr+TPyuImyASqY3X44/1gxkpNuL2q3gCQoRPza0a5//4ZHCdAMqn6ZJVp1H4NmUZqpsP3zqSx0O6KsDgPJYXkqxutGA4a5OTsTzHgc4sphWIt5HB/fP/fLZ4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=acaClXLU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="acaClXLU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8Hh863629967;
	Fri, 31 Jul 2026 11:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OwQu1K
	4tNCpLh32TioA75NRa6GUBXcBColvEk77aIjs=; b=acaClXLUKVx/gcuafSRDHn
	jfpBeAU4QRzQsjEQ6NVromwl03bnXs0nZ2mjcAVpX8JILhVc/b2XHIG694u/atRb
	y4hAoAMTuNvCdZgNBQaook5A1DkzaXy0RidvV86pN0C+etEHOklV0avrtRJjyOjM
	CAUav/zO3O/j84axuTXu+3rSLdY2o1qbmiwaZW6sYYmIIu3Sn5hsdBGvI3QpgTPz
	wwYAldkrw0bd3j+U8up0zYFV6k7WPhe5KQCVPHGy3MuA+Ox5lXuNZpHLKiO6W2yi
	z6q9ejxupgBxXODWXCNSNj1BsMZHgpGCJjo4z25n+UnwZp0ebMciQOlQG4rBPI2A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycvn7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:26:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VBQgsA015054;
	Fri, 31 Jul 2026 11:26:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwfskk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:26:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VBQl9211272654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 11:26:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F732004B;
	Fri, 31 Jul 2026 11:26:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7554E20040;
	Fri, 31 Jul 2026 11:26:46 +0000 (GMT)
Received: from [9.39.25.127] (unknown [9.39.25.127])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 11:26:46 +0000 (GMT)
Message-ID: <46dcfb0c-209e-43fa-a713-b39d3c2d6748@linux.ibm.com>
Date: Fri, 31 Jul 2026 16:56:45 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] generic/645: notrun if FS doesn't have enough free
 inodes/blocks
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>
References: <20260730172207.1937537-1-ojaswin@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20260730172207.1937537-1-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EGS7mTEJ199EHTfIqUrgvF44kcEwS8a-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfX5EWuF3T2bxuM
 ZALdxl+XsdMhVYfIvUChkHZfeWlNUfTfhfBN9WaM8MVYf+rN0mLXJL+7aEBPF/e3wVZNtAy0jyC
 7DOMOa54hEmW+EHZ7B6cb4+lVKSC9/X8jAk9BV7nu5xS2BmtsHZ1WJ5VLJgbkTQG0OeuPSi1a2f
 1Li8jDZAm4RcT+6m0ZYcwoR7YbQejP5sR/9mDhLo2GiqFqsPczZferv0+mzK8MUraNBzvMWTszQ
 tTmB5NyLyTzIHz9zDrElpnpAX+U3u0yA9bde5bsTvJ7ocFmDOrtyrw9m9TswuVu5ljcmvTtji95
 OpYChPHUbrWjnWSw0o9rKwX7T4sRKN4IoywMs7a0QfDDhJ8ii4wZhYMUKVXJNRKM4OkB8F5pP/k
 uwN16MepW4f5Uqn3tXaDAuaVv7bOCMfwb95XkAf04+j9b41pNg7SCQ698YXHJM5qdpN/wHvZlq7
 vTkC/Z3Qhe45hbe963Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4NSBTYWx0ZWRfXz2WmS7aHBHJf
 HMSDbdqAS+WJPNbCGD1wl0408+ccFJFldBjjlY469A3f90MsbXWodFAs9LGhSmYt1mp4R38HgZ9
 whLBcvbcAkXIL+mc1A+wbmN8QIcKB4s=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c867b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p2ZZ_g01jCg9CbmMwhAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EGS7mTEJ199EHTfIqUrgvF44kcEwS8a-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310085

On 30/07/26 10:52 pm, Ojaswin Mujoo wrote:
> When running generic/645 with ext4 using 64k block size + bigalloc, the
> test fails with ENOSPC because the filesystem runs out of inodes before
> the test completes.
> 
> The test creates approximately 10,001 files, however, in this particular
> configuration a standard 5G FS only has around ~5100 inodes resulting in
> the ENOSPC failure.
> 
> Parse vfstest output to notrun the test incase we encounter this ENOSPC
> instead of reporting it as a failure.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
> 
Tested with ext4 + 64k block size + bigalloc on a 9G filesystem.
generic/645 now correctly notruns instead of failing with ENOSPC.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> * Changes since v1 [1] *
> 
> - Instead of using a helper, check for ENOSPC in vfstest output
>    (Thanks for Darrick for suggestion)
> 
> 
> [1] https://lore.kernel.org/fstests/20260617054216.3186441-1-ojaswin@linux.ibm.com/
>   tests/generic/645 | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/645 b/tests/generic/645
> index d6eb75e6..6498efe1 100755
> --- a/tests/generic/645
> +++ b/tests/generic/645
> @@ -22,7 +22,13 @@ _wants_kernel_commit dacfd001eaf2 \
>   echo "Silence is golden"
>   
>   $here/src/vfs/vfstest --test-nested-userns \
> -	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
> +	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP" \
> +	> $tmp.vfstest 2>&1
>   
> +if grep -q "No space left on device" $tmp.vfstest; then
> +	_notrun "$TEST_DEV ran out of free blocks/inodes"
> +fi
> +
> +cat $tmp.vfstest
>   status=$?
>   exit

-- 
Regards,
Disha

