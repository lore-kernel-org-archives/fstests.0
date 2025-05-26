Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077051C3C18
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242729; cv=none; b=f77aCET1BX5OU17AbUBfp99JHZzqfoCWi+s47R89EuDY10DBSHietHCd6JelJ4p4CnfPhnrTTTvP/PKkznliDyn5aZ6Hw25x/JP78Txeum+Omxd7ciU3hHTabKDEAyJrqrYx3reHmiSGxUwlKNcr2/HMEwAQiU890KfrRAn3C7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242729; c=relaxed/simple;
	bh=P1+EeLY5IPhb4YU0+C1G3GmKrYzElyRQ9/JEaXlbFMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toLzc/u0MjAAimPPYrlwFnnMokfYCZ8WOjH+xjiuudPBiaeNxHez7FWobWb6DGrsI2A5GG+2xbkUF+pMBGPa+3OspnBTaBsf4pXj/AkJHsl2CreaGZs7IUd0Ho+cbpYhVs7keeB3XxGvl4boujB4YnTl2bJxkLAdGGiizvbIfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0O3VbF4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0O3VbF4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2347d505445so1130115ad.2
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748242727; x=1748847527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqxMwoDSNUAcqwcqD9TS7Bta59hVdB6bkDH08heUML8=;
        b=M0O3VbF4eICDnwqwQoFBF6yEKOWvefFP2nGA5H1VtatspNmqf+5Wb8SE7dIx1k5ybt
         IaCaQQN1lucIOgLMjSoHJE9zOZEdpcFQx8g+OcH+JvfXGcemQ++yLHUMSXZLGJfE1Ten
         GuEYUauMmYEH3iAdVQWy/Bbk56IcchlPhGN54vlv8DteVhLRBP6f9FfC1p4DdZ8qvfDQ
         pUO1uh883lZXtPGoVmsUneg7GLYxHJyXbc8QLQ8w+el+mFG6NU2cC0HiNYTEBHuBdZ1P
         44sa8G+PWLmTpwunjVUDFh6HFCKWMxcI1GM9ihAt/6W59Ky+1oS4IypSKajKl58ct7ms
         bUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748242727; x=1748847527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqxMwoDSNUAcqwcqD9TS7Bta59hVdB6bkDH08heUML8=;
        b=fU87keYJwViY96q04cgcq20X0ivvbsKScnR/yj3b56Ri6bAqy7G5CCA5mJ43ibhZE7
         4upEoHXeJr2t47pUqWAqpNSWZkpYWLmAEbH7HSInsnqYzwd0SXrgJN30C4Tul9cc0ivi
         SOy3+7m63bggBVkBc7km5Io5SwKVnwly4yfTF0GWsPFoMTPjvX7jbf7F1Fy03IYGkBnv
         qZHimyN4mAc8K6WaqdWT53WYJ+fBG8pm/Oknx7cWa15th5i5NVlBkZTldNuuq+d3OChd
         k61seJVIj4YEwmkljy3s4iG1M24q+oS4RhsWDJgIjHtXJLl7byLkIFdSnMUoRcD624n8
         p8jA==
X-Gm-Message-State: AOJu0YwI/XPz7YpOW3LdgFsgEl9R7xTbIPvUlxwGQ/ZZDG9OR3pB0cWF
	KPbjZK35feG4nwqfv2lVHi2s3sKFDCF6irAegpSFm13MTVmX1pWj8+p0eLfbnQ==
X-Gm-Gg: ASbGncs1xomND8sUmvhovx/6hCSzoahVa9PEb+1woGQPwSxBi4jOhMEZf27mXwH/U4q
	DjbW/dlIQUBZGiNjqehOhDR4wz/PgXWs+Qi1/oamxgZH8scE/+PZF1x5QwfGQ95hs+O7ljg+LVQ
	aGJfcNzb3labIDbjTcoe6IqX5wP+wVB/9KN0HEidzfTsdJ0VR5gnzblQ2MV+qICcR5QBBBY9xu2
	legsm7R15A6flwV4/vWtXSSPHO4xPYERkufBWMvwiNwjfUGWdpoYkFPzv5QJ/79qLgN15TX4+F0
	tk87dIDUx+lKEvtRtRM8IbkgXV5GnqeZ8//EU7I662uXqchn3obWPOhw6hMT7Q==
X-Google-Smtp-Source: AGHT+IFK8b8W2vWY8dVxh4L8QgdK12kpCaE7lEm0gqIZJp/D5icom+nWAj+LP9EFTGtFkVKZFEm59w==
X-Received: by 2002:a17:902:fc44:b0:22c:35c5:e30e with SMTP id d9443c01a7336-23414f69078mr121028045ad.13.1748242727167;
        Sun, 25 May 2025 23:58:47 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23411640a6fsm38048265ad.175.2025.05.25.23.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:58:46 -0700 (PDT)
Message-ID: <19ab7ccb-65c9-45e7-bdb8-4cf38b9b2ae9@gmail.com>
Date: Mon, 26 May 2025 12:28:43 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/28] check-parallel: use common group list parsing code
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-7-david@fromorbit.com>
 <39c2355dea38ef102f7a6c930f14f0cd14e6bbdc.camel@gmail.com>
 <aC1S1c-YcOivGRVx@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC1S1c-YcOivGRVx@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 09:43, Dave Chinner wrote:
> On Tue, May 06, 2025 at 09:26:37PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> Build the test list directly from command line prompts, rather
>>> than hard coding the tests and using the check infrastructure to
>>> filter that list.
>>>
>>> We still pass exact test lists to check to execute the tests that
>>> each runner needs to execute, but all other test list commands
>>> are no longer passed to check.
>>>
>>> As a result of this change, check-parallel no longer passes unknown
>>> CLI parameters through to the internal check invocations. At this
>>> point, the only non test-list related option is config file section
>>> selection; more of the check options will be brought across as
>>> needed in future patches.
>>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> .....
>>> +usage()
>>> +{
>>> +    echo "Usage: $0 [options] [testlist]"'
>>> +
>>> +check options
>>> +    -D <dir>		Directory to run in
>>> +    -n			Output test list, do not run tests
>>> +    -r			randomize test order
>>> +    --exact-order	run tests in the exact order specified
>>> +    -s section		run only specified section from config file
>>> +
>>> +testlist options
>>> +    -g group[,group...]	include tests from these groups
>>> +    -x group[,group...]	exclude tests from these groups
>>> +    -X exclude_file	exclude individual tests
>>> +    -e testlist         exclude a specific list of tests
>>> +    -E external_file	exclude individual tests
>>> +    [testlist]		include tests matching names in testlist
>>> +
>>> +testlist argument is a list of tests in the form of <test dir>/<test name>.
>>> +
>>> +<test dir> is a directory under tests that contains a group file,
>>> +with a list of the names of the tests in that directory.
>>> +
>>> +<test name> may be either a specific test file name (e.g. xfs/001) or
>>> +a test file name match pattern (e.g. xfs/*).
>>> +
>>> +group argument is either a name of a tests group to collect from all
>>> +the test dirs (e.g. quick) or a name of a tests group to collect from
>>> +a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
>>> +If you want to run all the tests in the test suite, use "-g all" to specify all
>>> +groups.
>>> +
>>> +exclude_file argument refers to a name of a file inside each test directory.
>>> +for every test dir where this file is found, the listed test names are
>>> +excluded from the list of tests to run from that test dir.
>>> +
>>> +external_file argument is a path to a single file containing a list of tests
>>> +to exclude in the form of <test dir>/<test name>.
>>> +
>>> +examples:
>>> + check-parallel -D /mnt xfs/001
>>> + check-parallel -D /mnt -g quick
>>> + check-parallel -D /mnt -g xfs/quick
>>> + check-parallel -D /mnt -x stress xfs/*
>>> + check-parallel -D /mnt -X .exclude -g auto
>>> + check-parallel -D /mnt -E ~/.xfstests.exclude
>>> +'
>>> +	    exit 1
>> _fatal ?
> This is a common usage() function pattern in shell scripts. It's
> clear that it exits with a non-zero error status when someone gets a
> command line parameter wrong.
>
> Also, check-parallel does not have a status variable that needs to
> be set to propagate exit values, nor does it have any traps set up
> at this point to need exit value propagation.
Oh, right. Yeah, check-parallel directly will exit from here, so yes 
exit 1 should be fine. Thanks.
>
> Hence calling exit directly is really the right thing to do here.
>
>>> @@ -198,7 +310,7 @@ grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\)
>>>   echo
>>>   
>>>   echo Ten slowest tests - runtime in seconds:
>>> -cat $basedir/*/results/check.time | sort -k 2 -nr | head -10
>>> +cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
>> Maybe have this default to top 10 list but make it parameterized, just
>> like we do it for DIFF_LENGTH (# number of diff lines from a failed
>> test, 0 for whole output)? Do you think that would be useful?
> Not at this point in time. This is largely initial debug
> information; it tells me which test(s) are consuming all the time,
> and how close the overall runtime is to being bound by single test
> runtime.  I only put this here because I was running that command on
> the CLI after a test run frequently, and generally I was only
> looking at the top 2 or 3 tests in the list....
>
> e.g. if the whole auto group test run takes 9 minutes, and the
> longest test takes 8m30s, then it is clear that total runtime is
> bound by the slowest test. Make that test run faster, and
> overall auto group test time will run faster, too.
>
> This tells me what tests I need to focus on for runtime optimisation
> (e.g. sync -> syncfs conversions). Once all the low hanging fruit is
> gone, it won't tell us anything useful and I'll remove it...

Ah, okay. Now I get the reason for introducing the information of the 
top slow running tests. However, we can still keep this feature - in 
case someone writes a new test and uses some functionality or command 
(like syncfs instead of sync) and slows it down, although that can be 
caught in code reviews too. Anyway, no hard preferences here. But thanks 
for pointing out the reason for introducing the top slow running tests 
information.

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

