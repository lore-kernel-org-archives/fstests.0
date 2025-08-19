Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242735336D
	for <fstests@vger.kernel.org>; Tue, 19 Aug 2025 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641462; cv=none; b=L40vgWQGLb84T8/mmo64mZUSP67Zgx+z2O+msv6TI9IpotNAiU32FLXSthS6hKUGFcfLW61J6XtjKVw5jxY1/qbDqQlvEPNFBDi6qWw7nH1Jeyc9cEUGcE0mxOnmLj+Mmq8Uo426bNlI4/NBIs1QOP+uUohwzWkkddkVGSB1f5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641462; c=relaxed/simple;
	bh=L+ibI2ccVWRrG01vWzftJwOJ8ML1WNE6uslsrQR8XRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XifCGQuSDSDLRrYWtrz0eweyd0polaORn9Xv2D9buYM35zGIvtTLw/drSvJ5A4a18Xn9nHjKNMcASiRdGhAxpRdzlwoxMnRtknctAc6iWbDyyGF64GeAZXWSZwtQm8QRwBjs01omxv8dbkg9v47T22dTdS9KA/e5ONHR/aYDW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z7b79QT4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z7b79QT4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so3860583f8f.1
        for <fstests@vger.kernel.org>; Tue, 19 Aug 2025 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755641457; x=1756246257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5EPwkk2h2VvlQX+uHcqGHZ+eDnoXbcMRAI677RCbbcs=;
        b=Z7b79QT4osP1Vt+kBsaNCtj3C5AGITxwA9W/peDL/w3BQ+nMTXRpZHjgu5KMCBFoX8
         Fz6GllTXXopJMJBrGDZIFoSth/RDmd9y9/nl5ClXXlOq6pRHsRpm/EccJKj0GOBLslv3
         EdbexDxZ3j98v/gdyKBiuBWkxa0OncSzX2BO+QDL+MSXE8cUKxNmp5EcPhi9SJrQksRc
         1smGSD8GEVRnyfwiOOFugRwgGqKpVH/VvokFm3COOc3/lKb9mpcCvFHce6C91WLNzhDG
         4wIm9kRu0fg+E33ApCDg/Q7gPugINy8ZJh2S1PDGcquU68ChYXtT2mE5ihONWjfKeJzC
         DFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755641457; x=1756246257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EPwkk2h2VvlQX+uHcqGHZ+eDnoXbcMRAI677RCbbcs=;
        b=SHKYA9EV2nzkZ6AjRNwjhARgcZCrqnVYOfXup0Lwu2EpAOlNsGIFqLiEQS+RM2Kb/u
         b6vAxIR+vTZZFfTB6suK7FqGAjPyt6ONnOpJmTa17Wq+KpDwTtvV2eG/aVcdx8KR07w0
         ek3xdH2SaPa1687b/mARd3FbWU+8H+2sOOOHt6HD2Vd5L4LRLo3xpMvUZYmp5/I+Krke
         wjmRjknRh94fe/ysY8ShjLCXBO03dU5BNBXq8KkFbJYXQEOCzaiROxQ2SwGPwR7UOljT
         CJOnurQhUVI39Z4QP2e9ryLeqC2NUqEQ9GE3EDarTy6lb1T1gyLg2TUIc4IJuofBEtb6
         4aXg==
X-Forwarded-Encrypted: i=1; AJvYcCX/qU9/pdqZpMmarrblA/GqK+6619qBvYiClPvz2BTMNuXFrybtqgDyKQbA/+aco1y/D1jxPcAp@vger.kernel.org
X-Gm-Message-State: AOJu0YyvP4otOHuFdN3XyypsDjaaQLUBy/LrceKtp5ZOwu8y4x8Bmv9j
	O9mHLgl5NAM1+MTAR9lqRiVuENl9DO7FopV0OPrJqCHdKwRfqwHA9MG+EmpbezVMiT0=
X-Gm-Gg: ASbGnctopJxxsjmrs4hO2OYFuic7SLp+QH5kdRgROzMro5NWIM+DXjsD47ECIeMwHLj
	qcCjEEq0Hj8yg0ylS8kEZ535DgTU96QKegzuXR+VvCi5r56CmAgQXhH13nZ03/1xQQ+Pz4csx1z
	nEUO9jCY9E0UbQck6LE4S4AskjUyDtI7TBsa59VJlzk1wps+yJha9PHpbTm+yFqd6u1BVlefHfR
	vOUqHVDQlMH/7jos+gcBD4geZr4ACPhJSyrnlKq5uUQ3AI+6RGCzlMiEBJmzAsXsS7QRGnFScA3
	M0zMppG67/+wO8mMWoU1etWGF1xWvRwofPFi/GnM1VOEHbHktunaz/y/PxzOMBTcUYBBSXdBJgn
	WsXpa02YCX8xx+909xtNmzaAFUnZsOtSl3LgFF+HuiMF0fj1Rl5I=
X-Google-Smtp-Source: AGHT+IE/3VfVJ1H2279PIyB5U+f9dzhyqd3s626g58t/jpNuGOyO3pIPe1PF1Nig7qWbro6hi7z9QQ==
X-Received: by 2002:a05:6000:2483:b0:3b7:8b2e:cc5a with SMTP id ffacd0b85a97d-3c32f75b3acmr335941f8f.40.1755641457311;
        Tue, 19 Aug 2025 15:10:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4f0esm3264121b3a.90.2025.08.19.15.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 15:10:56 -0700 (PDT)
Message-ID: <06028d7f-6835-47e5-937c-915f14311881@suse.com>
Date: Wed, 20 Aug 2025 07:40:51 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] btrfs/137: Make this test compatible with all
 supported block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <2d3037bcbb0e5cd51b81bdb8f4fa61397f74dfa6.1755604735.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <2d3037bcbb0e5cd51b81bdb8f4fa61397f74dfa6.1755604735.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
> For large block sizes like 64k it failed simply because this
> test was written with 4k block size in mind.
> The first few lines of the error logs are as follows:
> 
>       d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> 
>       File snap1/foo fiemap results in the original filesystem:
>      -0: [0..7]: data
>      +0: [0..127]: data
> 
>       File snap1/bar fiemap results in the original filesystem:
>      ...
> 
> Fix this by making the test choose offsets and block size as 64k
> which is aligned with all the underlying supported fs block sizes.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/137     | 11 ++++----
>   tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
>   2 files changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/tests/btrfs/137 b/tests/btrfs/137
> index 7710dc18..c1d498bd 100755
> --- a/tests/btrfs/137
> +++ b/tests/btrfs/137
> @@ -23,6 +23,7 @@ _cleanup()
>   _require_test
>   _require_scratch
>   _require_xfs_io_command "fiemap"
> +_require_btrfs_no_compress
>   
>   send_files_dir=$TEST_DIR/btrfs-test-$seq
>   
> @@ -33,12 +34,12 @@ _scratch_mkfs >>$seqres.full 2>&1
>   _scratch_mount
>   
>   # Create the first test file.
> -$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 4K" $SCRATCH_MNT/foo | _filter_xfs_io
> +$XFS_IO_PROG -f -c "pwrite -S 0xaa -b 64k 0 64K" $SCRATCH_MNT/foo | _filter_xfs_io
>   
>   # Create a second test file with a 1Mb hole.
>   $XFS_IO_PROG -f \
> -     -c "pwrite -S 0xaa 0 4K" \
> -     -c "pwrite -S 0xbb 1028K 4K" \
> +     -c "pwrite -S 0xaa -b 64k 0 64K" \
> +     -c "pwrite -S 0xbb -b 64k 1088K 64K" \
>        $SCRATCH_MNT/bar | _filter_xfs_io
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> @@ -46,10 +47,10 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
>   
>   # Now add one new extent to our first test file, increasing its size and leaving
>   # a 1Mb hole between the first extent and this new extent.
> -$XFS_IO_PROG -c "pwrite -S 0xbb 1028K 4K" $SCRATCH_MNT/foo | _filter_xfs_io
> +$XFS_IO_PROG -c "pwrite -S 0xbb -b 64k 1088K 64K" $SCRATCH_MNT/foo | _filter_xfs_io
>   
>   # Now overwrite the last extent of our second test file.
> -$XFS_IO_PROG -c "pwrite -S 0xcc 1028K 4K" $SCRATCH_MNT/bar | _filter_xfs_io
> +$XFS_IO_PROG -c "pwrite -S 0xcc -b 64k 1088K 64K" $SCRATCH_MNT/bar | _filter_xfs_io
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
>   		 $SCRATCH_MNT/snap2 >/dev/null
> diff --git a/tests/btrfs/137.out b/tests/btrfs/137.out
> index 8554399f..e863dd51 100644
> --- a/tests/btrfs/137.out
> +++ b/tests/btrfs/137.out
> @@ -1,63 +1,63 @@
>   QA output created by 137
> -wrote 4096/4096 bytes at offset 0
> +wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 0
> +wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 1052672
> +wrote 65536/65536 bytes at offset 1114112
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 1052672
> +wrote 65536/65536 bytes at offset 1114112
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 1052672
> +wrote 65536/65536 bytes at offset 1114112
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   
>   File digests in the original filesystem:
> -3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
> -d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> +9802287a6faa01a1fd0e01732b732fca  SCRATCH_MNT/snap1/foo
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap1/bar
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap2/foo
> +8d06f9b5841190b586a7526d0dd356f3  SCRATCH_MNT/snap2/bar
>   
>   File snap1/foo fiemap results in the original filesystem:
> -0: [0..7]: data
> +0: [0..127]: data
>   
>   File snap1/bar fiemap results in the original filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/foo fiemap results in the original filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/bar fiemap results in the original filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   At subvol SCRATCH_MNT/snap1
>   At subvol SCRATCH_MNT/snap2
>   At subvol snap1
>   
>   File digests in the new filesystem:
> -3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
> -d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> +9802287a6faa01a1fd0e01732b732fca  SCRATCH_MNT/snap1/foo
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap1/bar
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap2/foo
> +8d06f9b5841190b586a7526d0dd356f3  SCRATCH_MNT/snap2/bar
>   
>   File snap1/foo fiemap results in the new filesystem:
> -0: [0..7]: data
> +0: [0..127]: data
>   
>   File snap1/bar fiemap results in the new filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/foo fiemap results in the new filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/bar fiemap results in the new filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data

