Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6628382
	for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751245615; cv=none; b=qhSDYXg8Bn0bjUgywxWljRL/hhlptp5+1VIqXtnszYjKvq9L2URa8iN5Xyck6ZQs85eNNMDvH1QaUkTPYXV7fxbbX76ghIqOOfRLiLx3VfidulDYRFU8Mtd9i8EK2y7iks1giMQhnMRDhqCg7xhjmJ/aZdPwPwQs3eKvEBLR3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751245615; c=relaxed/simple;
	bh=r2Woouheibczhg8rD1I6Rw5r1Frknn41ygF2Jc/n9bw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ox1qCIv/PSX+wAVjBKU80bGyLi2Ryxcw5Z9K4pmH93QBFCE/heZc9nGjcYS5yBoxdVp3gFYz1uAz5IvS7mA/veRoJjDXY6EFHHGlTTjDLjCJDYbxvLw0AUeDp5UvkveDmhV9o70pTKzlGdM0sg5vRI+gEQD5irnnaAEbHqtwoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fI7RkWTb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fI7RkWTb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3070187f8f.1
        for <fstests@vger.kernel.org>; Sun, 29 Jun 2025 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751245611; x=1751850411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOrzMG4l1CxkU8Fqu5oNyslD1FbTkhi+OsLMOsshxFE=;
        b=fI7RkWTb7WqTV2Otasub7+AK6W+Vwdq2XoDms4qAoARnLVUJCwe98MUW+XkRES2Tja
         Lftc5NxQuNcmUSnW+7F0/Dvjd9oRGzHXtKYjs90NcX+xyF0NO7A534lWvXIv93WT8mxg
         J28e/DMOThogijEtxihtkkdYpshfMCyzAa5mTEBRXOxrqVLnWliOErm/48c+zqg2lk3H
         rMaw2nN29FTQg++zOrS/dbWLJ9Kxht5AYAOtJ/O5h8nQlg9/Jpkc2uzvfiuydG3weCNk
         1WAuIG1tzNuRtumU5SZl7hZKrZVhL0KNPavnN1xWH3wtEOtqR6HGFYMeOfMhD6Ri9bpQ
         CQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751245611; x=1751850411;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOrzMG4l1CxkU8Fqu5oNyslD1FbTkhi+OsLMOsshxFE=;
        b=AT0rjE7jEDX0X325N1y452xXSocae3kGJZOMdsZ8KAUGABjLoPBlN9pf8ct6XPgp7K
         kjydrJu+OmB9/Dd0hQCQhNEaWEW8O2yMCyAaJm4u5UQU/M2f8N1IVm+MKEVX2GIMlNr6
         pHHJ8dulAseqmvP3y7aSst2uu614qVv6UYRAdRoNhaWS9SoqTQWltrRNYmNusWTg/10I
         isjNDZIedDIKbZhO9n3quWMI3isEDOlaJeak0mAdRiIGZ9c2Xa65glf80BowNrBqhbH0
         dnh6SK/e3U4Z40vCLy1tY704X+supw7AOVdcSJgdz1EVgLpHhxJP9hbAjBDNigcI2ZH1
         dYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPEjO/HhLQInYLa7LkLMJV5OJ9E//tQOaRf5OFmJnbOohnc7qjTCrmoeJIVlgJ2LV3GwqPEsVB@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsvuhSkoIvD8oTEaB3Siuvw/yDw+/6mTNA7/46UVaIwM5RbPM
	cECdG9HRUXWqlgltX44oF9AqiyoOmgleDZrTadAIj40svI3O+71fSZpygIkKmUORWqk=
X-Gm-Gg: ASbGnctgZmlEChbqCuDl5JWEycL9O30fsRH3vIm6KLQfsUNZjYI+M66Cqw9GWcd9AZy
	0AhGw1zIEjI0JT8VFuo9TCEvDN1gGnwEysMNTUvGaHDRhU5NuskRSjO5gkJt/VbfJ6/fx0KHhNu
	zh6cVBfJUzoE9FkJ+2g+ZJzMi2wBMz4h2qBXDdAOSTX/UTUsmkx2lSeDcM9s1umGXjySwhkY/bC
	1wXt5OWPHsrO1+YJUe1+w+avt8J5ZVvfsOuLGk43BXOK5bclR6CZ9pDsIf6AQNDje3k5mQmFALD
	QFdG1187UOPvXiogpd21R6LGO8XFu55sDon9kTvFkRuu7TS5cy7/+emwsX7bKVpPq3Q7rMelgz8
	3PfTU4PmPtBYnNg==
X-Google-Smtp-Source: AGHT+IH9vGnjDGoH0S6a/Maso00iklROVFOPGIkkFxNhJHhCr0jYU86K3+2N7/NJS2Rv2dD6IdUP0w==
X-Received: by 2002:a05:6000:4211:b0:3a4:d685:3de7 with SMTP id ffacd0b85a97d-3a6f3102820mr12428029f8f.8.1751245611320;
        Sun, 29 Jun 2025 18:06:51 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e30201c1sm5901071a12.22.2025.06.29.18.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 18:06:50 -0700 (PDT)
Message-ID: <8fc4cf7f-20fa-4c21-bc6d-b661c99b2d75@suse.com>
Date: Mon, 30 Jun 2025 10:36:47 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: add proper btrfs log tree detection to
 _has_metadata_journaling
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250630010253.30075-1-wqu@suse.com>
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
In-Reply-To: <20250630010253.30075-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/30 10:32, Qu Wenruo 写道:
> [BUG]
> With the incoming btrfs shutdown ioctl/remove_bdev callback support,
> btrfs can be tested with the shutdown group.

Forgot to mention, if someone is going to test btrfs with shutdown 
support, here is the branch:

https://github.com/adam900710/linux.git shutdown

Thanks,
Qu

> 
> But test case generic/050 still fails on btrfs with shutdown support:
> 
> generic/050 1s ... - output mismatch (see /home/adam/xfstests/results//generic/050.out.bad)
>      --- tests/generic/050.out	2022-05-11 11:25:30.763333331 +0930
>      +++ /home/adam/xfstests/results//generic/050.out.bad	2025-06-30 10:22:21.752068622 +0930
>      @@ -13,9 +13,7 @@
>       setting device read-only
>       mounting filesystem that needs recovery on a read-only device:
>       mount: device write-protected, mounting read-only
>      -mount: cannot mount device read-only
>       unmounting read-only filesystem
>      -umount: SCRATCH_DEV: not mounted
>       mounting filesystem with -o norecovery on a read-only device:
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/generic/050.out /home/adam/xfstests/results//generic/050.out.bad'  to see the entire diff)
> Ran: generic/050
> 
> [CAUSE]
> The test case generic/050 has several different golden output depending
> on the fs features.
> 
> For fses which requires data write (e.g. replay the journal) during
> mount, mounting a read-only block device should fail.
> And that is the default golden output.
> 
> However there are cases that the fs doesn't need to write anything, e.g.
> the fs has no metadata journal support at all, or the fs has no dirty
> journal to replay.
> 
> In that case, there is the generic/050.nojournal golden output.
> 
> The test case is using the helper _has_metadata_journaling() to
> determine the feature.
> 
> Unfortunately that helper doesn't support btrfs, thus the default
> behavior is to assume the fs has journal to replay, thus for btrfs it
> always assume there is a journal to replay and results the wrong golden
> output to be used.
> 
> [FIX]
> Add btrfs specific log tree check into _has_metadata_journaling(), so
> that if there is no log tree to replay, expose the "nojournal" feature
> correctly to pass generic/050.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   common/rc | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 2d8e7167..a78b779a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4283,6 +4283,14 @@ _has_metadata_journaling()
>   			return 1
>   		fi
>   		;;
> +	btrfs)
> +		_require_btrfs_command inspect-internal dump-super
> +		if "$BTRFS_UTIL_PROG" inspect-internal dump-super $dev | \
> +		   grep -q "log_root\s\+0" ; then
> +			echo "$FSTYPE on $dev has empty log tree"
> +			return 1
> +		fi
> +		;;
>   	*)
>   		# by default we pass; if you need to, add your fs above!
>   		;;


