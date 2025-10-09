Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5814A01
	for <fstests@vger.kernel.org>; Thu,  9 Oct 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998919; cv=none; b=R5pPwq+GljRv6VjUJ6agCJWFZAQbUi1lKhn0x1PiXDFHZkn169RuSNSB5PxTDibGUfMFEiEbrXHB03bCpNJVOMNlm06zXzAx6CyJh/mE36w76HMS1+TGAePbKANDIgjJGhS8CGy7zt3CP7tN58BJY5pRYQNY/7TzZqjgeHZhtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998919; c=relaxed/simple;
	bh=0IaEi0uq3l5f2+N98pir3HUxmmcK6n3FtbANj028fXY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I+Q0GU6Txkwa8pFtEqDviZYyGuqLTWy+w19Gqq/ege6OOQFmbTs2S4JDS8qbbn4QAqhSpCmdy4cUMZvNNHkfv6ceLSSFr9pku3YaE6O0yNaKFRUskqPqm2w4U4Hd6CsQl/oD22it5CNK/Zd6SPJGO7Xe28MggCDITHRwW2cvuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcIkufyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcIkufyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C104FC4CEE7;
	Thu,  9 Oct 2025 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759998919;
	bh=0IaEi0uq3l5f2+N98pir3HUxmmcK6n3FtbANj028fXY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YcIkufyU3AIdB5p+J/F6271VUWMBVI3szwmvzfmUyPBz/xT4Vle+4Puqo0l5+zne4
	 O25bSppZi+rukle0LDT28zebDOaPzUOagLYxPSkpHpXFqqJQ2tjQWpEm9K9quV5kQ+
	 250tFttQXBus1E0A95Eb6k6LTdmOcGplW8EVabI+Z0q+m0zuo6p5TG0P/iiY85d97v
	 Wr4mJK1vcI/4qyR/f3BC2BY8NhcOZIYbkBArR8UqkFf055AV3tZC+nfcNywBiamlnI
	 +WDFqdXkUaLyIkJjizuaZ7eG6lhyhq4HdHNsbQl+7Cmd2RIBaJsd+py16duRxtrZU1
	 CwqiKUCRxkJhA==
Message-ID: <7cab9cad-c075-452d-8600-bacc2db916b6@kernel.org>
Date: Thu, 9 Oct 2025 16:35:16 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/f2fs: introduce _require_inject_f2fs_command()
To: Zorro Lang <zlang@redhat.com>
References: <20250928185240.57862-1-chao@kernel.org>
 <20251001062441.cjh2wd7uleduehey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251001062441.cjh2wd7uleduehey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/2025 2:24 PM, Zorro Lang wrote:
> On Mon, Sep 29, 2025 at 02:52:40AM +0800, Chao Yu wrote:
>> Introduce _require_inject_f2fs_command() to check whether inject.f2fs
>> supports specific metaarea and member parameters.
>>
>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   common/f2fs    | 25 +++++++++++++++++++++++++
>>   tests/f2fs/009 |  2 ++
>>   tests/f2fs/012 |  2 ++
>>   tests/f2fs/019 |  2 ++
>>   tests/f2fs/020 |  2 ++
>>   tests/f2fs/022 |  2 ++
>>   6 files changed, 35 insertions(+)
>>
>> diff --git a/common/f2fs b/common/f2fs
> 
> You remind me that there's a common/f2fs file, you can move f2fs specific
> functions to common/f2fs (e.g. _check_f2fs_filesystem) later :)

Okay.

> 
>> index 1b39d8ce..4b01e032 100644
>> --- a/common/f2fs
>> +++ b/common/f2fs
>> @@ -25,3 +25,28 @@ _require_scratch_f2fs_compression()
>>   		_scratch_unmount
>>   	fi
>>   }
>> +
>> +# check that inject.f2fs supports to inject specific field in specific meta area
>> +_require_inject_f2fs_command()
>> +{
>> +	if [ $# -ne 2 ]; then
>> +		echo "Usage: _require_inject_f2fs_command metaarea member" 1>&2
>> +		_exit 1
>> +	fi
>> +	metaarea=$1
>> +	member=$2
>> +
>> +	case $metaarea in
>> +	sb|cp|nat|sit)
>> +		val=0
>> +		;;
>> +	ssa|node|dent)
>> +		;;
>> +	*)
>> +		_notrun "unsupport metaarea: $metaarea"
>> +		;;
>> +	esac
>> +
>> +	$F2FS_INJECT_PROG "--$metaarea" "$val" "-h" | grep "$member:" > /dev/null || \
>> +		_notrun "--$metaarea --mb $member support is missing"
>> +}
>> diff --git a/tests/f2fs/009 b/tests/f2fs/009
>> index 7333d484..465be874 100755
>> --- a/tests/f2fs/009
>> +++ b/tests/f2fs/009
>> @@ -9,10 +9,12 @@
>>   # and expects fsck.f2fs can detect such corruption and do the repair.
>>   #
>>   . ./common/preamble
>> +. ./common/f2fs
> 
> The common/f2fs can be imported by common/config:_source_specific_fs()
> automatically, so we don't need this line at here.

Oh, so we may missed to add such line for f2fs in common/config:_source_specific_fs(),
let me add a separated patch for this, and then we can remove ". ./common/f2fs" for
f2fs/002.

> 
> (Same below)
> 
>>   _begin_fstest auto quick
>>   
>>   _require_scratch
>>   _require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_inject_f2fs_command node i_links
> 
> If the "_require_command $F2FS_INJECT_PROG inject.f2fs" is always required
> before _require_inject_f2fs_command, how about call it at the beginning
> of _require_inject_f2fs_command ?

Yeah, that's better. :)

Thanks,

> 
> (same below)
> 
> Thanks,
> Zorro
> 
>>   _require_command "$(type -P socket)" socket
>>   
>>   _fixed_by_git_commit f2fs-tools 958cd6e \
>> diff --git a/tests/f2fs/012 b/tests/f2fs/012
>> index 7438d9ce..8e156772 100755
>> --- a/tests/f2fs/012
>> +++ b/tests/f2fs/012
>> @@ -12,6 +12,7 @@
>>   # 4.enable linear lookup, expect lookup succeed
>>   #
>>   . ./common/preamble
>> +. ./common/f2fs
>>   _begin_fstest auto quick casefold
>>   
>>   _fixed_by_kernel_commit 91b587ba79e1 \
>> @@ -21,6 +22,7 @@ export LC_ALL=C.UTF-8
>>   _require_scratch_nocheck
>>   _require_command "$F2FS_IO_PROG" f2fs_io
>>   _require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_inject_f2fs_command dent d_hash
>>   
>>   #check whether f2fs supports "lookup_mode=x" mount option
>>   mntopt=""
>> diff --git a/tests/f2fs/019 b/tests/f2fs/019
>> index 2307bd96..f6bb0b52 100755
>> --- a/tests/f2fs/019
>> +++ b/tests/f2fs/019
>> @@ -12,6 +12,7 @@
>>   #    corruption in the file
>>   #
>>   . ./common/preamble
>> +. ./common/f2fs
>>   _begin_fstest auto quick rw
>>   
>>   _fixed_by_kernel_commit 77de19b6867f \
>> @@ -19,6 +20,7 @@ _fixed_by_kernel_commit 77de19b6867f \
>>   
>>   _require_scratch_nocheck
>>   _require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_inject_f2fs_command node addr
>>   
>>   # remove all mkfs options to avoid layout change of on-disk inode
>>   export MKFS_OPTIONS=""
>> diff --git a/tests/f2fs/020 b/tests/f2fs/020
>> index 38bc6582..332848d0 100755
>> --- a/tests/f2fs/020
>> +++ b/tests/f2fs/020
>> @@ -12,6 +12,7 @@
>>   #    corruption in the file
>>   #
>>   . ./common/preamble
>> +. ./common/f2fs
>>   _begin_fstest auto quick rw
>>   
>>   . ./common/attr
>> @@ -21,6 +22,7 @@ _fixed_by_kernel_commit 061cf3a84bde \
>>   
>>   _require_scratch_nocheck
>>   _require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_inject_f2fs_command node i_xattr_nid
>>   _require_attrs user
>>   
>>   # remove all mkfs options to avoid layout change of on-disk inode
>> diff --git a/tests/f2fs/022 b/tests/f2fs/022
>> index ed3b4f2b..f81180e8 100755
>> --- a/tests/f2fs/022
>> +++ b/tests/f2fs/022
>> @@ -11,6 +11,7 @@
>>   # 4. fpunch in foo w/ specified range
>>   #
>>   . ./common/preamble
>> +. ./common/f2fs
>>   _begin_fstest auto quick rw
>>   
>>   . ./common/attr
>> @@ -20,6 +21,7 @@ _fixed_by_kernel_commit xxxxxxxxxxxx \
>>   
>>   _require_scratch_nocheck
>>   _require_command "$F2FS_INJECT_PROG" inject.f2fs
>> +_require_inject_f2fs_command node i_nid
>>   
>>   # remove all mkfs options to avoid layout change of on-disk inode
>>   export MKFS_OPTIONS=""
>> -- 
>> 2.40.1
>>
> 

