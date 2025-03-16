Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051BF14A4F0
	for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742148380; cv=none; b=mi1Pl4TONL9EaT+AvTxWy5Q77cl5M3b0rUw8oM6drdHXMwjuAiPxkHaqAKh3wPND57c6F2la2q9bvjXTmYsSyMrbhIJvC946wG0TUw0Dd3a1nsCO7Ne4LieXVAqc+4DHylFEtcKDS/OwyoNjfMrpXBKPnZTV64A4mzNWotyQAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742148380; c=relaxed/simple;
	bh=9vvQu8glDxfWs2LNP+M2BePHagiNZuDP6luz+QOBMTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thrdB7ViEJG1NhCimwopaCme1vQ968N6e774lncEr4q3Np5aeaMibgvZut8UOO2lW9yz6wzWnVzEMU61MhR/dzc5d28iMmwSpBIUGIhiwajnES+MV/qdgCYyEYiXX20R2s208EF724hAy6sw0OYR9VweIi+vp/cXgN2dMZabR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6W2uhtp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6W2uhtp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742148374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+vWJKYde9fKoYHA1UQ5mO90sXxcG1RFWHbkUWHBn9E=;
	b=W6W2uhtplNA6od9W9KbRiUhRu06+DyQQOPEvuwekl0ku9CCGFsG+DcHyePVEOntorpLPcw
	x4JhKHiyKHZzAw0Xi+fy94zkp1wAW5JFBFEGIj+ETnAsMJwnbxyDVf5WSbO5a9h38ILUrM
	BDQBfaEO3qKc21zjMfZRfgl60gxi8pE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-_B1i0N9UPYSfkZVoVHybig-1; Sun, 16 Mar 2025 14:06:13 -0400
X-MC-Unique: _B1i0N9UPYSfkZVoVHybig-1
X-Mimecast-MFC-AGG-ID: _B1i0N9UPYSfkZVoVHybig_1742148372
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b4dc23f03so965476839f.1
        for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 11:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742148372; x=1742753172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+vWJKYde9fKoYHA1UQ5mO90sXxcG1RFWHbkUWHBn9E=;
        b=YSSJVpM2NT/UU9pRgjoLZ30mRN5NoG1qOmfTnAd+5KCFn2HzcAVGtgbIM7/ODS2hfM
         AltUit9dYwdYo0Ov9dvUAJ3oBXOp3cCOavZfJ9DZs4F+/mmkj2S4/2LVh4xemC27iZuQ
         uhcyPP+gb36MXZDPHXspQ7VzNFk2eOh7MbWhby6yCmOBFl8vGsBsUOY8vz4xMMuigdXI
         UNySUcypTBJDK2EluGAYyzTi228iqiUVJNXRBs6ZGAT/wgaLktJMn6VhlNQuh3VjJP7D
         P/ybdZtcBvGbvThEM5iaqalv3ZYaa/TjY/DwJpPTYQOaTTlDSPWN87OtQLE0v9Fbq3ui
         5CAw==
X-Forwarded-Encrypted: i=1; AJvYcCXj9M5bIAPwSBBYyHD/dJaYjIxDbHe9EC6tCat1W0VERQFOwlYaN4sCtoHCRux4jwokcudnbk/B@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/TMpQPuJQCL7FiIpvvGaNepX2rR74hCmnKtyLHD7dFSeTa1b
	7AmIcrnzDlc1ZviI21xlqIGqOzYJKtnPVRZNwKlyUZLXMK2l0xHZ1jwG4xlJF7hrGx4SXhAbU9O
	5qZ/NMAVunag0Dj4oBiK6ItKS0W8Ws4+JPQ8/CWBDBVUXqx/murh4hQY=
X-Gm-Gg: ASbGncvE+Aub0Y+mCu73zLNSuW9D2j+NCA271uwFolTMpFuj8ZbajC25T1HlI9FEYdw
	x2BMRMq02ITAsZ5/GUN/0bmMLlk5GLMmZ//7kf4MU/kEz7WETB6r8KaN2vqExBle0kiPF+Eb5fk
	Hfi4qqs1O6FSdI7vEU+R8pSx1H/jaYUMba+rD3MK1B0rX2aEHNAkdMLU3BVJQulKQWibx13GkUp
	19iVPGVyfTeVI9LbzHCJAT+TO4053GqNahikHlkBOgzMo3h04xUemceBscl/auu12ihctaLnpux
	QqdYcVXz+ooq6auReEixH7c=
X-Received: by 2002:a05:6602:7205:b0:85b:3827:ecef with SMTP id ca18e2360f4ac-85dc48ac747mr1102745939f.12.1742148372322;
        Sun, 16 Mar 2025 11:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHggvJvbuSSXWMzqFluu32ORMLn8Qo2D1I0qMWrcS4e+5hMFx0/qamG0D1QqQ+WcTOeyGZ/ag==
X-Received: by 2002:a05:6602:7205:b0:85b:3827:ecef with SMTP id ca18e2360f4ac-85dc48ac747mr1102744239f.12.1742148371969;
        Sun, 16 Mar 2025 11:06:11 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263702031sm1871505173.3.2025.03.16.11.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 11:06:11 -0700 (PDT)
Message-ID: <2a8ac1e3-ac7a-4097-b55a-fcd66bb017c5@redhat.com>
Date: Sun, 16 Mar 2025 13:06:10 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] lib: remove random.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
 hch@infradead.org, Christoph Hellwig <hch@lst.de>
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-8-sandeen@redhat.com>
 <20250316145423.c2ws6hhrozl33czv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ce0de787-1017-4b5b-8876-bff6adf4952a@redhat.com>
 <20250316164034.GO89034@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250316164034.GO89034@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 11:40 AM, Darrick J. Wong wrote:
> On Sun, Mar 16, 2025 at 10:48:50AM -0500, Eric Sandeen wrote:
>> On 3/16/25 9:54 AM, Zorro Lang wrote:
>>> On Mon, Mar 10, 2025 at 01:29:09PM -0500, Eric Sandeen wrote:
>>>> sparse points out that lots of things in random.c could be static,
>>>> and upon doing so we realize that nothing in this file is used.
>>>> Which is unsurprising since these are all part of the standard
>>>> C library ... so just remove the file.
>>>>
>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>> ---
>>>
>>> Hi Eric,
>>>
>>> When I did the fstests regression test this weekend, I found a regression
>>> failure on generic/007 (diff output):
>>>
>>>   --- /dev/fd/63	2025-03-15 13:31:35.044534292 -0400
>>>   +++ generic/007.out.bad	2025-03-15 13:31:35.002455111 -0400
>>>   @@ -14,9 +14,9 @@
>>>    .........................................................................
>>>    .........................................................................
>>>    ....................................................
>>>   -creates:  18736 OK,  18802 EEXIST  ( 37538 total, 50% EEXIST)
>>>   -removes:  18675 OK,  19927 ENOENT  ( 38602 total, 51% ENOENT)
>>>   -lookups:  12000 OK,  11860 ENOENT  ( 23860 total, 49% ENOENT)
>>>   -total  :  49411 OK,  50589 w/error (100000 total, 50% w/error)
>>>   +creates:  18839 OK,  18890 EEXIST  ( 37729 total, 50% EEXIST)
>>>   +removes:  18783 OK,  19951 ENOENT  ( 38734 total, 51% ENOENT)
>>>   +lookups:  11858 OK,  11679 ENOENT  ( 23537 total, 49% ENOENT)
>>>   +total  :  49480 OK,  50520 w/error (100000 total, 50% w/error)
>>>  
>>>   -cleanup:     61 removes
>>>   +cleanup:     56 removes
>>>
>>> By bisecting, the first failed commit is this patch. After removing
>>> the fstests internal lib/random.c, the output of src/nametest.c is
>>> changed too, that breaks the g/007 (xfs/188 maybe too) test.
>>>
>>> It fails on all filesystems (e.g. xfs, ext2/3/4, btrfs, tmpfs, nfs,
>>> cifs etc). I'll defer the release of this week (03.16), hope we can
>>> fix this regression next week :)
>>
>> Oh no, I'm sorry. I thought that if this stuff was never used it'd
>> be safe to just yank, but I clearly must have missed something.
> 
> Ahahaha, it's linked into libtest.a, which is then linked into every
> fstests binary.  Therefore, any binary calling srandom and random get
> this bespoke version instead of the one in the C library.  From the
> looks of it, the RNG code itself runs the same operations in the same
> order every time, which is why you can pass a seed to fsx/fsstress to
> get the exact same sequence of operations.
> 
> Maybe lib/random.c should have its comment updated?  Clearly two
> reviewers, myself, and the patch author missed this point:
> 
> /*
>  * modified by dxm@sgi.com so that this file acts as a drop in replacement
>  * for srandom and random.
>  */
> 
> Because that doesn't really explain /why/ the code is needed as a drop
> in replacement.  How about:
> 
> /*
>  * modified by dxm@sgi.com so that this file acts as a drop in replacement
>  * for srandom and random.  fstests programs rely on the exact sequence
>  * of integers generated by these functions for reproducibility and the
>  * golden output, which is why we override the C library.
>  */

Yeah, I agree. We need a stable random.c copy for reproducibility on
tests that expect it. :( Sorry about that, it's my near-constant
reminder that even "trivial" changes need testing :( 

And I'll figure out how to make sparse happier about it.

-Eric

> --D
> 
>> It's probably best to just revert/remove this patch for now, so it
>> doesn't delay any release.
>>
>> -Eric
>>
> 

