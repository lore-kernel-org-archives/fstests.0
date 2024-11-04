Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115E1AAE27
	for <fstests@vger.kernel.org>; Mon,  4 Nov 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758348; cv=none; b=taDGmGMvQdktqy2ZNgEx8jSYTAONObXbY/d0Tke57ut617D4IJOQKv/a5mPUVfVczV3fmYXUab1UZGiKWl2yxNDJdN8Ov2Cvm8LC3BKfCcz0OlXKAqzG1XsIEYOurZEkQ+gk9EbvP6Vlxa2Xkhjj0yjs6jsXtoekcM5jhxfjwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758348; c=relaxed/simple;
	bh=Bi/4M/zEnG5/f5/DbRuXAH131rtHrZaCG1BOzR1ubJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEGEDEIHRlSEBxCC995Yb2S6TelWP5uk68ELufIZe+W4U6dmfwj49My2+ixQ46VoVJG8HSj31A/LGf5At1Rl05kb2hoMXQLLJP7Qln7ptrHgOuHZ5Kcby91S0rxvgXKinHoXay/eAfu+caiIwKeFW68LFvRjjcFu4wrFlObMhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V/jvxzze; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V/jvxzze"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=21dnOeOQfqVC24vhE7gjK5YSGlXoIFyJ/zBFwcXMr1c=; b=V/jvxzzeQvgA5wwSgf0taEps8G
	CHWewpvmmthkYFKLeRKdd7qW5Vzpukdt/h7LijYCCmzDPXR3nPVLxuW1CUofp1g19pe4D4kSBds55
	8LUs8l+GtAGS7VMZrQoc0TqSNxMTWAZzM284EKpDPWw5TNxuIPYjQAK2aDA4ARc2wYrU/eNuoo3pn
	9vPUlDdgsz9KW5zM0d/3zID7Zvx3uxD1v7DhxN2VsbCdyj35CjgKlXKKC7rLJE0m1+s7/Bs0btUUS
	Kf4M/xXQHSRwD48WzSzlG++8hilO584ABxx0gpwrhRaLipWqr1hwJ0OK6PSn1lmDDR8UQ/L3u3i+7
	hTPdKmFQ==;
Received: from [177.172.124.78] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t85J9-001rBX-3g; Mon, 04 Nov 2024 23:12:23 +0100
Message-ID: <febd4cb4-9802-4181-b591-b9978829e493@igalia.com>
Date: Mon, 4 Nov 2024 19:12:18 -0300
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/casefold: Support for tmpfs casefold test
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
 kernel-dev@igalia.com, Miklos Szeredi <mszeredi@redhat.com>,
 Eryu Guan <guaneryu@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>
References: <20241104210636.38934-1-andrealmeid@igalia.com>
 <875xp265by.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <875xp265by.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 04/11/2024 18:45, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@igalia.com> writes:
> 
> 
>> @@ -67,6 +74,10 @@ _scratch_mkfs_casefold_strict()
>>   	f2fs)
>>   		_scratch_mkfs -C utf8:strict
>>   		;;
>> +	tmpfs)
>> +		# there's no mkfs for tmpfs, so we just mount it
>> +		mount -t tmpfs -o casefold,strict_encoding tmpfs $SCRATCH_MNT
>> +		;;
> 
> 
> This looks like a hack.  Why mount it here instead of _scratch_mount?
> This should just be a nop for tmpfs.
> 
> 

_scratch_mount doesn't have any code related to casefold, should I 
create a _scratch_mount_casefold for tmpfs?

I added it here because is where the other filesystem do their casefold 
options setup.

>>   	*)
>>   		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
>>   		;;
>> diff --git a/common/rc b/common/rc
>> index 2af26f23..2ee46e51 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -374,6 +374,9 @@ _scratch_unmount()
>>   	btrfs)
>>   		$UMOUNT_PROG $SCRATCH_MNT
>>   		;;
>> +	tmpfs)
>> +		$UMOUNT_PROG $SCRATCH_MNT
>> +		;;
>>   	*)
>>   		$UMOUNT_PROG $SCRATCH_DEV
>>   		;;
>> diff --git a/tests/generic/556 b/tests/generic/556
>> index 51d2d482..78cdf1bf 100755
>> --- a/tests/generic/556
>> +++ b/tests/generic/556
>> @@ -485,11 +485,20 @@ test_strict_mode_invalid_filename()
>>   
>>   _scratch_mkfs_casefold >>$seqres.full 2>&1
>>   
>> -_scratch_mount
>> -
>> -_check_dmesg_for \
>> -	"\(${sdev}\): Using encoding defined by superblock: utf8" || \
>> -	_fail "Could not mount with encoding: utf8"
>> +# casefold tmpfs was already mounted in the mkfs step
>> +if [ "$FSTYP" != "tmpfs" ]; then
>> +	_scratch_mount
>> +fi
> 
>   can you fix _scratch_mount to correctly mount casefolded tmpfs?  if
> not, provide a new local handler that will either call _scratch_mount
> directly for !tmpfs or do the correct mount for tmpfs.
> 
>> +
>> +if [ "$FSTYP" == "tmpfs" ]; then
>> +	_check_dmesg_for \
>> +		"tmpfs: Using encoding" || \
>> +		_fail "Could not mount with encoding: utf8"
>> +else
>> +	_check_dmesg_for \
>> +		"\(${sdev}\): Using encoding defined by superblock: utf8" || \
>> +		_fail "Could not mount with encoding: utf8"
>> +fi
> 
> Ugh. the kernel message should have been the same. Much better
> than special casing the test.
> 

Well, to be accurate the encoding isn't defined by the superblock in the 
case of tmpfs, so the message would be imprecise.

But I think the if wasn't needed after all, the _check_dmesg_for grep 
should be able to do fine like this:

"\(${sdev}\): Using encoding" || \
	_fail "Could not mount with encoding: utf8"


>>   
>>   test_casefold_flag_basic
>>   test_casefold_lookup
>> @@ -517,7 +526,9 @@ _check_scratch_fs
>>   
>>   # Test Strict Mode
>>   _scratch_mkfs_casefold_strict >>$seqres.full 2>&1
>> -_scratch_mount
>> +if [ "$FSTYP" != "tmpfs" ]; then
>> +	_scratch_mount
>> +fi
>>   
>>   test_strict_mode_invalid_filename
> 

