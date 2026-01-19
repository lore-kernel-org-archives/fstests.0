Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAEA26B76A
	for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799499; cv=none; b=kLbm3pcOlXBeBR1WSHL2sPTAo90rANBWDjicQKkrcXS/dO0sBLvWt4uBfvgMfJhp97uI1mbvXjoTipSeSOWUKZZrto12fBUFoYSsh4HLsPhGbDJE7mW5lBUMLfEp2GAHJ4ds+emTFAoN5oJ+Y6v0/KO6uOMgJoRxlWLWJE4ylaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799499; c=relaxed/simple;
	bh=CnDmtDYmRluV5xNZH0mkFhvbczIDDWXNbGlwYZDuiPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9SED9yrcVWXClvTdl476W2n7NnjtVRWINovR0uPkyspvxy5b942zaLE13e4QazhjmrPEr3XbKTDDZceSDwbWeHMPqVYwC1GAUBp46Qx1FOFOCJMdJPB8yksTzjKyinnyQgZnTh68Vt2DkIV33K2Z9ORGND//bcEYBedl1ewpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIuRa4/G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIuRa4/G"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0a95200e8so25000745ad.0
        for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 21:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768799497; x=1769404297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AakCd/wUCLSL/4M3N3eE0riIT13BjOzkdwfw/2Sys2A=;
        b=dIuRa4/GBHDP4dq8N1rUdofVas5cvWQYrYPrw7NUsoc4LQ1vCHecVjD4Mmp01hhX2B
         wj73HAW3yDE9ge6n+8K0RBJquMCdd8KPvedI9FpT9smwaN0/H2WjKsi3TscOvyF5cVIn
         j3RdnRz1Yxh913NdOpPREKR+1RM4Win88UgdvLFxBGrUR7+O1R4lQWYYfFOnFMz3T2Xj
         gYYaexnnH/Tgy9mOh9B72feskLM4Abz9y+UCAIp5bmNram3veZHGGlnEulmSfOQaH873
         TVb3Ryo/zEbSWWhX/9mySSE2oJ18pRVmffIvqtMVBP8no+nIvZhK3fjMEqtIxZjf22Tq
         +p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768799497; x=1769404297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AakCd/wUCLSL/4M3N3eE0riIT13BjOzkdwfw/2Sys2A=;
        b=pF34m2kSK7qD4wIzMV61mWy2s8sB/ze6uHyc0dDhSBNw4S6UMDf1liQ4h42RMJECPW
         hizYDxpOxaGBHzkoIvVjygKsIfYtjsYUqwlYl8VfAhv7Vg/k59pkE0fJZSeiGKP4GpKi
         qwDYS6vZ8Z4/V0tVln01Zd5vFfhT/U6HmISQhbhRcEGcyqmvj/RoYyBaFG5DbU6X3XHI
         FwPY3caED70oC6PsoMixJgsAsnvao3IrwVDEDXwYhP+N+6T7rmgZOcyjgCKaDIowgiAf
         TF9LIRS17qLO1/ulFxSjwCO5r6IwqkwXL4Ur9cmreeF3tc0F/ALhUu8fC/XDe06fXwCY
         k7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEcovdD8Gro1Nz2SM2dOxcjlq9yO/bg6s+cxfNzkiHMsE8VFfrObRlTMIf7qsTxob/Jn/dd3nK@vger.kernel.org
X-Gm-Message-State: AOJu0YwMpU1lI5KeuCApfLoS2uPebiGcSJS6deHozJgoJkNzU6611zg3
	9qJY7d02j9I59dPYk9o0h8V2Knqhl6ATjxm7SHu+0lHyY+Jcmywo2KJj
X-Gm-Gg: AZuq6aKzhbisopjuzEZPpGwshAJoWxOMQpAeTkVIZYpVt7f34VsfkSjeJYwh8yIZkM0
	IIHGntZXR6RTLqZblSgEBi3uz1kS8LY57/DVaOHSQNpAayC3UBDITaPSbug4K0NJnyeONf1wDtc
	5FIL97qKn1Ab0F3dCNXmseCLatYYprD92+qqUnupNpy8JfvcbcYW97o4HMVuvuyK3PuMROw4sOd
	SO2vkrfZcE95WCLzxGAJmxiayu2nBq68Z0wG9x3Z9b5k2g9fGgXdc8Ze1xfd+KRM0NzsN9U1OmK
	V7M0pu6WmJa40A76yRgdKYt8O+VYUtODEN4oqWP/hEukC5afkt4FCXKaioPYCAUNtnqXC60rdKh
	+zKlb9RrhWlteXaQFQ7wQnjFGCArrhz/Y3vX1VvEqikDXk+Uka1+FQcvSgHmEZL4D5Cr8XFVDWF
	c1SqrfxDS0jwVtB/Wg4W4ZIzoDfX8Dt9MN
X-Received: by 2002:a17:902:f54a:b0:2a5:8d30:58f7 with SMTP id d9443c01a7336-2a71751652bmr101027235ad.17.1768799497392;
        Sun, 18 Jan 2026 21:11:37 -0800 (PST)
Received: from [192.168.0.120] ([49.207.204.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dcd00sm82485985ad.65.2026.01.18.21.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 21:11:36 -0800 (PST)
Message-ID: <85d826e9-c7c4-4d5b-86c1-d1ee4135a76f@gmail.com>
Date: Mon, 19 Jan 2026 10:41:32 +0530
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
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>
 <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <b3d93d75-9c39-44ac-9c7e-0346b3a970cf@gmail.com>
 <20260118182213.sfd4k6zq6olmf6ez@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20260118182213.sfd4k6zq6olmf6ez@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/18/26 23:52, Zorro Lang wrote:
> On Mon, Dec 15, 2025 at 10:34:14AM +0530, Nirjhar Roy (IBM) wrote:
>> On 11/1/25 17:06, Zorro Lang wrote:
>>> On Tue, Oct 21, 2025 at 02:27:46PM +0530, Nirjhar Roy (IBM) wrote:
>>>> On 9/26/25 22:07, Zorro Lang wrote:
>>>>> On Tue, Sep 16, 2025 at 03:30:09PM +0000, Nirjhar Roy (IBM) wrote:
>>>>>> When this test was ran with btrfs with 64k sector/block size, it
>>>>>> failed with
>>>>>>
>>>>>>         QA output created by 371
>>>>>>         Silence is golden
>>>>>>        +fallocate: No space left on device
>>>>>>        +pwrite: No space left on device
>>>>>>        +fallocate: No space left on device
>>>>>>        +pwrite: No space left on device
>>>>>>        +pwrite: No space left on device
>>>>>>        ...
>>>>>>
>>>>>> This is what is going on:
>>>>>>
>>>>>> Let us see the following set of operations:
>>>>>>
>>>>>> --- With 4k sector size ---
>>>>>> $ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
>>>>>> $ mount /dev/loop0 /mnt1/scratch/
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>>>>>
>>>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>>>>>> wrote 83886080/83886080 bytes at offset 0
>>>>>> 80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)
>>>>>>
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>>>>>
>>>>>> $ sync
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M   82M   95M  47% /mnt1/scratch
>>>>>>
>>>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>>>>>> wrote 83886080/83886080 bytes at offset 0
>>>>>> 80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)
>>>>>>
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M  137M   40M  78% /mnt1/scratch
>>>>>>
>>>>>> $ sync
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M  162M   15M  92% /mnt1/scratch
>>>>>>
>>>>>> Now let us repeat with 64k sector size
>>>>>> --- With 64k sector size ---
>>>>>> $ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
>>>>>> $ mount /dev/loop0 /mnt1/scratch/
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>>>>>
>>>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>>>>>> wrote 83886080/83886080 bytes at offset 0
>>>>>> 80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
>>>>>> $
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>>>>>
>>>>>> $ sync
>>>>>> $ df -h /dev/loop0
>>>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>>>> /dev/loop0      256M  104M   95M  53% /mnt1/scratch
>>>>>>
>>>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>>>>>> pwrite: No space left on device
>>>>>>
>>>>>> Now, we can see that with 64k node size, 256M is not sufficient
>>>>>> to hold 2 files worth 80M. For 64k, we can also see that the initial
>>>>>> space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
>>>>>> because of higher node size, more metadata space is getting used.
>>>>>> This test requires the size of the filesystem to be at least capable
>>>>>> to hold 2 80M files.
>>>>>> Fix this by increasing the fs size from 256M to 330M.
>>>>> Thanks for this detailed explanation. As this's a ENOSPC test, so we
>>>>> must make sure this case still can uncover the original bug, before
>>>>> increasing the fs size. Can you make sure that? Or maybe we can replace
>>>>> that "80M" with a variable (according to "Avail" size).
>>>> Hi Filipe, Zorro, Wang,
>>>>
>>>> The original commit message of generic/371 says that this test catches some
>>>> excess space usage issues. Is(Are) there any patch(es) that fix this issue -
>>>> so that I can remove the commits and check if the test expectedly fails with
>>>> slightly large fssize i.e, 330M?
>>>>
>>>> I did find some related commits [1] and I ran the test with 330M and
>>>> 256M(the default size) after removing the commits[1] but the test passes
>>>> with both the filesystem sizes. So I am guessing, this is not the patch that
>>>> can test generic/371.
>>>>
>>>> [1] https://lore.kernel.org/linux-btrfs/cover.1610747242.git.josef@toxicpanda.com/
>>> Hi,
>>>
>>> I'm not familiar with btrfs patches, but from the commit history, I suspect
>>> it *might* be related with below commit:
>>>
>>> commit 18513091af9483ba84328d42092bd4d42a3c958f
>>> Author: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>>> Date:   Mon Jul 25 15:51:40 2016 +0800
>>>
>>>       btrfs: update btrfs_space_info's bytes_may_use timely
>>>
>>> Or "c0d2f6104e8ab2eb75e58e72494ad4b69c5227f8" :)
>>>
>>> Thanks,
>>> Zorro
>> Hi Zorro, Filipe and Qu
>>
>> Thank you for the pointers. I tried running the test reverting the above 2
>> mentioned commits, but the test seems to pass without these commits, so
>> probably these are not the ones. I am not able to find any other relevant
>> commits and the test case is also very old. Any further ideas?
> Thanks, I don't have any objection on this patch now :) As this patchset still
> has unresolved review points from btrfs list, I think you can change and resend
> this patchset to get further reviewing.

I have already re-sent this patchset excluding this particular patch, 
and the rest of patches are merged (i.e, the changes for generic/562, 
btrfs/{200, 290}. Only this one is left.

--NR

>
> Thanks,
> Zorro
>
>> --NR
>>
>>>> --NR
>>>>
>>>>> Thanks,
>>>>> Zorro
>>>>>
>>>>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>>>> ---
>>>>>>     tests/generic/371 | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tests/generic/371 b/tests/generic/371
>>>>>> index b312c450..95af308e 100755
>>>>>> --- a/tests/generic/371
>>>>>> +++ b/tests/generic/371
>>>>>> @@ -19,7 +19,7 @@ _require_scratch
>>>>>>     _require_xfs_io_command "falloc"
>>>>>>     test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
>>>>>> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>>>>>> +_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
>>>>>>     _scratch_mount
>>>>>>     # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>> -- 
>>>> Nirjhar Roy
>>>> Linux Kernel Developer
>>>> IBM, Bangalore
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

