Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594F1E500C
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249417; cv=none; b=X3RQVfX+/7iEYU/bKbJjdqORzsGCE6iZGz8okmRLwpjhLwCh66uicLN8uxm5wGQh+ktYsFIA1C9hnGJDf+35VtNx+Csls2yYKo329kN9cHru3WtjLWlBbIoHHvJKr9MY+JDdpJB6OK7RQ2qBZ4E6kPpi1zgKPt0GD+zloUEhhnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249417; c=relaxed/simple;
	bh=iKEdZJQrCaI+BEj623wv44tlu4LIUzMYAn3qrdw66x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEyYUhRC6/00ZWKuKaSjmq0haiiAidL0tv9TrbH6klEy1/U4eLacmabA1FVTFdmLq4md8CqAJ+tuk2iWdG+cUBxq/Y3P814jhAl0JzXw/WPgTZn/E7B9If5QxixlTX0LADOzxaleomDpArXddlFdwBel8UCSegVTPn+C5/AHD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4c/wpPG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4c/wpPG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23035b3edf1so12913915ad.3
        for <fstests@vger.kernel.org>; Mon, 26 May 2025 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748249415; x=1748854215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOuwZBwLIWYX5a7NBSjB2FT0QaajGDb1mNBQRFwi8Gg=;
        b=A4c/wpPGzHCPJp7naGvPhJDXNiFHEukupn8nB6CpPUrA7RkkOkehsNEN0uUlecGCzi
         pEkZLGvFvZ2/YKn0ufA8DG5CWVA4dbovr+CKTI1tCm4yUrwUrV4+8hCVOG+hbHg44rsG
         tyt3yai3oV559xzRVDhmAzpglPonz2HF5KoyJ7cLSKAFflHTK/ZIU5z06v/4ubfuH7SS
         7q/4bnsGGPfoE7L4DfqC3djcpnnofNj5lnBLmYo9n6pie4dBdRatOctsnqRrhf6cU9xp
         BzTjHQXyfPj0t23Y5heguAmHdleuC2spBoEPRN5WjhHrZ6v81nJ9FQVLfAKA6Og0c36G
         x+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748249415; x=1748854215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOuwZBwLIWYX5a7NBSjB2FT0QaajGDb1mNBQRFwi8Gg=;
        b=CjC5Hi/C37vSG1bY/mNt6elf7cYnHTBX6hoGe98qBcce6AIgR2BQ+58skikxWMB9CW
         PYjiMfthNH1VfceeEBHFIfSv/iTYvooKgZv4U39R1rM54JkpFVS3UtVLkwLu+zCZsWKa
         BcbaGYk5EieMR0rJPBGlCTO4YWtCgT22plf89m+qg3jBZIPf3sb2PuxK1xPBMXSSyK5G
         la96QEaOuTzJtDW1DNlYPX0LKU6XDRRev3lA4QAE3x6caZ+W6JTcwYQc5ZK4XrQlPlp1
         lXsBCdEgBB0CFpVw+6fGGxOzDE6q6QhMnx2acTq7eN2/fPSVm+OJLCDYL+A2tUtT9i+o
         OwAg==
X-Gm-Message-State: AOJu0Yzfq7sCVhO+t/0zgp+KL/ZUFlPbAiqLBLbjllv6sJ9XNlWNh9vY
	yUktoPu29OMOv+mOwR5Sl5FbSHiFtDd3peEMdnymDbUBKueNivKyIAu0
X-Gm-Gg: ASbGnctRNmJAphMf77QftAW5S4facpfUxmrRFv0kweIfRA53dc7ZqcPaW+MD2UQsHWP
	4ALWHb3FBtYTnqkJAWGwxbcAGwiFXhpzfpBKJWryW+6hTCskKAzVI29c2K4NsKkoxGL0ejZt/RO
	JjC90JvqeDjIf+pGWbuU/q3KQTylTD3I9qyYc3EjtcIl0vLBDGJc23AWYgSW1p95306Mwj2vBlP
	6UX3lkaefUp5DsVB/Ma1M9H0QBD37qf5Tv+7/vSXSDUZl868iwQdUc6xuqWnTax5rbJAtBQMsWU
	UsR9MIjiZTFiaetuSL9SeSIAXkcCtljecxUDSI9F1PmQ66Z12hJ5XU1cB1Jg+J4dw4R7
X-Google-Smtp-Source: AGHT+IH7wOmKYVzuHKw+hiKqux0LP47FhPRTIRwq8KvliWYVw1Y3seiCOdatln5B6kqOtKuQPSiEvA==
X-Received: by 2002:a17:902:e881:b0:223:65dc:4580 with SMTP id d9443c01a7336-23414fe65a9mr118636445ad.52.1748249415353;
        Mon, 26 May 2025 01:50:15 -0700 (PDT)
Received: from [9.109.247.80] ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2343a00986dsm24183645ad.178.2025.05.26.01.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 01:50:14 -0700 (PDT)
Message-ID: <fd136632-44f0-4690-be6f-3bfb3d3ba1b0@gmail.com>
Date: Mon, 26 May 2025 14:20:11 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] check-parallel: adjust concurrency according to CPU
 count
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-8-david@fromorbit.com>
 <e434a271402602fa7ec5efbcd9d92329ecdd4614.camel@gmail.com>
 <aC1XWzTFPUa_7WS_@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC1XWzTFPUa_7WS_@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 10:02, Dave Chinner wrote:
> On Wed, May 07, 2025 at 12:15:09PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> Concurrency is currently hard coded at 64 worker threads. This is
>>> too many for small CPU count machines; the idea is to create a
>>> sustained load of roughly one test per CPU as they are mostly single
>>> threaded/single process tests. The number "64" was chosen because
>>> I've been developing this functionality on a 64p VM.
> .....
>>> diff --git a/check-parallel b/check-parallel
>>> index cb5d6aedf..0649a417f 100755
>>> --- a/check-parallel
>>> +++ b/check-parallel
>>> @@ -10,7 +10,7 @@
>>>   # the loop devices.
>>>   
>>>   basedir=""
>>> -runners=64
>>> +runners=$(getconf _NPROCESSORS_CONF)
>> Minor: Not related to this change. Maybe we should have a _get_nproc()
>> just like
>> _get_page_size()
>> {
>> 	echo $(getconf PAGE_SIZE)
>> }
>> _get_nproc()
>> {
>> 	echo $(getconf _NPROCESSORS_CONF)
>> }
>> and replace all the $(getconf _NPROCESSORS_CONF) with $(_get_nproc)
> I have thoughts on that.
>
> I think determining test scaling based on the number of CPUs in the
> machine is wrong. If I run in a cgroup that limits tests to 4p on a
> 64p machine, then fstests will think it is running on a 64p machine
> rahter than on 4p. That's ... not ideal.
>
> I think there should be a global variable that defines the
> concurrency that tests should use to scale load/processes rather
> than use the CPU count. Then check/check-parallel can set the
> concurrency as they desire and we no longer have to worry about
> tests creating excesively huge loads on high CPU count machines
> because they were sized to load a small, low concurrency test
> system.
>
> i.e. I intend to separate the concurrency with which check-parallel
> runs from the concurrency that individual tests use to scale. For
> check-parallel, I am thinking of fixing test concurrency scaling at
> something like min(nr_cpus, 8), whilst the check-parallel harness
> itself uses nr_cpus to determine how many concurrent runners to
> instantiate.
Okay yes. That makes sense.
>
>>>   runtimes=()
>>>   show_test_list=
>>> @@ -30,6 +30,7 @@ usage()
>>>   
>>>   check options
>>>       -D <dir>		Directory to run in
>>> +    -t <n>		Number of concurrent tests to  run
>> Minor: Maybe we should mention the valid range of <n> i.e, 0 to 1024?
>>>       -n			Output test list, do not run tests
>> Nit: Maybe there is some spacing issue here? "Number of concurrent ..."
>> and "Output test..." don't begin together.
> Not that I can see, I think this is just email quoting and tabs
> doing funky stuff.
Okay.
>>>       -r			randomize test order
>>>       --exact-order	run tests in the exact order specified
>>> @@ -81,6 +82,7 @@ while [ $# -gt 0 ]; do
>>>   	-\? | -h | --help) usage ;;
>>>   
>>>   	-D)	basedir=$2; shift ;;
>>> +	-t)	runners=$2; shift ;;
>>>   	-g)	_tl_setup_group $2 ; shift ;;
>>>   	-e)	_tl_setup_exclude_tests $2 ; shift ;;
>>>   	-E)	_tl_setup_exclude_file $2 ; shift ;;
>>> @@ -111,6 +113,11 @@ if [ ! -d "$basedir" ]; then
>>>   	echo "Invalid basedir specification"
>>>   	usage
>>>   fi
>>> +if [[ $runners -le 0 || $runners -gt 1024 ]]; then
>>> +	echo "Invalid thread specificaton: $runners"
>> Minor: Maybe we should mention the valid range of "runners" in this
>> error message (0 to 1024)?
> /me shrugs.
>
> It's an arbitrary "check-parallel won't ever scale past this" limit
> because the diminishing returns from added concurrency that Amdahl's
> Law define is already kicking in at 64 threads. If you are running
> check-parallel on a >1024p machine, you already know enough to be
> able to look at the source code to determine why the error is being
> emitted. :)

Yeah. Got it.

This patch looks okay to me. Thanks for the clarifications.

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

