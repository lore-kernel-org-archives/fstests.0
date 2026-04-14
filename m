Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E63A6408
	for <fstests@vger.kernel.org>; Tue, 14 Apr 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161141; cv=none; b=aShFGunkoQr32GIkUyyzaRyJgy0l/vosBnVMYHGvUTeYt44ZMfJdD42KU+T9Umpzv7Yc9AbKVDRQWVcvTsMb5jsH6wjPmIqbOcMGKZwaBOyeo/cUSn9+QHRstffKzYkxCs8eTtzJp88DScD1GKK2c7AbZernMMqYo9hMht1RE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161141; c=relaxed/simple;
	bh=rA0bp7VRFbyYv404VARSDJDM1OYNulxXY3W30al3Dg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikyQ/JgKPq5VTv/t1XXmG2BAhgjbp65jkK5FKbzZWf6L3v4dv+QXCjy8IFuFeBb/l6OHMCARPqUyYgzhfBM+RxCnCAdimI7IK5163BMggfWlj3btZGtTxaNaTl8+f+odIRV+pJWygV8qyDZH4sS/RPrSlAqPhYZxGm32CDGXvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFcoDtpy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFcoDtpy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIjKZ1833259;
	Tue, 14 Apr 2026 10:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B9yDQh
	RzsqzkKJXROBOMzTPvuERMjR6APpyneXzOY/w=; b=SFcoDtpyFEE1UJSxwRUXhD
	BCw53Q1dgXknRIak2JNaF/c6UE1LCAzEaINny+uRFMOaL6VLuqxuMTOZIg9phnKB
	fomobDJ16FVSKwQfzDYU6nhXG3vHFt1r2mKSeVfUv6RQjYAePO6Bcf2mzNOzX+D9
	4GCbl8+tjI8X4HTfIeXMnsyud5XZ9sgVRgWRVUQfPP9OvxCL9yEjruwRsggQ3xcE
	FIxLDCxj7LeGA2/XWa6AoVR8g14Ztss2TiCkGoGrLhMRatj54vDWGPsi3AmZONZR
	bQgpuwDD80aJ8F1+hpTMnnhcJekDm3nMTpU0ZUy8WzpiBy8kmJJNkBZcTsUHtURg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ra4v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 10:05:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E9pmRQ004570;
	Tue, 14 Apr 2026 10:05:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k8v0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 10:05:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EA5VEw52297984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 10:05:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACDC920040;
	Tue, 14 Apr 2026 10:05:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA0AD2004B;
	Tue, 14 Apr 2026 10:05:27 +0000 (GMT)
Received: from [9.124.217.53] (unknown [9.124.217.53])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 10:05:27 +0000 (GMT)
Message-ID: <3f9045a6-0e62-4df1-81c9-7378cb0587dc@linux.ibm.com>
Date: Tue, 14 Apr 2026 15:35:26 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] generic/775: Fix an infinite loop due to variable
 name clash
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <9c8783dc648ef861f81cba8d5d692932b795e262.1775802601.git.ojaswin@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <9c8783dc648ef861f81cba8d5d692932b795e262.1775802601.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfX7aG4NfYSlnIM
 nm0no4u6C+FPm7B90fjERtlsqABjrQuPbAb6KQfieYrc1kO0FyWrg6r9xM0kNDqqI9mu4PWZHTy
 6SIAPfMAcIRn+8qPZC7a4PjRRvAnfZAct1lZXMIJuTj+uRQ7e3c5rrUtuo5qQXspDmt0bvkrVbr
 IVXpS/o17KxUz88etosHstMPGbatHcaKeQE2j1VrseFwDyW/S9npDiV6Pd9MZzCmBU0MISbrpmg
 9Tkv8ogNQxH6nJCv3kaU9KJ1qF8RsbKYSE9+ObeAVO1MQ4LR+30mDLvK96lIhL8NkFDL0Zgz+mm
 ZTldKUpexfaCuumwUz2k8rhBaW8xngMLK4xBktg9GlDgwhfIplR3rSnCx5cLLKVupRb1Zqd/cRu
 cVxFwlnTKAl6Q1/1wc3RXD+wqA/BawJiYYUryUmxPBGKDc4aAGADYnjWbI+UYElAjGMl1O3QyIL
 W5QTjejrv+T+K7RW5sQ==
X-Proofpoint-ORIG-GUID: PWF120o-sbPPjcQ_I2CiD83RZ2TBTwsi
X-Proofpoint-GUID: 05kD_gqIc-vbOkQ6LIrwPQmoWTOvUYG_
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69de116f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=yS74YPqICVl9FapQL3EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091

On 10/04/26 12:06 pm, Ojaswin Mujoo wrote:
> We use i as the iteration variable in the main test loop as well as some
> internal loops. Due to this clash, $i variable of main test loops was
> getting modified by the following loop in prep_mixed_mapping().
> 
> 	for ((i=0; i<num_blocks; i++)); do
> 
> If num_blocks is less than 10 (example ext4 with blocksize 4k and
> cluster size 8k) i would always be set as 3 and the main loop would
> never exit. Use local variable to fix this and while we are at it,
> rename it for clarity.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I've tested this patch and it fixes the infinite loop issue. The test 
now runs to completion without getting stuck in an infinite loop.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/generic/775 | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/775 b/tests/generic/775
> index 2a4287bb..6dc005a0 100755
> --- a/tests/generic/775
> +++ b/tests/generic/775
> @@ -41,7 +41,8 @@ prep_mixed_mapping() {
>   
>   	local operations=("W" "H" "U")
>   	local num_blocks=$((awu_max / blksz))
> -	for ((i=0; i<num_blocks; i++)); do
> +	local blkno
> +	for ((blkno=0; blkno<num_blocks; blkno++)); do
>   		local index=$((RANDOM % ${#operations[@]}))
>   		local map="${operations[$index]}"
>   		local mapping="${mapping}${map}"

-- 
Regards,
Disha

