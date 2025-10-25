Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06792EAD0F
	for <fstests@vger.kernel.org>; Sat, 25 Oct 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387219; cv=none; b=iZRKS5NjKNNG2jsy6YVGgQqFF2BmMMBfzZkyisAhIJ+GFL/aXqCo1ydARSCv+d5ifmTzKGA2xxgmiA4xs8CZXzcsro9Tda2pY9W1fGWS6HL9P2y2psa/LONkmsXGXogMrJ9cUinngD7kxGgaDDAjiZM4iDu7V6a7yZi7UO7CRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387219; c=relaxed/simple;
	bh=x5Zfju5tq/4qygh6E3gfDeoUeTXHi3cFBw2ntwHfFhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI4EdySzu+WNO59h2ezcQ8lhNOWOpRI5gZvTROmTmeEF87cDsB/GgrPqUbzlTtOUYNa/4prPl/2/mn8cnA7rN1Nd8KWxL/UFkS3ORScc/gE+GHMjooPhhChNv9FvFdnwltWTkonTeGaEWdd5j9N1F1k7ogzESvP1on5koxvD8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JKfg2thk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JKfg2thk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471b80b994bso41071835e9.3
        for <fstests@vger.kernel.org>; Sat, 25 Oct 2025 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761387214; x=1761992014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9PtPsexDpDiFXe6bvXUwGadaGf7cY3dlOxZFz1GquK8=;
        b=JKfg2thk4sZUJCYxN2uE2h6h1iV+dNatEMrdGsVpGjRkZd6LUT61vo00SshXeUSRsO
         eyoPMsBodYIt7gopEMt6EkBM72QkXx3pwLJJlTrTnXVAytPpGch7O+8a4UDtFADBk1up
         CH8LBsjwEknlj8uXtnIvjgU1p9oB9lMfIDCOkoAw03JNdJbBYdxwVx99SHYLiezo9jy5
         kcFWYvnE1LdhG3yU7AY3k1ZupPuP5PySQugt0a57A5rPPAyE0Vz7Bpc54DiivciT0vUP
         0o756pl2WgLu7xcQPr+4h1aGjZWgrirWpeX7WnWwTfVy3WAkWMup4FFAxfJOgxoexDpI
         aLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387214; x=1761992014;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PtPsexDpDiFXe6bvXUwGadaGf7cY3dlOxZFz1GquK8=;
        b=R8LeV8SRD3ByvywI80jnlmLIMIK6jRoNv/+5/2Jq+aZ6Q5unvPgSFhJUkJghc0iMQH
         mY/w0CR6GTWEfHxQvtU+G/YSCUtbBIs/AyTahcbRIqj6IWY9Fn/mDhTkUYnSdAoq+QWZ
         KfjcxE1e3OhZnJgp2dkdbdUZXUZhz7jgMfMPytK3mgGmU5b/EHXXDc4QV5uHRIopsopr
         jyt2BARnJfFDHovnI8aQy2+kptSL2LjpultUP/maUcZMNLV6UvwGPn7uh4Af7gtxkhRe
         uKbBv2Rtm63MI9m80UcnHYMQynPdHGiZ+zaezyZ9DMm35M8Z0fMp7FbvRQW63OtwgwED
         HOLg==
X-Forwarded-Encrypted: i=1; AJvYcCXiF450HF5vhpfrVY9KaQWiqVu9MosYHxKk3ywpHzl7qbDHYXJ8D8ShHBCwg09+CfVdbOZ1qs/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4rVPy+vvDg1B6p51vHMQX4fdfyEHhHAQw0nPzWL+r40fxVnq
	wt5BE9zTWcHMq4xMLFOIiOoh/X0nTp6eXIulZBO+Nr5w9x31lX+5yXRm75/hDRMtbL8=
X-Gm-Gg: ASbGncs/hqQghgC/E3asC4CX5MPR6YQOToIkqWNqAR3L12Cxky/WkYLHn/Ahug6hqSr
	M6mSLl0rSV+jXBAqVIFSFwTmKMxUVKyN3qGhEHtocTojfydiq/561VJZIUvd1FZJdw+5M4t3jNl
	jHd35JG373qLwDahm/NHrpsf3LsE6Zo4+0VlCu4nE3Omkih3Y/q1qfc4PL7qkf8CAS6KLci4i2T
	F4BYhFnIjifrEOcjrOkb7Rsi8+3qsCIRaAc7ClivdOdhgjyKEBviAfbjcTh03d/K50wxwHjtpKF
	InvAkfCJCsQbANfxuqLBBI+rOElUsjDvdwNhx2uiBrE8mJt4PeRHkjvCI5y1nwjSEe6ZQ4nIoWl
	Cqt8kOO1qFRSwZfSH45CJj5pbWUz6lbuv+P5Trj/cCYmJ/vHpgZ8HO6Wf3lxOWy2HK4wxygXoBj
	DhPtw9ZytFid87rCujXskp7yDX0hyUzXXdnLm8yEs=
X-Google-Smtp-Source: AGHT+IHJYhhAB98ygsyvpxZ4Q7D8SToFy9rFnyfTSxKbc6zRFxwpSVGA7ABW+SJh7DeencBNdAEA9A==
X-Received: by 2002:a05:600c:3b0c:b0:471:669:ec1f with SMTP id 5b1f17b1804b1-471178785e1mr246763685e9.8.1761387213804;
        Sat, 25 Oct 2025 03:13:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e44262sm18560465ad.102.2025.10.25.03.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 03:13:33 -0700 (PDT)
Message-ID: <bb46518c-9836-4bd2-8142-fbb8c859fd3f@suse.com>
Date: Sat, 25 Oct 2025 20:43:29 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test fsync of directory after renaming new
 symlink
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
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
In-Reply-To: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/24 22:23, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a directory that has a new symlink, then rename the
> symlink and fsync again the directory, after a power failure the symlink
> exists with the new name and not the old one.
> 
> This is to exercise a bug in btrfs where we ended up not persisting the
> new name of the symlink. That is fixed by a kernel patch that has the
> following subject:
> 
>   "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/generic/779     | 60 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/779.out |  2 ++
>   2 files changed, 62 insertions(+)
>   create mode 100755 tests/generic/779
>   create mode 100644 tests/generic/779.out
> 
> diff --git a/tests/generic/779 b/tests/generic/779
> new file mode 100755
> index 00000000..40d1a86c
> --- /dev/null
> +++ b/tests/generic/779
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 779
> +#
> +# Test that if we fsync a directory that has a new symlink, then rename the
> +# symlink and fsync again the directory, after a power failure the symlink
> +# exists with the new name and not the old one.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_symlinks
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
> +
> +rm -f $seqres.full

Looks like a rouge command?


Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test dir and add a symlink inside it.
> +mkdir $SCRATCH_MNT/dir
> +ln -s foobar $SCRATCH_MNT/dir/old-slink
> +
> +# Fsync the test dir, should persist the symlink.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Rename the symlink and fsync the directory. It should persist the new symlink
> +# name.
> +mv $SCRATCH_MNT/dir/old-slink $SCRATCH_MNT/dir/new-slink
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# Check that the symlink exists with the new name and has the correct content.
> +[ -L $SCRATCH_MNT/dir/new-slink ] || echo "symlink dir/new-slink not found"
> +echo "symlink content: $(readlink $SCRATCH_MNT/dir/new-slink)"
> +
> +_unmount_flakey
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/779.out b/tests/generic/779.out
> new file mode 100644
> index 00000000..c595cd01
> --- /dev/null
> +++ b/tests/generic/779.out
> @@ -0,0 +1,2 @@
> +QA output created by 779
> +symlink content: foobar

