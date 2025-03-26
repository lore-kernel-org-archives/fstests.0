Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6A3BBF0
	for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959487; cv=none; b=S2zSoGO/fj7jvurjKDN87hkPAkZAcy+jRGzgQpCjTjI6Gbk8RGITNFZ2DU0M2EF57b/XD9RYx35Q6uEn6qbAgB2JvJ8CFyYUhT4cLkc77rlzGZAMLMKf8xmJ9IlnhRdER8jNF94Wrxr+lkTez4ZxtT/qPawJj89WkhFo2shdyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959487; c=relaxed/simple;
	bh=slulgQE+aQy8LnXABstJI1BsbYuK7K2GlkRqWtbSuz8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CJPK/kVX6rMOdjbw01DZRjgcIoNOryM+Zajsw+tzADssK0Z5rY25jFSRNOuXQPeWFS4D0TuZaRhuzBN87Uski7a66VVIYPIc22sytp0zp8IqdZvX5hW8GPUPK1Hn/JZhdo/v8t19JbK7rHv2dDaOfteqq9GnBDhS7D/nGja2eiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9FPCAbz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9FPCAbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2890FC4CEE2;
	Wed, 26 Mar 2025 03:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742959487;
	bh=slulgQE+aQy8LnXABstJI1BsbYuK7K2GlkRqWtbSuz8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=F9FPCAbzYPZeT7YoHrHWfj7nRRfLTkWj90rnHLh+VVjsp+DRmVQRme/X4w3npGZx+
	 ax5usCDXTPnwLm+b67FHZjFrwEDp8HmzjU70dO7wp9ChsewDV5YDIIn6DZsIo11IrT
	 IM10FIOzkiiY2IDQSdWfpgbrLxUCP3VlmG/2Vep32R3p/+4Psq2QFOkykI3C//zx8j
	 1rsRH4R1gMKOiWWel35ifQuag9+NrsPM2tjXRIcYJQfSXSfxnmVsn/hKhKfqqmmdUl
	 etYNpPDJFYDVXGqRnSriuUQ1pAzlFImYq64qZkPtW2BWsAA57JEXR43aO1LIjbz92C
	 6tXHSWF6yyKxg==
Message-ID: <5ae5a7d0-18bb-49f1-abb2-46807e39a7fe@kernel.org>
Date: Wed, 26 Mar 2025 11:24:44 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, fstests@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 6/6] f2fs/009: detect and repair nlink corruption
To: Zorro Lang <zlang@redhat.com>, Dave Chinner <david@fromorbit.com>
References: <20250325125824.3367060-1-chao@kernel.org>
 <20250325125824.3367060-6-chao@kernel.org>
 <Z-M6PkLZI2LIOlXY@dread.disaster.area>
 <20250326004748.bx2z62lpqpg6rjlj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250326004748.bx2z62lpqpg6rjlj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 08:47, Zorro Lang wrote:
> On Wed, Mar 26, 2025 at 10:20:30AM +1100, Dave Chinner wrote:
>> On Tue, Mar 25, 2025 at 08:58:24PM +0800, Chao Yu wrote:
>>> This is a regression test to check whether fsck can handle corrupted
>>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>>> and expects fsck.f2fs can detect such corruption and do the repair.
>>>
>>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>> v5:
>>> - clean up codes suggested by Dave.
>>>  tests/f2fs/009     | 141 +++++++++++++++++++++++++++++++++++++++++++++
>>>  tests/f2fs/009.out |   2 +
>>>  2 files changed, 143 insertions(+)
>>>  create mode 100755 tests/f2fs/009
>>>  create mode 100644 tests/f2fs/009.out
>>>
>>> diff --git a/tests/f2fs/009 b/tests/f2fs/009
>>> new file mode 100755
>>> index 00000000..864fdcfb
>>> --- /dev/null
>>> +++ b/tests/f2fs/009
>>> @@ -0,0 +1,141 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
>>> +#
>>> +# FS QA Test No. f2fs/009
>>> +#
>>> +# This is a regression test to check whether fsck can handle corrupted
>>> +# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>>> +# and expects fsck.f2fs can detect such corruption and do the repair.
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick
>>> +
>>> +if [ ! -x "$(type -P socket)" ]; then
>>> +	_notrun "Couldn't find socket"
>>> +fi
>>
>> Perhaps something like:
>>
>> _require_command $(type -P socket) socket
> 
> Good point! Maybe double quotation marks -- "$(type -P socket)" is
> helpful, due to if socket isn't installed, there will be only one
> argument.
> 
>>
>> would be more consistent with all the other code that checks for

Agreed.

>> installed utilities that a test requires?
>>
>>> +_require_scratch
>>> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
>>> +
>>> +_fixed_by_git_commit f2fs-tools 958cd6e \
>>> +	"fsck.f2fs: support to repair corrupted i_links"
>>> +
>>> +filename=$SCRATCH_MNT/foo
>>> +hardlink=$SCRATCH_MNT/bar
>>> +
>>> +_cleanup()
>>> +{
>>> +	if [ -n "$pid" ]; then
>>> +		kill $pid &> /dev/null
>>> +		wait
>>> +	fi
>>> +	cd /
>>> +	rm -r -f $tmp.*
>>> +}
>>> +
>>> +_inject_and_check()
>>
>> Single leading "_" is reserved for fstests functions, not for local
>> test functions.

Oh, got it.

>>
>> Just call this one "inject_and_test", because that is what it does,
>> and call this one:
>>
>>> +inject_and_check()
>>> +{
>>> +	local nlink=$1
>>> +	local create_hardlink=$2
>>> +	local ino=$3
>>> +
>>> +	if [ -z $ino ]; then
>>> +		ino=`stat -c '%i' $filename`
>>> +	fi
>>> +
>>> +	if [ $create_hardlink == 1 ]; then
>>> +		ln $filename $hardlink
>>> +	fi
>>> +
>>> +	_inject_and_check $nlink $ino
>>> +}
>>
>> something like check_links()
>>
>> Otherwise this is a good improvement.

Thanks Dave for all your review and suggestion!

> 
> Hi Chao, if you agree with all these changes, and don't need to change more, I can
> help to merge this patchset with above changes. Or you'd like to send a new version?

Zorro, I'm fine w/ all the changes, I'm appreciate for that if you can
help to update the patch!

Thanks,

> 
> Thanks,
> Zorro
> 
>>
>> -Dave.
>> -- 
>> Dave Chinner
>> david@fromorbit.com
>>
> 

