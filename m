Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF734071F8
	for <fstests@vger.kernel.org>; Sat,  6 Jun 2026 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737765; cv=none; b=IVVAKi1kuU2R7GBYC4lmWIQfoVBrQLKmaLvNobFuxYl98vCd4qvDSorm19Wf/Vxs/G2gkMrb9EOh0tSCy9TFCpPSyGURULULApkvWO6IjUg3MQxqeukfcR2WLUuzihOg+C9EilJHhm+3Sm+NMEi15dFnz+kVWNQrO0SonViN3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737765; c=relaxed/simple;
	bh=gKflb/wbZ6BW7LX/bbQvSSjmT1x2N++OD/0K2OK//zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EU13dQeIqMXOao1KotSpTBuL3lrZ72LtKBDxxIsK7bi7Kw5Ri1f9Xc9V3iNYXNbM790AMXblNF0XBBO7Y9q2KTDrDgUVK7Jwv4kPItPr78b7FLjTXpr/EACf5IuZHTjbNfgM8OgmQRk50f9rIPsZyB9/Zzty75TirsneE9t+cf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KnEpXnWN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KnEpXnWN"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bed4f2f0898so340593966b.3
        for <fstests@vger.kernel.org>; Sat, 06 Jun 2026 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780737762; x=1781342562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nWEsSAcx64Ea0Dvu6YbKN26tgp9EXTE1o4Ngb5NfW6o=;
        b=KnEpXnWNpWAGOZu2nENOBYM4z2/TL5FokaE1EhEd80vb5bT/JvjtaTZ6yq1UZHOO/5
         E49YOUTcIU2MWaCgwAjVPKeFvGvdqE4sMmIVO9AxNGyN66bNGit9XvXGo1s1PCVTFcEN
         oZ4M6YwSJUxZPHdK/dluMrZiKUNjhmUjRTKEwwhEpVGhV1OXV40q/6/yDUhipTCZXdLT
         UcRRTR7lYwApFzZisM6v5+onXnWNuy/gPyAH8S0Kro3VK0tbDDSEYgNaC6CqWmhXszOB
         vOzzSlDY3u9cZbpA47XKlQX6/L2NXHG9zYmoC5I1hd2O4cnapS/D37zI7D6hoIqEQbsC
         XgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780737762; x=1781342562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWEsSAcx64Ea0Dvu6YbKN26tgp9EXTE1o4Ngb5NfW6o=;
        b=hFLIQYNwRrjULADB0+BbBCDDrAKUHYnSeYnmSCTGtokZ6waHGS+xaOYL+4NwUWYPfm
         /TiBmsBFvQ/xwAy3YdbPkpR0aDSTgEZj9U9hdnceqHAOnUMhe5VuAkqy5jZtEOHcwHVa
         qj6DUqv0NKnUnB50Ux/rFlBgsFV62JgUX9CRc/fA791mGNH/JmJVXiAhF7FI24iT8tjn
         3yeVH8lQMdXe/pfDk/1ER0CXxc7FY1ERZJl1tFaLEXIsEitSKzXhTXqfGlm/VF2MmtHS
         ZwFcq0jOzbAYzWHqKxMmOD//e3+IJ2o4ZuKVw/Zb8FO/g/l1ypYeA0Xl5StSi2dzM2aw
         JjKQ==
X-Gm-Message-State: AOJu0Yyw6+5QGC1u3xLI5f9WIhXwJFoEP4VuEfiDZdgvH0BPajbXVIP/
	tBIGDAgrQu6gzJGbZ5S8S3OcdUsATmnC/ofJPL4ifBNByJLKZWE7JisGydahIUIjp8WMh0zthtx
	QB09b
X-Gm-Gg: Acq92OFV6vqnZ4YEfybsEyM0lg1TaKQBukDhgcbkv+e1+JDOCbWRBCLY6o4P8UNujS/
	ctQe+7L2vDYQFuQ7giewBjw3rqtGC6ahZHkRTXo4vLQOt9tJcVLtvy9vW5pllnjr/0nAonIsZfr
	3fuHOuBxyFUz4ujMGBDvoxPN1UOp3WmR0gXfodMNgylFrNPVieTlS06TSSHT+kmzdtFoFkg7Ic/
	+qIJBkRlnvm9GVPMq8zutaQpZewgjIjp1avkO9p8Y0sAOmJGrQTc53vjB5NwSwxYVptl2lsaqFh
	e4mht4FuoAQb0dESC1WoC2tVl8g5/r7SM0yrnRKEoCe2tnaKqLpVWVyOxbyTFsaDAulem6s9jTL
	vjj4E+YmV+WwpvS8m5eRgi+m5QdKlFD9zSj1znqRWlM+7NhpMCJm9cX3ThJsUYAxSgFncDswY4A
	zwq3cRxJwBVISBqA1pxva7SxKq7BbkEC6z8OZAgqDT2JFHSACBVHXb4vWsAC2WUCZKgLy0Hjpqq
	GELDCytf9p4SlDa66kp8JFXOvU+DAV5ItLxUPXuEYyxcL2u1Qb8E80ILQ==
X-Received: by 2002:a17:907:96a2:b0:bed:fc51:cbbd with SMTP id a640c23a62f3a-bf371e43389mr341529866b.30.1780737761876;
        Sat, 06 Jun 2026 02:22:41 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1:0:2bb5:f164:6e6a:38d8? (2403-580d-fda1-0-2bb5-f164-6e6a-38d8.ip6.aussiebb.net. [2403:580d:fda1:0:2bb5:f164:6e6a:38d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm11511149b3a.0.2026.06.06.02.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 02:22:40 -0700 (PDT)
Message-ID: <8d63ffbd-4e34-459b-9613-81f4b5210d15@suse.com>
Date: Sat, 6 Jun 2026 18:52:36 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fstests: use MOUNT_OPTIONS to populate
 TEST_FS_MOUNT_OPTS if possible
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>
References: <20260602001422.24364-1-wqu@suse.com>
 <aiGsok9xtmdM-q9c@zlang-mailbox>
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
In-Reply-To: <aiGsok9xtmdM-q9c@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/6/5 03:18, Zorro Lang 写道:
> On Tue, Jun 02, 2026 at 09:44:22AM +0930, Qu Wenruo wrote:
>> If the test config only specifies "MOUNT_OPTIONS", but not
>> "TEST_FS_MOUNT_OPTS", the mount for TEST_DIR can have inconsistent flag
>> after _test_cycle_mount().
>>
>> Here is an very simple test case to show the problem:
>>
>>   . ./common/preamble
>>   _begin_fstest auto
>>   _require_test
>>
>>   mount | grep "$TEST_DIR"
>>   _test_cycle_mount
> 
> AFAIK, TEST_FS_MOUNT_OPTS is designed to be the exact counterpart to
> MOUNT_OPTIONS. The former applies to TEST_DEV, while the latter affects
> SCRATCH_DEV and any other manually created devices (such as loop or dm
> devices). Therefore, when testing custom mount options, better to specify
> both parameters.

Thanks for the explanation, in that case, I'd say we need to improve the 
docs, to mention both MOUNT_OPTIONS and TEST_FS_MOUNT_OPTS.

And even better, rename TEST_FS_MOUNT_OPTS to something like 
TEST_MOUNT_OPTIONS.
MOUNT_OPTIONS and TEST_FS_MOUNT_OPTS really look like they come from 
completely different worlds.

[...]
>> - Not sure if TEST_FS_MOUNT_OPTS is needed
>>    If not provided, the default config for TEST_FS_MOUNT_OPTS and
>>    MOUNT_OPTIONS are the same.
>>
>>    The introduction of TEST_FS_MOUNT_OPTS is from commit 0e9141e49d4a
>>    ("common: add cifs support"), with extra handling for
>>    _test_mount_opts().
> 
> No, actually TEST_FS_MOUNT_OPTS is far more than that. For example, you can
> check commit 3839d29973, it has TEST_FS_MOUNT_OPTS in _test_mount. But at
> that time xfstests was still under its original form, there was not common/
> directory.
> 
> Then 8c4905a4 create common/ directory and common/rc, then TEST_FS_MOUNT_OPTS
> started to appear in common/rc:_test_mount().
> 
> Then commit 0e9141e4 brought in _test_mount_opts for CIFS, but it didn't change
> the logic of TEST_FS_MOUNT_OPTS for TEST_DEV mount. And we can learn about why
> CIFS need a seperated TEST_FS_MOUNT_OPTS from its wiki link:
> 
>    https://wiki.samba.org/images/9/99/Xfstests.local.config.txt
> 
> Therefore, TEST_FS_MOUNT_OPTS has been dedicated entirely to TEST_DEV by design
> since the very inception of xfstests, and this principle seems to have remained
> unchanged. The real issue now is that we run into a conflict between
> TEST_FS_MOUNT_OPTS and MOUNT_OPTIONS when the helpers try to detect features,
> particularly those that depend on mount options.
> 
> As for whether TEST_FS_MOUNT_OPTS is still necessary, I feel we need more
> discussion on this. Some upper filesystems might still need it, and the original
> purpose of keeping it separate for XFS testing probably deserves a deeper look.
> (CC'ing Dave Chinner, who might know more that that history :)
> 
> About your current Btrfs tests, I would highly recommend specifying both
> TEST_FS_MOUNT_OPTS and MOUNT_OPTIONS at the same time. (I always do that
> actually).

Sure, I'll also set TEST_FS_MOUNT_OPT in that case.

Thanks,
Qu>
> Regarding the feature detection mismatch, a quick fix could be making TEST_FS_MOUNT_OPTS
> default to MOUNT_OPTIONS when it's not set. That said, it is still worth double-checking
> the initial purpose of TEST_FS_MOUNT_OPTS, just in case I miss something.
> 
> Thanks,
> Zorro

