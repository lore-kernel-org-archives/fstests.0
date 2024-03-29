Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED03A267
	for <fstests@vger.kernel.org>; Fri, 29 Mar 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691554; cv=none; b=QgypA+U0ZQEhdrIBIKS778SP9Y9sOyQRuCRebCeOReRjEWUf5eHevBmLEbbfev1YvTR7c7M3Msh2mfMlEupCNMupT+pRUPTuxlWpllSKkHAW6IOjXqnwcdswfHQngbEOlhMBo/zz90AQzh5Y1rThGSCQpmFuyHhUL0NgGYERxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691554; c=relaxed/simple;
	bh=xNwQwk4BnL+S5gTYo32OJLtJqj+ug7Df92hso5rftNI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gyd2hGS22mICYQc5CjDrSFReOi9XFv5Hkzsc0EGZ73KeOTXUuc/Lg77RAWBu1Fiucc7RBp1Eu7CRQiRcTg2S5JIdxG+5s/EDgszZVY8DAe5+8SMHghMbdd+sQJFWS0k3lBIgWPckuicbUFfsgMumvbzqgPNfBkbAqi4VslImeCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IggyzNwc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IggyzNwc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T4a9Jg026987;
	Fri, 29 Mar 2024 05:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U1XhdyVmg1pLXZoFBbvDm18/4pqjz09htnDeS1PtBB0=;
 b=IggyzNwcutO6xp8O0J0ErQ128LPY2nj0FkE81TFP09oQKHSSoCuaPs+tgXuumsuoBSrt
 Tyvnjn597Opey+nIaB9B5gRJ4gkMz9NMfpZGywP3v+76sbraNOYFzCG3KINFH2eHeyII
 BQNS9Z+9WOd2xcOzXQNvl9FdQijgWVPaWeHa2LuMdVLOzxAg3RHrZSG9vbAo3wO0ah+i
 UNbdYebMNhkCBDGWpNthaLiDzCulpW0KAmxFvJRQgM8/4Uab5togDGpWZPeJCPcq7gvq
 xwn0ZHE5ScXDaAnUnWMNed+V9bWG+hNwnoKp3bohYcVTzNdXp/9eiPJT2BzQ/m7M/2A3 9A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5p6mr5f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:52:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42T33Hja025558;
	Fri, 29 Mar 2024 05:52:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2awna59t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:52:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42T5qKbL16122228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 05:52:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BB192004E;
	Fri, 29 Mar 2024 05:52:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74F1420040;
	Fri, 29 Mar 2024 05:52:19 +0000 (GMT)
Received: from [9.43.118.21] (unknown [9.43.118.21])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Mar 2024 05:52:19 +0000 (GMT)
Message-ID: <f40fe042-a905-4dec-8038-a879fb917085@linux.ibm.com>
Date: Fri, 29 Mar 2024 11:22:18 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] generic/735: improve test by incorporating extra hints
To: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Cc: ojaswin@linux.ibm.com
References: <20240319111613.11029-1-disgoel@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <20240319111613.11029-1-disgoel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ODc0rI7Vh9nDRkm3RsYfYaibbfxwVrnB
X-Proofpoint-ORIG-GUID: ODc0rI7Vh9nDRkm3RsYfYaibbfxwVrnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_04,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403290047

On 19/03/24 4:46 pm, Disha Goel wrote:

> On power systems with 64k block size (where default page size is 64k) we
> encountered a kernel oops due to an integer overflow issue when writing
> near the last logical block of a file. The allocator could allocate a
> range where the end exceeds the maximum supported logical block
> (UINT32_MAX), leading to a subsequent BUG_ON. This issue has been
> addressed in the upstream kernel with commit 2dcf5fde6dff
> ("ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS").
>
> 	==================================================
> 	kernel BUG at fs/ext4/mballoc.c:4448!
> 	Oops: Exception in kernel mode, sig: 5 [#1]
> 	CPU: 8 PID: 2880554 Comm: xfs_io
> 	NIP ext4_mb_use_inode_pa+0x110/0x160 [ext4]
> 	LR ext4_mb_use_inode_pa+0xac/0x160 [ext4]
> 	Call Trace:
> 		ext4_mb_new_inode_pa+0x134/0x3a0 [ext4]
> 		ext4_mb_try_best_found+0x158/0x280 [ext4]
> 		ext4_mb_regular_allocator+0x16c/0x940 [ext4]
> 		ext4_mb_new_blocks+0x610/0x960 [ext4]
> 		ext4_ext_map_blocks+0x858/0xa90 [ext4]
> 		ext4_map_blocks+0x218/0x800 [ext4]
> 		ext4_iomap_alloc+0x10c/0x260 [ext4]
> 		ext4_iomap_begin+0xfc/0x1f0 [ext4]
> 		iomap_iter+0xf0/0x190
> 		__iomap_dio_rw+0x208/0x690
> 		iomap_dio_rw+0x20/0x80
> 		ext4_dio_write_iter+0x210/0x4d0 [ext4]
> 		vfs_write+0x364/0x4e0
> 		sys_pwrite64+0xd4/0x120
> 		system_call_exception+0x164/0x310
> 		system_call_vectored_common+0xe8/0x278
> 	==================================================
>
> This test has been extended to provide a hint about the relevant fix
> in case of failure.
>
> Signed-off-by: Disha Goel<disgoel@linux.ibm.com>
> ---

Hi All,

Looking for review comments on this patch.

Thanks
Disha

>   tests/generic/735 | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tests/generic/735 b/tests/generic/735
> index 75b23d5e..0ba111a6 100755
> --- a/tests/generic/735
> +++ b/tests/generic/735
> @@ -6,16 +6,19 @@
>   #
>   # Append writes to a file with logical block numbers close to 0xffffffff
>   # and observe if a kernel crash is caused by ext4_lblk_t overflow triggering
> -# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
> -# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> -#
> +# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for
> +# commit bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> +# commit 2dcf5fde6dff ("ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS")
> +
>   . ./common/preamble
>   . ./common/populate
>   _begin_fstest auto quick insert prealloc
>   
>   # real QA test starts here
> -[[ "$FSTYP" =~ ext[0-9]+ ]] && _fixed_by_kernel_commit bc056e7163ac \
> -	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> +if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
> +	_fixed_by_kernel_commit bc056e7163ac "ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> +	_fixed_by_kernel_commit 2dcf5fde6dff "ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS"
> +fi
>   
>   _require_odirect
>   _require_xfs_io_command "falloc"
