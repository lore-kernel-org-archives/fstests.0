Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998F2D29CE
	for <fstests@vger.kernel.org>; Tue,  7 Oct 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825697; cv=none; b=dzJzVgglux8W65jOQjaVNZ4H9znjTwA9fnFJOW35qXPp0i3+IRb/yDiLhRdCGjyP03p22LYXSVVvbJywkdD2HbITazSEHeM64oBnEbXeRo55Yq2hipg7osWRZdwtUOO7ItePrAsSJzfRTmG8jkL/1vZ+wYMXCpWkQg5QmSzwEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825697; c=relaxed/simple;
	bh=9WY07egGlgn6C7h6Yg9yeGZ1u6vylq7iznqS6n+qlsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vul12e7Uwaxxfb8Fc42CvL62wrn69Jxr2MxA9NyCJpQKeJqiL698iyvpOr/5ES6LmvVP0ht0iDX3IcAKk0+Y5b0rg9fYaJsvTanDewnLqJNSnAs8tmjUFgN3qzuHEh/tSRRY8aFPRjrGeBO2bDSlS5uZZ+UgO5zOwsmaNOC/iZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0s7CDlW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0s7CDlW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d2c35c459so43116685ad.0
        for <fstests@vger.kernel.org>; Tue, 07 Oct 2025 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759825695; x=1760430495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11qzUeHYpQDkpnFHLPlq2ZOani7O3G9RsrHCsLGYTpA=;
        b=A0s7CDlWDV1cg6sw5EF3aViWrIVaPsVI2AvAK6rHaaQsnqewm1bo4s36LvrqscDZ3a
         x9594VInkTAF8izzV0eIjzkdy8NAeG0IiyP8278mBXY+xWw+4R2LM7dZ4Q6wgYIY4XFC
         +K+pKXQ80EWJAF3QnB/B1WkgtKN3lUP6iE0MImFAiWCXLzA7KUhhZdM/782WWMrsiMSt
         v8zIGB9edKlJX+yaTwqa2sc6gqZ5jm7Hv+7jPBBNLGsYovaZQgHYokAloukb7mx2bR6n
         jL7yZSULP9XBsOhd0ZZodE8SV8DqbG6MSBT4SSCu09vT28Gp9KJ7EoJ0rOErDTOUpxBt
         XvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759825695; x=1760430495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11qzUeHYpQDkpnFHLPlq2ZOani7O3G9RsrHCsLGYTpA=;
        b=fNsCZ7a6LM6wDy+Fut9RM778BlMEoIeJwh+xW75V+AEI/nb252ZjGDHhBFBocO/4Gp
         wAgntOCcUcgsEayI+0KomSdhDwR4omjCIQJO05TVi92AD2dXP73n99jRLlDpDHnlXPSF
         a6HtVspEiYjDrz+unDZopOMP7odgWuXo92upyjGyY2cwp6BEwOCdZLO2G5wCcc75x9qG
         1cyRTTSK3Ps0iR1CgEBKTic7Zf9NuVDfaEi4RI7/iu5sVRG3nSQ/lO2nQZhNKU2R6XtK
         DWFE+8jeFNu8pQymY5MQY/YdvZbQ+WOa0iB+/vizdRoIHJz4kSteJLJ0ElUhbhbXVvzu
         4Lqw==
X-Gm-Message-State: AOJu0YwsXUGKzRgKw6WXZ09rw8Kz3CZOePV9KvFpvrK3zStVslb5Z4dW
	nN1AYl5lsW7cG9mSUnr9YzICiEL0kvNFR7kRB/O6dYAblekeGNTf45ho
X-Gm-Gg: ASbGncvhc18GJGQwFXxitpaIrSI7nN4Z47hsVxjLvfysIo0xVmcX1x/OK8xhlhQh7Y4
	lI2Tu2psrBP0vXMpCA1ve7mb650saErjcSPDuWuuRvyOmM2v5dhKXwCmkjMkOSoMBM9fQYoXD7X
	Rs/3bzNgWCBINWPRDmgGn0iGbZUJUYnemubGWKLoTdBNYafD0AasoZSg0g1pCWbrtQ+fHG1h3WE
	Y1GmkN6inEYIQmM7Tr3UJKF5W/hzpH/hYt8r3Z1rzfDnE6RN4oYm5GBYWEsULTjOKYnHzU4waal
	r+iPksEPBdmLhFrfR4vxoEWNOVNbZqY2O2flYTW7RWwr9uU404mvZk6bAB81VEtNaxMd+pHdI3z
	B1xcTaWyJdk3rtPLhEg2JLIy3L14iJDRbhzPK92kKyRN3pvDYwiAD2klfQuWsY4/G7x/Ssu+x5k
	3jKW0Za3B2ig+gqgosGJSFJJpWe65v
X-Google-Smtp-Source: AGHT+IFcrbY5SBkUzr6BtX6NlpHaZqeVAKBgEw2mJfPb1b+8C24j2n/5WJaoOXQjmdeJy2B3VCGCwA==
X-Received: by 2002:a17:903:178e:b0:274:6d95:99d2 with SMTP id d9443c01a7336-28e9a6a90e8mr175572575ad.39.1759825695365;
        Tue, 07 Oct 2025 01:28:15 -0700 (PDT)
Received: from ?IPV6:2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5? ([2405:201:d006:804f:3dc3:e5b1:3dc8:9cf5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff0d4esm19325832a91.17.2025.10.07.01.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 01:28:14 -0700 (PDT)
Message-ID: <17426fc6-294e-4c14-b2b0-4591c15251e5@gmail.com>
Date: Tue, 7 Oct 2025 13:58:10 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs/200: Make the test compatible with all
 supported block sizes
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, fdmanana@kernel.org, quwenruo.btrfs@gmx.com,
 zlang@kernel.org
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <c93a0f1885721e7bc2800094fafb7fd7bd2c607b.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926173815.wmyvfjxckwhnvu3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250926173815.wmyvfjxckwhnvu3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/26/25 23:08, Zorro Lang wrote:
> On Tue, Sep 16, 2025 at 03:30:11PM +0000, Nirjhar Roy (IBM) wrote:
>> This test fails on 64k block size with the following error:
>>
>>       At snapshot incr
>>       OK
>>       OK
>>      +File foo does not have 2 shared extents in the base snapshot
>>      +/mnt/scratch/base/foo:
>>      +   0: [0..255]: 26624..26879
>>      +File foo does not have 2 shared extents in the incr snapshot
>>
>> So, basically after btrfs receive, the file /mnt/scratch/base/foo
>> doesn't have any shared extents in the base snapshot.
>> The reason is that during btrfs send, the extents are not cloned
>> and instead they are written.
>> The following condition is responsible for the above behavior
>>
>> in function clone_range():
>>
>> 	/*
>> 	 * Prevent cloning from a zero offset with a length matching the sector
>> 	 * size because in some scenarios this will make the receiver fail.
>> 	 *
>> 	 * For example, if in the source filesystem the extent at offset 0
>> 	 * has a length of sectorsize and it was written using direct IO, then
>> 	 * it can never be an inline extent (even if compression is enabled).
>> 	 * Then this extent can be cloned in the original filesystem to a non
>> 	 * zero file offset, but it may not be possible to clone in the
>> 	 * destination filesystem because it can be inlined due to compression
>> 	 * on the destination filesystem (as the receiver's write operations are
>> 	 * always done using buffered IO). The same happens when the original
>> 	 * filesystem does not have compression enabled but the destination
>> 	 * filesystem has.
>> 	 */
>> 	if (clone_root->offset == 0 &&
>> 	    len == sctx->send_root->fs_info->sectorsize)
>> 		return send_extent_data(sctx, dst_path, offset, len);
>>
>> Since we are cloning from the first half [0 to 64k), clone_root->offset = 0
>> and len = 64k which is the sectorsize (sctx->send_root->fs_info->sectorsize).
>> Fix this by increasing the file size and offsets to 128k so that
>> len == sctx->send_root->fs_info->sectorsize is not true.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/btrfs/200     | 8 ++++----
>>   tests/btrfs/200.out | 8 ++++----
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/tests/btrfs/200 b/tests/btrfs/200
>> index e62937a4..b53955ce 100755
>> --- a/tests/btrfs/200
>> +++ b/tests/btrfs/200
>> @@ -38,14 +38,14 @@ _scratch_mount
>>   # Create our first test file, which has an extent that is shared only with
>>   # itself and no other files. We want to verify a full send operation will
>>   # clone the extent.
>> -$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
>> +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 128K 0 128K" $SCRATCH_MNT/foo \
> This change and explanation makes sense to me, and I think 128k won't break
> the "an extent" requirement (compare with 64k). So,
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thank you.

--NR

>>   	| _filter_xfs_io
>> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
>> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 128K 128K" $SCRATCH_MNT/foo \
>>   	| _filter_xfs_io
>>   
>>   # Create out second test file which initially, for the first send operation,
>>   # only has a single extent that is not shared.
>> -$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
>> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 128K 0 128K" $SCRATCH_MNT/bar \
>>   	| _filter_xfs_io
>>   
>>   _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>> @@ -56,7 +56,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>>   # Now clone the existing extent in file bar to itself at a different offset.
>>   # We want to verify the incremental send operation below will issue a clone
>>   # operation instead of a write operation.
>> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
>> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 128K 128K" $SCRATCH_MNT/bar \
>>   	| _filter_xfs_io
>>   
>>   _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
>> index 306d9b24..a33b3c1e 100644
>> --- a/tests/btrfs/200.out
>> +++ b/tests/btrfs/200.out
>> @@ -1,12 +1,12 @@
>>   QA output created by 200
>> -wrote 65536/65536 bytes at offset 0
>> +wrote 131072/131072 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -linked 65536/65536 bytes at offset 65536
>> +linked 131072/131072 bytes at offset 131072
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -wrote 65536/65536 bytes at offset 0
>> +wrote 131072/131072 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   At subvol SCRATCH_MNT/base
>> -linked 65536/65536 bytes at offset 65536
>> +linked 131072/131072 bytes at offset 131072
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   At subvol SCRATCH_MNT/incr
>>   At subvol base
>> -- 
>> 2.34.1
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

