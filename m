Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBBE38F24F
	for <fstests@vger.kernel.org>; Mon,  4 May 2026 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938218; cv=none; b=YgWXmkGWi5437e4PPZync2ptHirz0h8ZHdXhfoJTBBZqgs6hKO6Plz0k9f60A8jPD9ks5giZ6Yy0rospuhmnRG2+ZZsutozWNmewl0YyOCAQu78ckZB35yzNru2TGNNkf4oT/Ab5HBo902j8WS7uh/2qSKKgtpm1o4x6ZlCZRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938218; c=relaxed/simple;
	bh=P0JRurqQEroBpI6NTu34iI6OS1yE20tL5Pk2ort+Ewk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QnqM62Z0JCpsT+lZDPduFVz/2OaM9LOygR4e0JhPfbjoojcMJwoRuN6xE43CY6CAoYFTQm0jPspH5sHiutVSjhiXKg1IDhbvBkmnFaTucN+uyOkjoB0ol+DX3SkV6bTdr7Xy1xo+U/3GYs/gPjCHUtdyYhKc1p0WNbJH7o8e3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0o/vIad; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0o/vIad"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3653cb9c6f8so1501629a91.0
        for <fstests@vger.kernel.org>; Mon, 04 May 2026 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777938217; x=1778543017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YS3nIskAJmcds5exY/NyDgnXHfFkRgkwxiLt6dSOk6E=;
        b=J0o/vIad2NXUktDNQFXeIIQolwKchEsbAlNjls9Jtv7TNlLG8KH52rM1dmA0969u92
         5jxEmqwenBdMQhXq+d2LZe8o44BtT7xErA4VZXIhyg2iauPlt8QUbKa39C45tjfuJydl
         +JKOra1ThWiOTlvHr4JqlOVZLc7BXIGhwjTIi5DkVw1DQw/c3FZoWGPyTGc4liAUbOk5
         YrH6HkNqmI8oSPZlvUKJtNb1mYodfRU8DdmZsJ1CwGs6ikG3SnR+buFnG0e+vjMn1WT0
         1P5sZSMTnm56x0mZlldn2RGBIrhYV95WBxOi3hAViWfTOIp7sPO54y6PiT+md3n0z1bq
         tQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777938217; x=1778543017;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YS3nIskAJmcds5exY/NyDgnXHfFkRgkwxiLt6dSOk6E=;
        b=Yig5+l/FGZ5achJaJD9wlppLgUuFc//hxFENY8SdKE5OnNbxGjjog6xs7cGFBJvUi8
         m5Vmzgs386Mnnm8cmMbubIZWBmDCTV0WsAemDQi0LXhZsezT3mlprzXFON0+a/Z0FM+C
         WQYHIpf9jDJqcFQff82mjWKSjdjUTu7Iq71bRWYSKl0bJ6dS+2viPYDGi6RxEHDLKC7r
         sCFI5IdxO6gLrgsy4tdEN47MobNlbly5pVWwYoXyTC/SUfgQXxSGHPM+tHJPDE4SUhj1
         ynUi0HlUSzuBEa6J9dVgmoo7oZazmdV7wmxKVFfSPP9sA7MUcSWZKM74ni9pQZgnvmSy
         kUAA==
X-Forwarded-Encrypted: i=1; AFNElJ80jokvfRzDgu8jQsE78LGIddzpP/pLG/HlO4o5bKk58D3Drl4Z7Q1Nb4FZ4KXDfR7QU572nzQF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dCUtDG2PvZCrZx4AeWmmFMnFnJxxMtAVGYPt7HGnSbIiu+mp
	TXssnA0/7ynL0mOvcUJjAhixTJCblxp7DQbM8cc3vm2j2WaOdH3jQMIk
X-Gm-Gg: AeBDievXHxJsAZWhvId6uHzqim5/c6ScrUCwAOzg4yV9QtxYkZLdOXx89h2ZbdcCLK4
	C1zXwVGCUp8uHlBcKWlAhFeQ2/B/27NwHY3wFK9ggya7AZYgy7+gt6Z7mEstlxctlN2jIz4pLSi
	fVIIp9volt3/uu9THQI/k1reraWFFW4AmbXgKZr4f16H9asigb9u7X71i40czM3giPc7WxccuB6
	YBKifdHU6yeTxO5d6r73enks2yqINt98fH8Szi/1pSo7l0J0fG04sl4azndoRdbQQxEEdzvuS/9
	7e+EI/62+IpafHRr7oFU0aqfFalOqOpmKkuTT+8aPBafKbF2zfEA8Mrw7Vo7agz+rELDqzrQ9DT
	PcqNIx9xaC3Ub87EadXfhNPMYjlULzSI2UNgAmKNG9LCRGXIOYiUEhSJWLax4EP/9kUgx8QoL2e
	eeF+QUlMFrTOc1qDXKmrR9UvB1NxoeD7iQ2frchGI=
X-Received: by 2002:a17:90b:4d01:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-3657737b70dmr940328a91.1.1777938216866;
        Mon, 04 May 2026 16:43:36 -0700 (PDT)
Received: from [192.168.50.119] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be028cd6sm15818818a91.14.2026.05.04.16.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 16:43:36 -0700 (PDT)
Message-ID: <683ddd4b-d811-4d6e-a348-6918a10fbab8@gmail.com>
Date: Tue, 5 May 2026 07:43:32 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: add _require_log_writes_sized
 helper
From: Anand Jain <anajain.sg@gmail.com>
To: Disha Goel <disgoel@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, fdmanana@kernel.org,
 quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <20260427122551.71696-1-disgoel@linux.ibm.com>
 <7a5a4c7f-2c1f-4dc8-b2ef-b052b62798dc@gmail.com>
 <3cc304b6-0069-4cb8-b3c2-a15d0365cde3@gmail.com>
Content-Language: en-US
In-Reply-To: <3cc304b6-0069-4cb8-b3c2-a15d0365cde3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 07:16, Anand Jain wrote:
> 
> 
> On 5/5/26 05:53, Anand Jain wrote:
>>
>> looks good.
>>
>> Reviewed-by: Anand Jain <asj@kernel.org>
>>
>> Thanks
>>
> 
> sorry, not yet; I'm canceling the RVB.
> Details below.
> 
> 
>> v2:
>> - Renamed function from _require_logwrites_size to
> _require_log_writes_sized
>> - Added documentation comment clarifying the parameter is in KB
>> - Made function call _require_log_writes() internally to avoid redundant
>>   calls in test code
> 
> 
>  This change log should be below the Signed-off-by "---"
> 
> 
>> Suggested-by: Darrick J. Wong <djwong@kernel.org>
>> Suggested-by: Anand Jain <anajain.sg@gmail.com>
>> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
>> ---
> 
> ... v2 changes  here...
> 
> 
>>  common/dmlogwrites | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/common/dmlogwrites b/common/dmlogwrites
>> index a27e1966..0925b333 100644
>> --- a/common/dmlogwrites
>> +++ b/common/dmlogwrites
>> @@ -14,6 +14,21 @@ _require_log_writes()
>>  	_require_test_program "log-writes/replay-log"
>>  }
>>
>> +# Require a log writes device of a minimum size
>> +# $1: minimum size in KB
>> +_require_log_writes_sized()
>> +{
>> +        local size=$1
>> +
>> +        [ $# -eq 1 ] || _fail "_require_log_writes_sized: expected
> size param"
>> +
>> +        _require_log_writes
>> +
>> +        local devsize=$(_get_device_size $LOGWRITES_DEV)
> 
> Please keep all declarations at the beginning of the function.
> 
>> +        [ $devsize -lt $1 ] && \
> 
> use $size instead of $1 and
> 


> $devsize and $size units are different, 512 sectors vs KiB
  My bad, devsize is also in KiB. So this is fine.

> 
>> +                _notrun "LOGWRITES_DEV too small, ${devsize}KB <
> ${size}KB"
>> +}
>> +
> 
> $devsize is not in KB and $size is in KiB

 This is fine as well.

Thanks, Anand



