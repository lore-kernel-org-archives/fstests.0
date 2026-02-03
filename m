Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A21F3B87
	for <fstests@vger.kernel.org>; Tue,  3 Feb 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770104831; cv=none; b=F0uww89DgJYGWW3uUJNffYLaJzjSHWZo1UrKO53yBqqvdthDnh+si3IVWagrP9txVOA0CBqsaX4A4z503lrJmVxDiPMzZDn4pgG63T0lIaWq+1ZSTejmOtxA9ud+D/wRGY0pzYQLGkedtnJWDHlshD4IKms3GtBDelr8qvc36dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770104831; c=relaxed/simple;
	bh=N03NInlogGf3lhGiaw27Bs0wKYg6UZeTDgrAuXkKLh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t7OqeizR/e4zBB6RgRy7nXMLU6FSCBqhpVGgQ3Sde3D3qIjjMcJy3D7LB6vVOAQAmpf5mQ8XcC8EJ0MJhJPojwPsRe3OGwW0zZBqrsQvmUZFVsSBHPTXg2DzeO5cLElqlG6LZLTPQWmdU/K94L8ohyqGlhdgzp+B1O2+kFSDr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l08ji3Ep; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l08ji3Ep"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6130Gc4d028582;
	Tue, 3 Feb 2026 07:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gwTy11
	Mo9DlgriZL5dNuOqXIyQDqsCycQg066ph7IHo=; b=l08ji3Ep7X6hAkzE7hkbAe
	9lko+eNkyBo4uA1OycndrRJimmZnMg7mIvuZ1dP8cfR3PI891pkEg9pPdIbIC8E6
	rAYJ1Rt4sOMmb+aLsImX6TKVIafBAuvJjAbyrggD5GhUwERa51MGi0RjXFmGbkt5
	LpsuVffwJuhG2yPw3E+xOP6qDlXQdmlhPtNAjsSx/HniOWbxHgr+YBRFwZmRgSbq
	4Wfj4H44qN6YZRHEtqhY5+ic2K1sjT+uP3raZgjkFpPeJS784sgPXYxR3s927CMY
	rClUGiugabfHz8/2HHhIbbHjOL1Kw+jljV8sk8IE4dPyndShBv5yAC0+LQGvuvwQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986c6t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 07:47:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6135NWmt009600;
	Tue, 3 Feb 2026 07:47:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vey0aeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 07:47:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6137l1vK60621192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 07:47:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0C0F20043;
	Tue,  3 Feb 2026 07:47:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B06120040;
	Tue,  3 Feb 2026 07:47:00 +0000 (GMT)
Received: from [9.109.198.113] (unknown [9.109.198.113])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 07:47:00 +0000 (GMT)
Message-ID: <99f8ceb5-761e-47de-a7ee-f823fd18f935@linux.ibm.com>
Date: Tue, 3 Feb 2026 13:16:59 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/307: Calculate donor size to avoid failures for 64k
 bs
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
References: <20260202132730.589621-1-ojaswin@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20260202132730.589621-1-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA1NyBTYWx0ZWRfX9iHk3BLupC/s
 mHYcLNFj//Kji25BBo/wxwUwjHCcYvcJl/pjx9D7D9xZpFmk6au5iMhlZM/rst4LEUQuj39St7u
 T3FCW55lxMxQFGWGxkMB0KVEgxBO62al9KKqPjiX/me0jZ2jNpmhovt3Q89aIN7hLlBZDK6DHiF
 6xnimkBAQVrp2mqvHL+N00Wekm+a7jRkvldVSDMftqAj+ke9/c09F8SocbX7j/J8d21oz/EoOEM
 +NrdEghsFM4GAE6+S3cDnMSwSqRsTVfKunRXP3T0gFIwv5SnBTlQGHweYCySZn1PWF+YzUF5AK1
 L32Iya7Sj+w73+LVjaGVzWXTydC3+Dd/87MiajEJB9fS6KwTJQxn9AI7qlGlEYzhEShy5Z3bn3d
 yLdp7ur+Fr648/eMA7mxFbd78APMJAVYf11gO++dY+Nu/Of83LD7pqiaitWxGBu51hZZPQ1QFQu
 d8OdHIUnED4BDp+Dk/g==
X-Proofpoint-GUID: pMKc5E05V2cJgJqaXfYkMgFHOPYeLEzn
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=6981a7fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=k54H8d9qNlckLa8umXgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pMKc5E05V2cJgJqaXfYkMgFHOPYeLEzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030057

On 02/02/26 6:57 pm, Ojaswin Mujoo wrote:
> Hard coding donor size to 250M causes the following failure in e4compat
> 
> e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
> ./common/rc: line 4616: 1583182 Aborted                 (core dumped)
> 
> The issue is that e4compat asserts that the stat.st_size of all files
> combined shouldn't be more than that of the donor file. In case of 64k
> blocksize, fsstress often creates sparse files which have >3G size even
> though their disk utilization is <100M. Since donor file is not big
> enough, this trips e4compat causing the failure.
> 
> Fix this by dynamically calculating the donor file size based on the
> size of all files. Also, make some changes to avoid future ENOSPC like
> reducing the -n passed to fsstress to keep the size around 2G and making
> sure we use the whole SCRATCH disk instead of 500M.
> 
> While we are at it, add some new lines to make the code bit more
> readable.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for the patch Ojaswin. Tested successfully on my setup.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/ext4/307 | 41 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index 1f0e42ca..7e7fb9c8 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -12,24 +12,57 @@ _begin_fstest auto ioctl rw defrag prealloc
>   # Import common functions.
>   . ./common/filter
>   . ./common/defrag
> +
> +# Get the total of stat.st_size of each file to determine the
> +# size of donor file. We use st_size here instead of blocks used
> +# because thats what e4compat.c checks against.
> +get_bytes_used() {
> +	local filelist="$1"
> +	local total=0
> +	local blksz=$(_get_block_size $SCRATCH_MNT)
> +
> +	while IFS= read -r f; do
> +		echo -n "File: $f: " >> $seqres.full
> +		[[ -z "$f" ]] && continue
> +
> +		if [[ -f "$f" ]]; then
> +			local bytes
> +			bytes=$(stat -c %s "$f")
> +			total=$((total + bytes))
> +			echo $bytes >> $seqres.full
> +		fi
> +	done < "$filelist"
> +
> +	echo "Total bytes: $total" >> $seqres.full
> +	echo $total
> +}
> +
>   # Disable all sync operations to get higher load
>   FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
>   _workout()
>   {
> +	local blksz=$(_get_block_size $SCRATCH_MNT)
> +
>   	echo ""
>   	echo "Run fsstress"
>   	out=$SCRATCH_MNT/fsstress.$$
> -	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
> +	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
>   	echo "fsstress $args" >> $seqres.full
>   	_run_fsstress $args
> +
>   	find $out -type f > $out.list
>   	cat $out.list | xargs  md5sum > $out.md5sum
> -	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> +
> +	bytes=`get_bytes_used $out.list`
> +	echo "Total bytes used: $bytes" >> $seqres.full
> +
>   	echo "Allocate donor file"
> -	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +
>   	echo "Perform compacting"
>   	cat $out.list | run_check $here/src/e4compact \
>   		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> +
>   	echo "Check data"
>   	run_check md5sum -c $out.md5sum
>   }
> @@ -41,7 +74,7 @@ _require_scratch
>   _require_defrag
>   _require_xfs_io_command "falloc"
>   
> -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mkfs >> $seqres.full 2>&1
>   _scratch_mount
>   
>   _workout

