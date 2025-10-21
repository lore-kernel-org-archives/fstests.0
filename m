Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0232A3FE
	for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037232; cv=none; b=PfauMu0SMCLxkIImu9IsqL3H85j3aUwR2iZnD3JgyYidGTH+iJOVHWpPK6l/lu3QowAIDHgxWwOPooevf2qHQaRVWUZqxB+g11RIOTZZ9jNaPMImXqGh8pZAw5MBxiQuneZ39lWIpkOXbB3JQx0NePl0xqtHq+GZoR6R7M0JklY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037232; c=relaxed/simple;
	bh=UmwZAZQjV8eTDOxDrwhOqKnxRb7y5QbqinaWvjyuQCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1DhXBhNKD13adSexqXDUu4Vu4kQvJMMVSVsusfqa8orCVi3xMRNR/8J4m/18zzlFXQsse862xQFLxV852wu/Bbmw1VRKP1urb/PB9r5e5w/4j/wwFABhj7o1IgqdQXplDxN8MoAACReInPDaIJTjDot7bcKxNuvNlHI3v5z9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtFv28Js; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtFv28Js"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so4066990a91.0
        for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761037230; x=1761642030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7MHT0KvXR3ynnsp4FuoYsWXqdsukeWYiZ23hKRdJUg=;
        b=UtFv28Js8pUNRexcDVsENIhDjYeJqKVronYs5uJuYGp7KuU8wsNfa/azafOlEGeVQx
         ProtNvaCgFKdJxhxGvBGg4ch/WUq3zKf5qf/6a6YEYrHOQovNUyu0Ox2I4AqNhqJLZ8u
         fy4DMHs+7NoCPxx6+JKO5ktTdtpR4XbIqpUhLTRy8FG1GWgDiNqwvMsWV7rXyFVQpeq8
         ZdoP++LJ7AkHS7Dei9vvmbFPz60+uVhbewkuSzOFpR9tV4jfjKtSgsmThHSHIImvrcIE
         v980+/xksR4MC0SDDGe5kLIDJdv20bgq/1IqF02YFTaqxwS9H3XDaRcsANJ0BXn7pZUB
         tPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037230; x=1761642030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7MHT0KvXR3ynnsp4FuoYsWXqdsukeWYiZ23hKRdJUg=;
        b=HyC0SJoq4xsrXP6VgoNybK1btj4vt9EVmlnjDvNb5q/KJ7vqGQ9kiTGI52e5cfd6mm
         CyBw6dxrSuTR0prUx/UtJ6vX8vxuM8Rb8nBJYhA+NWm0jgSJnNtrJe3LyVI6gdAjk1eg
         CU6wVNyhM4kwVrjMAtBcmpCe7hnpsvZaBN902VmPQpo/ACXHNsyszxjgroEaWm1Ximkz
         14ZRr2/umAtM1UjVIJ0v/gBTN9S9/UMxfhCEqr2Lt7sp3lDRhuXH7kC3xYhsbPs8jqOu
         Uaq1JPfJh4sI98S8ves2b45WWkV4C3pAibE66yGTNtsECBpYvl+F0Z1qa9i4OU2KNVTG
         SCTg==
X-Gm-Message-State: AOJu0YyCW7L1+Gl0JdnkLzQZSHJ3bx5DDF1JA+bC9rpaOZHM2O/AB2Os
	kbDFmHhxYA6ODVx37QJqcov3UNmYYJjBWbCKm/PUeKe4P2BqzQP2bwjO
X-Gm-Gg: ASbGnctSNoETbtTu6tMayujzzl+StCd8bEzKdYCWSInL/1YAleBBfBHYTMPrNiJ8E6i
	3c1i5hIWsFeektd3KNru+r7kbZ8k17TK/A3b9+w4/yaFPH/TqcB8BcEiOE++e3IM/uWVZmRTYZh
	RurgpBN6jjQIK+u250tKy5dO8WrpaLXrDbmH1AFAjFW/qx/dUtC9mWOqfBjiL5RnZyNHuWA6DWJ
	yIHa//pjfuesgPHPbk52xNQasMQXZ9VyFRIHY0deTji1EPUFkqwy4OYuTXLBsBD/JsAAG3BvjIX
	M+w6XV9gd/Wru/DbE0dWV4QTgUgwe5CKcXQHJUbuxRumqearUebYgiu0B1/iCBwh0ogd621g7Yn
	L1sSyjE2036lRWI8VtCvxlBA6cjRHpQYEjGHzazT1pxXcI0orp+mzDDLtWo3TmkC6/awCUCwSpy
	rr9xDzTppcKuc=
X-Google-Smtp-Source: AGHT+IHzZnJKM1ivuovAO61aY55fZ++dxl1l6ThxUDA1px+CpvV+tRSPQbz7tvUCpvK4lh4KJ9Detg==
X-Received: by 2002:a17:90b:5111:b0:33b:c5ce:3cb0 with SMTP id 98e67ed59e1d1-33bcf8e4560mr22678536a91.20.1761037229477;
        Tue, 21 Oct 2025 02:00:29 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.204.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de09fa4sm10324622a91.7.2025.10.21.02.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:00:28 -0700 (PDT)
Message-ID: <52024246-43ca-4f2a-bbcd-0db1c2d16578@gmail.com>
Date: Tue, 21 Oct 2025 14:30:24 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] generic/371: Fix the test to be compatible block
 sizes upto 64k
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, fdmanana@kernel.org, quwenruo.btrfs@gmx.com,
 zlang@kernel.org
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/26/25 22:07, Zorro Lang wrote:
> On Tue, Sep 16, 2025 at 03:30:09PM +0000, Nirjhar Roy (IBM) wrote:
>> When this test was ran with btrfs with 64k sector/block size, it
>> failed with
>>
>>       QA output created by 371
>>       Silence is golden
>>      +fallocate: No space left on device
>>      +pwrite: No space left on device
>>      +fallocate: No space left on device
>>      +pwrite: No space left on device
>>      +pwrite: No space left on device
>>      ...
>>
>> This is what is going on:
>>
>> Let us see the following set of operations:
>>
>> --- With 4k sector size ---
>> $ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
>> $ mount /dev/loop0 /mnt1/scratch/
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>
>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>> wrote 83886080/83886080 bytes at offset 0
>> 80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)
>>
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>
>> $ sync
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M   82M   95M  47% /mnt1/scratch
>>
>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>> wrote 83886080/83886080 bytes at offset 0
>> 80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)
>>
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M  137M   40M  78% /mnt1/scratch
>>
>> $ sync
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M  162M   15M  92% /mnt1/scratch
>>
>> Now let us repeat with 64k sector size
>> --- With 64k sector size ---
>> $ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
>> $ mount /dev/loop0 /mnt1/scratch/
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>
>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>> wrote 83886080/83886080 bytes at offset 0
>> 80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
>> $
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>
>> $ sync
>> $ df -h /dev/loop0
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop0      256M  104M   95M  53% /mnt1/scratch
>>
>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>> pwrite: No space left on device
>>
>> Now, we can see that with 64k node size, 256M is not sufficient
>> to hold 2 files worth 80M. For 64k, we can also see that the initial
>> space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
>> because of higher node size, more metadata space is getting used.
>> This test requires the size of the filesystem to be at least capable
>> to hold 2 80M files.
>> Fix this by increasing the fs size from 256M to 330M.
> Thanks for this detailed explanation. As this's a ENOSPC test, so we
> must make sure this case still can uncover the original bug, before
> increasing the fs size. Can you make sure that? Or maybe we can replace
> that "80M" with a variable (according to "Avail" size).
Hi Filipe, Zorro

The original commit message of generic/371 says that this test catches 
some excess space usage issues. Is(Are) there any patch(es) that fix 
this issue - so that I can remove the commits and check if the test 
expectedly fails with slightly large fssize i.e, 330M?

I did find some related commits [1] and I ran the test with 330M and 
256M(the default size) after removing the commits[1] but the test passes 
with both the filesystem sizes. So I am guessing, this is not the patch 
that can test generic/371.

[1] 
https://lore.kernel.org/linux-btrfs/cover.1610747242.git.josef@toxicpanda.com/ 


--NR
>
> Thanks,
> Zorro
>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/generic/371 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/371 b/tests/generic/371
>> index b312c450..95af308e 100755
>> --- a/tests/generic/371
>> +++ b/tests/generic/371
>> @@ -19,7 +19,7 @@ _require_scratch
>>   _require_xfs_io_command "falloc"
>>   test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
>>   
>> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>> +_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
>>   _scratch_mount
>>   
>>   # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
>> -- 
>> 2.34.1
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

