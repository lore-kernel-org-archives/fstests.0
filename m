Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD342045B5
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972586; cv=none; b=OBMqREPJ7943QWPmmJYek1hypgnc1wo1jZ3cXP0pHOiBs/d7BRuzsunqJooxDvUVArMT/J82/V3fUNeuOC2Kf+bGqEqyU8jfDm2c50pQiE/KVoERYQAnuGGxbcqbpK6UkEKonjBsLiys8rqnpXFechPBgPzJ/vnoMzdf9U+Pi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972586; c=relaxed/simple;
	bh=NEj3dtCP94WiQlXM/1OjcTodFsd5vLOq02/XK2A3NAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZaG3ReNFIhDGJQMNYA8P0NbKLZO3TfREW9mR20qMB68IwtNPpDSE1vggWisdkJDRqJyXygkEhfz2bAFyDCc0cv8rQMVAwE0wG1IA4EYH3DHWaxmw0QPLj4Qdl4FPxt24z1XyDQ/ZkdGzDJvRL9tiEeNw4cWF7x3LLqRlx1HDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaNLzj0y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaNLzj0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741972582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTQqETymfI64rYCHD3RFYLPP1EktMRZB14OOsZvG+FI=;
	b=EaNLzj0y07z0XZAaXqv7X2j0Uzr9yH+mntbteWEYqWP6x9JbyTFghQoGZ7CddXjM4dXn5g
	FAp5BXhVhEe5xc6YcAyHpOaM3s39dQtEHZ9PYXLOMqMHLj062DBAsExjSbXVQrUsVeoV1K
	4G6YhfVZyhnZcwlRhin/o7TQADYNBgk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-w-rkst2ZMIu76AZqhqoIaA-1; Fri, 14 Mar 2025 13:16:20 -0400
X-MC-Unique: w-rkst2ZMIu76AZqhqoIaA-1
X-Mimecast-MFC-AGG-ID: w-rkst2ZMIu76AZqhqoIaA_1741972580
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso46672305ab.1
        for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 10:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741972579; x=1742577379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTQqETymfI64rYCHD3RFYLPP1EktMRZB14OOsZvG+FI=;
        b=n9Y6pgqXViYxyIaobYRbYa8o7xLTbjHekwGXsZCDrOgPtg/qDe97vfAVp01HC0akBZ
         yvL0K+QFWTKQ+wz7iMWTXDMQQ2SXxMRzxmbFPF3HGvLMoRSJXU21pedDsigRGLB24MnI
         vBVm3qGLcZwIFziccZESp59aUENV9SMZrzY1FwoE4OjVq64iPtDPz7wNezCBwcM7LbE7
         O6wNxcHs6Kmd4zGHGEcXAyBUyAVql9aJZbdFvqDWbrcZ6RMxO+BgfJyWQsLAxifry876
         EpvrTx+GVNqFwHMX+L/M1n7xeouviVpTX7Hg1ZswUpz1oivcQ/sUgfNd0giCSFxGtkTd
         3LBQ==
X-Gm-Message-State: AOJu0YzIjgB1BGtB+KCZCwCUam7oN27c982WeabdDco3CcKH/pLGeN2Q
	0NPyZghzGK1+UeXP/K2dS0AkphYhJYGmD2dC53/lCi70AamgRij4RzTMKX0CdKFaPIxi8E6qnxI
	63uPyBWchsqKe6GTLefhk76Wbg9cO8c9EJtU1u9TlMiCEPGGFYUj5r4Y=
X-Gm-Gg: ASbGncvyMACYkTpdfqyR+glTeqkWubbVT1vJ6KtmVRPcHaUhMLmp0zucR08gq32B6Ma
	vWQSNTspN+hRau/07R4zf9rqfshdW6irg24jVNupa9RoYARGqZSHV5rjs37GOlnD0jPbYmjieuP
	+N3nBVJF6q6pcGCkLAHTTCtv6w/E3kEvckXasOrgJywX0YV/1qOeCtIBFeOeBKv/tD9hpGDInLN
	56YbhX2t6ulDy81FjAVTu3YB0DT4ISQ2TwewFb4zIDE7Kw4BiVDVJH/ViXdIfobzLk6oB+8g+go
	ynyrloZrGj0YJuZPvsrb2l4=
X-Received: by 2002:a05:6e02:1d06:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d4839f5dd3mr25957685ab.1.1741972579654;
        Fri, 14 Mar 2025 10:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlA+g3E2U159yb25SbAmmEqBJK6LYmmDkJSEHSNz+ETUB5dFBzL3hlHdWR7YyDU0OVLW/Wjg==
X-Received: by 2002:a05:6e02:1d06:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d4839f5dd3mr25957375ab.1.1741972579335;
        Fri, 14 Mar 2025 10:16:19 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2719c4404sm393000173.72.2025.03.14.10.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:16:19 -0700 (PDT)
Message-ID: <6a486dcf-7a62-4094-a5f7-d3fbb6437874@redhat.com>
Date: Fri, 14 Mar 2025 12:16:18 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] common/rc: explicitly test for engine availability in
 _require_fio
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Jeff Moyer <jmoyer@redhat.com>, Zorro Lang <zlang@redhat.com>
References: <7ca733f5-f33a-4b2e-a70d-4a48a4904391@redhat.com>
 <20250314164812.GK2803740@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250314164812.GK2803740@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 11:48 AM, Darrick J. Wong wrote:
> On Fri, Mar 14, 2025 at 09:56:20AM -0500, Eric Sandeen wrote:
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
> 
> Well, they override it with the correct name "e4defrag":

and/or with libaio - it doesn't matter what it's overridden with, just
that the incorrect name in the global stanza is never used due to
re-specification in each subsequent stanza.

I guess I don't really understand how it helps to explicitly describe
the contents of each ioengine= line that clearly still exist in each stanza,
or why that's critical to the commit log...

Not saying your suggested text is bad. Just saying I don't think it warrants
a V3, unless that's a showstopper to get your RVB, in which case I will go
back again and take the time to do so.

Thanks,
-Eric

> $ fio --enghelp
> Available IO engines:
>         cpuio
>         mmap
>         sync
> <snip>
>         falloc
>         e4defrag
> 
> I think the commit message should call that out specifically "...but in
> each case later stanzas provide the correct ioengine name 'e4defrag',
> so...").
> 
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> With that amended, this all looks good to me so
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
>> ---
>>
>> V2: Be Better at Bash, thanks Zorro. Also add | sort | uniq to ensure
>>     we only test each requested engine once.
>>
>> diff --git a/common/rc b/common/rc
>> index ca755055..ac443ec2 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3977,12 +3977,19 @@ _require_scratch_dev_pool_equal_size()
>>  _require_fio()
>>  {
>>  	local job=$1
>> +	local eng
>>  
>>  	_require_command "$FIO_PROG" fio
>>  	if [ -z "$1" ]; then
>>  		return 1;
>>  	fi
>>  
>> +	# Explicitly check for every ioengine listed in the job
>> +	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort | uniq`; do
>> +		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
>> +			_notrun "fio engine $eng not available"
>> +	done
>> +
>>  	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
>>  	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
>>  }
>> diff --git a/tests/ext4/301 b/tests/ext4/301
>> index abf47d4b..a05b8e8a 100755
>> --- a/tests/ext4/301
>> +++ b/tests/ext4/301
>> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>>  cat >$fio_config <<EOF
>>  # Common e4defrag regression tests
>>  [global]
>> -ioengine=ioe_e4defrag
>>  iodepth=1
>>  directory=${SCRATCH_MNT}
>>  filesize=${FILE_SIZE}
>> diff --git a/tests/ext4/302 b/tests/ext4/302
>> index 87820184..e0f5f2f9 100755
>> --- a/tests/ext4/302
>> +++ b/tests/ext4/302
>> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>>  cat >$fio_config <<EOF
>>  # Common e4defrag regression tests
>>  [global]
>> -ioengine=ioe_e4defrag
>>  iodepth=1
>>  directory=${SCRATCH_MNT}
>>  filesize=${FILE_SIZE}
>> diff --git a/tests/ext4/303 b/tests/ext4/303
>> index 2381f047..0a83e86c 100755
>> --- a/tests/ext4/303
>> +++ b/tests/ext4/303
>> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
>>  cat >$fio_config <<EOF
>>  # Common e4defrag regression tests
>>  [global]
>> -ioengine=ioe_e4defrag
>>  iodepth=1
>>  directory=${SCRATCH_MNT}
>>  filesize=${FILE_SIZE}
>> diff --git a/tests/ext4/304 b/tests/ext4/304
>> index 53b522ee..5f2ae4bd 100755
>> --- a/tests/ext4/304
>> +++ b/tests/ext4/304
>> @@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>>  cat >$fio_config <<EOF
>>  # Common e4defrag regression tests
>>  [global]
>> -ioengine=ioe_e4defrag
>>  iodepth=1
>>  directory=${SCRATCH_MNT}
>>  filesize=${FILE_SIZE}
>>
>>
> 

