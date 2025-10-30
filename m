Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E4288D0
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804264; cv=none; b=EhXSxrYAuOzQ0G/iEr+B3hgBl2AcEsqo4aY4m+1dmdZQUHAJYqtIJ50eAECLYvdTNiiKLJnizpubjWj3cPEC1MIxI5WLL1C0s1Gewi5D9M1SWgZPkupeswz1UAQn5+RrqwO54aJjwG5qHwQHcynAFTPsKvlkautg815RjLrAgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804264; c=relaxed/simple;
	bh=Ob6CN4EMxiNdZS/l5PpzQ/6WWl3DRB8FPXTi+kE3hx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDNWLnQNGsmU4ShHGBsJc1rEWAHi9UulXkLgwWqHuI92AcWDK7WgYqw0ewjcABEDuCm+cZlQ7rTE35b9JOxncgT1ZoyiMPtd+O+wPRAtJzQGDuP9z+ObkGqDFxVibSYyvmjrUQDEJSK4ZTtlwfqAVd6ewbYfWLi4tAbFQAdA4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3d14omI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3d14omI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so970967b3a.2
        for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761804262; x=1762409062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKErskWqNUXPgWHgoTynrJXfGfE02ELTVvClulx9bYQ=;
        b=b3d14omIxedl6MzP2YMTi54himR3aKYINtlgYv4VozLqFzWYzxtuWkfE2h31Fhiyp+
         U8kB6enwK/QQPEgtlawb9yTW2/+yHbJG9woivzIPsk8umoCPw23vBbIOAe7V70kMCvZY
         z3sBmx2UH2ZQBP1gYF0azybVlXQUBa6fXv54quKCPv0VgaZ6cV2JwvK9HpAYcarykMrD
         6K3p7j+0+pRvHIkEBjQhXg5NUM7dbePAfLQhoiRFEh4tKsiWGK15spM2b8yFEJJG/LwQ
         FbDkK/NdzoHj12VcH3gshBLJVF1NChRqCIYP1xhn+rkObcFpomL3Fp1nhWvTgEOYL2Q/
         aoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804262; x=1762409062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKErskWqNUXPgWHgoTynrJXfGfE02ELTVvClulx9bYQ=;
        b=wn9puA6AKQ/XiCCn8/RrSQNbsQvhPWb8dxIjwG2+y/B7BrMOHEGHFZkB2CgcqI676P
         aAD/xLfdwPY/ioGYPSIXL4RTYnwzUrXxfLd5TYccQs1Xv7mghOTvYQ0w6OwxFGPpDsk/
         KSrQMS7N3So4KOAx9+oGeVS7Wo6Rk8yPE/KFNHytJyNzEgUID2e7Ja6v6fQg9iTlmoEi
         VV7Hk10oM5O4IevF/2gdf+BiBqp+sYA94AEPQnHv7iXSbCmGdPZT1OaSj1NfWghN8iBD
         49MTcTrQf4YWQSWFhLEbwvymfklGK+d4IKwq3ufvY0n1XEcbYO37Bd+AJzXqaEwG6g68
         4r7A==
X-Forwarded-Encrypted: i=1; AJvYcCUJTrJGrX0NTEyofkv7N8X2HMqjtJvFrbSS0sgMf1mTlmu6B/HZpfSwx4lSsrRCHAWsaybMnKGd@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnb6WOf6ajB4UU/9CMN00OuIuYBiLOky7suXdiA9KlnCtJ6S5
	rs+u/kfB1mh3jaTMYNhq067adVaKhXp9tVCrQuone81Fm7gqbXFpEC5T
X-Gm-Gg: ASbGncsV0JWXEzqkhCjrGKVEDFJHIP4fVPxdfzXIawxY60PXInTk6+LcOZvEi/tJ4OV
	rkyRy1zDp7er7bR57nQHUteVM/yhxAWKszSYJdjUIcPqTwqb/vpp1VO2JBUG4CydZj2CzbTksr1
	GgRfY/nh2/yEt+8XdFppziIqC6razXsKHiOw0yqAR4ERSVl9Gf0SZI7iXnvgpLuAu+ATYkQ07OF
	1mgR1mL5yO4enP7l93ldnbspDnXYWz1SQZY9Aa8C/I1fXgF0o3j7MnXB3ixfbxXKAYrFhagV6Dk
	amfMm/0Fj/6NwEqLjfpvdFfuvw1Air0nMaMqa36LA0dOCAporY3Ijpmmdt6dy9iblJkZ4CvM5/L
	8X9gLOvYtwxusnzPrkFyrdenbw7rrZURYmzVquCCfP+gkgjh0JF+H4SYc0I2qibZyuwXwEXQZPs
	Gv6dTznR2H9cgWQSMj+14U
X-Google-Smtp-Source: AGHT+IFXLeO5nh0dpewKxl5nUMCIaH6qGNwm+XqIzRneSj+4MrHfiJdfnc7SOmBhrR6C9gvWKu0yDQ==
X-Received: by 2002:a05:6a20:3d05:b0:33e:4b14:7e9 with SMTP id adf61e73a8af0-34657f5c6e6mr6326346637.22.1761804262385;
        Wed, 29 Oct 2025 23:04:22 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414072487sm17169234b3a.52.2025.10.29.23.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 23:04:21 -0700 (PDT)
Message-ID: <20ae71dc-c279-42fe-bcce-1b271f487a2e@gmail.com>
Date: Thu, 30 Oct 2025 11:33:33 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] common: fix _require_xfs_io_command pwrite -A for
 various blocksizes
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054618045.2391029.13403718073912452422.stgit@frogsfrogsfrogs>
 <4e8a9b373fdfeecd3e0de2a91ecdd75fbb94e18e.camel@gmail.com>
 <20251024221647.GW6178@frogsfrogsfrogs>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20251024221647.GW6178@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/25/25 03:46, Darrick J. Wong wrote:
> On Fri, Oct 24, 2025 at 02:48:00PM +0530, Nirjhar Roy (IBM) wrote:
>> On Wed, 2025-10-15 at 09:38 -0700, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> In this predicate, we should test an atomic write of the minimum
>>> supported size, not just 4k.  This fixes a problem where none of the
>>> atomic write tests actually run on a 32k-fsblock xfs because you can't
>>> do a sub-fsblock atomic write.
>>>
>>> Cc: <fstests@vger.kernel.org> # v2025.04.13
>>> Fixes: d90ee3b6496346 ("generic: add a test for atomic writes")
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>   common/rc |   14 +++++++++++---
>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>>
>>> diff --git a/common/rc b/common/rc
>>> index 1b78cd0c358bb9..dcae5bc33b19ce 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -3030,16 +3030,24 @@ _require_xfs_io_command()
>>>   	"pwrite")
>>>   		# -N (RWF_NOWAIT) only works with direct vectored I/O writes
>>>   		local pwrite_opts=" "
>>> +		local write_size="4k"
>>>   		if [ "$param" == "-N" ]; then
>>>   			opts+=" -d"
>>> -			pwrite_opts+="-V 1 -b 4k"
>>> +			pwrite_opts+="-V 1 -b $write_size"
>> Nit: We can still keep this to 4k (or any random size and not necessarily a size = fsblocksize),
>> right?
> Well, yes, the default will still be 4k on an old kernel that doesn't
> support STATX_WRITE_ATOMIC.  For kernels that do support that flag,
> write_size will now be whatever the filesystem claims is the minimum
> write unit.

Okay.

--NR

>
>>>   		fi
>>>   		if [ "$param" == "-A" ]; then
>>>   			opts+=" -d"
>>> -			pwrite_opts+="-V 1 -b 4k"
>>> +			# try to write the minimum supported atomic write size
>>> +			write_size="$($XFS_IO_PROG -f -c "statx -r -m $STATX_WRITE_ATOMIC" $testfile 2>/dev/null | \
>>> +				grep atomic_write_unit_min | \
>>> +				grep -o '[0-9]\+')"
>>> +			if [ -z "$write_size" ] || [ "$write_size" = "0" ]; then
>>> +				write_size="0 --not-supported"
>>> +			fi
>>> +			pwrite_opts+="-V 1 -b $write_size"
>>>   		fi
>>>   		testio=`$XFS_IO_PROG -f $opts -c \
>>> -		        "pwrite $pwrite_opts $param 0 4k" $testfile 2>&1`
>>> +		        "pwrite $pwrite_opts $param 0 $write_size" $testfile 2>&1`
>> This looks good to me:
>>
>> Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Thanks!
>
> --D
>
>>>   		param_checked="$pwrite_opts $param"
>>>   		;;
>>>   	"scrub"|"repair")
>>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

