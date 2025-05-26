Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703C258A
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748235385; cv=none; b=pioUiMyN4XO4yYuWkeS2A4Yjsc53u2I9xKzh9XtYQOfB29zufqB8+Wa8wzwk6ujFlrPd8PyhagceaouJ3iWkIK1Br/skToGOC0jSU51kQWkCeTPGrHLv2ULJxgXi+rYu9y2kVB05nGjAIZ+QMTOgoB9SArsu+MWfXr0B0teGCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748235385; c=relaxed/simple;
	bh=VXsYXgUCPb4zmotEASYVPyTjzx5J3pV1gio6PSJN5Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qijRJtYUuw9icYVbRYLR0JB/rreVZqLRChRDRb/BGSMwcytmCD22Bi2HFHxotUVTWvkLnKaLDx8/DCuJOlDp1svW2ii7W2obG3WBlx8bQ9ff5A/diVDEN5orYA67joHH5wXd+yxpo6nXEEC+nhjYzpqhQGl0u9C0OWrCRrJRlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSOFDTty; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSOFDTty"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c73f82dfso1222935b3a.2
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 21:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748235382; x=1748840182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6htVuCjw5Sd8UQqNGNOGe2AZpJUplE1eFceys0EW56g=;
        b=WSOFDTtym1T95Kkr6vJBNrzp22o0+jD/m8nLOnq9NxrDfRL0TEAeV/yp/YWeAguPuT
         ErbFqaCKXVT/nZ5zoSyQ+KT0KPrHvMo+m2RoPzibRAQf0ZqcqJwCXRddCpKVJYQyiCpv
         Sq22NClxBaSWeO0ur+6JhTxuW+1TjD0btIHle4RiWPAvNU6Y0nhaEkM+8e1oa55DGRjI
         vChTv3QzXNr7snm30cDr4hJsjgP9HiDKKoReRsSPoZfNKEKZagsdyex+u7SZV8kOSvz1
         0Qng40v49bmU9wI6q3Zs5GwNNhiu7gZOZxhubKF0DHRwGmg6jLY0lYBuW2evuxSd3Kvd
         TnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748235382; x=1748840182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6htVuCjw5Sd8UQqNGNOGe2AZpJUplE1eFceys0EW56g=;
        b=np2DQC5nnXjMJXCrCUX/sd6Qjf5Qf0EcQgLvbjMrhwzGd6B0G7YIsqK5cpWPL7JTqy
         5vLRy5rI7XK2vTNGQtT4NZ91nvEb5wlT2QKVqJM7idjjTvu+bedwgxTeFBwmSt4bJKoc
         6ErQSO2yd2blhXXo1aUrgz9XtjZ6uEWcEBzY4SBDtp+CpacAhGvKeetfzum4zM8P2Lw4
         pMzg4ezCVUDRTKlVZMTKV6Q5Hcm7pDdujFbVp71vRQ0r7jqmZG4ngI2quUJlQa1dGY0e
         IcAPj/gDE66HA56ZeQ5Fy32PJGOuy5tMBFUxB+d4uqXPC3A3/RU1irf8cP2DTZbkZvDh
         x7AA==
X-Gm-Message-State: AOJu0Yyg+G6aNbeSVHyw8AKliwWF16NP8drISHlncTOmxcv6FeqSRfo1
	RDdFPbfMZsiyCohmLVNmdkkaWLQsDAboo5M5Rx02pV5qlej5KlOCHmBK
X-Gm-Gg: ASbGncuzBw5yOBAP3LizoCGGsLUvl+6V0xgkxUcen2fLHCWgOfecatROjEBV2LEfVhx
	R1t2z+S2vQb8SfP2h1ZslJniQv0hOuaGPUAs4xPVRW7lQ1O+mNi5L5fAPQWrJRWDFCmv3WDMjVh
	N7KdU42WQh6K/j+qSKgnT4oIBJFA/LT+fuSSHkMnePi5gcqj1el5vCBNNZEgSc2t2rihgb0cWHd
	ggrcXiISxlPiNNGoT5YW7jFbKnByVUpWKMvz3xK6VEvpncPATdJ7cFuV959JpIJJqSNDeZQzUyf
	Uoh+9HA8AIZNCqzIemDX89ZPUIV+6nhHNtqQTwU9GgfdwLwA0lQVtEilVjotRA==
X-Google-Smtp-Source: AGHT+IEz2FvlSuyr4PbxIZ02iCEVRjDgUithRvHplG3/RCOs9nauKpAFjjPHNX3xlVTnqoNcseWSYg==
X-Received: by 2002:a05:6a21:710a:b0:216:1ea0:a526 with SMTP id adf61e73a8af0-2188c3bc363mr12044403637.40.1748235382140;
        Sun, 25 May 2025 21:56:22 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e5f74sm16197001b3a.26.2025.05.25.21.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 21:56:21 -0700 (PDT)
Message-ID: <8ad0483a-b597-4ac0-b23d-c55cfd37983d@gmail.com>
Date: Mon, 26 May 2025 10:26:18 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/28] open-by-handle.c: use syncfs() rather than sync()
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-25-david@fromorbit.com>
 <31048aeecaf4cb1622fe3a2b18f6a7d921175fa8.camel@gmail.com>
 <aC06u4BelSuGE8iA@dread.disaster.area>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC06u4BelSuGE8iA@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 08:00, Dave Chinner wrote:
> On Wed, Apr 30, 2025 at 02:26:28PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> xfs/183 runs bulkstat_unlink_test to create 100 inodes, unlink on
>>> and bulkstat them. It takes a ridiculously long time to run under
>>> check-parallel because it runs sync() multiple times per iteration:
>>>
>>> Ten slowest tests - runtime in seconds:
>>> .....
>>> xfs/183 328
>>>
>>> When running check-parallel, sync() can take a -long- time to
>>> run as there can be dozens of filesystems that need to be synced,
>>> not to mention sync getting hung up behind all the mount and
>>> unmounts that are also being run.
>>>
>>> Convert the sync() calls to syncfs() so that they only try to sync
>>> the filesystem under test and not the entire system. This avoids
>>> interactions and delays with other tests and mount/unmount
>>> operations, hence allowing both the test and the overall
>>> check-parallel operation to run faster:
>>>
>>> xfs/183        4s
>>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>>> ---
>>>   src/bulkstat_unlink_test.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/src/bulkstat_unlink_test.c b/src/bulkstat_unlink_test.c
>>> index d78cc2ac2..62e5bb978 100644
>>> --- a/src/bulkstat_unlink_test.c
>>> +++ b/src/bulkstat_unlink_test.c
>>> @@ -88,7 +88,7 @@ main(int argc, char *argv[])
>>>   		}
>>>   
>>>   		if (chknb) { /* Get the original number of inodes
>>> (lazy) */
>>> -			sync();
>>> +			syncfs(fd[nfiles]);
>> This looks good to me.
>> Minor: Is it safe to use int fd[nfiles + 1];
> Yes, it is. Variable size array declarations like this have
> been supported by C and C compilers for a long time.
>
>> Isn't it better to use
>> malloc()?
> See my previous comments about stack usage in userspace test code. :)

Yes. I mostly meant in terms of stack overflow issues if "nfiles" is 
large, but I checked C stack space in the userspace is around 8M so that 
should be fine. Thanks.

--NR

>
> -Dave.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

