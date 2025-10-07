Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E5246BA8
	for <fstests@vger.kernel.org>; Tue,  7 Oct 2025 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825750; cv=none; b=Temd2PJgCZ69jfK+mKvEN7vNt5YXCj2XeZO5z3TrKEg/3tFJd2mkmfRyyDvpM+cLwUEXVV+oU6a04V1uxHsZFh448K0Ke14bSZ+mqRTwHU/01Yewt3pLDuNvHVwTnY1bSYgqAJifMWXi7xfrOmg8n0BqhOZtq/HQgACj4Yn3Vr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825750; c=relaxed/simple;
	bh=KOhg2/Tg2rM4whRj3tLBe4KVcM9Kn/yYW/3pSByYMIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIAg1qfnkphgfWlaSJEhJ6n1YXP4+se+ABxk2igF3eWUVU/oGQuju8zakrcHdTlpiFvRxJxx4Cd64nLOyhArRUqD2Yvz70he69OvMBt1eG84Kz8XpCpjLrpguBpOhPLns2Pzd9XYfB3O6JyRYpvnDs4uijLZeBXT6bbbIwuEO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzIF7o+f; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzIF7o+f"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d69771e3eso41199235ad.3
        for <fstests@vger.kernel.org>; Tue, 07 Oct 2025 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759825747; x=1760430547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRY+TAFutulMoBAvsGfTymUGeSNyswqGxaQ0nrgPwYY=;
        b=OzIF7o+fSH/k5iK2X946rc6k52r/zVnhUksAG6TzEmIJRoVkzs/akt/Bn+QKTZhYbu
         AVIWDIfPvmuGN/HrolAP9tFaCAjpT8uKxkG0VFQJHyE7Zr439zd77hTKQqcZnsGWI7sg
         y2fxFVqBuB61JaXEwDBPQUSjBcIj9TIdChLThWoeSq1TRA/YAwBAfvPGL/tF6bicMH+W
         /7nWzQxhkoP+OO2euxH62woOri8VjrxoG5LKYH3fepMLAflxfZUxs/EiKVLHoHGjUepF
         Yzd/ZsnBwxM+62MEMW9CI3zpZKbxPwwW82AH7Y2QHZuMtf0WZpQda8B/5QQMKOPKxgMM
         uTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759825747; x=1760430547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRY+TAFutulMoBAvsGfTymUGeSNyswqGxaQ0nrgPwYY=;
        b=Ep1b9xbsBQpTx8q340oQMJ/4Y7ARmzJnJQZgGJbczma45WIaDEX50dMCW0bEFTXCl1
         ARSGCSJOlrkNjx3cEsxv/Z2E054j76s6+tsFziOiwPciPkx43ajngaVIwMor1rS4InE8
         tLe5FttmQ3vDgr8HSxiBMulgjOqOTUblp80MbUGx5dTLDHd3mhzV+Cq521OD/eXCHtJi
         eSmblsN3g0nzNKiM56tmVsRDUzvgZYAarYDfiUrQz8PO6n3QBarLZ1pcAtmKsoNoMnYl
         37hGD9zLpqQJ7LHFAZX0ok8FiOnwwvAJUSAzoc5jiUIDUjX2lkycdQmU+jtOtI36Cqt9
         n1EA==
X-Gm-Message-State: AOJu0YweiZOmAXvit2SAhWDNTQq/+MgsraimdQ6ttVIyj32Fx9Njfa6r
	iiZFwAthnvMpPpDii7naiHbOy25Lze0JqisYfKLsCI4tZ/1HCykANiq0
X-Gm-Gg: ASbGncvHAWpEft1j5CnkDthSA/yMa7av4ksRtH6ElPOkVtUWAc5mPouiQBSSV4CzCkZ
	A6TjkRl36t2F/UWhQRgBXydYojnwO9A4azgWaUjtOl7dG1FcBI/GOL9U4S0krDjhDgkIp0J24I/
	lKwnNyiqn4Qmz4QLmZW4hm58YE+tvY0qHQQSvhLpQXZk8stLB2v3/pbNytNUvQKspB3rdkjmJbo
	cjVyougcAKHNbe7pTa1Pgptb255Ue5ifKFa6PR7J80sapWTC33NpkLdOtSaTausectNNHqkoU23
	OQBYYlUSYUccFUAxPbKhsw/Lq02BgokXgf0JlaBcOQiep5s6b8lqG9oYWlEhvWtR81gHmpeL87I
	uSgyi0Wz6JAspLb7IOo776x3jOoq+2tJkT1NUlkHET+pTnj7qcOjoopzRGcp8Bzpla7UPtYr0t2
	3OO5raSMcWePy6yU3Z7zZyNzpVuxvh
X-Google-Smtp-Source: AGHT+IEIzp4V8bwn6tA6SqYcgJGCgoG95S8yeo43nQdg9ldIEzXo0RHyhBqXcMUCT2Uw2Y+WZeMCEw==
X-Received: by 2002:a17:902:dad0:b0:261:1521:17a8 with SMTP id d9443c01a7336-28e9a565b4emr185999035ad.16.1759825747061;
        Tue, 07 Oct 2025 01:29:07 -0700 (PDT)
Received: from ?IPV6:2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5? ([2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a68deasm13326859a91.25.2025.10.07.01.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 01:29:06 -0700 (PDT)
Message-ID: <86b3c5c5-82ec-4083-9f1c-ac3fc11b0d57@gmail.com>
Date: Tue, 7 Oct 2025 13:59:02 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] generic/562: Make test compatible with block sizes
 till 64k
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>, fdmanana@kernel.org
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <b3ce6c555b0a04f6c8cca08ab36e3b0068abbbb2.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926165421.k7n3m6o2nuscarkq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250926165421.k7n3m6o2nuscarkq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/26/25 22:24, Zorro Lang wrote:
> On Tue, Sep 16, 2025 at 03:30:10PM +0000, Nirjhar Roy (IBM) wrote:
>> This test fails with 64k sector size in btrfs. The reason for
>> this is the need for additional space because of COW. When
>> the reflink/clone of file bar into file foo is done, there
>> is no additional space left for COW - the reason is that the
>> metadata space usage is much higher with 64k node size.
>> In order to verify this, I instrumented the test script and
>> disabled COW for file foo and bar and the test passes in 64k
>> (and runs faster too).
>>
>> With 64k sector and node size (COW enabled)
>> After pwriting foo and bar and before filling up the fs
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop1      512M  324M  3.0M 100% /mnt1/scratch
>> After filling up the fs
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop1      512M  441M  3.0M 100% /mnt1/scratch
>>
>> With 64k sector and node size (COW disabled)
>> After pwriting foo and bar and before filling up the fs
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop1      512M  224M  231M  50% /mnt1/scratch
>> After filling up the fs
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/loop1      512M  424M   31M  94% /mnt1/scratch
>>
>> As we can see, with COW, the fs is completely full after
>> filling up the fs but with COW disabled, we have some
>> space left.
>>
>> Fix this by increasing the fs size to 590M so that even with
>> 64k node size and COW enabled, reflink has enough space to
>> continue.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/generic/562 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/562 b/tests/generic/562
>> index 03a66ff2..b9562730 100755
>> --- a/tests/generic/562
>> +++ b/tests/generic/562
>> @@ -22,7 +22,7 @@ _require_scratch_reflink
>>   _require_test_program "punch-alternating"
>>   _require_xfs_io_command "fpunch"
>>   
>> -_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
>> +_scratch_mkfs_sized $((590 * 1024 * 1024)) >>$seqres.full 2>&1
> Filipe is the author of this test case, if he can help to make sure
> the 512MiB fs size isn't the necessary condition to reproduce the
> original bug he tried to uncover, I'm good to have this change, even
> change to bigger size :)

Okay, I will wait for Filipe's comment on this change. Thank you.

--NR

>
> Thanks,
> Zorro
>
>>   _scratch_mount
>>   
>>   file_size=$(( 200 * 1024 * 1024 )) # 200Mb
>> -- 
>> 2.34.1
>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

