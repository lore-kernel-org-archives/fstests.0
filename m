Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C04277803
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907312; cv=none; b=eslmrhPDRhh0lRyXryj6YJZgfpDfWxN8aWZTVJwafjZJg28MwOQAGDBd8HNiDCGQTWWIejKSROQ3udGldxmStAs8HgEdfpyQoHGxFnP6itRXAPO8Eh/wSzZcZdAQGi6YCAYR2bq6wWJtWuXkVwsVEo73z+L52Hswxf7qCoyQ3gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907312; c=relaxed/simple;
	bh=Kfw42C6tDQ+goG19KwTiJ4ohGwXs3Iv/EnsP7pZVEw4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uH0AB1M2wvtyE9DN/SQNYQcPqHLO4lRxtLdxSMgAiIpzF4Jy+zrYOShnsQKgCvmARyt0w8bTEA+5BarehyF/YzwpWdrztBeKsCu2JCJyX90Rm7ajEkEsf5iDBd0aUvQwtvpy39rTokkxfOZTlA4Mqi9ao9DbF7yrW9Xgk9KNelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTGw74w+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTGw74w+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578FAC4AF0B;
	Tue, 25 Mar 2025 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907311;
	bh=Kfw42C6tDQ+goG19KwTiJ4ohGwXs3Iv/EnsP7pZVEw4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jTGw74w+bYHU354IX+4j3pncVpAd1WQXe36LyM6cd8TToxzmR80jSm9TQfypLTVLs
	 IECD9ViwnwmaYEdHMMZuxX0ZW3nDy0LxECVBXkfWPYfrCSS8xX8zj+tR7qW7tfytsv
	 fe9Aaa1qp6KmmH7dsExF9xVuLbjC/kZ16U/1Iagcql4/5H0MLbgXfnVWliibjJ3+bV
	 usw1rywY9hxcKe6KzXTSIFi1+nLKQSg1t42Km9SODcS/O0T4TtsorvOkDRnLuxJiqQ
	 anmBIx5PsrRHndUqBzZQbHshpENfG921tZx3XEC5EAhAhvibocul5Z1A8xdS1nnzZw
	 DcHsRa6D3oyhQ==
Message-ID: <68e0cf2c-31f2-47b6-a789-df2df3763856@kernel.org>
Date: Tue, 25 Mar 2025 20:55:07 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 6/6] f2fs/009: detect and repair nlink corruption
To: Dave Chinner <david@fromorbit.com>
References: <20250312072309.3989074-1-chao@kernel.org>
 <20250312072309.3989074-6-chao@kernel.org>
 <Z-J0LnCEWX2bo9LF@dread.disaster.area>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z-J0LnCEWX2bo9LF@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/25 17:15, Dave Chinner wrote:
> On Wed, Mar 12, 2025 at 03:23:09PM +0800, Chao Yu wrote:
>> This is a regression test to check whether fsck can handle corrupted
>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> and expects fsck.f2fs can detect such corruption and do the repair.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v4:
>> - remove unnecessary "_require_command fsck.f2fs"
>> - clean up _fixed_by_git_commit line
>> - fix to clean all tmp files in _cleanup
>>  tests/f2fs/009     | 147 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/f2fs/009.out |   2 +
>>  2 files changed, 149 insertions(+)
>>  create mode 100755 tests/f2fs/009
>>  create mode 100644 tests/f2fs/009.out
>>
>> diff --git a/tests/f2fs/009 b/tests/f2fs/009
>> new file mode 100755
>> index 00000000..9120d8a5
>> --- /dev/null
>> +++ b/tests/f2fs/009
>> @@ -0,0 +1,147 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>> +#
>> +# FS QA Test No. f2fs/009
>> +#
>> +# This is a regression test to check whether fsck can handle corrupted
>> +# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>> +# and expects fsck.f2fs can detect such corruption and do the repair.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +if [ ! -x "$(type -P socket)" ]; then
>> +	_notrun "Couldn't find socket"
>> +fi
>> +
>> +_require_scratch
>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +
>> +_fixed_by_git_commit f2fs-tools 958cd6e \
>> +	"fsck.f2fs: support to repair corrupted i_links"
>> +
>> +filename=$SCRATCH_MNT/foo
>> +hardlink=$SCRATCH_MNT/bar
>> +
>> +_cleanup()
>> +{
>> +	if [ -n "$pid" ]; then
>> +		kill $pid &> /dev/null
>> +		wait
>> +	fi
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +for ((i=0;i<14;i++)) do
>> +	echo "round: " $i >> $seqres.full
>> +
>> +	_scratch_mkfs >> $seqres.full
>> +	_scratch_mount
>> +
>> +	if [ $i == 0 ]; then
>> +		touch $filename
>> +		ino=`stat -c '%i' $filename`
>> +		nlink=0
>> +	elif [ $i == 1 ]; then
> .....
> 
> Ok, it works, but it's a bit nasty. You want to run the same
> injection and checking on all types of inodes, so factor that out
> like so:
> 
> inject_and_check()
> {
> 	local nlink=$1
> 	local ino=`stat -c '%i' $filename`
> 
> 	echo "ino:"$ino >> $seqres.full
> 	echo "nlink:"$nlink >> $seqres.full
> 
> 	_scratch_unmount
> 
> 	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV \
> 		>> $seqres.full || _fail "fail to inject"
> 
> 	_check_scratch_fs >> $seqres.full 2>&1 && _fail "can't find corruption"
> 	_repair_scratch_fs >> $seqres.full
> 	_check_scratch_fs >> $seqres.full 2>&1 || _fail "fsck can't fix corruption"
> 
> 	_scratch_mount
> 	_scratch_unmount
> 
> 	_scratch_mkfs >> $seqres.full
> 	_scratch_mount
> }
> 
> And now most of the test cases become this:
> 
> _scratch_mkfs >> $seqres.full
> _scratch_mount
> 
> touch $filename
> inject_and_check 0
> 
> mkdir $filename
> inject_and_check 1
> 
> mknod $filename c 9 0
> inject_and_check 0
> 
> mknod $filename b 8 0
> inject_and_check 0
> 
> .....
> 
> The whacky cases with socket and orphan inodes can be handled
> by factoring inject_and_check so there's a second function that
> takes both ino and nlink as parameters.
> 
> This gets rid of all the unnecessary if/elif logic and looping, 
> leaving only the test code that does the work behind.

Thanks a lot for the suggestion, it will be more clean w/ above
implementation, will update v5.

Thanks,

> 
> -Dave.

