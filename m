Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF43367B69
	for <fstests@vger.kernel.org>; Tue, 19 May 2026 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228496; cv=none; b=X7v+Xilq+8U1MT51OI5xl9w1dVuKV2SoBIJLrde6x2DVEC9Z3ICo+Eigp7UmUuVYovqo/GvHZs3GETb9d1QCJG1J+Fs1m2FDIivLnQ3/bVHTRaaP2cbYOoqrpeAuscDHvoHVha/r98qK1YFrY/7eyWBBtOaZZmMYNeOipworGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228496; c=relaxed/simple;
	bh=3SYkAKMKmsj9uqnCFrPK7q+9UsRrRcHRsqrMZ0/L6js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwlG8+uUfZFIHdcpbxin9dmIpHLZA2dl40xwjXyRl4GTOTVVqJ1HnqPPZ9W5khYBnilsX0jdxChCC4z5sUOUkxjlrfiVs86n9JL+336M1CtlMdAPcc0NLjIzJTe8Rz/wVojuwCUtKVvEJAaMLyHd9pXbXXKTfcdmPpkIa3o+3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QeqZATId; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QeqZATId"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso35471085e9.2
        for <fstests@vger.kernel.org>; Tue, 19 May 2026 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779228493; x=1779833293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TTI4dCi8ZZO20f9p8Sjn/cedZ/ywBXVVUaaJuI86fdI=;
        b=QeqZATIdUjyWV7b5SnAfAMW1glvnm/99/OTsExPqD7zD1KWxCATXj0zRTimG4knloZ
         BDFnLEaamcRbha/DJP6x3sSbpDyWdJwfcdrcpXHkK2ziivL1zE/aGFS2NYMIpecNqyBt
         w68d2K4AEDC6NUmA+xwW1+YAjxcs/EqEo2iM5ARnl1MfCH8+1AOSJDKrW1pvyy4GUXRu
         pE/GgT0xwZ6HAy5+ZybTwgQ5r6S38JiZFG7hSKFM/YHE+9b5mMWhXdybFWs8TIRNMxrA
         gDDcrAbLDWmVnp5IJDb+QnjVCc2QuVHfKzYBUuH/bi1kODj31Bi9BGaOEMVbSvkNM1DR
         gOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779228493; x=1779833293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTI4dCi8ZZO20f9p8Sjn/cedZ/ywBXVVUaaJuI86fdI=;
        b=Ia6dNYzAJl5FORvg0OrP31ywEfYObgTaXS8I5Q0lWAIIDYBiPiAfG/elh5US6opkkD
         AVs+dO5dPWec0u9kS6MNvqQiXUiJA7+erXSxvyUzm66/K6HS1bD2VyTAVUNMpyCV0L7/
         dkA4XqNAin1pp2WgSCAa0OuUOINlBjy3QlX4hdOF4DC3Vbfa5EHyy/Y1P16CvIMDL9tx
         G945KMq2X7bfXr5Vz1ec92KiVHmdZiMC5FRjqqwQFWL48D5nxRw8WLXkzVbe7dIvpSEA
         rTcJLvPvzkj1x7FRcoUNMlSHtQzzIzD1Jsr82NfVRW6ZJ+HRwaV267z24i16ONhCuhYN
         VaqA==
X-Forwarded-Encrypted: i=1; AFNElJ9IXLGN+OGJpkAxre0QUxne0rGEytPSZPIKmAzjlHXkRcxrIkJms9iDfGHdwDjhgVsxIHPSHNF2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgt0S+pGmRgMletVgS7rJPN6uDN+82h1Bhw/v1B/AXjNZ4gUvo
	mjqpwxukfqATDEydMS7Q15AmWx5yd0Gsnha5gVIGfDkRIUjFAn43lTzBhqeyfRLVQeo=
X-Gm-Gg: Acq92OFq/YYpmusYG/rnuJ9Hq0IgTOxjeov2aC2pFc0Itd65/eCZU/PZiHSbCWowt3z
	8hJxFJ6egO9ly5YsgVCSz1chx76ehXDutjjDAfLYzylUI0xY3bSy1cqoLEaGHkgyl0D4cHsTs7h
	aC9/Xf5H5O+fPqGs5WTuhnczQHTej+WxTT7zAli+T4PcEwt1jWp8GVSgLLw7fH3TcAX2Jiqhxbl
	70p5lFvb1of+o6YMQdZmLBDTDcRSm936v5QKRfo87cImxOhTsEmlmrEh3uCT+CgqRHt45d03gKn
	385wgAmE4AHpq9pqCABoI4j2S3GUYQgwnB1/HZaR2UUX2IxUxU7SGQ1aivXWG7POa9cHmaAY2nr
	okwk8Ua3iFuTV4fIoPielsTlCbEj34ykY9INXLt/745+36efliD85LuJQd3Q1bdfP+K+2gzZJSm
	CyzqqvX788Z0Z4FAwF4aXlOQ3qv/LO4shgShEgsEW1slQzmEc9d3wwqyoSLfNYB0Q/4Nxuqia0p
	PnmodByx5qni/4R5YiQIS8jsdbvSxwnYKbMqbtFEy3LnWo=
X-Received: by 2002:a05:600c:4692:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48fe6326445mr340218615e9.21.1779228492777;
        Tue, 19 May 2026 15:08:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c77162sm20844701b3a.40.2026.05.19.15.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 15:08:11 -0700 (PDT)
Message-ID: <9d0bb7a4-7179-4d52-b3f4-0b67c0ed0352@suse.com>
Date: Wed, 20 May 2026 07:38:02 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: add a test case for fallocate i_size extension
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <a92aea73a82100f1dfde58e6f64191bed1d7f41d.1779210827.git.fdmanana@suse.com>
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
In-Reply-To: <a92aea73a82100f1dfde58e6f64191bed1d7f41d.1779210827.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/5/20 02:44, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test an i_size expanding fallocate into a range beyond current i_size that
> already has a preallocated extent, with an unmount and mount after each
> fallocate to verify that no metadata (i_size) and extents were lost.
> 
> This used to fail on btrfs when not using the no-holes feature (which is
> a default since btrfs-progs 5.15) before this recent kernel fix:
> 
>    c562ba61fc5e ("btrfs: fix incorrect i_size after remount caused by KEEP_SIZE prealloc gap")
> 
> So in order to reproduce the failure when using an unpatched kernel and
> a btrfs-progs >= 5.15, one must run the test with:
> 
>    MKFS_OPTIONS="-O ^no-holes"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/generic/795     | 52 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/795.out |  5 +++++
>   2 files changed, 57 insertions(+)
>   create mode 100755 tests/generic/795
>   create mode 100644 tests/generic/795.out
> 
> diff --git a/tests/generic/795 b/tests/generic/795
> new file mode 100755
> index 00000000..299c8134
> --- /dev/null
> +++ b/tests/generic/795
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 795
> +#
> +# Test an i_size expanding fallocate into a range beyond current i_size that
> +# already has a preallocated extent, with an unmount and mount after each
> +# fallocate to verify that no metadata (i_size) and extents were lost.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick prealloc fiemap
> +
> +. ./common/punch # for _filter_fiemap
> +
> +_require_scratch
> +_require_xfs_io_command "falloc" "-k"
> +_require_xfs_io_command "fiemap"
> +
> +_fixed_by_fs_commit btrfs c562ba61fc5e \
> +	"btrfs: fix incorrect i_size after remount caused by KEEP_SIZE prealloc gap"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# The fiemap results in the golden output requires file allocations to align to
> +# 1M boundaries.
> +_require_congruent_file_oplen $SCRATCH_MNT 1048576
> +
> +# Create our file with a size of 0 and a prealloc extent in the range [4M, 8M].
> +$XFS_IO_PROG -f -c "falloc -k 4M 4M" $SCRATCH_MNT/foo
> +
> +# Unmount and mount again to remove any in memory state of the inode. We will
> +# verify later that neither metadata nor extents were lost during unmount.
> +_scratch_cycle_mount
> +
> +# Do an i_size expanding fallocate that overlaps the previous prealloc range
> +# and extents past it. This increases the file size to 9M and allocates an
> +# extent in the range [8M, 9M].
> +$XFS_IO_PROG -c "falloc 7M 2M" $SCRATCH_MNT/foo
> +
> +# Unmount and mount again to remove any in memory state of the inode. We will
> +# verify later that neither metadata nor extents were lost during unmount.
> +_scratch_cycle_mount
> +
> +# File size should be 9M and we should have unwritten extents in range [4M, 9M].
> +echo "File size after cycle mounts: $(stat -c %s $SCRATCH_MNT/foo)"
> +echo "Fiemap output:"
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap
> +
> +# Success, all done.
> +_exit 0
> diff --git a/tests/generic/795.out b/tests/generic/795.out
> new file mode 100644
> index 00000000..b2f78ac0
> --- /dev/null
> +++ b/tests/generic/795.out
> @@ -0,0 +1,5 @@
> +QA output created by 795
> +File size after cycle mounts: 9437184
> +Fiemap output:
> +0: [0..8191]: hole
> +1: [8192..18431]: unwritten

