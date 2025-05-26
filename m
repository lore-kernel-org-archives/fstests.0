Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1732CCDB
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250067; cv=none; b=Dz2c+WqlNrzGBNePK2luPr2T0euchj/G6XPzaReIZd5qkAPJ4LLJnE+YFSOiSbKuKKHQ0lKklnNBAAf4aolF3HAOEYHkgm4gH7yXyNZnAa2P90CvMkyKsmaiwG1p3rpY45604UYKoYbvr+6O/dDc8Vr8+hWzz4/NFX94zxM1Ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250067; c=relaxed/simple;
	bh=q/DlaN6sf15ffdu3MY215BfaTgDtT5Z9n97QKr3SrdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q72iV0uNJnITR4tKPNxhQ326qjVDvhygcUaBzkmBHX9J+YsRXHUKhdzEMXMw9g73vN9cUqUwbY44M/IlIvjBxXdnsfO1uwKVFOkHfoVNShZ+V2McwMcZrLprkkVsFsEREbtEVLEZHij5taRE+59nuhO4NVN5dKfTKX/CfUFjZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdHRvV6T; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdHRvV6T"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2320d06b728so13662905ad.1
        for <fstests@vger.kernel.org>; Mon, 26 May 2025 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748250062; x=1748854862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PfBTq+dhYp+QoQvjIh8RsaP51SHNuvm3h+JaJGwFm/U=;
        b=ZdHRvV6TEfN5rc9n7PzTdLst6ryiHn5hLt1VEPtHZOi0A3DUNXfy5va21XayHBsiWb
         L5Fg0gbdWtYWlOUeRfWQ1+1iuzDDdHC60U0v6rxhSEl5KtwRpxrXGLiZlBLYkXHT7J+4
         fvjzxlUedAZry3Ne1W/I4lO2U6CG6PSjHpqp43nC6CBXN4W6tzlsHN4JWI4DiaKrUCu/
         2xLwNKuYY+pFiRBYV4ag3/n4PQ59DSuCX23FItpBbtCijAY9avCcfmeQpmoYFsgtpl/I
         J/xuqCk7qNTSUAena8lWIpJ+YbswtfwSqoakDDQYCblhzOqOje18AvXjcFXZW0O1OV9H
         XMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748250062; x=1748854862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfBTq+dhYp+QoQvjIh8RsaP51SHNuvm3h+JaJGwFm/U=;
        b=sIiWbNTvW4P2VMFUJWyUp0EhqbnZOBzb+0TXb9iWFxl+ix0TbNklhb8zhJZexxzsyr
         LUuI43sVDsvQQYqcilisT8XPdJ/rWAjHii1AeKBsCxXuOP8CA9QT01j9q+91WQ14wxvJ
         QoczcFZ5CmBrJzu6T2KP8HwXyn7pLQakhIHCDvAFPwfOXriPMECghOmRAU7LcNipCjEL
         bHeFEmOL59t9Fr53RGciVDikMXCeEmeT/Z1YgQFrpu5GK4eDUMkSvjzw4d0sHJafHNFC
         L382s8vdEZ1NIwvB3X2+AAg9zxn76yigmdIrZVansT0XLRFTcaY73NXsP+07urNJe5ch
         kggw==
X-Gm-Message-State: AOJu0YyPgOPqmWdhtOF5G26VTGqQb1nGaYlpVvRNd6OwcmiwVpoBezo/
	sX3uL4SQEnOS0KRk8wp5xccUVvvElwpbV3ZoF5H1tzlone/2RdZLz9tZSxNFgw==
X-Gm-Gg: ASbGncup7BwnXwCpbNAt9aLd54b02Pdszwl17zL3inIc4uHzVVGRLqXKOY6i28hiSYD
	8VG8iOJujH+Edc/gxg72UqzRYVv1iE+dgjJ1WYqOIym9EkrTYVVJc6OvtYbRChi0Aoz3tau9md/
	IFBLZ7LdM6Au/9IILQtCbw7hJMSnILbu9AyKLhkDN8MPRUSW4jz8sdYxJH9FgFnn6zvBkTQfK10
	2qzbYFTKWDI8iSyG8LiF3nMBAdtmy7qjtiY/2yiNpDJfZUt0m0gDy9cRlvBLbKsn+bJoZas7lXL
	ZjPutBGA5GLttAk+U6RtEevyECBrxLNdijvs8bN4UIxMVYIewnq7240GZ3bHaKho1XJj
X-Google-Smtp-Source: AGHT+IGV0q/iWDq3q052N/vT3xSaUHf1GU3/k5fSrGuk/EW542lOX3wU4s6PbxRQ5OxMLLUPY8MjHg==
X-Received: by 2002:a17:903:4b0c:b0:223:5945:ffd5 with SMTP id d9443c01a7336-23414fc83ffmr141200815ad.32.1748250062172;
        Mon, 26 May 2025 02:01:02 -0700 (PDT)
Received: from [9.109.247.80] ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2341e8ca45dsm34810305ad.125.2025.05.26.02.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 02:01:01 -0700 (PDT)
Message-ID: <571a2bfb-7a1e-4627-b97d-eead9b0f7260@gmail.com>
Date: Mon, 26 May 2025 14:30:58 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/28] check-parallel: allow FSTYP selection from the CLI
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-10-david@fromorbit.com>
 <ed42bdd1d43dd856978e8dea5b6bbc736e182d8a.camel@gmail.com>
 <aC2oLzBppRVtLwV7@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC2oLzBppRVtLwV7@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 15:47, Dave Chinner wrote:
> On Wed, May 07, 2025 at 02:19:31PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> Add a CLI option to specify the initial FSTYP to test. If this is
>>> not specified the the default of "xfs" will be used. This option is
>>> different to the way check has FSTYP specified as check-parallel
>>> has no infrastructure to support non block device based filesystems
>>> and hence we have to reject virtual or network based filesysetms
>>> are this point in time.
>>>
>>> Note: This patch only implements default mkfs parameter support for
>>> the test device. Config sections can be used to override this as
>>> check will then format the test device when the section that defines
>>> non-default test device mkfs options is selected.
>>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>>> ---
>>>   check-parallel | 44 +++++++++++++++++++++++++++++++++++++-------
>>>   1 file changed, 37 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/check-parallel b/check-parallel
>>> index 5fee62f37..19f2d2b0c 100755
>>> --- a/check-parallel
>>> +++ b/check-parallel
>>> @@ -18,7 +18,7 @@ run_section=""
>>>   
>>>   tmp=/tmp/check-parallel.$$
>>>   
>>> -export FSTYP=xfs
>>> +FSTYP=
>>>   
>>>   . ./common/exit
>>>   . ./common/test_names
>>> @@ -35,6 +35,7 @@ check options
>>>       -r			randomize test order
>>>       --exact-order	run tests in the exact order specified
>>>       -s section		run only specified section from config file
>>> +    -f <FSTYPE>		specify the filesystem type to test
>>>   
>>>   testlist options
>>>       -g group[,group...]	include tests from these groups
>>> @@ -66,16 +67,39 @@ external_file argument is a path to a single file containing a list of tests
>>>   to exclude in the form of <test dir>/<test name>.
>>>   
>>>   examples:
>>> - check-parallel -D /mnt xfs/001
>>> - check-parallel -D /mnt -g quick
>>> + check-parallel -f xfs -D /mnt xfs/001
>>> + check-parallel -f ext4 -D /mnt -g quick
>>>    check-parallel -D /mnt -g xfs/quick
>>>    check-parallel -D /mnt -x stress xfs/*
>>> - check-parallel -D /mnt -X .exclude -g auto
>>> - check-parallel -D /mnt -E ~/.xfstests.exclude
>>> + check-parallel -f btrfs -D /mnt -X .exclude -g auto
>>> + check-parallel -f udf -D /mnt -E ~/.xfstests.exclude
>>>   '
>>>   	    exit 1
>>>   }
>>>   
>>> +# Only support block device based filesystems with generic mkfs support
>>> +# at the moment.
>>> +is_supported_fstype()
>>> +{
>>> +	local fstype=$1
>>> +
>>> +	case $fstype in
>>> +	xfs)		;;
>>> +	ext2|ext3|ext4)	;;
>>> +	udf)		;;
>>> +	jfs)		;;
>>> +	f2fs)		;;
>>> +	btrfs)		;;
>>> +	bcachefs)	;;
>>> +	gfs2)		;;
>>> +	ocfs2)		;;
>> Extremely minor: Maybe list the test in alphabetical order?
> I copied the list from a case statement somewhere in common/rc that
> was already in that order. I don't it's worth the time and brain
> cells to order it, let alone require anyone to maintain that order
> over the long term. It's just a simple string check....

Yes, that's fine.

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

