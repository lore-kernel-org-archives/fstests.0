Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07C21766A
	for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603398; cv=none; b=mBIW0xL9jkvpkTM8RcPespqyzonSMfLa82IltiYvC2BB1WRpWTAEoWwy7wyFtVfzIiq4E+Ki4/uGgZ1NZFpO+ZC0BXFE3OE11PM97k+vx3K+cbUwsc4Sy5CCPkaqNOKaJk5V18a+LuRvRG9+wbDZSkqmaV+nd+kMqIeSDHC1OSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603398; c=relaxed/simple;
	bh=1u/L50qjk28/dpCVhkDglmHokRXr5t6ZQVD5vPWQpTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV3SEVKIGXVkISB9ZxprTTZdGNopbK8lBececv/Hy7T6iJ+mVT7zeJ+3Fc+4weR32pDxElpqmadBMJa+eHWoX37okUIPa/S5eK7ClxddCrn5WhZ8Fk9S7kzn4qx1BQN+BYKSVO9UTxPo80j+WgoVpx5KjMpQz9bUoqmTGX3TiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArKBN6fD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArKBN6fD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734603395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7F7WumgbripVCX6ThhPDy5cIveNsKSy8nKxOGGHlCT0=;
	b=ArKBN6fD5LUd9l3k+w74+TOP1cpaNYF1uMQKgPHugEKwKzVIbeOyoBQBWhX2T2IFNtcq5D
	Aqpm0cz0Nzyu5QGrar3LKkkdySKgNJ5ZCAp0K873bZcvELXQwj/yMttTgG/cQihEWuVJ2O
	q+Yf6HY1Me794ZEiXKkFITy4Yodfe7Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-Wq1ak3AVO-Gb83aqUh9igA-1; Thu, 19 Dec 2024 05:16:31 -0500
X-MC-Unique: Wq1ak3AVO-Gb83aqUh9igA-1
X-Mimecast-MFC-AGG-ID: Wq1ak3AVO-Gb83aqUh9igA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21650d4612eso9585185ad.2
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 02:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734603391; x=1735208191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7F7WumgbripVCX6ThhPDy5cIveNsKSy8nKxOGGHlCT0=;
        b=mCFfX5mEj7b14l3znIHAUEj7ArnuB/mroUMW9+Y8wPkq/5mObKs9Lrzol7+PJ3w+e4
         627E4dIf5Y2T1Qe12xkgTpSJKCcd4+Wx2NiI2HeWs76E8Xok12ipHbu0y23HAac/yWZ3
         eCkCtQbVkpXKOdzrD6Nv4B4vIv7xi00C6XObycPXVgo0wfD6UtBJKx3LUpMxKRBhUyUL
         E7afDgZCbVHGwINIrIqjlPKV/TgjW807CIIatiyCGbet4GZXJ1h6D/1EBT6zTWexjVHg
         f4tRDWFhnXLRtn8WiCYU2Tlnr/RXRlsYAj6vwtnKnTSr946QArqczVmYrjBc98BqEX9N
         fhug==
X-Forwarded-Encrypted: i=1; AJvYcCXLy9EtzHEL8OtKmRdZmjs5mlKJVoXkagmfFW/VLua0fpRK2bTDeTL4LkBtNKHlc0S4eUjw37h8@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtX4CRIJr0w9zkGxndC3d/60GoA/vI2rrBPlh+BvCDB8P1IQA
	0g8PTdBPQyKP2ppRInOTFi8e/JeQmn/Nph+ydCb1BmuovfeR3qCaah92Sm+S+Ie1Qk53IklQozp
	53+nBtySx068oE6qaTPxF5FnfnaSsJjfJaWtxikefJTeFAoiZFnx1C1g=
X-Gm-Gg: ASbGncuIZuGDeiXusqYAQ3siln8/R47t1voks2JvJ2ucyVn3nqGA8VSB+hqazd5R+6+
	ggQNYFcDAKgUZgWAQZmJhzyPM7IEgUGbkQDrw2QLJqFvixjgvvUSHL0p+UOnHpkdt/tveJ4IUAv
	BZ6wrxEvsBo9Z6icG7tt6v2407BSth+GCHbc7kKIXz0LkMN9z6NwonKfAezpspyZJFpy5ofkt5a
	GuK1OQB4KaHHYZkDuxJyt/3TeQx1mSeh0RB429OahQ0hmtUIg8RVwm0pBpzAgydTSrTqWCDSXKo
	ZJ6N5VTrVwCb3QpoygMNEg==
X-Received: by 2002:a17:903:24c:b0:216:4064:53ad with SMTP id d9443c01a7336-219d96fc89fmr57180565ad.48.1734603390785;
        Thu, 19 Dec 2024 02:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErojYGx77GSsYM1ICHF6LPeOUlwxEqTIo25mAfUaEOSuMKd+hxYkOMuIMcVmpJVjr6TT4vaw==
X-Received: by 2002:a17:903:24c:b0:216:4064:53ad with SMTP id d9443c01a7336-219d96fc89fmr57180345ad.48.1734603390474;
        Thu, 19 Dec 2024 02:16:30 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970cbbsm9183185ad.103.2024.12.19.02.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 02:16:30 -0800 (PST)
Date: Thu, 19 Dec 2024 18:16:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area>
 <Z2OxMQACnMgmBR1a@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2OxMQACnMgmBR1a@infradead.org>

On Wed, Dec 18, 2024 at 09:37:53PM -0800, Christoph Hellwig wrote:
> On Thu, Dec 19, 2024 at 09:26:06AM +1100, Dave Chinner wrote:
> > On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> > > On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > > > +if [ $FSTYP = "xfs" ]; then
> > > > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > > > +else
> > > > +    _scratch_mkfs >> $seqres.full 2>&1
> > > > +fi
> > > 
> > > We really need to document why generic tests have file system specific
> > > hacks.  And yes, that's a request for Dave who originally added it
> > > without any explanation and not Ted.
> > 
> > Creating and then unlinking 50000 files is journal space bound
> > when using default 64MB logs on small test filesystems. Increasing
> > the journal size to 256MB halved the runtime of this test.
> 
> Please explain this in thet test.  And you probably also want to
> ensure that you don't force the log smaller than 256 either, otherwise
> people in 10 or 20 years will wonder why this test forces logs to
> be so small.

I'll help to add this comment when I merge this patch, if Dave hope to
keep "-l size=256m" for xfs.

Thanks,
Zorro

> 

