Received: from mail.cn.fujitsu.com ([183.91.158.132]:41885 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750773AbeFHEHF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jun 2018 00:07:05 -0400
Message-ID: <5B1A00E0.9050402@cn.fujitsu.com>
Date: Fri, 8 Jun 2018 12:06:56 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] common/rc: Fix mismatched output from standard mkswap
References: <1528190505-20483-1-git-send-email-yangx.jy@cn.fujitsu.com> <20180607095207.GH2861@desktop>
In-Reply-To: <20180607095207.GH2861@desktop>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, osandov@fb.com
List-ID: <fstests@vger.kernel.org>

On 2018/06/07 17:52, Eryu Guan wrote:
> On Tue, Jun 05, 2018 at 05:21:45PM +0800, Xiao Yang wrote:
>> Running generic/495 with EXT4 on RHEL6 got the following output:
>> ----------------------------------------------------------------
>> ...
>> +mkswap: /mnt/xfstests/scratch/swap: warning: don't erase bootbits sectors
>> +        on whole disk. Use -f to force.
>> +mkswap: unable to relabel /mnt/xfstests/scratch/swap to system_u:object_r:swapfile_t:s0: Operation not supported
>> ...
>> ----------------------------------------------------------------
>>
>> Before commit c1f1b30 of util-linux, mkswap didn't zap bootbits sectors
>> and printed a warning until force option(i.e. -f) was given, so we add
>> the force option.
>>
>> Before commit d97dc0e of util-linux, mkswap failed to relabel SELinux
>> labeling when the underlying filesystem didn't support it.  We avoid
>> default fs-wide context set in xfstests by mounting manually.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 9273ff7..6a20454 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2216,7 +2216,7 @@ _format_swapfile() {
>>   	# Swap files must be nocow on Btrfs.
>>   	$CHATTR_PROG +C "$fname">  /dev/null 2>&1
>>   	_pwrite_byte 0x61 0 "$sz" "$fname">>  $seqres.full
>> -	mkswap "$fname">>  $seqres.full
>> +	mkswap -f "$fname">>  $seqres.full
>>   }
> This part looks fine.
>
>>
>>   # Check that the filesystem supports swapfiles
>> @@ -2225,7 +2225,7 @@ _require_scratch_swapfile()
>>   	_require_scratch
>>
>>   	_scratch_mkfs>/dev/null
>> -	_scratch_mount
>> +	_mount $SCRATCH_DEV $SCRATCH_MNT
Hi Eryu,
> But this breaks test on overlay, it fails to mount overlayfs.
Sorry, i fogot the especial overlay.
> And I manually revert d97dc0e and build mkswap from util-linux, and test
> with ext4, but I didn't reproduce the failure. It seems it only happens
> when underlying filesystem doesn't support extend attr? (I don't have a
> RHEL6 env by hand..).
Do you build mkswap with ./configure --with-selinux?  We probablely need 
HAVE_LIBSELINUX
macro.  We also make the status of SELinux Permissive/enforcing.

I reverted d97dc0e and built mkswap from util-linux, and produced the 
error with ext4/xfs on
v4.15-rc7 and v4.16.

I seems that kernel cannot change the value of security.selinux if it 
has been initialized by
mount -o context=xxx.

Thanks,
Xiao Yang
> Thanks,
> Eryu
>
>
>>
>>   	# Minimum size for mkswap is 10 pages
>>   	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
>> -- 
>> 1.8.3.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>



