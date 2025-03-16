Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC221CEAB2
	for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742140138; cv=none; b=PjABTQkYrfzHA7mPiyTUH7Q0GM++JD6cV6qExU5jaBGMqQNK3xr1rje1j7LLiD35oeLNL3AQ0fAwLvQtHFLAP6+JduOrxcvdtmf8QRvHgEJgdEzAj5Owb9sz/C1mfLKgIDoqPP4q42oGXUCfSUFOZoO6B0GLR8yI6VutjKh0a4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742140138; c=relaxed/simple;
	bh=r9anJ1SoUzZw5teImQmR0jkSoOkElPS9IYcn9PXun1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtZEwlnxbTRaTKwdjLsG1lzQlxzDPB/K3VXnTv2IuRARmwbc2y33B++9dgyxMB3nkBCfPEzjtPx40h2ryhOraStCXZV/Xr9QYCx3wFhlAqyny3Jpu/oVBm0wTPbmMOiLgySE/NY/Z6AJe8wbBm8k88Tbz+xJ24ox/6LRCbc5jRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBLYpuwz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBLYpuwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742140134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs2+3eJd9iYwKLs77Ul1TdxmlpRkrsIfFKnKittT9kg=;
	b=CBLYpuwzkdpKrJCk+tcShfqCwbDW+0iflXwfMIGYl/AI84vPu7ffP73fB0+xj5ijKH+5zR
	6xlNL8GWW8q5wYXTXQ6dywQ1D0Kj7tj0HwJzdrLbfwH8YR0H3nN2tOy9IyBv0j3j5UPz2w
	9ttwnwIiNHXAdMZAcXhOYdwA71STNTY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-6rQ7T9xwPSGlEiFHRQf6Xg-1; Sun, 16 Mar 2025 11:48:53 -0400
X-MC-Unique: 6rQ7T9xwPSGlEiFHRQf6Xg-1
X-Mimecast-MFC-AGG-ID: 6rQ7T9xwPSGlEiFHRQf6Xg_1742140133
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85dac327403so730021839f.2
        for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 08:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742140132; x=1742744932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs2+3eJd9iYwKLs77Ul1TdxmlpRkrsIfFKnKittT9kg=;
        b=SpPh4WMornKrx8fWqIJer1podJWJm6EOSVj95ytrZwvdrrMv2aXVgRI5Iaq05KTTTc
         y/VxjHo6PsExbJdQptpJtVgxV8AejHXKd2vOXV78Sj+N7mNGvYgyIs2+7p6zfGcM2k/A
         x5qWkadhoQzlGwPDzUzArtKos4GMihY8+M2/Ob08veRhL69MjiCWwt3UfMkhj7C7yOB2
         NyIrACewwnDPuCJPcXfhBPpHZWa0IcY/P+qeBeZbzyOggHe93hYPoVFtK0PcNcBqLdA6
         EN8JzbGI1rrhB2RlfqwNInwj+GU3VRCD5l9sv3kN4rP0GD/Rb2oLHA3YpitzL2uc73WN
         G4GA==
X-Gm-Message-State: AOJu0YwPFllUmFo7SzAyYZFZ6JCT5+nnh8rTs9NiAfVX+p4BVAOnOhe/
	3rz4nckZkypX31BuughUU9pLQJWshJ1MurqibxttfHqS4P2vmi6SeaJLkGGjBgJZWQC86QW4bFE
	1LxOdBkQR9XM/DeGd62Jdz9D796AMJJ5uli4FIYXD92yXZ9H2SEjvgbc=
X-Gm-Gg: ASbGncs0uJDey8hLMyHAbcVFuL5fdtrrmky25Hx1+LH2DPLNrhxGQInrficXqV7ouLE
	Ti13aBqKSPwzKUY7w2+8FlbP89vinivssqB0QUMFLl07IFZ4BTaLZJpejkeg5eT4xUGS94WKTO0
	XPWvgTJuprccZT0AXIjddV5v9O0SUoMLu6J18bRBuIdKmiRKNLYXtg2mcLu3gToN2+Pbba2NbPU
	csYsMqANNpCVKqEToixyqfLm1sjtrzGNkRfWyFWQBANuwlyX/04GisTM4KaIG85mfSTR46SvKJN
	fkRh3xC3GCdwjciz5oi8EMk=
X-Received: by 2002:a92:c263:0:b0:3d1:92fc:fb45 with SMTP id e9e14a558f8ab-3d483a02e29mr108139625ab.5.1742140132715;
        Sun, 16 Mar 2025 08:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdjsUHJzdoAE9LO0zpcJXT3pOFwqEeMtEDCYXc6fGGdqqs3PRmgal+3Rn3sCD/X7PXkMUzgg==
X-Received: by 2002:a92:c263:0:b0:3d1:92fc:fb45 with SMTP id e9e14a558f8ab-3d483a02e29mr108139505ab.5.1742140132406;
        Sun, 16 Mar 2025 08:48:52 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f26381719fsm1849813173.128.2025.03.16.08.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 08:48:51 -0700 (PDT)
Message-ID: <ce0de787-1017-4b5b-8876-bff6adf4952a@redhat.com>
Date: Sun, 16 Mar 2025 10:48:50 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] lib: remove random.c
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-8-sandeen@redhat.com>
 <20250316145423.c2ws6hhrozl33czv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250316145423.c2ws6hhrozl33czv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 9:54 AM, Zorro Lang wrote:
> On Mon, Mar 10, 2025 at 01:29:09PM -0500, Eric Sandeen wrote:
>> sparse points out that lots of things in random.c could be static,
>> and upon doing so we realize that nothing in this file is used.
>> Which is unsurprising since these are all part of the standard
>> C library ... so just remove the file.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
> 
> Hi Eric,
> 
> When I did the fstests regression test this weekend, I found a regression
> failure on generic/007 (diff output):
> 
>   --- /dev/fd/63	2025-03-15 13:31:35.044534292 -0400
>   +++ generic/007.out.bad	2025-03-15 13:31:35.002455111 -0400
>   @@ -14,9 +14,9 @@
>    .........................................................................
>    .........................................................................
>    ....................................................
>   -creates:  18736 OK,  18802 EEXIST  ( 37538 total, 50% EEXIST)
>   -removes:  18675 OK,  19927 ENOENT  ( 38602 total, 51% ENOENT)
>   -lookups:  12000 OK,  11860 ENOENT  ( 23860 total, 49% ENOENT)
>   -total  :  49411 OK,  50589 w/error (100000 total, 50% w/error)
>   +creates:  18839 OK,  18890 EEXIST  ( 37729 total, 50% EEXIST)
>   +removes:  18783 OK,  19951 ENOENT  ( 38734 total, 51% ENOENT)
>   +lookups:  11858 OK,  11679 ENOENT  ( 23537 total, 49% ENOENT)
>   +total  :  49480 OK,  50520 w/error (100000 total, 50% w/error)
>  
>   -cleanup:     61 removes
>   +cleanup:     56 removes
> 
> By bisecting, the first failed commit is this patch. After removing
> the fstests internal lib/random.c, the output of src/nametest.c is
> changed too, that breaks the g/007 (xfs/188 maybe too) test.
> 
> It fails on all filesystems (e.g. xfs, ext2/3/4, btrfs, tmpfs, nfs,
> cifs etc). I'll defer the release of this week (03.16), hope we can
> fix this regression next week :)

Oh no, I'm sorry. I thought that if this stuff was never used it'd
be safe to just yank, but I clearly must have missed something.

It's probably best to just revert/remove this patch for now, so it
doesn't delay any release.

-Eric

