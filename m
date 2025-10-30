Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30B246333
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804219; cv=none; b=D80980zSNTZVAcIH1xqNTqd+WF85SQCpPsLmZ2eJZ873IZnTdFVfjdtvXsfqUy41i3F7mShggbjlE1ZMCpDp1kJdrSQ8uGXUVJXA43r+FJgdxKyPyQrHNZOmfNoc0SDaK09IEpz7uEQ6oIF47T3Dx5ZvBsnu/MSkpxko6daSchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804219; c=relaxed/simple;
	bh=GAVB6pA0v8cqvOFccYTuPJTOi2NUjQzyWVe6Vgc/THM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN8687Py75exOVyFHKQEQ2raDp22BCyy5X7o2/gcXqkIhOpvVB98IsfOIGDfu7J5I2iMMEgmYTrpxCE2p7w+T7yELRDzdMhSOPiihNcbdGo6HHhlITg2tr1edJjMrB64ebNyAbSMA8CmoWEJQC49bZHhKa7fNQTSZe4lMI69ebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnf3piuL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnf3piuL"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so661299b3a.1
        for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761804217; x=1762409017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OpBe/rFPygHuP3aSytGmsROXrHOD9mRD7CnBgIfX6E=;
        b=cnf3piuLZMW/OI7Z/MuHSTjxryyRtpqi7tUNgmqovWDGpRMjSzy2roRrcw1orl9Js1
         GUZcRvDRPzIGMGDHC7G9XeQQEQOF6/BflV3Su97ZcssZMjHn1783hJr2a7YitHlq6C4T
         eByrtVoxoqyobeOjjK10CXQbT8dpnotX3RyuFSeGpSYd7G78pPWm1FPAx8oP1X+hcJyG
         oChOZTeAopMV7i80nFIs1Q+B29rqe0ZYb1z3EUFHMLLVWcrTGC4kWYjSPSt3sMtLAQb7
         7HBDMaFe2Iv2S0BxiQK7B42ehkv9bKUX89Julcg1HWnj3f5QlQ05iXMPl6uP3mzQSpjf
         ey2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804217; x=1762409017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OpBe/rFPygHuP3aSytGmsROXrHOD9mRD7CnBgIfX6E=;
        b=rpts/18g5EMHs/EsYJOYXbmVhM6HXm9xWKIz3+UManAfKenMvWa2/FiOzemCM7RT8N
         MxH9xkjC5pzyT1t9hOR9TOh35siY5jeiuSXUmsPOxtE3WHZLFsz1VA9K0jFDfcSzxvnq
         V4d6wb8gF5KG4YXyafGLzLagHMABb6MCmnb1yFXPg5AmJAbQh6HsFIpkC/Wq+eNoyUvE
         YNUZb1mCt9Wjd/RGNj3gpRgZqxJX0Co+StMZh6Jca2OlC6pc+g2e5NaGI1UtwSLJOIZm
         omOd65vpnTe350vji9FELerTQCXW9FUYH4u4oOle1DCRVGrA67X9yslEJRFQ7xIW8o86
         o7ww==
X-Forwarded-Encrypted: i=1; AJvYcCXK7WNkV5wrhfXKiQamHdJ9gNqC3CMsoWUtpSAgIBwh1aR0N3+0Q8zqQbStwaK84f435qlIj5vv@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUQMlucWwQ8C/ogWdNN3aFetE7JzT39LrscEF3EIVTdenrFtJ
	xs3f0dW6XI38Tz2bnkxURkoh6bkzHYh5AWJxbmUd9WIO5sQlYaVExnO+
X-Gm-Gg: ASbGncvKl+J9n0/ba09my4ncgWHQzlReix5AHVlvGN4VYLXbnLsT3XMHUWa9ovnNbfh
	ptOAprdd+x3oiSAoLBSqlVUoCxC+rFrWjYZXlhBEfsKLBPkY6mt+p1XmzsJYXKn1zUq3u9Ha5me
	0mnp3KDq4K/bSpeAhsdxo9UPWVHVssIW1Pa/yvo93HJ9E7pHx92xheWC9sssylckRCIksVOEq0u
	8irMV0oDY+n9zUPebJYP0N/uU9hJtoC+2hAJjIBDQ+9BRqcMDKmfCnzcdprLLXbHWQIA1R6luB4
	lj13ej7iKcceQe3WXnyWdlIH9pkhwbFlvOe2RMra5I2oUuN2bYkIQKkbknDMs/Ji2qC++ZKZfMq
	oq7lSn8+GIs7CUsy3ErF3q/tdN5b0xi3zw2nu1mlg39S9e2YWD6KtwBmXq0byc37EKKIptwWSNY
	CwDtoTyL5b/0I1WTPvmYsjcDnVZGc+A3Q=
X-Google-Smtp-Source: AGHT+IEiHwjtemye0bI8yUw2E+gyDPsJBan1udi5daHQQaAhbn3NSp5A5uW7pytNPQquxV57mFLZiw==
X-Received: by 2002:a05:6a20:3ca6:b0:2d5:e559:d230 with SMTP id adf61e73a8af0-34787d94214mr2588702637.57.1761804217313;
        Wed, 29 Oct 2025 23:03:37 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.202.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140168f7sm17196888b3a.11.2025.10.29.23.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 23:03:36 -0700 (PDT)
Message-ID: <bc7d0963-69ac-4b64-a0e4-2aa09ff6d0cf@gmail.com>
Date: Thu, 30 Oct 2025 11:32:48 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] common/attr: fix _require_noattr2
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054618026.2391029.1336336050566653412.stgit@frogsfrogsfrogs>
 <95366976c8fee19ab2901c4b11fe5925042fdc95.camel@gmail.com>
 <20251024221503.GV6178@frogsfrogsfrogs>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20251024221503.GV6178@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/25/25 03:45, Darrick J. Wong wrote:
> On Fri, Oct 24, 2025 at 02:31:16PM +0530, Nirjhar Roy (IBM) wrote:
>> On Wed, 2025-10-15 at 09:38 -0700, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> attr2/noattr2 doesn't do anything anymore and aren't reported in
>>> /proc/mounts, so we need to check /proc/mounts and _notrun as a result.
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>   common/attr |    4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>>
>>> diff --git a/common/attr b/common/attr
>>> index 1c1de63e9d5465..35e0bee4e3aa53 100644
>>> --- a/common/attr
>>> +++ b/common/attr
>>> @@ -241,7 +241,11 @@ _require_noattr2()
>>>   		|| _fail "_try_scratch_mkfs_xfs failed on $SCRATCH_DEV"
>>>   	_try_scratch_mount -o noattr2 > /dev/null 2>&1 \
>>>   		|| _notrun "noattr2 mount option not supported on $SCRATCH_DEV"
>>> +	grep -w "$SCRATCH_MNT" /proc/mounts | awk '{print $4}' | grep -q -w noattr2
>> If noatrr2 doesn't do anything, then in that case _try_scratch_mount will ignore noattr2 and mount
>> will succeed. With the above change, we are just checking if noattr2 appears in /proc/mounts(after
>> the mount), if yes then the preconditions returns true, else the test using this precondition is
>> notrun. Right?
> Right.
>
> On a pre-6.18 kernel where noattr2 did something, the following will
> happen:
>
> a) V4 filesystem, noattr2 actually matters for the mount, and it should
> show up in /proc/mounts.  If it doesn't, then the test should not run.
>
> b) V5 filesystem, noattr2 is impossible so the mount fails.  Test will
> not run.
>
> With 6.18 the behavior changes:
>
> a) V4 filesystem, noattr2 doesn't do anything, the mount succeeds, but
> noattr2 does not show up in /proc/mounts.  The test should not run.
>
> b) V5 filesystem, noattr2 now no longer fails the mount but it doesn't
> show up in /proc/mounts either.  The test still should not run.

Okay, makes sense. Thank you for the explanation.

--NR

>
>> This looks okay to me.
>> Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Thanks!
>
> --D
>
>> --NR
>>> +	local res=${PIPESTATUS[2]}
>>>   	_scratch_unmount
>>> +	test $res -eq 0 \
>>> +		|| _notrun "noattr2 mount option no longer functional"
>>>   }
>>>   
>>>   # getfattr -R returns info in readdir order which varies from fs to fs.
>>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

