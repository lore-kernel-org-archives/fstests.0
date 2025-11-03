Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DE305E0D
	for <fstests@vger.kernel.org>; Mon,  3 Nov 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184751; cv=none; b=agdwhLUJDcz5kDuSDJ5t2baO2ee6/7WJpw7opC3n6wohRLYTaqdPaeata/rCzV3AqjWed7Fg3FIqFVP5VDg6yPMZSFFXc8zYRm47hlWImBqakrLxZzqIWqtFYMciazH8SDBqzOTjSSONYMI/GAkFgmFzmHfMsIsAXqxS8vERmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184751; c=relaxed/simple;
	bh=UNQxqyakC1b4LLogW3Nxj4H0amkiayvTCnsgPJLlTWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTd5aeGHLS3RNTFPxgYbTiTzoNMjz6yko6zS3SqJiZfSILoXu1UeN1aX18z+y365bqYjtESmgihhM04l6cuJuDqdYGmF5QoMR+z0TG0occ70ksW5xzTH+Bzrlds3uXhVgxCEplK55gG95nxIMGDzH5Dqr8SojVQXPMCGpXwW4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0oz0YLo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0oz0YLo"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b98983bb7a5so1004989a12.1
        for <fstests@vger.kernel.org>; Mon, 03 Nov 2025 07:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762184746; x=1762789546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TExBL/SuQphPlQQJDZb2a5sZOlXtbcd/UMgh4ewzF2w=;
        b=E0oz0YLott5PHViIwEdgGEga8Pqc4PkqQHSLrK/4wT/zSMXuc3H7ZarIaK8PJbTxqE
         GRgzEEs+aqOUXeAJCRWqHuRLOLN9xDhsH97REBhkYIo1Fxmz5X6z9KQht+sABjuUEl2m
         /ACr2YVLWRTI63XI8xU86GJAMF2w3/saEaRACCrT1Re+PIQEZsIo4OmP2fkOScYeuFti
         ZbhbLZEOv4I0D3m5q++J9Tyh92L8qO5yJght9vCu6o+0IwApFwPS2xleuVKw2SMCSPZ1
         wxMBdoNC2hZPFY8y5gylcZe4VX+faLvmoHATZJBDpj/2ReQ9aGmxr8zK17pa1Qdirfjn
         0+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184746; x=1762789546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TExBL/SuQphPlQQJDZb2a5sZOlXtbcd/UMgh4ewzF2w=;
        b=CDSif2zMp6h0Y+qig3thPU40GPmKsjUzzKE+xgLJtXO+xdpDGCt9bzUf6urw5v813r
         Dq3unly697iAw1IJ1FxZwYndMLxAJO+2frUR1VFqXBq1onQ8DR0kWhQhWiPT8tvmSdAS
         9WGpAviViG/dXXxYBLRWUYoLPmCC3Uz+mndsP/Z4YOTtseBd4+2mFGorz3omaFtIMFfn
         dLtKV7xE/6BYElSsquBLhu87Z7sV+McluD0j/I45Em1oXxxNB4/I1XxyB7mxRAvBVPIM
         oVf/cr4Lw2zEm9jGvUhqUbKfgFprDwJ5cScIzOakCYgrSddvCewB7vT1+wflQ7a5T4TJ
         N3Tw==
X-Gm-Message-State: AOJu0Yx9EPPM+4vESVJjnRF+8sz/pcwHcXKlf7IY8ZQIxKFLsku8L3Ch
	yQrzeMvAMhH1h6DVHCW231coWoZpy/aSmsWhG46OOsJDFQR8LM9n3JRI
X-Gm-Gg: ASbGncseF7xQJc+2tExfws1lXzK8iZLNjGIqUaB+AKUYgaXYr5pJ+iVjO/7aW3JsAkP
	bmGiojvg/WPpCtmDqLdhzkfuQzTMblVHN6V9CuVYc184DL5vMyzlngvq9VppskzyZMrdje+BMCz
	EA4t/4YWPej5Vcwlgev/rAHxMxGzoqupAjX5f/kDlmr1dE5GLNqPS4gPaF9UjXl5sG8xBmqMF0f
	G4vFjKzrGxNh/3rGNvrPx6Bzmz08MeaWCeaImgysrFuZnVjX+S1ygxaqct7HFP7EXtFje9pbpnN
	p7+d3UNqu2qTYuSA4Ucsk9K1bmHfz4LKO0DfGnU+NJWA+r7wiqC6a0Fzta1kpF0ZKEpwW+lFYe1
	tMOIlCKc+SpdC96JxS7gO/c3M7iYcUphCG/6RNhaBZLNUQCtKcmJYAr6uysAKZUnDnU44SB8tCY
	e7N9tkCucGsw==
X-Google-Smtp-Source: AGHT+IGX7fiFcI/wYFDuK59c/91G89g9joLOc3aocMfqIFDRmyFz5G0sygq7mlbKpsUx8LeaJdg6tw==
X-Received: by 2002:a17:902:d4c9:b0:295:724:c04b with SMTP id d9443c01a7336-2951a49369bmr158499745ad.35.1762184745542;
        Mon, 03 Nov 2025 07:45:45 -0800 (PST)
Received: from [192.168.0.120] ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268710a5sm126090125ad.1.2025.11.03.07.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:45:45 -0800 (PST)
Message-ID: <953a01c5-4ae4-4350-aecc-e1daf14ce307@gmail.com>
Date: Mon, 3 Nov 2025 21:15:40 +0530
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
 <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>
 <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/1/25 17:06, Zorro Lang wrote:
> On Tue, Oct 21, 2025 at 02:27:46PM +0530, Nirjhar Roy (IBM) wrote:
>> On 9/26/25 22:07, Zorro Lang wrote:
>>> On Tue, Sep 16, 2025 at 03:30:09PM +0000, Nirjhar Roy (IBM) wrote:
>>>> When this test was ran with btrfs with 64k sector/block size, it
>>>> failed with
>>>>
>>>>        QA output created by 371
>>>>        Silence is golden
>>>>       +fallocate: No space left on device
>>>>       +pwrite: No space left on device
>>>>       +fallocate: No space left on device
>>>>       +pwrite: No space left on device
>>>>       +pwrite: No space left on device
>>>>       ...
>>>>
>>>> This is what is going on:
>>>>
>>>> Let us see the following set of operations:
>>>>
>>>> --- With 4k sector size ---
>>>> $ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
>>>> $ mount /dev/loop0 /mnt1/scratch/
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>>>> wrote 83886080/83886080 bytes at offset 0
>>>> 80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)
>>>>
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>>>
>>>> $ sync
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M   82M   95M  47% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>>>> wrote 83886080/83886080 bytes at offset 0
>>>> 80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)
>>>>
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  137M   40M  78% /mnt1/scratch
>>>>
>>>> $ sync
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  162M   15M  92% /mnt1/scratch
>>>>
>>>> Now let us repeat with 64k sector size
>>>> --- With 64k sector size ---
>>>> $ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
>>>> $ mount /dev/loop0 /mnt1/scratch/
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>>>> wrote 83886080/83886080 bytes at offset 0
>>>> 80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
>>>> $
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>>>
>>>> $ sync
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  104M   95M  53% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>>>> pwrite: No space left on device
>>>>
>>>> Now, we can see that with 64k node size, 256M is not sufficient
>>>> to hold 2 files worth 80M. For 64k, we can also see that the initial
>>>> space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
>>>> because of higher node size, more metadata space is getting used.
>>>> This test requires the size of the filesystem to be at least capable
>>>> to hold 2 80M files.
>>>> Fix this by increasing the fs size from 256M to 330M.
>>> Thanks for this detailed explanation. As this's a ENOSPC test, so we
>>> must make sure this case still can uncover the original bug, before
>>> increasing the fs size. Can you make sure that? Or maybe we can replace
>>> that "80M" with a variable (according to "Avail" size).
>> Hi Filipe, Zorro, Wang,
>>
>> The original commit message of generic/371 says that this test catches some
>> excess space usage issues. Is(Are) there any patch(es) that fix this issue -
>> so that I can remove the commits and check if the test expectedly fails with
>> slightly large fssize i.e, 330M?
>>
>> I did find some related commits [1] and I ran the test with 330M and
>> 256M(the default size) after removing the commits[1] but the test passes
>> with both the filesystem sizes. So I am guessing, this is not the patch that
>> can test generic/371.
>>
>> [1] https://lore.kernel.org/linux-btrfs/cover.1610747242.git.josef@toxicpanda.com/
> Hi,
>
> I'm not familiar with btrfs patches, but from the commit history, I suspect
> it *might* be related with below commit:
>
> commit 18513091af9483ba84328d42092bd4d42a3c958f
> Author: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> Date:   Mon Jul 25 15:51:40 2016 +0800
>
>      btrfs: update btrfs_space_info's bytes_may_use timely
>
> Or "c0d2f6104e8ab2eb75e58e72494ad4b69c5227f8" :)
Thank you for the pointers. I tried running the test by checking out the 
commits before the above 2 mentioned commits, but the test seems to pass 
with the existing fs size.

--NR
>
> Thanks,
> Zorro
>
>> --NR
>>
>>> Thanks,
>>> Zorro
>>>
>>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    tests/generic/371 | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/generic/371 b/tests/generic/371
>>>> index b312c450..95af308e 100755
>>>> --- a/tests/generic/371
>>>> +++ b/tests/generic/371
>>>> @@ -19,7 +19,7 @@ _require_scratch
>>>>    _require_xfs_io_command "falloc"
>>>>    test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
>>>> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>>>> +_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
>>>>    _scratch_mount
>>>>    # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
>>>> -- 
>>>> 2.34.1
>>>>
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

