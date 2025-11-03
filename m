Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75A283FEA
	for <fstests@vger.kernel.org>; Mon,  3 Nov 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184691; cv=none; b=KEN6z7Hd51IMLMollCMAjGrEetTAxxsKfuM4/K5pABWrjxXGW8pKN2NaI9zuHkxcEDiCpmOHnaFgnjAJ6v8EchDh5S2pIg1/g7nmPuSxzHBjItoriCJ+dtgQxXgP73qNubbSytToUvUWr7i+FGLQI8NZzl61ZAXRBgZ+a4VIV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184691; c=relaxed/simple;
	bh=kYpLu1/yDrIJOwqJws/BRYf/D8WxX9d9FQZFcy8A6ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIwsnQwoE3Qi2HKglCa/5pExFqVq6tCA2Fg1Zob/XT/uI0Iqbabz9Y2XiMJm2wZdc4rzhOJ/6hGa1sxv3gElCR8M0AmZg8Ayciij9WpVS71UtY8T2IfPD+m7onQnRwTXUXjFe6iYDpgBP5G/n/knpkXHdp2k7XdFGsJtTSBLTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt5Jv1J7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt5Jv1J7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so3671657b3a.0
        for <fstests@vger.kernel.org>; Mon, 03 Nov 2025 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762184689; x=1762789489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6/myP/oJN+Ie46/1rvc3F9SMHcykmYYGVppisOD7EU=;
        b=Pt5Jv1J73GoLgMUHAejU6jwzrbbqOmx5n7XZ/HnKr81jQwKA5e+tWIewkx5qAD38gN
         0CbUsPgncfnDM5beAFj8shco9KW1UVgLvJmqKngJ04ZuSW+QVpV47av1G2O61Z5kYTLT
         90wGjqUJhgaigoHNUGgbwqUFCv0eK3a66sEydCZ8qUQFr96nFuvm9omXLruXG2WXDxcT
         oLegbWGQegcsy6drFD675gawauUvnX5/DfUx1ySELDNOfvqju/Ht++R0MNs5stHVr2ZG
         G2qTj4VfkxOPecoP/XyksHtdYOhkWx/wGaa/TiFxMnTORF+Wih3T4Pgj5lF5kKH93+Lr
         DDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184689; x=1762789489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6/myP/oJN+Ie46/1rvc3F9SMHcykmYYGVppisOD7EU=;
        b=a/YPjqzu3/wrXtlJIPELh+eUThOEWUlsGfJ+htT56dhY9S5VPzyGX1gT3kyi/HZtcy
         746IusapzjhN9tkrzz9aT3+BED7sMJ4+nGVFi3SpyOu0zq+k+15FUF7vLEvTkWfz13ZG
         AyKmqIk+S+3lEQh6w34JryfKFpKAMcVvRCorXKRI7RZapsmVMy8Vfotqv2FOzZOry0+u
         trhIZYaJU67R92OwssoSBonhHs3hM0pcZOuwyBdSKTk1w9ZeBJu1OcbKtbDkM0o2d+n2
         R1Ze50s/uU55XRdVCLclBM3ZbuMeTJJ/1HlSo5kG9DW60lCiHQzd375HLRmOdYbAExdY
         vFXw==
X-Forwarded-Encrypted: i=1; AJvYcCXllimn0cwFE7m6yHokkm/6g4aNLDQs3SqnSQ8LaC6vh+xJ35H1NLYWgs0HfeyB6OtCLJv1ZkFx@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+nRukswBL7L5Zf25iKPCOV6AjT9zPkPi4/8v28Tlodhfccvn
	Jn/Buy9gjUVchlCRyLyqVLLoOMnbb9ZR5wondwsdnRTzSr4NIxtwXlbh
X-Gm-Gg: ASbGnctnsqMsxeJErML2rYw9dfulfCIuR+3wFnGjnyh21Q1ZzGOGhKls/hzVFp/j/QB
	71DoqnwfmWtg7tVz53EKfZ43A9lFzAraMUBkoAZk4pACh3zp7NDWkVFHxFsQkno+gODqUyqErhG
	QOJuWdJunxWDFvazyttvT0LE8CEXbGiGBDWrqpZfvQ3OIhfTcyfMCjxScAlpubqA27Mbcl0Uifu
	CBfcjiigmWzengrq2K2sObQ277iQ18yW/CfmZJwrifo3K+wgFP0H5sGrPjhYtL+lz6LATY4HSqm
	wBfSeAgNNlCU5gzLYx7GWXNy4wZd5d0YtAClY8ZPyh9Yk2vBFgInMa7BLNRnMbbWh5Ckt3JBQqB
	frCZ+GB/KtyL9+5IWnHeyIXEAkvbW9irQq5TYrROVluKprANaaK94cGbImcyX0WUF6wxaFA4zcl
	8CP7MYwL97fG2j9rWWwBzucLmkSxS9VaU=
X-Google-Smtp-Source: AGHT+IHN+jzoALvXrXU7IjgCm79YS1nFFX6hMDqlVboIjwUOp1dYwbJ4PYz28Ayd8a+0OXsxnFH5Pg==
X-Received: by 2002:a05:6a00:94c1:b0:7aa:2cc6:8c38 with SMTP id d2e1a72fcca58-7aa2cc6b096mr6923041b3a.2.1762184688517;
        Mon, 03 Nov 2025 07:44:48 -0800 (PST)
Received: from [192.168.0.120] ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db197335sm11866291b3a.47.2025.11.03.07.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:44:48 -0800 (PST)
Message-ID: <8c3ac430-e992-4f1c-8560-a01e73641365@gmail.com>
Date: Mon, 3 Nov 2025 21:14:43 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] generic/371: Fix the test to be compatible block
 sizes upto 64k
To: Zorro Lang <zlang@redhat.com>
Cc: wangxg.fnst@cn.fujitsu.com, fstests@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>
 <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
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

