Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28064346E72
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887143; cv=none; b=IlmQFRJ7Zd9OqgWPtiYz2LyAKdBv5drukgYhxalIEJqa6WRlkeVgT9rxA5psp9fuA+RufdXu9ESalNeB9RbNBYt0Inejng580Ts1PG8Rj4KHCdlVoZNvmpDRDIR5+DZTPMjd3xJeR96UsNPZ3HpnJn+vZiMtzCTEzOOS+x/GNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887143; c=relaxed/simple;
	bh=7lSSYiUruz2h0P6a6b9q99X3GFkyQZm8+aetEAFe/pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kl6DZjaHWf3yqXtuRug9ctfFnJMxfzafVLSXGK7WnRbkBhdNPEPsdDbdipeyAHOPf8DpKH2HZQYq4aoxMIIpVQvBMDJ93oxVN+HNN1dExUI0tkcGB7f5wLX4aiK7vFKunIvTRSqxVcIgipTWIAczAhCHFAjjz0+WTx/aL8zMz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b1SPLmFY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b1SPLmFY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so3685935e9.0
        for <fstests@vger.kernel.org>; Fri, 15 May 2026 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778887140; x=1779491940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rz/NgBjF+q6WEJGtAfQZlX8Q0s+CLtsRAH2siiNq2BU=;
        b=b1SPLmFYzE/uBUIlbLuq59y22uCzafIvisavdZGfxQDjeNe3FpFosxFlx40i4hB7lZ
         P2yP8M0dutjXHkUrAdl4eXKXZ15gNe/BiwfjQIT/PijdGZhw1a4G/Oh/9EzVttp1yE+u
         P0vvT3FM3fQSaC6O+RZXZ/W8gzeuVUJVpaMSQ3xIcMnErB68ZuY4q1ETHwP9Q8nx/PRe
         3Q61pl9Qs7HOLAWCnzsqI0w0vsKWzV7ViVkaDj2DlqmvXGh5rwc6HQcBpRw+hs6vFrY4
         vBWqzbSBKuRbUqN3j34CQdWeHzikX3CYub213bfipLxWYhv57Ia0Wryv35pNbrGZFlx8
         61lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887140; x=1779491940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz/NgBjF+q6WEJGtAfQZlX8Q0s+CLtsRAH2siiNq2BU=;
        b=S+B/nX3kRTkZkSW9folB7TIlNKBY1lavriUXBqMBPoeViYNbZqH0LOWUV+DOspD8RC
         QeXMUK87Ye1vQVxb3VWinno5Hri07wPW4/h/g3raWHRzlH+4pzRncCgMnNE7DsebpLyR
         55U50c+ClCQcN/uElRZir9ZCQ1n/5m+XhAi1cqbXG5nZ4DxEFA+2ZNtwxSGtbWFxx5Ed
         udmUs8CFv98sFf/Xb0TwqjAeLGEB82G0/C7o5LeT8tK6zPuw/Rjj61y/a8FLrry7hLk+
         nWdV2ymCSLRx/a1Td3UBhZAGXksB+SOVRdDF4sd4BryBEqXQ08wk1AoJzgdEn25jf8CJ
         RcdA==
X-Gm-Message-State: AOJu0YyYu2fuxwJBIqzXJNepCLiuHFayMaS8SYdcxqyWeFULj3mQh9wO
	Y6vupQLcHPu2AtUoJIGZpcmnaXtbp+TEA0fYMMxQYuiKHwG28LIGAUPzcksVHyPJU+LscRwPUXw
	RhpEs
X-Gm-Gg: Acq92OEu811ZbKHWd5gO+ogWESYZyJF75kmNji7FnA7NqCQTpkbNVYqmfapEzsGp11w
	+fwhQj7SViThc3QRUpup4dk1i9XiaASWFi3wx//KmULj1fu0RFg+HkdolNFgqHuinY/MjiZJAep
	6eq1Wp7fXBQPZGzj82HSRMW/kEYuPACWs0YwPlKqQuC0UEEa3KxCLTxC8Lc4OEyTOs87bqnHadJ
	9833u/GluR83Yyf+3Xr4GsVvhsfmEorqLPnkKZYU1MlICk5DEMUY0YYcr5A6SYk5jgxlozPPIVa
	fjAFrjXpYYdfVrNyNadhngOPvqvEUrDFJCml8AU/19uiCWJm7BIAAxDJSnYUS9Ru9YCUT19FOBm
	Bu4guWlgS9R3qQu+ze4rqV5mDVf/hIMwBWELRwY91wUZgGq9M9wsK4koJnEjgsCEeoLD/GXe5Jd
	rq1luq4HZOLtrsc/n2A0rc+m5ZEdGsOqmGJm0ZNsUAWm3SOWlbyKNnFkAtb3YutlbqyR3bqKK/B
	t2KYBMzW0p67XQ14mf3TKILcyuzsRRrFGREoCmMig8CmnY=
X-Received: by 2002:a05:600c:3492:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48fe60e79eemr89529445e9.11.1778887140572;
        Fri, 15 May 2026 16:19:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb0csm64287285ad.17.2026.05.15.16.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 16:18:59 -0700 (PDT)
Message-ID: <816ad05a-4c36-480b-8166-d3c94597fb95@suse.com>
Date: Sat, 16 May 2026 08:48:55 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs/340: add support for older
 kernels/progs
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Long An <lan@suse.com>
References: <ed76cf7d6a0ad2a98e5730015dd4fc6514fc2343.1778749477.git.wqu@suse.com>
 <agdOBcKgPn3s7_u0@zlang-mailbox>
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
In-Reply-To: <agdOBcKgPn3s7_u0@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/5/16 02:25, Zorro Lang 写道:
> On Thu, May 14, 2026 at 06:34:39PM +0930, Qu Wenruo wrote:
>> The test case will fail on older distros like SLE12-SP5, there are two
>> problems on the test case itself:
>>
>> - Requires "--sync" option from "btrfs qgroup show" subcommand
>>    That option was introduecd in v4.9.1, thus there are still some older
>>    distros using that very old version.
>>
>> - Not all kernels support quick inherit
>>    The kernel commit introducing the quick inherit is 6.9, thus some
>>    supported LTS kernels do not have that commit.
>>
>>    In that case qgroup will just be marked inconsistent, this will cause
>>    the later "btrfs qgroup show" command to output a warning due to the
>>    inconsistent flag.
>>
>> Fix both problems by:
>>
>> - Require "--sync" option from "btrfs qgroup show" subcommand
>>    So older distros will just skip the test.
>>
>> - Redirect all output from "btrfs qgroup show" to $seqres.full
>>    So older kernels can still pass the test case by marking qgroup
>>    inconsitent.
>>
>> Reported-by: Long An <lan@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix the mismatch between the commit message and the test case change
>>    Forgot to amend the changes before sending.
>>
>> - Fix a bug in the stderr redirect
>>    The stdout redirect should be put last.
> 
> Sorry, did I miss part of the discussion? Why did v2 switch to notrun for
> older tools instead of using the compatible `btrfs filesystem sync` from v1?
> Was there something wrong with the v1 method :)

The main concern is the progs used in those tests can be really old, I 
mean there is no supported LTS kernel from that time period anymore.

With that old progs, I'm not confident enough to trust the progs to do 
all the qgroup numbers verification.

Nor do I even have an environment at hand to compile that old progs.

That's why in v2 I switch to skip the test case completely if the old 
progs doesn't even support "btrfs qgroup show --sync".

Thanks,
Qu

> 
> Thanks,
> Zorro
> 
>> ---
>>   tests/btrfs/340 | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/340 b/tests/btrfs/340
>> index 872f790cb975..eff76d0b633c 100755
>> --- a/tests/btrfs/340
>> +++ b/tests/btrfs/340
>> @@ -16,6 +16,7 @@ _fixed_by_kernel_commit 68d4b3fa18d7 \
>>   # For the automatic fsck at unmount.
>>   _require_scratch
>>   _require_btrfs_qgroup_report
>> +_require_btrfs_command qgroup show --sync
>>   
>>   # This will imply mkfs and enable regular qgroup.
>>   _require_scratch_qgroup
>> @@ -39,7 +40,12 @@ _btrfs qgroup show -p --sync $SCRATCH_MNT >> $seqres.full
>>   # without marking qgroup inconsistent.
>>   _btrfs subv snap -i 1/1 $SCRATCH_MNT/subv1 $SCRATCH_MNT/snap1
>>   echo "After quick inherit:" >> $seqres.full
>> -_btrfs qgroup show -p --sync $SCRATCH_MNT >> $seqres.full
>> +# Redirect all output to seqres.full including stderr.
>> +# For older kernels without quick inherit support, it will mark
>> +# qgroup inconsistent, which will output a warning about the inconsistent
>> +# numbers. Here we rely on the final btrfs check to catch any qgroup number
>> +# errors, thus no need to bother that possible warning.
>> +_btrfs qgroup show -p --sync $SCRATCH_MNT >> $seqres.full 2>&1
>>   
>>   echo "Silence is golden"
>>   _exit 0
>> -- 
>> 2.54.0
>>
>>

