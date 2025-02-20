Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3B2147E9
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087375; cv=none; b=gPkoQmEdz4Rctqzo12vuyN3zK0u+w1JdaJL8uxoaDfnwQ/KVVkMJWHqBB37kR5DES/ZfvnD5DLoAEJB579yvjvetZmcu1SNr6NVpKIargdtMrI0W/dBe1h+LOwujlgZjtfNJ5+jLD4CmeaB27tS+U5CFWuuy5erIcRc9wrtB5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087375; c=relaxed/simple;
	bh=W2qouT1kiRqLS1PsWmOnd/7frxrlfkMmPn135XxhpV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQ8/+jgcXeCFfYWmvj/pEi/Qfv1jBNtSvTP3ltSDnKSwLVmRegEHCd9FA3ONWkcNGmqD8d7xeo3av48GXZ6+gSkpcQta6IUSASQzTF01pafOxs1XS4o3PvatuC/ohg8ecucJnNsOPFmfGfHOyn1rqHgRnMWVb/Gmtvt7x76gtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FwwCn8Kj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FwwCn8Kj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso1612799f8f.0
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 13:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740087371; x=1740692171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ir9iGmJAnofSbbqb7Jer5xgOtPP4PLQv+BEeabYkJw=;
        b=FwwCn8Kj3LErrJIsBdcULj4xrLZJbprH/AxACICmlW6ZJzkSO1Ndo21ga9yAhrl7Q6
         eqM66R1I6015TdWbZnbb5jL0dm5PSoPXXa1Rf4dUNSPbcSzbDA7e56xU5bZU8Ndx3UeL
         /OwJouV89Agvc49yhlQ3PYXVeREmz6IWFeljOjxZEMIlO2DJ42nDbYDiVDwNq3ulK7js
         6OOgdcZYcvFzHeSyJ00n7rZYFEv7iskGU/mfWF3qzomkPHfB9dQduk5hJHpgPZkkEiEF
         4veQgZELEA4E012//e6Wm0/i+Zs17dmxOdet18AAAG9+0q/qreGOhcsHPYEjkB2RMN6V
         U3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087371; x=1740692171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ir9iGmJAnofSbbqb7Jer5xgOtPP4PLQv+BEeabYkJw=;
        b=o2UeJ3hOZCKy2PqLW5StBbFsMeoWU7cflKQOyMWHRRdpSWjoRqRFMT5OacIyK3NWYu
         77FCphjz57JSm9XFKm+v+wt7pdHPlk+vXl8pN9hvocMqDRby4N8arcQMP8PoEA35iRDr
         eX3+8JSE2gBt5b0qibMOpth4kz3Cet+7kcGMw3sEGXYK7nt/PK8cBAv5rKTS3Tr1Inti
         ocUBjuDfOvW8JcDbHt5l3o0SudBZShFHq00Se4Fh4xrWo/KiJPeb5Sq419J16xzDx5Sh
         MhWepK2534jaOqx69FGwarG/v5orFIsNzlog4Kii84s9COHIKmF1xamz9iJkKbJ05fmJ
         wTNw==
X-Forwarded-Encrypted: i=1; AJvYcCWLQEhaYhZh1RH0N+7J3HpUHcqz1WdRODcSYERkts0jLaIXu8cCeg3GQc5926+WJvGr9jiECA8b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+O0YvghU/X0hAR2BSw+LLjPXFAIbRIm/BowOmAHgMEhOo1d1y
	2yFt5h0yON9gu/BsbQoO9URY2HjCoR5XYwLVWJO6pZuM3nk5oU/tDkAwCATusuI=
X-Gm-Gg: ASbGncvo3N7nI8xb6k3xK49N75SB6xfwNCUdP93PGSp9aQNcYBGyM/8NK6sZW4mm5AJ
	J670bP/Y9kN7SMcUVjvS2i7FvQaNASxXrAFG/Kg7ZdPLjleVwIBMKEEDgkXJK9Zwyg2HIl7Sf0W
	H1cwGm/uHSOitkG/lPfqkkk+zOJCM+jY+zJoBen1K2OktCR/acviedcvVn1wvAqcKxib+wfj6ZT
	9Is7tJ8Gv0oIBe8rDdNJ0g9wlII1uXkby2kNiHJ2wmDL6lt5a3zd3GADeXrPvpYTXykcE9/ZdLT
	ntRRn7w6+GQRIA2cStswgguoEJ3X2ItqE45t3AmtJ7Y=
X-Google-Smtp-Source: AGHT+IGIMJMi5u43P1HQoPJj1shFmW2z2GTw7Z9K1NHEnvU0h4S5/U/OyKwS32uf86QaFubLDPfTyw==
X-Received: by 2002:a05:6000:4026:b0:38f:3aae:830b with SMTP id ffacd0b85a97d-38f6163270bmr4563274f8f.26.1740087370797;
        Thu, 20 Feb 2025 13:36:10 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349047sm126625595ad.7.2025.02.20.13.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:36:10 -0800 (PST)
Message-ID: <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
Date: Fri, 21 Feb 2025 08:06:05 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
To: Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20250220145723.1526907-1-neelx@suse.com>
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
In-Reply-To: <20250220145723.1526907-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/21 01:27, Daniel Vacek 写道:
> When SELinux is enabled this test fails unable to receive a file with
> security label attribute:
> 
>      --- tests/btrfs/314.out
>      +++ results//btrfs/314.out.bad
>      @@ -17,5 +17,6 @@
>       At subvol TEST_DIR/314/tempfsid_mnt/snap1
>       Receive SCRATCH_MNT
>       At subvol snap1
>      +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
>       Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
>      -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>      +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>      ...
> 
> Setting the security label file attribute fails due to the default mount
> option implied by fstests:
> 
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> 
> See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> 
> fstests by default mount test and scratch devices with forced SELinux
> context to get rid of the additional file attributes when SELinux is
> enabled. When a test mounts additional devices from the pool, it may need
> to honor this option to keep on par. Otherwise failures may be expected.
> 
> Moreover this test is perfectly fine labeling the files so let's just
> disable the forced context for this one.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/314 | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 76dccc41..cc1a2264 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -21,6 +21,10 @@ _cleanup()
>   
>   . ./common/filter.btrfs
>   
> +# Disable the forced SELinux context. We are fine testing the
> +# security labels with this test when SELinux is enabled.
> +SELINUX_MOUNT_OPTIONS=
> +
>   _require_scratch_dev_pool 2
>   _require_btrfs_fs_feature temp_fsid
>   
> @@ -38,7 +42,7 @@ send_receive_tempfsid()
>   	# Use first 2 devices from the SCRATCH_DEV_POOL
>   	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>   	_scratch_mount
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +	_mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>   
>   	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>   	_btrfs subvolume snapshot -r ${src} ${src}/snap1

