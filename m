Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123F1EB3E
	for <fstests@vger.kernel.org>; Mon, 24 Feb 2025 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740371958; cv=none; b=syfaainVpWCh8eifL2M2IZgLbaEQ+WQrddHcIR3qJcjGaenzrThtTfxeugmvNRynft5fEY+rnYQRXFMh8qcdpMka2TveUQVdPBADjVSgMjYcWiOp9BllR6dypeUQrIb9ZKi3a/grb7dUVyeasxMzrVEuU21sicGvGz7nfH6Naf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740371958; c=relaxed/simple;
	bh=k79ofe1PZPOJR0OrJo0bFr+RefGY7KPHPVv9TF6RcDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgrbHI1OzHE3DYctlmzwo6W3XOM9SmyRcAzfIyUkjb8YnkrM2j750SCauIX1YzVcBGuujweYI2Jvx2mNsBHh0KaSSocHY80ECznlRn6TRaDSi7rc1YJfRSCo5x4tXr3XE5xiEeuZgEuxlAx3BjQuRaeEyCSUIwz+s7ZJoDitSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw6W9rpO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw6W9rpO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212a930001so107624575ad.0
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2025 20:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740371955; x=1740976755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfF0Ck3a+hsNAsaRGDTNxAMveckS+XT+lQbkjNPTwEM=;
        b=Yw6W9rpOKA+1Yarf6H+eiSxHC0YGbNaUww+g8xHerRSvwC1BFmK2dPTS3UStvcxHmM
         ZLsR5FJ+5nCa6RvVmXXYAsX6ySc0pS3x9Ad+ExipEEbre29E4SSEOLr4mQ+iD0xi5Dau
         qXZ+mRxBFYsU3aExgl6CsT+kG8zNF2HbWfHFvbC26YDtfQOz6Ibv3m7FJKk34Dy3lNuo
         rQh9vabNG17cS7ubY9XcRmHXQhL5Rjd/lybc0UshtXHpe+RoobcsFK0z8hJrC9UqKhkh
         P5iH2CkAjL/HzBNd61bFxWrp8yjOPYraJGeLQAXQQpShiLqIronNSSnM37gHDzZ/nNJI
         QNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740371955; x=1740976755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfF0Ck3a+hsNAsaRGDTNxAMveckS+XT+lQbkjNPTwEM=;
        b=fxwJFa6DypDQZhRxfQ1PxcZPXg+tq8rK39GXeFEEhqPQ5C7u9DJNZSX7XPY/CrOO9X
         BRwn4KZbk+Twrg5uDTzKVPyqbPleYT2c/pmPyxHlVtAa0uQ2Bkhn/lwLNc4gFiqPGnfa
         oCfaQveCN0T1NSN/st1FaMWtMXs1GKbiriPH0N5Og8HXeoDWHIlaJo6/3/WVwXX54UOM
         mOecqoePyrdG+pKyvdTMrqu0b/mPZ/bUdiJk8YKnO/Zi1wSkWfIAW9t+w6DVCdYexRzi
         9M1wBznwZoAbxNDkwOyUYBgQ90vGnZvkosUDzlhgQkoZ9BkTpzVKj7Ee3M59FMFP+xGt
         9cQw==
X-Forwarded-Encrypted: i=1; AJvYcCXPHMYuKp0RuiLKj6k0hlVfb+YopG1eil5Z+pfdLxibED2Px73+h0mgZPqXACI6dcCDiNrEQIBX@vger.kernel.org
X-Gm-Message-State: AOJu0YxAw/sr0dUBUKhBCEHo+MX+vD7LLbsWSzd3HIITjEJ4LFG/2z17
	ypY/orSTbuzSbI4ZwguRTlz+zzsKTN44eaj0CkY4kw3DoXCosy4r
X-Gm-Gg: ASbGncsoHn/jJ69mdAsmT43sEqe20QFOaCDFXylhROpUh+shjhFmE8FK/7Pe+f+ab6T
	HUDziYph/3tZ50M8wMgkIL6hsgEgYw13kY87MzSnd4f/M/EeeclxtwO97npJXHoqmooHeiSQ13c
	SK8Sc7XKr/aVRDdmWlkbGo0J+LHrTMx73RTC/lpICsdv7zgg0ViNTIAvA7aHMql5D5wIHqVAhHr
	Q1EXG0jqFM2BHzruCKKsFs05DudC+tdVb4vgHVGcyxxJIgkDoti+kUU7PPuRe+etrX5tR1+j6uh
	RNBzP+wu9rzwudVRQBSqCyagphLA2RNXej4a
X-Google-Smtp-Source: AGHT+IE0ltQEqKAICQD+hY1oZgEDZhXLP2yW7TK0mJ8CoUaAoUF5XCTqllX8JdtztIe26WWdQanGIA==
X-Received: by 2002:a17:903:2f92:b0:215:a964:e680 with SMTP id d9443c01a7336-221a10de4a8mr169392575ad.25.1740371955000;
        Sun, 23 Feb 2025 20:39:15 -0800 (PST)
Received: from [192.168.0.120] ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d3b1sm171284025ad.163.2025.02.23.20.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 20:39:14 -0800 (PST)
Message-ID: <278823de-0b30-4ddc-ae00-8e3fc9757463@gmail.com>
Date: Mon, 24 Feb 2025 10:09:11 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test zero-byte writes to new file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <30dfe4a2d18ec2ca29d303c1f8fc943688221d59.camel@gmail.com>
 <20250221164751.GY21799@frogsfrogsfrogs>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250221164751.GY21799@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/21/25 22:17, Darrick J. Wong wrote:
> On Fri, Feb 21, 2025 at 10:44:09AM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-02-13 at 12:06 -0600, Eric Sandeen wrote:
>>> A bug was recently fixed in exfat where attempting to do a zero-byte
>>> write would yield -EFAULT; test for that here.
>>>
>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>> ---
>>>
>>> diff --git a/tests/generic/761 b/tests/generic/761
>>> new file mode 100755
>>> index 00000000..e933eb83
>>> --- /dev/null
>>> +++ b/tests/generic/761
>>> @@ -0,0 +1,28 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
>>> +#
>>> +# FS QA Test 761
>>> +#
>>> +# test zero-byte writes
>>> +#
>>> +# exfat had a regression where a zero-byte write to a file would
>>> +# yield -EfAULT. Should work on all filesystems - write should
>>> +# succeed and the zero-byte file should be created.
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick
>>> +
>>> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
>>> +	"exfat: short-circuit zero-byte writes in
>>> exfat_file_write_iter"
>>> +
>>> +# Modify as appropriate.
>>> +_require_test
>>> +
>>> +rm -f $TEST_DIR/testfile.$seq
>>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
>>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
>> Minor: Maybe just remove the test file that is created above (since we
>> are using the TEST_DIR)and not leave any test artifacts? Or, maybe use
>> the scratch device?
> Agreed, the _cleanup should remove the testfile.
>
> Using the scratch device (== additional runtime for mkfs) is overkill
> since this test creates a single file but writes nothing to it.

Yes, makes sense.

--NR

>
> --D
>
>> --NR
>>> +
>>> +# success, all done
>>> +status=0
>>> +exit
>>> diff --git a/tests/generic/761.out b/tests/generic/761.out
>>> new file mode 100644
>>> index 00000000..72ebba4c
>>> --- /dev/null
>>> +++ b/tests/generic/761.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 761
>>> +Silence is golden
>>>
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

