Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150583D4130
	for <fstests@vger.kernel.org>; Fri,  7 Aug 2026 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088952; cv=none; b=C3uWTRT/5gUyq1TT9HO6pMP/2IYFaqNnXw/pQLSBrTAA42BFEktDuEMpEyQ9TudmQVFlECRZ8PSMOUdEqhNwNysxcr6ru0+ii42E6uiYbmFAQvBn6mMWsWyPw/DZrVDZaK4iaNjuAj5qg/Y8Ct2Og0FgFuxiQ3opAxg/wyESUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088952; c=relaxed/simple;
	bh=qFAl9L2XJ76BW5cM9Bdtke4KwqFYXF74aj3UCx++9vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h7jO+M19aHwmPV7DRH55TBrcSkrj9rp3PL6V33Uxi0gBRuH7+5duVtdy7cD1VUC1QTrJ6K57C1xcr/C9xceKU+4tgP5WXJCvwAL+KKZD3lR94qdAHYXmwOCLNwcmQ7Lk/ogJHcOYm1VjU+RMottOC80vK1x+TIbpdTUywZmS8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fd0DAhU3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rqUvKuxV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fd0DAhU3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rqUvKuxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786088949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Cn3Pt6Cz41BB0ng4dLgJQ+cvpxzDsp5MGLSW2C/r2o=;
	b=Fd0DAhU3+/hputnUzTARc409ZODqBmafdiJsN4RiOpIMKb/n5N5VaREQUmM0/vxxMkZ9v2
	qzZ5aqyrX8NnENanMxwfoz89KcCCW+0G2Py2IS9IdWRITq1+Mjaih+KsdAn9AXIyfS8qDe
	GQZDx60kqXVVvwFevgLtwGFDboQLJnI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-W0lltMR5N8-qeyibfcP-HQ-1; Fri, 07 Aug 2026 03:49:03 -0400
X-MC-Unique: W0lltMR5N8-qeyibfcP-HQ-1
X-Mimecast-MFC-AGG-ID: W0lltMR5N8-qeyibfcP-HQ_1786088942
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so64436115ad.1
        for <fstests@vger.kernel.org>; Fri, 07 Aug 2026 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786088942; x=1786693742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Cn3Pt6Cz41BB0ng4dLgJQ+cvpxzDsp5MGLSW2C/r2o=;
        b=rqUvKuxVrCmBhYy61BdM3wqT92MQshR4xAANl8vaLztguYglIrFDerUHSSJgyzU4qT
         PlE+GXHAIyG+2bOwpmh0y0h1J6+nPmUN5varoASxxhAdK40N/MJzTKc3bC8wVwTM6NMD
         HTIlXGXneLerTAv/Y+uPjOVUSe0XoaILqz2/KiSqTc3em5sr0GohDTS+6QX/sd70eITf
         1RK1CHIYgynmEkFAP2oUlNSWCdOU/RKpU+drj4npbtIUrQpq/pMFdF32lTrRsLXDwGhf
         kfJt8UhwZa4VK/iHCjT8thb4lVgHOILmsJ1ivaCuZG0c1TluXUNoBUWy/d8QiX4/TstK
         sijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088942; x=1786693742;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Cn3Pt6Cz41BB0ng4dLgJQ+cvpxzDsp5MGLSW2C/r2o=;
        b=kchvzEKTYSupAXMzPTZglw3t9tWaGvTwgbjtNPozN+CFOtTziBO2DBW6Gj0eLXOFgQ
         seSnFKov/0X/7unsfkvtVqY0X6pIT/pUXFBSR4Gw9zGzsu/pj+gH0Qb/cacnIWfC1sgp
         pQgjosWCsdkI1gRV6WIzGXJlaKwGvh4f7uAsYhTO4YcI3K4QgrlqVhYR35WA4+vZYhSH
         AfdS8NAGsPE5Rgw0stHmamepGyQMwPLcYgQbwYtDOlDppLJHCJ/uayErsiN4jGbML+ES
         ie+eIieQye2TjCK3CND4HSYcci1fqGRjBZc88XqhwpdJq8w26pT6kUPKzfRnWlpxjMAy
         z91A==
X-Forwarded-Encrypted: i=1; AHgh+RolKf3EyRudAQbvRpajWtpqLTYWSfAT4ezl/js4SgWKREdQVhgh9FGoEN+6IvS2aWrRdXqUdhSP@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVTMeE//gLaGxaejmuR/fe9EXT0sSZbSVBsPy7+clcEhIykT3
	1XD3DWzsOezR2r77j3Hlg+/TTvUq+Y6rI98WiW6Ylq02hNt0KOKTpuqp/P8PXjRbLRbh4ZVR839
	2LDFRbA4DZqZBxnUCqpUd4ZmAgrS/TqN1jqdAq2HP7iXfc75sTPnmhaUzXxU=
X-Gm-Gg: AR+sD1125NwTup3KqvTVTvYtA86E7xbS61fgunuigtnveWd5Tt3BM9d1ozfk0OgYJzM
	sACq/zdWN4XjGXJXdwEUwlfI54wsWITnyn/bVOEFUdQSi4d4Vd8yQXz1M76TUwECuW+GLgjLdqE
	bh7PbQzoLdB8FysLa4BWSlJmCI/Wfhp8ABVHJNB0Aij8wGwWw0hneV4+WsJQRal2embFv+pVQIF
	KGYVdfpEhiOIaukx6HvuRDmnl+Sl5hNVXWcWgkHRM1ilK9cE+haLOTE64mDV0zi0ksLHn7GfKQV
	JBmzT10VZN+SqDXLQ3eEI/daPH8OGGkKljQ1p8UoMI7eEXXv2VecM5vJz3ymEQ/xz4/zDAPtG2Z
	rTPC9Bhw3jJ+oINv4wEZdpWYRO1TnvKosKYKD8/SFDDRDeaY=
X-Received: by 2002:a17:90b:4d84:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-3903c5dfd9amr19664243a91.18.1786088941835;
        Fri, 07 Aug 2026 00:49:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4d84:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-3903c5dfd9amr19664215a91.18.1786088941259;
        Fri, 07 Aug 2026 00:49:01 -0700 (PDT)
Received: from ?IPV6:2001:8003:4b1b:d900:266e:8be8:569:ffa6? ([2001:8003:4b1b:d900:266e:8be8:569:ffa6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff6658bsm1425135a91.14.2026.08.07.00.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 00:49:00 -0700 (PDT)
Message-ID: <304f1600-70ef-411e-b56c-5b91102ba343@redhat.com>
Date: Fri, 7 Aug 2026 17:48:57 +1000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xfs: test xfsdump subtree restores
To: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <20260723062617.424905-1-ddouwsma@redhat.com>
 <amiGzsz0KuUrV29o@zlang-mailbox>
Content-Language: en-US, en-AU
From: Donald Douwsma <ddouwsma@redhat.com>
In-Reply-To: <amiGzsz0KuUrV29o@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/7/26 20:39, Zorro Lang wrote:
> On Thu, Jul 23, 2026 at 04:26:17PM +1000, Donald Douwsma wrote:
>> Regression test for cumulative restores where a directory has been
>> renamed outside of the subtree being restored triggering the assert:
>>
>>   xfsrestore: tree.c:1421: noref_elim_recurse: Assertion 'isrealpr' failed
>>
>> Signed-off-by: Donald Douwsma <ddouwsma@redhat.com>
>> ---
>> Changes since v1
>> - Fix use of _do, including label quoting
>> - Update test output
>> - Add tests for additional edge cases
>> ---
>>  tests/xfs/995     | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/xfs/995.out |  8 +++++++
>>  2 files changed, 66 insertions(+)
>>  create mode 100755 tests/xfs/995
>>  create mode 100644 tests/xfs/995.out
>>
>> diff --git a/tests/xfs/995 b/tests/xfs/995
>> new file mode 100755
>> index 000000000..bba0bcd52
>> --- /dev/null
>> +++ b/tests/xfs/995
>> @@ -0,0 +1,58 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 Red Hat.  All Rights Reserved.
>> +#
>> +# FS QA Test 995
>> +#
>> +# Regression test for cumulative restores where a directory has been
>> +# renamed outside of the subtree being restored resulting in
>> +#
>> +#   xfsrestore: tree.c:1421: noref_elim_recurse: Assertion 'isrealpr' failed
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto dump
>> +_do_die_on_error="always"
> 
> I think this line is useless now, right? I'll remove it.
> 

Yes, thanks.

I did have a general question about how _do_die_on_error is used

$ git grep _do_die_on_error
common/rc:# second argument. If the command fails and the variable _do_die_on_error
common/rc:# is set to "always" or the two argument form is used and _do_die_on_error
common/rc:      && [ "$_do_die_on_error" = "always" \
common/rc:          -o \( $# -eq 2 -a "$_do_die_on_error" = "message_only" \) ]
tests/generic/017:_do_die_on_error=y
tests/generic/053:_do_die_on_error=y
tests/xfs/041:_do_die_on_error=message_only
tests/xfs/042:_do_die_on_error=message_only
tests/xfs/596:_do_die_on_error=message_only
tests/xfs/635:_do_die_on_error=message_only

_do_die_on_error=y doesn't seem valid.

generic/017 doesn't use _do, and I think generic/053 wants _do_die_on_error=always

Thoughts?

Don



