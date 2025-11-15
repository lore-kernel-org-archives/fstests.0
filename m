Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C81804A
	for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763189358; cv=none; b=lOGyfbx/zFFsKbznoF1/pdZIuyl+YKOdtzWV8aDkBRsPoGcXeQZh+sZcsJ2TY6Huj/KpZfpxofC4smSWDqjmxtS1BuRWfgI0VWaz3SGG5YBrr8LurhXtd8DPfTPaPu55ytmqC+HPpmfwNpRUWdfex9bptgHGAwlywd5/82YghmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763189358; c=relaxed/simple;
	bh=5TOaV/CVq+ypVF3VCi2WG0tJO4+cIIxcVmpSzBLsYp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzrduRed1NBEuOz3kwONHJQdrpQ4E7DRjqsTYcvkCY5Guptz4ThWgWZlsrmftWVLrTV+r9GxNbI5S4mJMBWcN1OlCfWrDpyfb463ozgwrdMyWZ/QbpBeHgRxS6b3FAfMXzT20KVZ0ayiRdq6/0afBCfnWFL50R/NyV0KsbeRBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoA7iFs3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwJHusHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoA7iFs3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwJHusHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763189355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqQof21RDOM1mJKKumuiVy44qnJZ5Tg2vh9qh5UPau4=;
	b=MoA7iFs3LHmy/y0ZUyMljXNDcxCn69+8SZBbdkbAKMldlwTbDGbSyom8ws+n/uHcw0AZU1
	PHz2ywDfTY98C0giCQvrcBmrqHQURpS78ckRXgqBhHUWWzS6iGXQWQS3QAe22RcPyeXw77
	xnEuEgXnkOCF4pHx1aKbkQ9e58duabU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-X7GJta4dMDu8Oik4kgmpdA-1; Sat, 15 Nov 2025 01:49:14 -0500
X-MC-Unique: X7GJta4dMDu8Oik4kgmpdA-1
X-Mimecast-MFC-AGG-ID: X7GJta4dMDu8Oik4kgmpdA_1763189353
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343806688cbso4201914a91.3
        for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 22:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763189353; x=1763794153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqQof21RDOM1mJKKumuiVy44qnJZ5Tg2vh9qh5UPau4=;
        b=dwJHusHnUgyyQKi8WpGOh2q6hiecvkU955pYCTAysP4WNuaB6Q3GhDf3GU9uMlx5HI
         8PyBL8QxrQ3pTeGghkdT0spzQer0aizc/qsvRxCeN6p3IFc2DDFXIGy+opGFNr4ICS7D
         twvtCLV6avRLMRl0Lj/T5lkjD6XCmnTKaBnZdZbuNjUlx3nXNZ63a0C9H9XLtyl0d5Vl
         XQ+CNah6KmYuzPgUFtP3RiWFZ5oxffi1WiIJBgHCsunZTtgqWX1PutfggEgjbWDTI+AP
         dAqdiEe2r+sXW5F7uoYgd28FV4/lRuRwKiqIjZf0lUHCWHQKEdCQ7j7yCfgH8eLIs6t2
         OqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763189353; x=1763794153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqQof21RDOM1mJKKumuiVy44qnJZ5Tg2vh9qh5UPau4=;
        b=CnP0H0DljF5xL42TvSTdcxqsqiHdWF796unGJYxbh3hFRJrVHj4+BkUVBa4XSJeMkQ
         /bgW2dlsqsm0c8r3i4qu8nINzZau1WGq6m1o6q3nAADBxMboB50OSsyN+hGoMmwNEklf
         RL73k5NRAJ5Ea7Tjg1RLBkIKBPe7F+/C6KSQCXZ3LU431/di7YysZFsforoP2Vcck8jA
         vDh4BntXaFJR5isFEvjt1yXRmzyWvba5fqw4UL8uHRjn8TpILHA7+Jbs8Wip7qY5Mdc6
         MLmwxhP1YHIbnz4UnAKDSwSreaMvsu/BuP5tE4HoAQv0SVzleUCUDA8NxuKAO73vBF6G
         s35w==
X-Forwarded-Encrypted: i=1; AJvYcCXYOIjeScByhg+6WYN+z7b5xVOMhmPHxp6Exf6VzE/l07hpUz/8lP2BXFbKPFYCa8xboxuSeWIU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ysngwMJlKFs4hulVKo027eQS1lNFxoJmULC/LE6oN/dcuN47
	8CRp99auFCvmneiIzwu0MUZgpeygXCmcYjLqlkXhaRU2UH8HP85/e2lFjRKUXbaGb0T9fn+11Dy
	qR0+NIu3Lsvi1bPphq2RZWrPN97aMZMVJSMw4ETEDM7BettJ9hNd0A/swX9I=
X-Gm-Gg: ASbGnctijBc+GqjYaBEOMneqr+cyocTJEeMZPCur69C6kaQIfR73esqlkJvXhMyZzlX
	ikpfci4tYW3ofJYMJBip2+ki0fMPTZFNAIf02EOSM+MJVNEFGnbZFl46M8wdL39RI36i+cvnTZL
	2YqRU1WaHzwxJA4iYT2+uowf+sWnWvxMzbK6Dz1dNH6mDkwSRnb5s+K26pGYK/RD9tgZERHIwAO
	0DQg2QRU17dfVPwmfsW4h+NjY6KkEzpf1DDZjvrkPOPICHTmjaV/9lPJeYghJS3laNZ9qZpMiQV
	80FqmDsAbgFMwGhasn0uB96mYLgECoS/lMCYYJNEv1c/savxwAYIF9OJiB9y/dca8chbkI9d2TN
	o0p8CbPa0pUbMbBjmPoyqTrhdS8+QWJDHV99j/x60aNexHmcijg==
X-Received: by 2002:a17:90a:e18c:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-343fa0dbdafmr6288197a91.15.1763189352949;
        Fri, 14 Nov 2025 22:49:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoDwemDOUMDOzq5FMhyftOyNr4AOfBbyBLs3a/ms/NS2kBwLP6MxkzTNyBMQVVNl7xA1rFdw==
X-Received: by 2002:a17:90a:e18c:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-343fa0dbdafmr6288178a91.15.1763189352473;
        Fri, 14 Nov 2025 22:49:12 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e0624f3csm11317448a91.0.2025.11.14.22.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 22:49:11 -0800 (PST)
Date: Sat, 15 Nov 2025 14:49:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Joanne Chang <joannechien@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1 2/3] f2fs/016: add test cases for
 test_dummy_encryption mount option
Message-ID: <20251115064907.tfrm6d5p2zlpmf7u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251112135223.3467852-1-joannechien@google.com>
 <20251112135223.3467852-2-joannechien@google.com>
 <98034c77-5e47-43ea-9c45-335e2cd51b68@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98034c77-5e47-43ea-9c45-335e2cd51b68@kernel.org>

On Fri, Nov 14, 2025 at 09:33:58AM +0800, Chao Yu wrote:
> On 11/12/2025 9:52 PM, Joanne Chang wrote:
> > Add test cases to verify f2fs's support for different versions of the
> > "test_dummy_encryption" mount option.
> > 
> > To ensure test robustness, the MKFS_OPTIONS and MOUNT_OPTIONS are
> > cleared. This prevents additional options from interfereing with the
> > test results.
> > 
> > Signed-off-by: Joanne Chang <joannechien@google.com>
> 
> To Zorro,
> 
> The changes look good to me, though, still I want to confirm that whether
> it is recommended or not to add new cases in old testcase.

Hi Chao,

I think this case isn't a regression test to uncover a known bug, it's a
basic mount options test for f2fs. So that makes sense to me to add
"test_dummy_encryption" into f2fs/016, especially if it doesn't need to
bring in more _require_* restriction (right?) .

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> Thanks,
> 

