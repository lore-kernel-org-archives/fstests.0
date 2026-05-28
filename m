Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21560314D16
	for <fstests@vger.kernel.org>; Thu, 28 May 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012356; cv=none; b=Uy6MBJEWYbbvWou0EoSPHQS6Zp7MqiOzJPRPLeu1MBlj+i+Q0kw69G8OdWfli7rfhtDd7+/Ln6/nt5Ll1gM8Nb1OBwMMiByGlAMOq+9XXpTO6jHhV4t7HDJN4/Ms88tV6N9iCtYc8DkTvOfKu2LyWGtul5jGMgs1Hif4KfNVIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012356; c=relaxed/simple;
	bh=/pQlXuDDDhFaargqtOMFNgKvB7c3tpaquOp5D7GNWiU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AtfcRhjjvP21eaimrgbaX1MKfUmsLdkNIiBIlK7lXI2oTU6M8QgZbJ0xIHDSpB6fnFUq9L7jh5VYdAo4mOIgYWLv2JyqegqG1kwtSxeXGPH7ZeAhsazlBUf8QXh5JtYfeEZ8uCtitZRx8bIFR4+maqpGSOTvuHqkY35nwFQgds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMe4+kql; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMe4+kql"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-835c98b659eso10575040b3a.0
        for <fstests@vger.kernel.org>; Thu, 28 May 2026 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780012353; x=1780617153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWHeLdd8K1qOhmkjkd+5/Im2+vY/uXRe6mdyAKRgUdU=;
        b=tMe4+kqlTYEEARmqxf0HakTuxeJN+Y2Jb4g3+xFY/KrDdI1PZUQ2ZAJNomSaRLJoIY
         nFJmJxoeaSkGwKd4/JBfesZSZ4DVdS5hGaaeJqVKgA36dNm0l/n44oaqtMBR4+No1u39
         j2jyzG9K7McdtG39la3MGjnnHRjw5m+fDb8PiB6rT1aZCQA8DEnHo/8LDPKysWQ7wSOO
         3E/wjyIh+piDGtmG/W1BwEjeGDyUJfxIs9nOs2LLrOL3KmI73dEPzbxKtJ4u5HzCGbkN
         WQIvIAFIpPDy/qVyJOuMEkwQh6KusmByvAB3QhicO15Bj81E5L7/e00yZtPqb024y6Xg
         UWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780012353; x=1780617153;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWHeLdd8K1qOhmkjkd+5/Im2+vY/uXRe6mdyAKRgUdU=;
        b=ET3kRxRw20cmsMiF5AHmNx0kW98vxrA9hcgcLiZTEgoBOpBeOkU+4GBZm9TlNBso/J
         AIfG/dZ3GF6GZquDimPlN9fxSf5mCCOOuhM+358wDEtXRcxWXxP/k3T4p8NpNnLVZ52M
         D6Sc3P+O0S/P7ybNruAAffzCRs5AwBwP9iUmTz1qVedXofULhXmq+069iRPAprdk0UsS
         ZLixRvibxv8Cg3lA8LMfM5eLwtG3Kcy0PWLbbRF2TW6GND9ntrsrJU7n+3/gHjNHfSTf
         euyBZoLsH5WnKWulzSsp36CJIyRrsnoJcDv41EpTBT+Pok6NCZg/lFv3G1nKgmKlUksX
         CoJw==
X-Gm-Message-State: AOJu0YzoaZf4fgL4BgkfdKmtayxCP8NLfZ2mGRd7OMldB2cj9fhiUxfS
	0+fPxlM1XdrlnvpUicOlem0MSjNaAkIafJr9SbhaxDjfWwukDYeEJw/P
X-Gm-Gg: Acq92OFj3gHy1c+q4OoW0n3ZPNXI+ctwHIhROvELnhDD3rYcTVNkgGz6bmNRXf9dyn3
	aMWvvcYCEITnmPIRJ4SwPIx7Q/ccmq+8dbja5neZSWZ0TmL3CL9IuCIT1655O+zqWhwhuS+Bb1D
	tURumd35fxc9rkebujiR2EPIoRPuUfivJapQGS4joTMkA9ratdBNwIGmjCqWv8sMrzXznMsObKG
	XhhaJ0549kk4N8VPNRdURwTiFJFIBvalepWQygZw9vHynfMkBbXHSfudhTL1m2z5+Gi7WxQIzRA
	6sn+/tPC57NpDyXY5Ck14pr7goBbnlQTQnrfCER8zwIL85wMlr0Y1DJdDBQrnUZEkDYAwYOLJ0d
	xBfvHEu/deYIoeJvnVoqIZxln/hU9dIiGFbTt1Ht6n/9YL1o9ztR7glZPhqRE+rfPXhE4uAsEAI
	dg9bxGFIlVb/dmjr2NYFNMTO8vPQirEA==
X-Received: by 2002:a05:6a00:4fcf:b0:838:1c02:276c with SMTP id d2e1a72fcca58-84212bc4303mr363520b3a.40.1780012353410;
        Thu, 28 May 2026 16:52:33 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842132fea00sm86448b3a.47.2026.05.28.16.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 16:52:33 -0700 (PDT)
From: Anand Jain <anajain.sg@gmail.com>
X-Google-Original-From: Anand Jain <asj@kernel.org>
Message-ID: <acf8dd4b-1d00-48d7-9297-bf508c0b0b6f@kernel.org>
Date: Fri, 29 May 2026 07:52:29 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: add a test case for writes with prealloc extents
 beyond i_size
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <4b84813ed94332ccf8bb46848ed91f699d75794a.1779964012.git.fdmanana@suse.com>
 <c4b59c1c-1f2f-4d93-b710-eb44a8c5943f@gmx.com>
 <CAL3q7H4V8mcisQRkxAro1_w0h+WxqAkapnp9AbKed1geGw6gDQ@mail.gmail.com>
Content-Language: en-US
Reply-To: asj@kernel.org
In-Reply-To: <CAL3q7H4V8mcisQRkxAro1_w0h+WxqAkapnp9AbKed1geGw6gDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/5/26 19:30, Filipe Manana wrote:
> On Thu, May 28, 2026 at 12:23 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2026/5/28 19:57, fdmanana@kernel.org 写道:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Test writing into a file range containing prealloc extents beyond the current
>>> i_size, with an unmount and mount after fallocate and the write, to verify
>>> that the file data, size and extent layout were not lost.
>>>
>>> This used to fail on btrfs when not using the no-holes feature (which is
>>> a default since btrfs-progs 5.15) before this recent kernel fix:
>>>
>>>     080ecbd05432 ("btrfs: mark file extent range dirty after converting prealloc extents")
>>>
>>> So in order to reproduce the failure when using an unpatched kernel and
>>> a btrfs-progs >= 5.15, one must run the test with:
>>>
>>>     MKFS_OPTIONS="-O ^no-holes"
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>>
>> Just one question related to the specified mkfs option.
>>
>> As you mentioned, this bug is only affecting ^no-holes, thus default
>> mount option runs won't trigger it.
>>
>> This makes me wondering, should we have a dedicated btrfs test case just
>> exercising the ^no-holes path.
>>
>> I know this will cause duplication, thus will not be a good idea to
>> maintain, but we also have dedicated test cases utilizing specified
>> mount option/mkfs options already.
>>
>> So what is the prefer method here?
> 

There will be many testcase and option combinations,
which makes this harder to scale and increases the
chances of missing a testcase + option combination
across federated teams.

I think it makes sense to maintain a standard testing config
(not sure what to call it, maybe a Test-Profile?).

V2 was sent here:

https://lore.kernel.org/fstests/cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com/

Any thoughts? I'm ok to revisit to send v3 if needed.

Thanks, Anand


> So in the past I attempted tests like that, making them btrfs specific
> and forcing a mount option.
> Some people (non-btrfs people, I don't recall exactly who, to be
> honest) disagreed with the claims that the test was actually generic,
> and that exercising the bug should be done by setting MKFS_OPTIONS in
> the command line.
> 
> I'm assuming people and our automations run tests with -O ^no-holes. I
> do it frequently in my test vms.
> 
>>
>> Thanks,
>> Qu
>>> ---
>>>   tests/generic/796     | 54 +++++++++++++++++++++++++++++++++++++++++++
>>>   tests/generic/796.out | 10 ++++++++
>>>   2 files changed, 64 insertions(+)
>>>   create mode 100755 tests/generic/796
>>>   create mode 100644 tests/generic/796.out
>>>
>>> diff --git a/tests/generic/796 b/tests/generic/796
>>> new file mode 100755
>>> index 00000000..c42a4722
>>> --- /dev/null
>>> +++ b/tests/generic/796
>>> @@ -0,0 +1,54 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
>>> +#
>>> +# FS QA Test 796
>>> +#
>>> +# Test writing into a file range containing prealloc extents beyond the current
>>> +# i_size, with an unmount and mount after fallocate and the write, to verify
>>> +# that the file data, size and extent layout were not lost.
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick prealloc preallocrw fiemap
>>> +
>>> +. ./common/filter
>>> +. ./common/punch # for _filter_fiemap
>>> +
>>> +_require_scratch
>>> +_require_xfs_io_command "falloc" "-k"
>>> +_require_xfs_io_command "fiemap"
>>> +
>>> +_fixed_by_fs_commit btrfs 080ecbd05432 \
>>> +     "btrfs: mark file extent range dirty after converting prealloc extents"
>>> +
>>> +_scratch_mkfs >>$seqres.full 2>&1
>>> +_scratch_mount
>>> +
>>> +# The fiemap results in the golden output requires file allocations to align to
>>> +# 1M boundaries.
>>> +_require_congruent_file_oplen $SCRATCH_MNT 1048576
>>> +
>>> +# Create our file with a size of 0 and a prealloc extent in the range [0, 2M].
>>> +$XFS_IO_PROG -f -c "falloc -k 0 2M" $SCRATCH_MNT/foo
>>> +
>>> +# Unmount and mount again to remove any in memory state of the inode. We will
>>> +# verify later that neither metadata nor extents were lost during unmount.
>>> +_scratch_cycle_mount
>>> +
>>> +# Write into the [0, 1M] range, which increases the inode's i_size.
>>> +$XFS_IO_PROG -c "pwrite -S 0xab -b 1M 0 1M" $SCRATCH_MNT/foo | _filter_xfs_io
>>> +
>>> +# Unmount and mount again to remove any in memory state of the inode. We will
>>> +# verify later that neither metadata nor extents were lost during unmount.
>>> +_scratch_cycle_mount
>>> +
>>> +# Check file data (and size).
>>> +echo "File data:"
>>> +_hexdump $SCRATCH_MNT/foo
>>> +
>>> +# Check we have unwritten extents in range [1M, 2M].
>>> +echo "Fiemap output:"
>>> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap
>>> +
>>> +# Success, all done.
>>> +_exit 0
>>> diff --git a/tests/generic/796.out b/tests/generic/796.out
>>> new file mode 100644
>>> index 00000000..c6c6e6a8
>>> --- /dev/null
>>> +++ b/tests/generic/796.out
>>> @@ -0,0 +1,10 @@
>>> +QA output created by 796
>>> +wrote 1048576/1048576 bytes at offset 0
>>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +File data:
>>> +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
>>> +*
>>> +100000
>>> +Fiemap output:
>>> +0: [0..2047]: data
>>> +1: [2048..4095]: unwritten
>>

