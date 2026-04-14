Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E23C1414
	for <fstests@vger.kernel.org>; Tue, 14 Apr 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160730; cv=none; b=rFL9avxtYgI5oKeS8k0/sYO/Kyjed2itKqhs6YuFMGVn9+sEvUk1rmTtwL+TfldhlzWOJA/L1cIm2DkAPlqUlF1G17aFNbjWk3+G7uKQ0lvGLK/yA2DT6qM/YFM0AZ2QGqJR83mIuKlBMu/z3qdgaM31r7g0HlTD1lBlpR/npD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160730; c=relaxed/simple;
	bh=/thdWhc6JInBlOcavTQDJkTVMAahHzDh+iLLAWKejR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/i+vBAY6RtF4RNCAbSPNvUtOhyuT968S9nDchRM6LmeTEb0Dhe11g5CjMrrjrAuolHum3OmV5hkLIodzuyYznRxE2dCcY188xrEAsmUo8baiQCklPo5fssolg/FXY5gWXC+cwdEb71o+4TPNXetHunMGplVx/gnaSlec6ppvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sgTWz3lw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sgTWz3lw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIXuT1859930;
	Tue, 14 Apr 2026 09:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TGpKBD
	DVIlkgzJ7uR4TvNOMrp+ddqjp/HT5/qoXGPws=; b=sgTWz3lwkY/bJ+oA4nGYsU
	30vYLys9j/8zXLriqzLecvOv+1Wi7oQ5MSVu/l3fXCEY8+3gSq50TCDat7hmYKcD
	gYojcaWFFec/agIKmT3DaKLpOw3mBgn7nzcam/P1JTOQ114obRkHZ347D7DHzIKM
	N0NjxrN9jtmrI0MqpBWUqJTYOD0cG8dlszY1LUbohvoAwxwCLgHzK7yrMiqmc4Ee
	C5QP3PyipUkgNKfIH+BJb7lURfJatKF0OYimYFDcq5PA5i2nehPPR4zDz1VqchMD
	eElpwJuKF5IrJ4sKgd5mdUem6j3MJYz+C8dHH2Y+yBePM4moCkHDt5QV76PLN5Vg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pa0qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 09:58:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E9pmPU004570;
	Tue, 14 Apr 2026 09:58:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k8u2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 09:58:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E9wg9846072126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 09:58:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDBD42004D;
	Tue, 14 Apr 2026 09:58:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98A8720043;
	Tue, 14 Apr 2026 09:58:40 +0000 (GMT)
Received: from [9.124.217.53] (unknown [9.124.217.53])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 09:58:40 +0000 (GMT)
Message-ID: <71f85683-7bc1-487a-924b-388cef6b3648@linux.ibm.com>
Date: Tue, 14 Apr 2026 15:28:39 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] generic/765: Fix sysfs queue path for nvme partitions
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <43211d99fd66d3e8a956e1336b800962392c1df5.1775802601.git.ojaswin@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <43211d99fd66d3e8a956e1336b800962392c1df5.1775802601.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Za0MTtUsWEaXQkvekoX45NXtgnvyUJRN
X-Proofpoint-ORIG-GUID: esqAotaq0szwXXJ9e6xMAHmbTfKQDKQY
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69de0fd4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=PTX2Xa_kaKc_2XOvjW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfXzWOFUhXLHt6j
 3FhRQS4VP5yptXuFy2yoUnxhsiY1/Di7Njsv7NUEW/eKE19aOymT3tT0iYhzK+o4DYNBxAsCy1o
 4EG8ry5DcaLga9sPSDx/eFfOBseHvfdugjCPQZTF/wyEmU7rKrWTpxF5w5TYeHUbWbzHx2W9BTn
 OOoi2TmXQZpcGSV+2ZsqzMxHt3k8dz/xfZewr78g0VEF/AvVJuFtQJNjc26/Ro+ylp4pvep+LFl
 lgzhrpCH99yNLfKF3USV/ddXA5gU13KRQhXyp3JPvlR0+HfqV2/Ih+aUToywOeKh5jDksj7/OGr
 Nd+fyMJ3Y6nh79ognW0VNIPNb6yPF2fDaKmiAf+sa4iO5IbEAtbUmIn1JOZj8h0za8Pf7dhTdJh
 wJMOVHuV1w1v+8MtA8euHisNDoFOgMrFUV8pNwM93PNqH1rqrTPA1HUCxNXnNWZmQvbUkp7jfrU
 7kNWWLQHinleqyLRKzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091

On 10/04/26 12:06 pm, Ojaswin Mujoo wrote:
> This tests checks atomic write limits reported by statx() are same as
> the ones reported by sysfs, however nvme partitions don't have the
> /sys/block/nvme0n1p1 style entry and also use the namespace's queue
> limits for atomic writes. This causes the test to fail because it
> expects /sys/block/nvme0n*p* to be present.
> 
> Hence, use the new _sysfs_queue_path() helper to get the correct
> atomic write limits
> 
> Also, fix a small typo (s/awu_min/awu_max) when printing awu limits to
> seqres.full
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I’ve tested this patch and it resolves the issue with nvme partitions.
The test passes successfully on my nvme partition setup now.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/generic/765 | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/765 b/tests/generic/765
> index 8c4e0bd0..09be53db 100755
> --- a/tests/generic/765
> +++ b/tests/generic/765
> @@ -94,16 +94,17 @@ test_atomic_writes()
>       _scratch_unmount
>   }
>   
> -sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> -sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> +queue_path=$(_sysfs_queue_path $SCRATCH_DEV)
> +sys_min_write=$(cat "$queue_path/atomic_write_unit_min_bytes")
> +sys_max_write=$(cat "$queue_path/atomic_write_unit_max_bytes")
>   
>   bdev_min_write=$(_get_atomic_write_unit_min $SCRATCH_DEV)
>   bdev_max_write=$(_get_atomic_write_unit_max $SCRATCH_DEV)
>   
>   echo "sysfs awu_min $sys_min_write" >> $seqres.full
> -echo "sysfs awu_min $sys_max_write" >> $seqres.full
> +echo "sysfs awu_max $sys_max_write" >> $seqres.full
>   echo "bdev awu_min $bdev_min_write" >> $seqres.full
> -echo "bdev awu_min $bdev_max_write" >> $seqres.full
> +echo "bdev awu_max $bdev_max_write" >> $seqres.full
>   
>   # Test that statx atomic values are the same as sysfs values
>   if [ "$sys_min_write" -ne "$bdev_min_write" ]; then

-- 
Regards,
Disha

