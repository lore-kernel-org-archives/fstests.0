Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26A3905EC
	for <fstests@vger.kernel.org>; Tue,  7 Jul 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415439; cv=none; b=K9E0E0LUAL86p3HRUo3x9du5UBha0AM7JTBPQK3302xwzHql7N5lVBmKU2XljrIa1rjgP5QktoNM6uvG9iONDOpNfpkABeN6OvgYW7Fuj90sDzl9oBuN+JdkN/ehGLBnwTcFuDNIrbkV/6bS0dAi+JvyEOADUsXUIwWyrOxW5Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415439; c=relaxed/simple;
	bh=VPb+ahFuBMgrl9OAnxZTm/wRKfAn4mrMAjQlyLe7q04=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=XX3d14ZUwKXOsrXwQtVHVjqRU2hTOivFWb/PfO1I+D8R6KYkXO74bcIlHYpXR7QfUOSKsCF8DxxJ1mpEoqq2pdxkEdtwL7+5WvGmL5Obv2JkM5PUCwVmhJtSrb0VvNgxjQohmPC4Enq+yz919bcvhjxD9RCcXiYPFgkq96I6udY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lz/etgLl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lz/etgLl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ba701891so31359775e9.3
        for <fstests@vger.kernel.org>; Tue, 07 Jul 2026 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783415436; x=1784020236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMv73KxUaqJiUgzQNIjwVA2ADE+OY9HWdRamYX/WJHY=;
        b=Lz/etgLlelv49IBr1K3SBaE341TeF2qJA0LZKVmUBaBwbDMiHWBsHMb2B8Yo7oz07J
         GuNlPSlRIut07SB+g4/FdsJtaMYBxxatDhtS9DIT2acKBnDhSAWooesNtnRCKYu8HTyo
         XnuaoIisZJLVNqaHnr9KSQvs8dPsHBxvXfH31ytM+UGAFvHoE2VWVGIN3CDXUoWyyJ77
         q4Td+kDr+ukHisIvx05ccXxlpCnHaGX8MwbOTyCHKNYhRSCcGpdVTyoP3CmX12PR1PRH
         g+r6eOa5iE79fTLP+S69p73Npfl8v8F7AwXRLG6LBOTuZFWW/OoUN7Iy6ZWhhAeyJo03
         jtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415436; x=1784020236;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMv73KxUaqJiUgzQNIjwVA2ADE+OY9HWdRamYX/WJHY=;
        b=sSC0RlQCOIvSXiijFKsqHO2QhiYEheF3G+g6twxGB9lgrmSfrGbxdJRmUxw+XHjOYL
         lZTOMRT04t0LpJMIRbAFwxB5y5fiiP+67PDZh5uvjIfIxIShJ8xqvqTQmVBxPO8kyQKl
         jAJn3G4gROrYl2xr4TgiEupe3Hn/JB+XUlmSGsU6ZBp+rtzsSuWVzO2NS14OPL3hVWKz
         F2JIVoJisMp1XiSE+azCbKvKkduL2irhCeg84MrExx3rRgG2X5XL39SbB0r5TzPj5wDM
         4pUxC4Ta+cw6ZbQ0aAEGt1IH2NWdOzYCrjcryhnYSkXWqMC+14guEa0xg6GqPI/rxKaz
         YvQA==
X-Gm-Message-State: AOJu0YwF/jdRWDell5crhyEdzaD01Yqr0vjgKM+JM2uPFXZGUMhQCwgC
	IempNNhQxlYCAea8HNNo9CH4f2RShr3rYQCk9LyawPRhrM/91VZDy6il5eTadMD1h5KQQ8WX/Ug
	UN/n+zYU=
X-Gm-Gg: AfdE7cms57esoVAYWO6Z9LRnR672x+ozgDw03NlRdIVlYDUiaTfRBqVSWXIs7l+UCaJ
	uOTlYokIA20E89qc/qTxBkmcTdoOJCDQXkjLb/fcuLshU/RXJqiidJt69U4UVc8qulU7ms3BOdg
	JYgDZWH5KQ8n0gakWYlQlH6OD7Rm1pvAUmv1pNnMRO3hditeVUhP6GobIqdt6i9/XOqtBCyNmUA
	+TIuRBVRSF9q+6xfS7GnWk7W9X+uR13A8SyBHuqBdBSeI75pDgRMQJiIz2zPl8h3Fd8JeNL8xH2
	btEAUL2tQqBLE9uoaE0OAxMq2y5X3M++zjhK5/UZcTW4Cr6444nhIYSzZk2QDWE4jfALJt3zSDP
	uN/sK1xQsRmGa5YJgbGjvPnACQ74La/YEbPwEWcL5jmkr/E3uXlEQhUE5l5i8Vy20K4aoagkInL
	rGgOU8eIRxHufpk3oK
X-Received: by 2002:a05:600c:4505:b0:493:e006:3153 with SMTP id 5b1f17b1804b1-493e00634cdmr30952075e9.34.1783415435622;
        Tue, 07 Jul 2026 02:10:35 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c865asm6448861c88.11.2026.07.07.02.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 02:10:34 -0700 (PDT)
Message-ID: <be633a11-6870-429f-a463-508099b96886@suse.com>
Date: Tue, 7 Jul 2026 18:40:30 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/062: avoid warning from polluting the
 golden output
From: Qu Wenruo <wqu@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <7df0f6d0323abed08ffb1f40775474e4b39fef19.1783414762.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <7df0f6d0323abed08ffb1f40775474e4b39fef19.1783414762.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please discard this one.

Avinesh has already submitted a better solution doing the runtime check.

Thanks,
Qu

在 2026/7/7 18:29, Qu Wenruo 写道:
> [FAILURE]
> With the latest setfattr (provided by attr 2.6.0), the test case
> generic/062 will fail like the following:
> 
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/aarch64 btrfs-aarch64 7.2.0-rc1-custom-64k+ #22 SMP PREEMPT_DYNAMIC Tue Jul  7 16:05:57 ACST 2026
>   MKFS_OPTIONS  -- -O bgt -K /dev/mapper/test-scratch1
>   MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
>   generic/062  1s ... - output mismatch (see /home/adam/xfstests-dev/results//generic/062.out.bad)
>       --- tests/generic/062.out	2024-04-25 18:13:45.101553098 +0930
>       +++ /home/adam/xfstests-dev/results//generic/062.out.bad	2026-07-07 18:22:12.384539920 +0930
>       @@ -649,6 +649,7 @@
>        SCRATCH_MNT/lnk
>        SCRATCH_MNT/reg
>        *** restore everything
>       +Warning: option --restore=file is unsafe without option -P (--physical) as it traverses symbolic links in pathnames
>        *** compare before and after backups
> 
>        *** unmount
>       ...
>       (Run 'diff -u /home/adam/xfstests-dev/tests/generic/062.out /home/adam/xfstests-dev/results//generic/062.out.bad'  to see the entire diff)
>   Ran: generic/062
>   Failures: generic/062
>   Failed 1 of 1 tests
> 
> [CAUSE]
> That output is a warning from the latest attr, introduced by attr commit
> 3fb06b9ba314 ("harden setfattr --restore").
> 
> There is also a compile time flag to toggle that warning.
> 
> [FIX]
> Since we have no way to know if the setfattr command from the running
> environment has that hardening or not, and the way to disable that
> warning is to use "-P" option, which does not exist in older versions,
> just redirect the stdout into seqres.full to avoid pollution.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/generic/062 | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/062 b/tests/generic/062
> index 896590403fda..faeb9650c608 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -186,7 +186,9 @@ _create_test_bed
>   _extend_test_bed
>   
>   echo "*** restore everything"
> -setfattr -h --restore=$tmp.backup1
> +# For attr 2.6.0, --restore= without -P will output a warning.
> +# Redirect it to avoid polluting the golden output.
> +setfattr -h --restore=$tmp.backup1 >> $seqres.full
>   _backup $tmp.backup2
>   
>   echo "AFTER RESTORE" >>$seqres.full

