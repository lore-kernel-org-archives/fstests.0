Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A6275B1B
	for <fstests@vger.kernel.org>; Tue,  2 Sep 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852042; cv=none; b=FcfEKBlnqiGaU9W1IMduj/nTTuNNii7vnp5+9QOFD0SmF5Non6tpaEh5i71hvD2lfdanZJAFw8XFdsZMe7RFt+KgVi+gG92RlT1Q3vnipa6q9ja/RcZDyVMJJO4KPY+GPE/mz53gdd6AU2vi8k+0277gAjxDfrfvb6CiPs6+Wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852042; c=relaxed/simple;
	bh=VhzDwRXislpuhfxl5JmOC+7U1fmkTLC3CFWXYF7yvUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET3eSfGcwDu5HJnegZ79bGlavQqQ0pziGrgKASr6RY6ory6L9HOq/e1C2oZfsaj7oSi3mjqhriviYShxYf6Iz+nlxvtg/QglucNcDjfhgBzv3oaA70K+8UjKmwsgbq1+/A8xBwhqgzNJHiJAhA8mJi0MhgjALABleP3KdUbBUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wc2qtjjv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wc2qtjjv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso3704948f8f.2
        for <fstests@vger.kernel.org>; Tue, 02 Sep 2025 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756852038; x=1757456838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WzD65PaAJkA8qRlCZYXV02FKe4apg2z1HYBuuXVayLw=;
        b=Wc2qtjjvz2wB8SyTn6dynB43V56tuomWy8LWQ6bM0o1ERdBQ+Je9B1OAU3fdhuLCQD
         TqjNDBo/hHWH1umZ6EzIqGlsctD4TtsVBt4jVwn0dRcx5AcubwVIUqNJ0wtW38LMxdMa
         vFlIQ4oAUNdaLCQfU20oqJenDf1KSZCHvjk68sjqt+mVBwseuZCQIZ0EZnFtCmVI9iGH
         +Ks6ki6jn6uURwH+b6MqSYS5qFnALIUkcJ492gGRGAc/QThExwuWALb6XNfp+P9CRFI6
         99M/PNSPsnmy0EEuVDvGlajwr8RICddNZv+cvx4n984Z+3pbfnNgw8l2fCXXUBfMpD0Q
         f3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852038; x=1757456838;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzD65PaAJkA8qRlCZYXV02FKe4apg2z1HYBuuXVayLw=;
        b=HnV4iv+Xs5hrrF6AmkJBSFiuyPgKhF/i80um/ciILhnJj7XYw47ESRp4XGiLSm82rZ
         22e/dQhh+IYVRWTC7WHGvoV8htxao1rocIIS/5Bq76QNuscFMeHw51fKo8EEyV7JARDm
         BtdtY0FPI7VA4/FKvH3IOy1AM1lD28+Zqy3md9coc2WE+yjs9htUv/E7a7tNzW5xwPWe
         h/un9JWQ8zBTgOSMzHRpg2Whn+KflUJKp/OL7YNiXUVR0xB3SM1mVzs7Jywqz3ts6BBt
         4fB9Q7pI7v048hE6WpkYMjwj546WfJvu2QnLOdPKl5zBaJd02tUvw2fQLxQVNMbBMR7h
         c6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXweJL9YBgGboa9Q5IJGfKsKcJV6TEy3iYP0hQx5heaXnVIYC/jp4gzfaaA9/UhhcBrsRAPm3QY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5qCv7fD923N9PbU2xn2RhiF+RpRWN8hYEG6rnQBqIBuf6y+p
	ICqjN/xrA1TISEBQ56V9S2/7vdapKis0jX3FV5qVR59WF+l7DnxdbTMu/lBTuKSTcbQ=
X-Gm-Gg: ASbGncuuBFPOMk6CzX2AcDKiPZWGp5BKJnH9IrEZZFvRMztnaPpvvC3yTJnLotG4vWy
	86DF49PGOzsdM3BvBr9fIPNUPAGxlKtf0zkUtjlf/abkepnmZ1Un3BUnZYcIxIg0kEPH/HTCv38
	ol4Cw8t+FaZvEzcy2lfYs+EYY+SyNoVnSrV/ZkQZ2YsAUsp2fcAJRoEpPKdBCgtdr6FM2r10PjU
	mjLlO8vg+3kGwQwfskY2Hh/XXYUdB7gQkOWdnxlbFO9SRtt55wIzKYxzqj954rpEzj4GHwO3JRz
	TBv2D7mbl6/RwXMaTCulIuCoj2z7bjWF05/UPqbhlhYt165QaW4P6K+NjoR72/WOeGkPjHPrP+H
	MNWEDUymib1lmkDhXqgd6QcnG3aHvhIGHAE6D+p3rzrYecWB9WdXeh5PyfUNoqg==
X-Google-Smtp-Source: AGHT+IHsjiNRH3/3m6/0auq2GXXY0wRA+grJoi8LQiE038AvG4VVzHR9N1oqZso390zsQFCpGcQ2Qg==
X-Received: by 2002:a05:6000:25c6:b0:3cb:c173:86e8 with SMTP id ffacd0b85a97d-3d1def69b6cmr10712292f8f.47.1756852038440;
        Tue, 02 Sep 2025 15:27:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad188sm12802364a12.26.2025.09.02.15.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 15:27:17 -0700 (PDT)
Message-ID: <a32bfa7e-4873-4abe-96c5-2fa4e35b7ce2@suse.com>
Date: Wed, 3 Sep 2025 07:57:09 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: add commit IDs for kernel fixes already merged
 upstream
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <c2806ea741c0f0d185930c30dbc334bc1fbbfbd5.1756823100.git.fdmanana@suse.com>
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
In-Reply-To: <c2806ea741c0f0d185930c30dbc334bc1fbbfbd5.1756823100.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/2 23:57, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Replace the commit ID stubs for btrfs/301, generic/211 and generic/771
> with the commit IDs in Linus' tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/301   | 2 +-
>   tests/generic/211 | 2 +-
>   tests/generic/771 | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 7f676001..f68ea03b 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -19,7 +19,7 @@ _require_xfs_io_command "falloc"
>   _require_scratch_enable_simple_quota
>   _require_no_compress
>   
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit 7b632596188e \
>   	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
>   
>   subv=$SCRATCH_MNT/subv
> diff --git a/tests/generic/211 b/tests/generic/211
> index 6eda1608..f356d13b 100755
> --- a/tests/generic/211
> +++ b/tests/generic/211
> @@ -15,7 +15,7 @@ _begin_fstest auto quick rw mmap
>   
>   _require_scratch
>   
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 6599716de2d6 \
>   	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
>   
>   # Use a 512M fs so that it's fast to fill it with data but not too small such
> diff --git a/tests/generic/771 b/tests/generic/771
> index ad30cc0a..ea3e4ffa 100755
> --- a/tests/generic/771
> +++ b/tests/generic/771
> @@ -25,7 +25,7 @@ _require_scratch
>   _require_test_program unlink-fsync
>   _require_dm_target flakey
>   
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 0a32e4f0025a \
>   	"btrfs: fix log tree replay failure due to file with 0 links and extents"
>   
>   _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"

