Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31E1514F8
	for <fstests@vger.kernel.org>; Tue, 14 Apr 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160367; cv=none; b=HlDC0WsZJExkUaGZZqULVXaDSPCtXCgj0NCJICU8SziThj5+725UeJSCD8G7l0LRdJ3m6hH7BuVn0jwhcP9VLljDo2OIbbquXA0UJ0voxtvTUnW8nVbjLbJSvCVyO3m9jjkPECl4cjrb75+vkM7WHKEDtyMzCPiVZlm+t3BARSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160367; c=relaxed/simple;
	bh=q/0JPVxScwThOvRAJXvZM5RktlKD6ELJSUr7kg9lZt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZ393l8nrCSIrZNuZBlSa13rkWff+d+W5e34oAk/lBIYQzpB76E6/0ErVeAGHFDUfJqwm/KAm8fHgmLXHnG2YirUxVHslvP7YWxCXnXWO+D1HvaZAXicL3V7v3aB6BTFZHFZ+DeKfiSrEAJGWj6KkDMbQ3nDEKNC6FFYzvmLoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tNu9ErOP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tNu9ErOP"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLJuuR1807454;
	Tue, 14 Apr 2026 09:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wj0Zb0
	rVR03rr6axRofT+B0gX2cl7QeR0zfQSB9Wvz0=; b=tNu9ErOPH2C29BoquHGKxU
	N9xIrWRTixxraflgBY9Yq2xmqA/UFD7TUX6I5XcklFmtAeOc2QEE6fzlvnf7kJum
	uYMpY4UsHb8ZVp1qPYODDxB6SeS6oqs8/W/CwwQH/Myuspaiw+EaZEeFyA5SzSrG
	jfeGn16gldij6XOzIZztFQ7vvkmJbYmFj4PH7EnMhoIz3YFgCtvGTup/pqnLPS6c
	QXVjpPRMRDQTLocLSpjpMPlqRtjhIZJbQ2sjV1bzkiTYQYamfLTMGMmvjD3Zvr5l
	fugY4B4cZSevIcMkGNnfRQJJPLbeHnmRrQ5LJzq8FfG4j14i4FRi2QxsYhWL4xbA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k2072-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 09:52:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E9Tbn4031106;
	Tue, 14 Apr 2026 09:52:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y90ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 09:52:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E9qcV736307298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 09:52:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECB9A20040;
	Tue, 14 Apr 2026 09:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 980212004D;
	Tue, 14 Apr 2026 09:52:36 +0000 (GMT)
Received: from [9.124.217.53] (unknown [9.124.217.53])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 09:52:36 +0000 (GMT)
Message-ID: <48078f41-bf2b-4a00-ab92-da8c3f01f7f3@linux.ibm.com>
Date: Tue, 14 Apr 2026 15:22:35 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ext4/061,062: Minor fixes and refactoring
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: djwong@kernel.org, fdmanana@suse.com, ritesh.list@gmail.com,
        naohiro.aota@wdc.com, wqu@suse.com
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <a8692b9af458ffba24881fabb6ed9342ed4a6d93.1775802601.git.ojaswin@linux.ibm.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <a8692b9af458ffba24881fabb6ed9342ed4a6d93.1775802601.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: INvjDKbEw4kznuVSQtK01ZyN0FPu3BZI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfX2u3WJghJ9lDX
 g8dcx9EUVeiYNf3lMX8ATmN/RAtsbofLZ/nr4BR2J1BQSxURMOjCt1gVSV6H/BBn6xql1vW0GAM
 LEjokpOHAcojwmBN86QO/MG4UhICivRaFww5Kfwz6KUea9cq7oCKRxZT5TulqoQV2Ff/PVzyYWQ
 BJROgs39XpBzTmAfQ59BnkT98dtx7G2WzI5K/khs2+04omiEA5UZDKGOfPKDL8TKb/S/2OF5uM0
 ikdfZicctlUyDhmMzxJl61hAyw1yDKcm7Dj0txEQWJnviRN7QHPN8wixHhV9aLBNgiVU1TAPxr5
 WsU5VVU51bMaknWCE0PiJmfZ6M4IJAfeiIJ2NzDO1dcaFg+5UbB9g2mLbqT3g3X+up5MixIdfUd
 xvQtjze2BUzYhra/XL4vRHLoXlNQ2++MElSgLz7bJkPMYARer+kicvalE/UiIIYezbln3a+QPva
 J1iCHFv3jOfYlg2YLOw==
X-Proofpoint-ORIG-GUID: Re4LZrsq20XkziIeO0YPK7QaPEvP9Cec
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69de0e68 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=jYFY7zNtPr8KwsLo5XEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091

On 10/04/26 12:06 pm, Ojaswin Mujoo wrote:
> Fix 2 issues in the tests:
> 
> 1. Use fs atomic write limits instead of bdev's
> 
> The tests use block device's limits instead of limits advertised
> by filesystem. This can cause failures because block device might
> advertise a higher maximum than the FS.  Fix the tests to use
> filesystem's limits instead.
> 
> 2. Fix the test loop range
> 
> Fix the test loop start and end so that our calculations for
> blocksize, clustersize and iosize are correct.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Hi Ojaswin,

I've tested this patch and it works correctly. The tests now properly 
use filesystem atomic write limits instead of block device limits.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/ext4/061 | 28 ++++++++++++++++++++--------
>   tests/ext4/062 | 26 +++++++++++++++++++-------
>   2 files changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> index 1d61c8b0..69ddeaca 100755
> --- a/tests/ext4/061
> +++ b/tests/ext4/061
> @@ -31,10 +31,19 @@ _require_aiodio
>   FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
>   SIZE=$((100*1024*1024))
>   
> -# Calculate fsblocksize as per bdev atomic write units.
> -bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> -bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> -bs=$(_max 4096 "$bdev_awu_min")
> +_scratch_mkfs > /dev/null 2>&1 || \
> +	_notrun "mkfs failed"
> +_try_scratch_mount || \
> +	_notrun "mount failed"
> +
> +touch $SCRATCH_MNT/f
> +
> +fs_awu_min=$(_get_atomic_write_unit_min $SCRATCH_MNT/f)
> +fs_awu_max=$(_get_atomic_write_unit_max $SCRATCH_MNT/f)
> +bs=$(_max 4096 "$fs_awu_min")
> +ps=$(_get_page_size)
> +
> +_scratch_unmount
>   
>   function create_fio_configs()
>   {
> @@ -97,10 +106,11 @@ run_test_one() {
>   	local cs=$2
>   	local iosize=$3
>   
> +	echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
> +
>   	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
>   	_scratch_mkfs_ext4  >> $seqres.full 2>&1 || return
>   	if _try_scratch_mount >> $seqres.full 2>&1; then
> -		echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
>   
>   		touch $SCRATCH_MNT/f1
>   		create_fio_configs $iosize
> @@ -127,7 +137,7 @@ run_test() {
>   	# cluster sizes above 16 x blocksize are experimental so avoid them
>   	# Also, cap cluster size at 128kb to keep it reasonable for large
>   	# blocks size
> -	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
> +	max_cs=$(_min $((16 * bs)) "$fs_awu_max" $((128 * 1024)))
>   
>   	# Fuzz for combinations of blocksize, clustersize and
>   	# iosize that cover most of the cases
> @@ -145,8 +155,10 @@ fio_out=$tmp.fio.out
>   create_fio_configs $bs
>   _require_fio $fio_aw_config
>   
> -for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
> -	run_test $bs
> +echo "Awu min: $fs_awu_min Awu max: $fs_awu_max" >> $seqres.full
> +
> +for ((bs=$fs_awu_min; bs <= $(_min ps fs_awu_max); bs = $bs << 1)); do
> +	run_test $bs $cs $iosize
>   done
>   
>   # success, all done
> diff --git a/tests/ext4/062 b/tests/ext4/062
> index 05cce696..56bf080c 100755
> --- a/tests/ext4/062
> +++ b/tests/ext4/062
> @@ -33,10 +33,19 @@ _require_aiodio
>   FSSIZE=$((360*1024*1024))
>   FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
>   
> -# Calculate bs as per bdev atomic write units.
> -bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> -bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> -bs=$(_max 4096 "$bdev_awu_min")
> +_scratch_mkfs > /dev/null 2>&1 || \
> +	_notrun "mkfs failed"
> +_try_scratch_mount || \
> +	_notrun "mount failed"
> +
> +touch $SCRATCH_MNT/f
> +
> +fs_awu_min=$(_get_atomic_write_unit_min $SCRATCH_MNT/f)
> +fs_awu_max=$(_get_atomic_write_unit_max $SCRATCH_MNT/f)
> +bs=$(_max 4096 "$fs_awu_min")
> +ps=$(_get_page_size)
> +
> +_scratch_unmount
>   
>   function create_fio_configs()
>   {
> @@ -146,10 +155,11 @@ run_test_one() {
>   	local cs=$2
>   	local iosize=$3
>   
> +	echo "Testing: bs=$bs cs=$cs iosize=$iosize" >> $seqres.full
> +
>   	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
>   	_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || return
>   	if _try_scratch_mount >> $seqres.full 2>&1; then
> -		echo "Testing: bs=$bs cs=$cs iosize=$iosize" >> $seqres.full
>   
>   		touch $SCRATCH_MNT/f1
>   		create_fio_configs $iosize
> @@ -175,7 +185,7 @@ run_test() {
>   	# cluster sizes above 16 x blocksize are experimental so avoid them
>   	# Also, cap cluster size at 128kb to keep it reasonable for large
>   	# blocks size
> -	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
> +	max_cs=$(_min $((16 * bs)) "$fs_awu_max" $((128 * 1024)))
>   
>   	# Fuzz for combinations of blocksize, clustersize and
>   	# iosize that cover most of the cases
> @@ -193,7 +203,9 @@ fio_out=$tmp.fio.out
>   create_fio_configs $bs
>   _require_fio $fio_aw_config
>   
> -for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
> +echo "Awu min: $fs_awu_min Awu max: $fs_awu_max" >> $seqres.full
> +
> +for ((bs=$fs_awu_min; bs <= $(_min ps fs_awu_max); bs = $bs << 1)); do
>   	run_test $bs $cs $iosize
>   done
>   

-- 
Regards,
Disha

