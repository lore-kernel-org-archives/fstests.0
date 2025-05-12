Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA519D8A8
	for <fstests@vger.kernel.org>; Mon, 12 May 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036262; cv=none; b=uCDPKxRwVoMOoIzfejForjOG1vO+7iDJFhDJwgbIyIGALZAHySRPFxNvcHaZ7w6HWViHrtf53XBMPA07gE02a6EA8kxohgPH6MjAqXKwBbDQEhYIZ1BNF4ngZmYkGrzdaz6stTSgZbKMDCuVOr/bp1OL/86zmdv0BtkawJV8V60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036262; c=relaxed/simple;
	bh=LoBGweeCRihhLbT87E8n0vng6oQCw63PRQDrQHTGgJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDA0rLTGAd2PsX7boK3PSOG2wIlyxpGwcUh/Nsz1qhbOHqjORfAUyAP1hKGgpg/3yLizLKgtPeTJfCDryEx8n6BUtZ7OcdcOtK79tUIXozz/WJYrKea96bx6qNc3mZbiUfQDve5rk/CkZxGL3PVcfYjUEaL9F6rusyqNzmlDXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D/sO9SUi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/sO9SUi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0af41faa5so2233671f8f.2
        for <fstests@vger.kernel.org>; Mon, 12 May 2025 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747036258; x=1747641058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxB1WLpx9nqvldAmF2fmYyqMp23jnRQd3Wxs1y2cVn8=;
        b=D/sO9SUimVX2xT47mQF2mlHLZ3cto3bLsVHdDklu98uHxi4kNAmISatJR0H06TqrA8
         T8Zib3uuEMpYxtS9nf7cKgcgvXbCQDodkOrpFibfCb/8KahKPwX/lSbX3tRAYriRnibS
         tacjhXctYdYv/WPT22sbKKt77NIh4OOhHIjzP1yOGHW42RD/VymGlpj/vNP4ehwZaybD
         0grMsI6KLTj/W+ZR/6ZgTf+sYHj/It9JYBH47vMZYcK0NiqtPoNpbOoO9AhjJJ7W/RgM
         mfos+v382F2chtEn7fjX+SFeu0Q/9fdqRQWNCSTVy42CGZXROHSZv/7THyxWlj+JxYQ+
         CZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747036258; x=1747641058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxB1WLpx9nqvldAmF2fmYyqMp23jnRQd3Wxs1y2cVn8=;
        b=rq/CWDXb0puCRHAGyJkPmYsUGYxUA8OmLS2Ro51TfpIKIEk5UApAuNNwobu6Rwn7dx
         A5crAL4r5j1hZdJK3GRQRg0V0aNxq1nggCQ3r5YSBeJ0y/CNrlL6inzklZT2SXuTJgOE
         9nu0uJ40XAFdiiZkporcPpd0LNYTWMhuddOtibfdMB7YtqClYVyKfZbyi0gSophBYlud
         BB5ux+8f1cbZlfV4A3Triy+i0vsI9uD5+HC85pN+iRHXvdJ9VxY/pODBzz64LZIatHbB
         SLgFHgd1WrQZ8Md+tQVaL1gPiwf5vG7hdLNsP60aRUBn/mMIvBEduJAlc9bBpP/wiX0T
         VhCg==
X-Forwarded-Encrypted: i=1; AJvYcCXMYwkxUukjBRg4xQsNopioat4YehAL7fGdal7u2qNWokzNKLuF++b6MnIp6qEqQ0YDB2qTqIoQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzkOIfUvFHjItIRAi0UtIXneL8H1VonqN1lm4KaEP5DkCc+u+Pt
	PprSy8DiyFioVlxA6gWYpQYRWNj8+sNksyw3ovmROmJYz5JStINbJlqL9p37O4v3pQtO01sf2Hx
	A
X-Gm-Gg: ASbGncumcp0rWww6QhOnE1GhdDSk+VW1cYaCfumPG7/w5xATfnaBqgurS7eG7/WEe3n
	+53wufp45LOa49zAFM2xz7l312p/wMEP2ZgJXIOQ8gBvD6cBjyhlE4mKelfmvNZRRNv7c8SJKAb
	jhUbL4xLbpDXIMWDKBTbvGoOA9aXDAmZ3BmEY+5nBnZXfA5iUSoTD4SMZSOZ0ZgM8O0BEhChVr2
	rUUfS4dvEE+blLkDwDyR2ij3kEggQPh4VsHE/NdcdzFRO1QFXC/y6NxB36/3ng9n8VTzFHQ9MqX
	/ytlnCtFNZWCOXJi82uXBXIffsfbEdV+w4iCB1ZLuwPlNS1EsqCHw7dIR0QPzPyZyxTq6msJQNN
	U6nIqjExlZqGT8w==
X-Google-Smtp-Source: AGHT+IG5cTCfxCazkZb0GDigK8Hmk6QTb9vDefbmMh9SM8KbflakLBCdDZDXkqoT8+Vg14QdlXMBpg==
X-Received: by 2002:a5d:648d:0:b0:3a0:b84d:892e with SMTP id ffacd0b85a97d-3a1f64f17b9mr8722315f8f.54.1747036258325;
        Mon, 12 May 2025 00:50:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2351b7a87dsm4356550a12.70.2025.05.12.00.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 00:50:57 -0700 (PDT)
Message-ID: <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
Date: Mon, 12 May 2025 17:20:48 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and
 rescue=idatacsums
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250512052551.236243-1-wqu@suse.com>
 <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/12 17:14, Filipe Manana 写道:
> On Mon, May 12, 2025 at 6:26 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a kernel bug report that scrub will trigger a NULL pointer
>> dereference when rescue=idatacsums mount option is provided.
>>
>> Add a test case for such situation, to verify kernel can gracefully
>> reject scrub when  there is no csum tree.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/336     | 32 ++++++++++++++++++++++++++++++++
>>   tests/btrfs/336.out |  2 ++
>>   2 files changed, 34 insertions(+)
>>   create mode 100755 tests/btrfs/336
>>   create mode 100644 tests/btrfs/336.out
>>
>> diff --git a/tests/btrfs/336 b/tests/btrfs/336
>> new file mode 100755
>> index 00000000..f76a8e21
>> --- /dev/null
>> +++ b/tests/btrfs/336
>> @@ -0,0 +1,32 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 336
>> +#
>> +# Make sure read-only scrub won't cause NULL pointer dereference with
>> +# rescue=idatacsums mount option
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto scrub quick
>> +
>> +_fixed_by_kernel_commit 6aecd91a5c5b \
>> +       "btrfs: avoid NULL pointer dereference if no valid extent tree"
>> +
>> +_require_scratch
>> +_scratch_mkfs >> $seqres.full
>> +
>> +_try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
>> +       _notrun "rescue=ignoredatacsums mount option not supported"
>> +
>> +# For unpatched kernel this will cause NULL pointer dereference and crash the kernel.
>> +# For patched kernel scrub will be gracefully rejected.
>> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
> 
> If the scrub is supposed to fail, as the comment says, then we should
> check that it fails.
> Right now we're ignoring whether it succeeds or fails.

Currently it indeed fails for patched kernel, but I'm not sure if it 
will keep so in the future.

E.g. we can still properly scrub metadata chunks, and for data chunks we 
may even delayed the csum tree lookup so that if we got an empty data 
block group, we just do an early exit.

Or should I do the failure check, and update the test case when the 
kernel behavior changes in the future?

Thanks,
Qu


> 
> Otherwise it looks fine, thanks.
> 

