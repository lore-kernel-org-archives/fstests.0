Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9021E3762
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250301; cv=none; b=mDXXNp3QoGEiEvuX6IGtid803cQI9fOHdwzpS2F89+QlAKbFY8kYD9aFpNSImrynheAQxLiiG2uN9YHyFLLA7z6pfQR1e7zf5yn2H4Q3omhTSy0zkkMab+PccG6wnQ67XI0Y52j0Bm+9QRq4P2s3hLhFKIbVD8T7ZpRpluOuDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250301; c=relaxed/simple;
	bh=fS8KP1MGX+ni2IluJZSzV6/spdu7HbLDcmGqd0uEbos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALzuVSdUO6iz/81rSshjHTbfGMmXqSduD/Iec78a1mHdwWpd0zO3yc5/jMTf19dJwNaG/5DN3HlF4yaTXPhTePVsTQjnBbTZBIYYYqCEpyMxvhCzbUhEJvoR08WgehEZ34n+DitP510lvf2dZPgJoAb8Z+VGw1G8443GNgx4Ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0teAeOm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0teAeOm"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7398d65476eso1261221b3a.1
        for <fstests@vger.kernel.org>; Mon, 26 May 2025 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748250299; x=1748855099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3DjUGTJVZXr+kHVsrZNgc5c0TtWDfBaE+YNjKc9nw0=;
        b=E0teAeOmVRoOKeP8WquhzwBYPNqo+k2RROEKQneeCwmUhT5KU0OnkWgRZ5GfgCB5p/
         Wfjsfgw8fGjOm4kQ0k4fSLzGRxmQULONsQusunIsNi8aa9GK3lXVWkrhL6qgLrKQ+TUf
         CaPWayWp0EfhuuVaKhUsjd+tNGCAoo0dDOPkALXCeXS4/jV/wZnfJTtQWSrWxHKR5H7b
         FBK0F/vk0rdipzNSCY57cRaQyucE2mIpuVsLluTUyHVi7w6AqV2gLTABP9zIQ41xdM+7
         Fs7Jom7o2cuoDRwBWHze3r4RNjax63lbw6MhLs0HwteSDwb29qgXVsKdbDvcKzNGtvTi
         oR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748250299; x=1748855099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3DjUGTJVZXr+kHVsrZNgc5c0TtWDfBaE+YNjKc9nw0=;
        b=KZTiODx5y6Dz8yF1CFofYJRWvsBa0TYfPy3V+z7Nfa+r6mJBHuySEC35XWNOVrpbaA
         /pbz5cMcMsEPMqEnXkoufRo6GiNdlASc6fUZXShkYtmYJUmkn8b6jMnUEuo2MCm6JI+H
         s4XVsvlM524D8Qv74ZeIeH6Ab9aDnDrmdDxQ566Tyj/Y+NgQ/rWBlfS2Jx8Up3H4qpxB
         KI0HlTWAHiQv4mYyeLJfj4xJoKxk2XtH1kZG/gwgznOWSvjRmUyE5TvU9WunOvwuob1g
         qZ9l/pc6U0xRipLlQ1CH3u3ALwQzwRO00CgIJT9y/1sYxs2mI+cFti8gB90XtooL42rS
         5USA==
X-Gm-Message-State: AOJu0Yw/m8YYUNL4G+kyj8NuUCPf9P8nW248CUNdLZYOMXfVWVXu9BVe
	mTBd1IN0C3wOHxYmYkiRHIYuzWA3MScx2Joj+6jOFoq9YIdrSEl41YLrQt5+qA==
X-Gm-Gg: ASbGncuafIC9RsJkeYFucUj77bXxcPhqGcfA2xwYstm36uYeNH7C4ZysODDlfVNb2by
	zq/upIJ2+GjOBK/igb2MuhVwwdm25AF39xdo8dZYRMTDlvJZHwNHqVgWK1It79nXjbSqJdRn9Dr
	IjfhJfFZxP6V1ykLu4raJujUcc+qusOdiFWpiiOJrCAt+0OejhiaxQPgATTr13DNdTEmqBCMrkZ
	66O8E5UAQA+X6cllAgKoCjZJuC5fGABVQgXOWtX5ml6iw/2q0DsVim+wawHo1qVeN0WbmDF2qh/
	Pn6DSfwJuoAJs3TJDBn45Jpaey9MvYRO2pkYmtb1cadITz6oof47NgvRCA==
X-Google-Smtp-Source: AGHT+IEKVB5Xt7CNZPXd6UsLwXNPBS+kDSn0oZpvjMG7ApapC2uWcc96AZSlDVUnCwBTUeQO4yNSMw==
X-Received: by 2002:a05:6a20:9f8e:b0:218:574e:830d with SMTP id adf61e73a8af0-2188b78d232mr13220453637.21.1748250299219;
        Mon, 26 May 2025 02:04:59 -0700 (PDT)
Received: from [9.109.247.80] ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829a4dsm17283141b3a.107.2025.05.26.02.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 02:04:58 -0700 (PDT)
Message-ID: <9d89ac6d-bd90-4c09-9a86-196acbc37c9e@gmail.com>
Date: Mon, 26 May 2025 14:34:55 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] check-parallel: use PID namespaces for runner
 process isolation
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-11-david@fromorbit.com>
 <0c40accd275f3fcdb9d00309159ecb9eb55335b9.camel@gmail.com>
 <aC2oxc6-f3J597f0@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC2oxc6-f3J597f0@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 15:49, Dave Chinner wrote:
> On Wed, May 07, 2025 at 02:32:29PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> This provides isolation between individual runners so that they
>>> cannot see the processes that other test runners have created.
>>> This means tools like pkill will only find processes run by the test
>>> that is calling it, hence there is no danger that it might kill
>>> processes owned by a different test in a different runner context.
>>>
>>> This means we need to turn of private pid/mount namespaces inside
>>> check itself - nesting private namespaces causes all sorts of weird
>>> TEST_DIR mount issues with SELinux disallowing TEST_DIR mounts.
>>>
>>> Note that this also regresses generic/504 for check-parallel,
>>> because it triggers looking at the init namespace from
>>> FSTESTS_ISOL=privatens and this variable is not exported to test
>>> subprocesses anymore.
>>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>>> ---
>>>   check-parallel | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/check-parallel b/check-parallel
>>> index 19f2d2b0c..aa88c681e 100755
>>> --- a/check-parallel
>>> +++ b/check-parallel
>>> @@ -267,14 +267,18 @@ runner_go()
>>>   	rm -f $RESULT_BASE/check.*
>>>   
>>>   	# Only supports default mkfs parameters right now
>>> -	wipefs -a $TEST_DEV > /dev/null 2>&1
>>> -	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV > /dev/null 2>&1
>>> +	wipefs -a $TEST_DEV > $me/log 2>&1
>>> +	yes | mkfs -t $FSTYP $TEST_MKFS_OPTS $TEST_DEV >> $me/log 2>&1
>>>   
>>>   #	export DUMP_CORRUPT_FS=1
>>>   
>>>   	# Run the tests in it's own mount namespace, as per the comment below
>>>   	# that precedes making the basedir a private mount.
>>> -	./src/nsexec -m ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
>>> +	#
>>> +	# Similarly, we need to run check in it's own PID namespace so that
>>> +	# operations like pkill only affect the runner instance, not globally
>>> +	# kill processes from other check instances.
>>> +	tools/run_privatens ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} >> $me/log 2>&1
>> Why aren't we using -s $section and only using $section with check?
> It is already encoded in $run_section - the CLI parsing adds the -s
> for each section that is specified on the command line:
>
>          -s)     run_section="$run_section -s $2"; shift ;;

Yeah, right. I realized that later. Thanks

-NR

>
> -Dave.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

