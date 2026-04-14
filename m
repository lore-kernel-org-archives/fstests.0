Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E13AC0FC
	for <fstests@vger.kernel.org>; Tue, 14 Apr 2026 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160936; cv=none; b=XYUo2GkWz/rU/5rrkKTG0vFImn8XbQMEfWp64FzGnHcXWYGvuSWqKIMaCAEHVC2ixMQ3ycUvZV8DbGIf/kYKveIVbijm/k+Jkwol1TQ3VhHLUR8wXw3cfQlSxjcL62TXdcE1D9p34lKgV+dKIVHUauWt99zCwWwkXy7w32J75Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160936; c=relaxed/simple;
	bh=aBLHXzI0iEgmoX7vXRyjvVxPvgIyzFjTk+tCCuPWjX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syQcGrD1Y0mCOVkOQjwqyEoQ1yvAXpIPEu4znn3oI71lejhY55qf2/cbhbaIBkWqMHXEXzcIUjTisLGTKMIJqnyt9cs1KVCvPtxWosvsUMOwe2tCAHRjDIDG4iVqEzQVmn+rfvidzodhpKJfPv/kbs4TcLT4++a0gzlHP/SsOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ElZJYJUB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ElZJYJUB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIPfk2130622;
	Tue, 14 Apr 2026 10:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tBDgYJ
	dErUq9Ql04iBLOHaTe4J2FruovDqMXxTQgEqE=; b=ElZJYJUBfQD4yM4h4nYj19
	zRxr13eD42vZAKGHIa4deftUq/nQZ9qf9r38Q9Z+GfFDlz03XpZRRh8hq2e8iyrx
	h4SU3S88jANRBRtX7ghVXyfCDEnfDmlYZHfZu3l+4L/2rxiWm2ykoan8fOSKhX6i
	hr7klysrWfmLEOoFXRERFSSXw27bNUPGqZQ2chnmZRTcrwVP3L+YgRD4XDbN1Vru
	VXtE0Ba8I0Rc1vGecsqKle8DiyWoEZTwX9uzHiGOmXkoFzmmQBtiqwWkHTJ9ML35
	nMv53i2irRZcrq6xtPsepraMcsRZ7Rp3dOpqwhJyxbMg3IgvoQIpWdobxZzS8Wjg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89na4t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 10:02:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E9pX41003581;
	Tue, 14 Apr 2026 10:02:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn8x8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 10:02:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EA25WZ28180964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 10:02:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1F972004B;
	Tue, 14 Apr 2026 10:02:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 530772004E;
	Tue, 14 Apr 2026 10:02:04 +0000 (GMT)
Received: from [9.124.217.53] (unknown [9.124.217.53])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 10:02:04 +0000 (GMT)
Message-ID: <a0e7e21d-04b7-4bd2-b851-879d86e557f8@linux.ibm.com>
Date: Tue, 14 Apr 2026 15:32:03 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] generic/765: Ignore mkfs warning
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: avL9zHntBCWFH5F57sHj7_7rE7qBPRHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfX38AWVb0ZSMwK
 rkeyoheFbkP4/XjRntFmdTMlxWD7NBint4WIf6m0BKjz5m7eSPZ1TGUeMdZyDYrlaOlIT37U53F
 H6cBmGZ03diNUBGB7qWaohoST3HXb8Mp3oOVAbCmab+tfVdvu0EqrjarS/fKp81RPhT0M1wJKWG
 e0ZG6V7elGpLTZg0RJFd/BWOHE0jsxQbfYPWfxjJ9ep0tY2xMj1JGbzhNvZsR4k95luONtThMsa
 iauVBNHyZ8pZbP8lDFm1W/FmDHNvT3rhtIamKNbWQ6QNGfQOHwK/v2hwzoUYMxN5ItlMLqJacXO
 beOkT4VP1EgCo7bJ5XJaPOH4cixEsNe5JvByC+UiFhS8WsINFK0hD6fqD0GqmNL7mFS6TvYrSSU
 oFVpc2sLQjlL/LMO9b+qHfZrkpXonrZPh4OOnncZw6VHpVsILFVKV16ijEcBYeu4BkY+8IJZq++
 WZWhzn122psXVG+/A7A==
X-Proofpoint-ORIG-GUID: uKMZXBuyvQU_PEp1mEJBBnPA2a5-wo_j
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69de10a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=1hEA8-96Klr8m2AX-WwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091

On 10/04/26 12:06 pm, Ojaswin Mujoo wrote:
> This test validates atomic writes for all possible block sizes. In ext4, for
> smaller block sizes with configurations like:
> 
> export MKFS_OPTIONS="-O bigalloc,quota -b 65536 -C 131072"
> 
> The output can get corrupted with warnings like below because clustersize
> more than 16xbs is experimental:
> 
> + 16 times the block size is considered experimental
> 
> Hence pipe these to seqres.full to avoid false negatives.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I've tested this patch and the test now runs cleanly without false
negatives from the experimental configuration warnings.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/generic/765 | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/765 b/tests/generic/765
> index 09be53db..b7cc70f1 100755
> --- a/tests/generic/765
> +++ b/tests/generic/765
> @@ -64,7 +64,8 @@ test_atomic_writes()
>       local bsize=$1
>   
>       get_mkfs_opts $bsize
> -    _scratch_mkfs $mkfs_opts >> $seqres.full
> +    _scratch_mkfs $mkfs_opts &>> $seqres.full || \
> +        echo "mkfs $mkfs_opts failed"
>       _scratch_mount
>   
>       test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT

-- 
Regards,
Disha

