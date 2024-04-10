Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F059C129
	for <fstests@vger.kernel.org>; Wed, 10 Apr 2024 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728139; cv=none; b=pcf5JPE62iM+g56BXZ7ag+o9aoqpKybURvy6ajRYaA4VjLnDX8CLG41kJlJkSEvrfGMfYVoijH+HFWZAy3JNALszdFNdyLLFgrrWHh3J50EegYJZPBmDnsLhdNVizsm2nbsfFPm6XtzKvVlMvu62pB4ztoYvOjwj3ZjdSAUk2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728139; c=relaxed/simple;
	bh=vVHDkv+GAYRBt6jx3r6avXs+zurXHPIpHLiVvKnwJgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwAqWZaQax31+AYG4ZxKy8v9Kq855Zxe6dmZ8POMCuf/k4qlSsj1eMj3pRqPdCgDqckV/6Yfu10+GIKwLYVNy2hNz/Dbzf66EGQkYpEn+BkLrtzLVPMqWgjWJxSQFMCS8+e4sfrJo8/XJsta1gpF8GkhdZSFK6SqGQv+iLdfP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fjGbWsiq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fjGbWsiq"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso49267441fa.3
        for <fstests@vger.kernel.org>; Tue, 09 Apr 2024 22:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712728135; x=1713332935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x2eLTG84Zos4xQkD74W9nLClnUlj0mQ50Bpr9rOON/U=;
        b=fjGbWsiqSSiO9PNSTJt53w8Fb/FBIwvKpzaC2rVtLmFPSAbienNmFK6/6juR5nYeOh
         /i6YVEwPadt8MKM+ETOaQ/MFTRL/9a+7rRnPMb9odeDO6pRr0gEt3Ws4OD7MzB3sT/6a
         bJqsCAE7umY7Mp8oyAkFdpHdqZAzWJPRAVSu4L0Robf8u0qOC0m8Zz6bGERCMUa2Ul83
         4w8PCXsNkOT357pUD5Ym03p03KV29eigE/jxPCru7iFuJzWTpK1UUWudUmPXyw0k/iVM
         FmVvsa81xLtS5tqeFg2FofKBodtODb5dnFs/PJ6TBbaBJYMViNFlrC1s0zJu0GmgEJOs
         lhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712728135; x=1713332935;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2eLTG84Zos4xQkD74W9nLClnUlj0mQ50Bpr9rOON/U=;
        b=rG1IN/anpbUdWCCnTKO2pTAAFfnVVHPUBUUVkmWQ7rhgG8jKx9LlvtZioGX+hdd8WX
         gJWxTn0N295fVkG4Gx4OOF9cevv4HK75QSyFOP6Q3iatt5yxfYcWlcbdTec4TXeXXLeB
         NG0mE9/nxs5DTIpZV+Zykjzl5bciuj6GgIXx8pdKsF16IbMB0qozA3f8X2B00r9ce2os
         Ys+8nE2Zm0XBtQD88Erp8WJ+XwfcjCVaevX22H680uMg9jzOIKQyJKueW2Y4K2lfgkK7
         yz/8rk7lk8W32i1gxqDMN6kq94renrBL/C+aTrPGFGlWmsppaNdRLW5VfUmoTdAoQA9F
         CLHA==
X-Forwarded-Encrypted: i=1; AJvYcCX7q5aKKZjRrCYpvRXjHdCPDdoCnoNUhULEwdSOO0b2Kz98m9aScy7L6z27ArrcXya54ekNTjfDx075FtpQ21Fvxud/SaY3XA==
X-Gm-Message-State: AOJu0YxHCXgewMpo1nScLMzYgmC027du2+H+8k6zYtVA2L52aqZDvcrO
	sNUWgKlB5bmfguiVhTdJUZ8T2y5vSnlbLeDFMc31uhdPdBonf4U1pdVpfwTdznI=
X-Google-Smtp-Source: AGHT+IFoRQz0aCbyde7qLTYTFa6fOtvq3JbdjPkvUcpcfX+cmHCtlO7A40g+jPCwPyY3UqR4jCnsNg==
X-Received: by 2002:a05:651c:9:b0:2d4:a8cf:e798 with SMTP id n9-20020a05651c000900b002d4a8cfe798mr1504610lja.14.1712728134736;
        Tue, 09 Apr 2024 22:48:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id y6-20020a62f246000000b006e6c74eac34sm9314207pfl.151.2024.04.09.22.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 22:48:54 -0700 (PDT)
Message-ID: <e9576dfb-c3ce-4adc-bb32-f7efa235907a@suse.com>
Date: Wed, 10 Apr 2024 15:18:49 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
To: Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
 <20240409111319.GA3492@twin.jikos.cz>
 <f113ab1f-58b4-453b-a6eb-7b4cce765287@oracle.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <f113ab1f-58b4-453b-a6eb-7b4cce765287@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/10 13:46, Anand Jain 写道:
> 
> 
> On 4/9/24 19:13, David Sterba wrote:
>> On Mon, Apr 08, 2024 at 12:46:18PM +0800, Anand Jain wrote:
>>> On 4/6/24 13:18, Qu Wenruo wrote:
>>>> [BUG]
>>>> All the touched test cases would fail after btrfs-progs commit
>>>> 5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when
>>>> the ioctl succeeded") due to golden output mismatch.
>>>>
>>>> [CAUSE]
>>>> Although the patch I sent to the mail list doesn't change the output at
>>>> all but only a timing change, David uses this patch to unify the output
>>>> of "btrfs subvolume create" and "btrfs subvolume snapshot".
>>>>
>>>> Unfortunately this changes the output and causes mismatch with
>>>> golden output.
>>>>
>>>> [FIX]
>>>> Just redirect stdout of "btrfs subvolume snapshot" to $seqres.full.
>>>> Any error from "btrfs subvolume" subgroup would lead to error messages
>>>> into stderr, and cause golden output mismatch.
>>>>
>>>> This can be comprehensively greped by
>>>> 'grep -IR "Create a" tests/btrfs/*.out' command.
>>>>
>>>> In fact, we have around 274 "btrfs subvolume snapshot|create" calls 
>>>> in the
>>>> existing test cases, meanwhile only around 61 calls are populating
>>>> golden output (22 for subvolume creation, and 39 for snapshot 
>>>> creation).
>>>>
>>>> Thus majority of the snapshot/subvolume creation is not populating
>>>> golden output already.
>>>>
>>>
>>> While golden output is better verification method in terms of
>>> accuracy, but, it falls short in verifying command exit codes.
>>> I personally think the run_btrfs_progs approach is better for
>>> 'btrfs subvolume snapshot'. It allows us to verify the command
>>> status without relying on the stdout.
>>> But, past discussions favored the golden output verification
>>> method instead of run_btrfs_progs.
>>
>> I thought the whole point here was to depart from the golden output, at
>> least in selected cases, and only in btrfs/ subdirectory so it does not
>> accidentally break other filesystems' testing.
>>
>> What past discussions favored does not seem to satisfy our needs and as
>> btrfs-progs are evolving we're hitting random test breakage just because
>> some message has changed. The testsuite should verify what matters, ie.
>> return code, state of the filesystem etc, not exact command output.
>> There's high correlation between output and correctness, yes, but this
>> is too fragile.
> 
> Agreed. So, why don't we use `_run_btrfs_util_prog subvolume
> snapshot`, which makes it consistent with the rest of the test cases,
> and also remove the golden output for this command?

For `_run_btrfs_util_prog`, the only thing I do not like is the name itself.

I also do not like how fstests always go $BTRFS_UTIL_PROG neither, 
however I understand it's there to make sure we do not got weird bash 
function name like "btrfs()" overriding the real "btrfs".

If we can make the name shorter like `_btrfs` or something like it, I'm 
totally fine with that, and would be happy to move to the new interface.

In fact, `_run_btrfs_util_prog` is pretty helpful to generate a debug 
friendly seqres.full, which is another good point.

Thanks,
Qu

> 
> Thanks, Anand
