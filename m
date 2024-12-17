Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E61487FE
	for <fstests@vger.kernel.org>; Tue, 17 Dec 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422237; cv=none; b=tA9YEo5v4tZJYop2FzflxHzxe7aLA/KVe0jj1F/GRlhnDzXGAGd8zeOrMm8b2ov0k++2iIWARLkRUqgNXTYOxq6Hibl1kZ2k2h58kAbbOMQ1KGhr3dv76V4EMy4MMSqq4ukyUWwRaLoe4kQtypx9fiwun6qpBSu0x3NXkW/mhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422237; c=relaxed/simple;
	bh=sWbvi+MRtRX1F8yn0PK5gs+eI2z7rl8lDc2dHT9rrZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQKjxN7jNT+bPUPA+Lf2qdXkflRxoMuiyOP7SOTcydH/C43GGALLq1CyyAzeV11CQftzFzXfPEgO6J2y8GQ8iISboD5H0qGqSqMPaPiqzFvqZrh8dkiz8vMNyQSy1SXsNrCBLhhFMcoQgnVo7q3TR6Jai6eYzrpAGJ86XeGzaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HTbqDamM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HTbqDamM"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e27c75f4so3817443f8f.2
        for <fstests@vger.kernel.org>; Mon, 16 Dec 2024 23:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422234; x=1735027034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TPgeOsepUL8NaDFFwx9ywxpWtq67Qj3d28D247T6wjg=;
        b=HTbqDamMRVHgVzMYt85DnyUkr0pfsFife3iASdb2bnl4wse/Uk5I7P5yZ9zZAjd7cZ
         oRSMmJ1q1DUxXwSqmkgmjH2Mcqe21XO+PsRPUKvMZZ8G60k/uwNpmixLQknRI8L8gHta
         jJASMYyQF7zUOYXw+rUydwMP8vEmgZDosiIvDnrMbdFaZxX/hbkqMmjGvsNTU0zDDCqw
         ImDpgY6XWWE+fHh58CCh4DCofZMi6+UkPowxmnlsgTjF/QoddhpjPAtqsXu3KxrJ9fP3
         rORTdwW/VbJxDlTDZPldCLKYl0EWD19xBQEOte3sblycbumVi+5m3+EAtfx4/dBg4EqF
         9LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422234; x=1735027034;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPgeOsepUL8NaDFFwx9ywxpWtq67Qj3d28D247T6wjg=;
        b=cG7+Ls9i/f/ZZxFfkz9ijz6Lnsn7wnRL7uHMkky2eB92BLxBLz7L404UnWfVd7PT4N
         8zw7o25j2RkQ9dof+WDDSjtrxfWMEcaehQvlF8jN963QjhvXPrQI65Z6IEOchf8LLoRa
         CGn4lq+cFQSH/5je48L3EKx2zKnAEX5/snbkay4VI5ASpaXf2JK9Crtlq+uiFUmn+yAB
         gfmRwvd1fFk4p5yEhCHttjAlaDf/NbkJdDHaoCtxO7L54/6wzr4emGEyM+zo0k3/BTJw
         1Z2wIa1XwcrjWKCwCMBbuyqPzvQE51NPV3bb9Htj3TuO2+rxixK9l1asofxJUudKx7sV
         G0xg==
X-Forwarded-Encrypted: i=1; AJvYcCWx4Oi8F/kYNhkWloc0QjEcc1oIHsYSk3oIbEIMIxjlgOZR665UShaN/U6iy/B6VhwH1LoHM1tl@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtykrO+AtfDL/8lkkFVwwoK2+5FTtWxwtiFninmELr4wtF871
	02Jdz1qlwNqtDvKm9VxqBCVThTxrIaMULaU6b+UTfBRhkFvjihwQN0Qu1R7/Vj4=
X-Gm-Gg: ASbGnctEXh0qB4ERjKU3LnlldfFA7XDgo+WrO0DAuQ2aevJommCqaAt2nfTjgi0fGPg
	HHTeO2Trd3Njo23g4YiE9HSUaE2A7KHjhrPvNUOVL3O6BkgHjUyUIf5AE7H7v4uoL5oDkSYRdzS
	C9oiXCqbIf4k90w6T+V/Uoi7xJAO518oU630qJlCEwonjAIQol4BN+PVkvCQbdcSNCMw5h/prVW
	0hEdRxtCuoHlwBER7xuKGWj9jutjqUXzzUglxS0B5/YlYkHqFL66lMzG24p/V9Rq6/g5qf4Xfso
	LCVJe3Ew
X-Google-Smtp-Source: AGHT+IH5pP8/M924hmvMrlYhjcMGfu6RkLF9VaxaKL0S7iN+FPzgLEN+3MwZDa1oCbQR3sJ3+mRw2g==
X-Received: by 2002:a05:6000:470b:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-38880ada7e1mr11566149f8f.25.1734422233624;
        Mon, 16 Dec 2024 23:57:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e500b8sm52660245ad.123.2024.12.16.23.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 23:57:13 -0800 (PST)
Message-ID: <3dc2706f-d0ed-4190-b385-8bce19d7d6c3@suse.com>
Date: Tue, 17 Dec 2024 18:27:08 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/146: fix failure due to missing test number
 argument for fsync-err
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dchinner@redhat.com,
 Filipe Manana <fdmanana@suse.com>
References: <5200182586d153054cbfc2549dea4b862c65e9fc.1733852046.git.fdmanana@suse.com>
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
In-Reply-To: <5200182586d153054cbfc2549dea4b862c65e9fc.1733852046.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/11 04:04, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 88c0291d297c ("fstests: per-test dmerror instances") the
> script src/dmerror now has an extra argument, corresponding to a test's
> sequence number, but btrfs/146 isn't passing that argument so the test
> fails like this:
> 
>    $ ./check btrfs/146
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/146 3s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad)
>        --- tests/btrfs/146.out	2020-06-10 19:29:03.818519162 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad	2024-12-10 17:19:40.363498130 +0000
>        @@ -1,3 +1,4 @@
>         QA output created by 146
>         Format and mount
>        -Test passed!
>        +Usage: /home/fdmanana/git/hub/xfstests/src/dmerror {load_error_table|load_working_table}
>        +system: program exited: 1
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/146.out /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad'  to see the entire diff)
>    Ran: btrfs/146
>    Failures: btrfs/146
>    Failed 1 of 1 tests
> 
> Fix this by passing the test's sequence number as an argument.
> 
> Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/146 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/146 b/tests/btrfs/146
> index d6d2829a..c1243757 100755
> --- a/tests/btrfs/146
> +++ b/tests/btrfs/146
> @@ -57,7 +57,7 @@ _require_fs_space $SCRATCH_MNT $write_kb
>   testfile=$SCRATCH_MNT/fsync-err-test
>   
>   SCRATCH_DEV=$old_SCRATCH_DEV
> -$here/src/fsync-err -b $(($write_kb * 1024)) -d $here/src/dmerror $testfile
> +$here/src/fsync-err -b $(($write_kb * 1024)) -d "$here/src/dmerror $seq" $testfile
>   
>   # success, all done
>   _dmerror_load_working_table

