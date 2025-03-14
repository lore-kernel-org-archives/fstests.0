Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2D201271
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963161; cv=none; b=JuJ8s3r6/voQe/RuBlwrhIoMu2hIwwWswR59t144NyskAxkrvpYbji75/ztGqBE++FYcojCaRrUaJDX/8Tcg1Y4VeIqZSkwgGwWC5F5pINhnMlbf3MwWksSHq/DJbWeMkaymWvejQKnb38qsRoy62zGsEggAZZI7CWddtxYMQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963161; c=relaxed/simple;
	bh=aABflKunAlFn0gBosAI/9R4kIe4rEPy36CCWs/j0qt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Un3NV9N+lQC80KPB0JOhVwQVplKyL7yiJRGGEn98F7XglLx4gKWDf3nwrVwMn4dxWRDrWc9X88iK+/jndR+W360AKmWQPSB0OKPmh7SExJBuWXaHah4VSaXBh+K+QNg8875iK/4IUKD3biRvYeOwwjA7FfJeFMtKXXo+AIDBwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijHYfc2r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijHYfc2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741963158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ4+U9P2rDmVw+8Ia3cNlFBVsvYo+BbnEv93lwjpvs8=;
	b=ijHYfc2rTaXSVnRp1ivIjz4wfI78A5BfnQcsH11qLwT+QZgFvoI6e4T8+NLf0OyOckzhOf
	gPjv5ZQhHJlkUF7kN9OOKXBWgU85I3GxTQqZl2FBNnCRmtjmgeEvL9uDPuHlJePn/sc2ff
	8cwZr/8oAI3oGQyi0x+qG5ENKJcuO8w=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-S_AQ_l1RNWaolNksgmbIEQ-1; Fri, 14 Mar 2025 10:39:17 -0400
X-MC-Unique: S_AQ_l1RNWaolNksgmbIEQ-1
X-Mimecast-MFC-AGG-ID: S_AQ_l1RNWaolNksgmbIEQ_1741963157
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso279547539f.2
        for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 07:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963157; x=1742567957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ4+U9P2rDmVw+8Ia3cNlFBVsvYo+BbnEv93lwjpvs8=;
        b=BeHzeVpSfH3vp6cjcZ03FeVOKsnEkXIMylihQkMq+MW4xx+pvtx4gfX+6g2mINotTF
         peIhyFPbkw594jYRjOe/vdmrjEoXxjdYH+gtNnvHh49XaCZ2zYnKrEPVXyxseXIe4uRE
         ErdPkHj4jH+SuVrXAMVFyp8L/0bQtoOrFwiJ7uK+Q4gvvxFoh55q/YQAbwR62jOCTBfm
         3sdi6WpfG7sn99mPnlJ/WONkFQiWqfqSpYw+MXbcf5/wawiUhyC1AfwvVQCwAfzHMxHZ
         Y3fH2zlqT9lPuQTYEFvwNBPoBcHUEaxeKkbZf9rq4pIV+zllCNMNxLmC9oE9CoQA8w+8
         iyOA==
X-Gm-Message-State: AOJu0YxTYKGTyPNspXtjPPYggJN27/lOoVxHE7JOwizycSg1faZS2h2i
	wLd4cKdt692+eoag+2V8q1HnkHxZGmoU4X2F7bfhP2MX6kGmk78VMGg3RMKwkQZfHaX2Hgh1Yla
	KhPEPU3wOlxR3Q6pPdC7v2tcrNtwYc4C1/KoN8surJ1kEnH4aCBsNEP8=
X-Gm-Gg: ASbGncsxmPHAjPtb2v1qLe/g7YoYbcMZDwnOzLP5ZTQYilNF2J0e6Ded5kFWINWbn93
	7pQzHB5yyCt5EzuLdDvrz8ZsgfgEWqs+gpA48SIxpcM5vyBlS2xZ1PvKmDV1aiENA4WBGIP6JE3
	7xFdX6zLZX+xn6U4ZIdy3c5v7s1GSZtYxPbMa5FOZqrLzWvC3zxLzY4P43/WBN+9GW0lqWJCTlO
	8ZmUoYwv7MpxgJ51f7rtkFe03y4EWepb8HAFOb8CXKawK05CYov6u1T1VpQ3qo1j6a5rGqd1G/z
	y4fVd+o+6o1bjeF9YG5iMsY=
X-Received: by 2002:a05:6602:474a:b0:85b:3e32:9afb with SMTP id ca18e2360f4ac-85dc4886c82mr296813739f.14.1741963156852;
        Fri, 14 Mar 2025 07:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUwpitpAXYxnchaSahIn1WvbGhm2pFU7PfNbPuMm2MAN05PWiueH2D2NvIafnIuHffgax2xA==
X-Received: by 2002:a05:6602:474a:b0:85b:3e32:9afb with SMTP id ca18e2360f4ac-85dc4886c82mr296811239f.14.1741963156485;
        Fri, 14 Mar 2025 07:39:16 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db879df41sm76289239f.23.2025.03.14.07.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:39:15 -0700 (PDT)
Message-ID: <2d814fda-6ce4-4758-a55e-387f05b3dedf@redhat.com>
Date: Fri, 14 Mar 2025 09:39:14 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/rc: explicitly test for engine availability in
 _require_fio
To: Zorro Lang <zlang@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Jeff Moyer <jmoyer@redhat.com>
References: <b761e302-8b4e-4a79-b025-d344d7bf5a69@redhat.com>
 <20250314143609.wk4ceplp5y3tw4mo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250314143609.wk4ceplp5y3tw4mo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 9:36 AM, Zorro Lang wrote:
> On Wed, Mar 12, 2025 at 11:48:11AM -0500, Eric Sandeen wrote:
>> The current test in _require_fio (--warnings-fatal --showcmd) does not
>> fail if an invalid/unavailable io engine is specified.
>>
>> Add an explicit test that every requested io engine in the job file
>> is actually available.
>>
>> Remove the "ioe_e4defrag" entries in ext4 tests - an engine with this
>> name has seemingly never existed, but in each case later stanzas
>> overrode the io engine, so it did not cause problems without this
>> explicit parsing and checking.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/common/rc b/common/rc
>> index ca755055..c155bb46 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3983,6 +3983,12 @@ _require_fio()
>>  		return 1;
>>  	fi
>>  
>> +	# Explicitly check for every ioengine availability
>> +	for ENGINE in `grep ioengine= $job | awk -F= '{print $2}'; sort`; do
>             ^^^^^^
> 
> I think a local variable is enough, e.g. "local eng".
> 
> And, how about:
>   for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job`
> 
>> +		fio --enghelp | grep -qw $ENGINE || \
>                 ^^^
>               $FIO_PROG
> 
> And to make sure the "||" checks the return value of grep, how about:
> 
>   grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) ||

Clearly my bash-fu is lacking!
 
> 
> Others look good to me.

Ok, I'll try this. Also noticing that I typo'd "sort" which was supposed
to be via a pipe, as well as a missing "uniq" :( sorry about that.

-Eric

