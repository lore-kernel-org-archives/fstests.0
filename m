Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E91DF26B
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659850; cv=none; b=FDNp0mjlmBK03HyIkqj6aPrLXt19y6uLQ1BB/m629tcr+vd8jBhpEEQ9Zkn/bKWYCnSL0kt/pnGl+JiRQ8/Wu4Ev20vp913EP0u2ZnalSAGXI0RHE+xLzANqWOUrOlgCeuiIxWAf8UW8e2GCSSDUBJy3RF63WNcl4sli24vBwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659850; c=relaxed/simple;
	bh=YinmwReazkNPB6ZX1QlREEjqhK5fZRJFq+/7acLtv80=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s8bKotBaL0OZHabyJi52a3RwILqnLXXHBqDZWhtiG5jLehX4yYu8OGpysK+PikWV4wkASNVWJCcpyHOrOh/iUARNpjTjqHW9jINcdbxs4L1/xKGACCMbnhVviSsbuwFhTI6GBoQ6SDMWQolTCTyg3UfK2DPonZ5ST49dlcvJIu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAWe3lRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAWe3lRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4ACC4CEEC;
	Tue, 11 Mar 2025 02:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741659850;
	bh=YinmwReazkNPB6ZX1QlREEjqhK5fZRJFq+/7acLtv80=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jAWe3lRlBTVNbQfAP3sN6euajei6scrROlr1u0xiTem0ZELVyNsCYISg2IAe0hu5e
	 /rHInoHimL8HU6dBTprbfw3Ue6EHuEsq/oRZ1FgGD9YkHEClA2Nac4Qjit/NKI2yjC
	 mwM6Vwnmr4iSGZHxaVT8H3Oj96g5htWbR20EQ+rCr24Kcy9z1Dw8NAaS9A2cKmnEcp
	 5kkpOmDQB2UiL5REHB6hl21MjV1vlTqj+6jhNOgSHTh0ghyNwAFNVpqV2U5xa+SxlB
	 8lJsOusckNGvjnOSvhAlFEMsyUpmYvNp3r9fCbjYdusNFAuhgm+lNmcwnLu9+CoSwU
	 W/nQlFIhmRQWQ==
Message-ID: <689f5126-e8cb-45cb-b620-99b4ea751937@kernel.org>
Date: Tue, 11 Mar 2025 10:24:06 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] f2fs/009: detect and repair nlink corruption
To: Zorro Lang <zlang@redhat.com>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250306081809.2397527-4-chao@kernel.org>
 <20250310080006.rkvoxu55fe3qlxmd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c62943db-6169-462a-95a0-15fb2d5bc079@kernel.org>
 <20250310194818.wki325qreuta26nc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250310194818.wki325qreuta26nc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 03:48, Zorro Lang wrote:
> On Mon, Mar 10, 2025 at 05:59:23PM +0800, Chao Yu wrote:
>> On 3/10/25 16:00, Zorro Lang wrote:
>>> On Thu, Mar 06, 2025 at 04:18:09PM +0800, Chao Yu wrote:
>>>> This is a regression test to check whether fsck can handle corrupted
>>>> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
>>>> and expects fsck.f2fs can detect such corruption and do the repair.
>>>>
>>>> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>
> 
> [snip]
> 
>>>> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV >> $seqres.full
>>>> +	if [ $? != 0 ]; then
>>>> +		exit
>>>> +	fi
>>>> +
>>>> +	export FSCK_OPTIONS="-f"
>>>
>>> You've set below code in _repair_scratch_fs():
>>>
>>>     f2fs)
>>>         fsck -t $FSTYP -f $SCRATCH_DEV
>>>         ;;
>>>
>>> The FSCK_OPTIONS="-f" is useless.
>>>
>>>> +	_repair_scratch_fs >> $seqres.full
>>>> +	if [ $? != 1 ]; then
>>>
>>> What does $?=1 mean? Does $?=1 mean finding corruption and fixed, $?=0 mean no corruption?
>>
>> That's correct.
>>
>>>
>>> If you want to detect there's a corruption, then fix it, then check if it's fixed. How about
>>> calling _check_scratch_fs at first to get the corruption error you expect, then call
>>> _repair_scratch_fs to fix it. Then call _check_scratch_fs to make sure the corruption is
>>> fixed?
>>>
>>> Something likes (just a rough example)
>>>
>>> _check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"
>>
>> You mean this?
>>
>> export FSCK_OPTIONS="--dry-run"
>> _check_scratch_fs >>$seqres.full 2>&1 || _fail "can't find corruption"
> 
> No,
> 
>>
>> We need to export FSCK_OPTIONS w/ "--dry-run", otherwise _check_scratch_fs
>> will be stuck once it detects corruption.
> 
> If so, you might need to give _check_scratch_fs (and _check_test_fs) a f2fs
> specific handling. Due to _check_scratch_fs aims to do "check" only,
> _repair_scratch_fs aims to do "repair", they have different target. When
> we call _check_scratch_fs, we hope it reports pass or corruption then return,
> neither "repair" nor "stuck". So if I understand correct, you might need:

Thank you for the explanation, now it's clear to me for use of those functions.

> 
> _check_scratch_fs()
> {
> 	case $FSTYP in
> 	...
> 	f2fs)
> 		FSCK_OPTIONS="--dry-run" _check_generic_filesystem $device

It seems not work for me, due to fsck can not accept long parameter
started w/ --? I didn't dig into this now.

fsck -t f2fs --dry-run /dev/vdb
fsck from util-linux 2.40.2

fsck -t f2fs  /dev/vdb -- --dry-run
fsck from util-linux 2.40.2
Info: Dry run
Info: MKFS version
...
Done: 0.071639 secs

So I used this in v2:

+    f2fs)
+        if [ "$FSCK_OPTIONS" == "--dry-run" ]; then
+            fsck -t $FSTYP $device -- $FSCK_OPTIONS >> $seqres.full 2>&1
+        else
+            _check_generic_filesystem $device
+        fi
+        ;;

Any suggestion? What about introducing _check_f2fs_filesystem and reuse
codes in _check_generic_filesystem as much as possible, then replace
fsck w/ $F2FS_FSCK_PROG in order to use --dry-run.

Thanks,

> 		;;
> 	...
> }
> 
> Or you have any better way to do f2fs check :)
> 
> Thanks,
> Zorro
> 
>>
>>> _repair_scratch_fs >> $seqres.full
>>> _check_scratch_fs
>>>
>>>> +		_fail "fsck can not detect and repair zero nlink corruption "$i
>>>> +		exit
>>>> +	fi
>>>> +
>>>> +	export FSCK_OPTIONS=""
>>>> +	_check_scratch_fs >> $seqres.full
>>>
>>> I think _check_scratch_fs outputs nothing if run passed, right?
>>>
>>> _check_scratch_fs calls _check_generic_filesystem for f2fs, the FSCK_OPTIONS
>>> is "null" by default, so above FSCK_OPTIONS="" is useless too.
>>>
>>>> +	if [ $? != 0 ]; then
>>>> +		_fail "fsck hasn't fixed nlink corruption "$i
>>>> +		exit
>>>> +	fi
>>>> +
>>>> +	_scratch_mount >> $seqres.full
>>>
>>> ">> $seqres.full" isn't necessary.
>>
>> Will update according to you comments, thanks a lot.
>>
>> Thanks,
>>
>>>
>>>> +	_scratch_unmount
>>>> +done
>>>> +
>>>> +echo "Silence is golden"
>>>> +
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/f2fs/009.out b/tests/f2fs/009.out
>>>> new file mode 100644
>>>> index 00000000..7e977155
>>>> --- /dev/null
>>>> +++ b/tests/f2fs/009.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 009
>>>> +Silence is golden
>>>> -- 
>>>> 2.48.1
>>>>
>>>>
>>>
>>
> 

