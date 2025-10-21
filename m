Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA71C5F13
	for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037075; cv=none; b=cG8/0GnaN6TkWmL4MeIpZeh9QFDfy4PbiVKzFP+sRzqcWp5YNl2/gj0uoKM4FiFkxghyME1LYl87lvG659JTLYWwrqFV+v9WR1dh61cvjuyc1SgdteP5/EEHqaeD9Df8ziW8HPCzPemB9pFF4zZ8X0Hq714R7X23oMmNrHopAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037075; c=relaxed/simple;
	bh=1e1ihDwZHghHuhWzzlAKe2jL67xtUJUzP939PcqfMjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bk5D/SOHrZwokH4MvZQzZI3Z1+5ekut8Tlt94xCOuqTA2CIs4NbYVgjERoXhFzveRV82Re3aelwAZEZmG5Q+ewUiz0Tp9oVHKoNwJvpsoG4L1C/owCuUEwaN2HP0YiWhvw73YaNMvtc1dkl+a2PztjoImBCmgQNaO6zBsBJd4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jE/6H5qq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE/6H5qq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781997d195aso4052600b3a.3
        for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761037073; x=1761641873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZTtuzKa6CdYAxQu3rJsEsQntQmQEkeFJxErmgREFM0=;
        b=jE/6H5qqcJBz5xOJmVcD7ZvA4dWCkIo9K63//RFBWNX/HcxGaxSXNHzl4bObS1cCMr
         8O923HB731sSo1TMJeblAm+OSHA8p25T6+j4Avnsqiln8DBwFOTAyQRwUJr1J3MDZB+T
         96E85D8P+fAEGYYxPq4APEDl95NPIqmknY2saeWdWNrQqYZuooSt1+7ADGhiV22bl8S9
         hi3Sf0l1Uy+ulWgVEDRwGkWhTz/LKLJ9sePr/36MxKeYDtZPDbuOvTlfI7IWeKMkW7Rj
         Hu7iddzfiucLJRqrPNtiHY08klK2PQDKOfZwDTAroXZ8GHrx4s7rh8RLt7YzRk3ujWvz
         E1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037073; x=1761641873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZTtuzKa6CdYAxQu3rJsEsQntQmQEkeFJxErmgREFM0=;
        b=vwnHWQkPzH9GmGXyTej4RMZiI2UJhU3VTIR6ce72bVOif3N7bMxMAjWFAruVMGatnK
         sbOJDtkvIaUnTTEZaFWeO7RQLcovK6xHbOb4madsdChZIZFMk/M2VTlvGgBMoyMPQLxj
         4SFdPZnP8WdnidftTZSwjKd9/1XiJbtX0gOOM24wgvUK4aaS4/97EkJ5u2bXImDtWVju
         9u3RXgdTnOOYM+8Ki1AQweiroYIr7/UeYXmYOzmi4hI5f2aPGZ5wFKAuOELHbX4QBdHx
         DHLuCafwtskqzSfsQSi3/9rN7med4YbiEoaJfYkzyslzjWJC5CCcx9bhsJmMPHEeeE9r
         VtLg==
X-Gm-Message-State: AOJu0YzBZHiL3WZZafLMdaioA71igtBADsBrExTK8t26Qd0vTknd9hnf
	1Z9w5uSdy9j37qYq/nhb7jfcO/8qOYRtJ6y10xgqQ2SscjH2QSrkgub+
X-Gm-Gg: ASbGncvMLv1wfezphuLFYLrEViOXT3oQAE3vamz/iIvgzGdeJcnnJ0dEsBi0O6roAKr
	/s+LhWlk/e7diWOQkqC8K3LBkmi0fOSxBqJ4kedSRIRkxe9xkrklwoeBFFBvbbrGFe3ZvrnPOG9
	TXAraR/xRie7b8yFVwt5ThkS35ZXMWeO84tom/1Q6TpcA10Dut8NsvwA+Dy9sZyvdqvBguWhWKE
	F2UPVqS6yFZNlT4h9tI0yf5AEm9m4uIUFj4eMAShwDMyrHVgrHg9WR33+XZUiMMI9GbtBl5aKgK
	ZG7g3rChUAaRPxAYfF1hOr0vM9RF1a1iQoI6yhUGx7qsDDBp9t8louFIDkrw3JkB2pRfrI7i1dX
	1a+ARDJVtqBTuE329n+LmAUNySmSs/a9gJRqknun6EkvQBeq0BRkheepVwr7zf4LWjOYQI5+3Pk
	NzUnQBIAWJITU=
X-Google-Smtp-Source: AGHT+IF0MWgGxg9kM0+tOuvmqoJLupdod1ogKlkPu163y6433lgybX9afHQMNUAkae/9laUUAPV2Cg==
X-Received: by 2002:a05:6a20:3d8b:b0:2d5:e559:d23a with SMTP id adf61e73a8af0-334a863a3e9mr20861925637.55.1761037073272;
        Tue, 21 Oct 2025 01:57:53 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.204.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664b30dsm9552325a12.7.2025.10.21.01.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:57:51 -0700 (PDT)
Message-ID: <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>
Date: Tue, 21 Oct 2025 14:27:46 +0530
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
To: Zorro Lang <zlang@redhat.com>, wangxg.fnst@cn.fujitsu.com
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

Hi Filipe, Zorro, Wang,

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

