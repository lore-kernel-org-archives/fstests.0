Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA83224234
	for <fstests@vger.kernel.org>; Sat, 16 Aug 2025 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328527; cv=none; b=LnwNiSAzS7sM2s5D1/V8bQ+cPkWj4TOE6R3XvYjThpbPKamZboMxraMyd6hfjjZlwbSu3Ot9SG0mmtsQiCYynsH1h61kZO0gMXDgpL6KeIa8lfNLnY5PzCh56h0clFsV/9Acrzh/F6g/k03D+wKFrDfFIjFA4u9XdC2c80xof5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328527; c=relaxed/simple;
	bh=c4tTy3wlTYksBN2LhG3HMKqNg8Ks6PlWm/MwcmEsvYo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j7CAy8SWyw+z0mabUF9wzJlC8VPOluzUCesRcXLI8K5eqhqAp6K/0k//wqaY3t3ZMNGT40Xf7qZbnkVFr3hqKfQDKswwa83p5AyUGOuGmhV8OWNjiRJE6dPddPHeYLfYyPGHe9xt/KbXvC6VvMtkof3Dn8KhkoCBSNugXmOIJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPtC+dmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPtC+dmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4F5C4CEEF;
	Sat, 16 Aug 2025 07:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755328527;
	bh=c4tTy3wlTYksBN2LhG3HMKqNg8Ks6PlWm/MwcmEsvYo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nPtC+dmFc7OBCsVrkeNyoq2hjl3apu1Z3qYsMOoPt3/mpV+oy7+GnW0VvKYNWO/K/
	 /9g3lvJJtLg/vz0n39XWpcgrVeTysIUMrhPN8HMX1Ie9gF7ttIP4jVPCl1lyHn4I9B
	 X/auQUTCcD4UvgBU2LDauXQEoUHpVGg/i3RybKdxgX9RIUdTKIXJFcBNGMBUuS2WvY
	 5sEvJIp37DrfAJJCi1lK+aljEjyIwqZQJgsQUygzKwROGBrSDIQ6LGdrpJjw0eL4hN
	 SrDHTj0Td+kl0n4qwyiB6QWBqhr7lgkXGOleOP1UwzkzvNdHGPJp2gVI7k6+rEW6HD
	 i3pa5ILgq5eJw==
Message-ID: <d23f7cbf-729d-4be6-87a5-7561cbd95ad0@kernel.org>
Date: Sat, 16 Aug 2025 15:15:22 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Daniel Lee <chullee@google.com>
Subject: Re: [PATCH] f2fs/012: adapt lookup_mode=x mount option
To: Zorro Lang <zlang@redhat.com>
References: <20250808065803.17298-1-chao@kernel.org>
 <20250815155408.ja527chpfrjtcuau@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250815155408.ja527chpfrjtcuau@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/8/15 23:54, Zorro Lang wrote:
> On Fri, Aug 08, 2025 at 02:58:03PM +0800, Chao Yu wrote:
>> w/ below change [1], f2fs will enable lookup_mode=perf by default, it
>> will change f2fs dirent lookup method from linear based lookup to hash
>> based lookup.
>>
>> So that, f2fs will ignore sb.s_encoding_flags by default, which is not
>> compatible w/ f2fs/012 testcase, in where it will control lookup method
>> by configuring this flag w/ fsck.f2fs.
>>
>> To avoid failure of f2fs/012, let's check whether f2fs has supported
>> "lookup_mode=auto" mount option, mount w/ the option if it can,
>> otherwise, don't.
>>
>> [1] https://lore.kernel.org/linux-f2fs-devel/20250805065228.1473089-1-chullee@google.com
>>
>> Cc: Daniel Lee <chullee@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
> 
> With this patch, I always get below error:
> 
> f2fs/012 2s ... - output mismatch (see /root/git/xfstests/results//f2fs/012.out.bad)
>      --- tests/f2fs/012.out      2025-07-21 13:33:12.379585206 +0800
>      +++ /root/git/xfstests/results//f2fs/012.out.bad    2025-08-15 23:51:54.156835560 +0800
>      @@ -1,2 +1,4 @@
>       QA output created by 012
>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/sda6, missing codepage or helper program, or other error.
>      +       dmesg(1) may have more information after failed mount system call.
>       Silence is golden
>      ...
>      (Run 'diff -u /root/git/xfstests/tests/f2fs/012.out /root/git/xfstests/results//f2fs/012.out.bad'  to see the entire diff)
> 
> Then test passed without this patch:

Sorry, I thought I've checked the case that kernel doesn't support
lookup_mode=x mount option.

> 
> f2fs/012 2s ...  3s
> Ran: f2fs/012
> Passed all 1 tests
> 
> 
>>   tests/f2fs/012 | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/f2fs/012 b/tests/f2fs/012
>> index b3df9a8f..15fc8f0c 100755
>> --- a/tests/f2fs/012
>> +++ b/tests/f2fs/012
>> @@ -22,6 +22,15 @@ _require_scratch_nocheck
>>   _require_command "$F2FS_IO_PROG" f2fs_io
>>   _require_command "$F2FS_INJECT_PROG" inject.f2fs
>>   
>> +#check whether f2fs supports "lookup_mode=x" mount option
>> +mntopt=""
>> +_scratch_mkfs -O casefold -C utf8 >> $seqres.full
>> +_try_scratch_mount "-o lookup_mode=auto"

We need to ignore the error from _try_scratch_mount ... here, let me fix it.

Thanks,

>> +if [ $? == 0 ]; then
>> +	mntopt="-o lookup_mode=auto"
>> +	_scratch_unmount
>> +fi
>> +
>>   check_lookup()
>>   {
>>   	local nolinear_lookup=$1
>> @@ -30,7 +39,7 @@ check_lookup()
>>   	local redheart=$dir/$'\u2764\ufe0f'
>>   
>>   	_scratch_mkfs -O casefold -C utf8 >> $seqres.full
>> -	_scratch_mount
>> +	_scratch_mount $mntopt
>>   
>>   	mkdir $dir
>>   	$F2FS_IO_PROG setflags casefold $dir >> $seqres.full
>> @@ -52,7 +61,7 @@ check_lookup()
>>   
>>   	$F2FS_INJECT_PROG --dent --mb d_hash --nid $ino --val 0x9a2ea068 $SCRATCH_DEV >> $seqres.full
>>   
>> -	_scratch_mount
>> +	_scratch_mount $mntopt
>>   	if [ $nolinear_lookup == "1" ]; then
>>   		[ -f $redheart ] && _fail "red heart file should not exist"
>>   	else
>> -- 
>> 2.40.1
>>
> 

