Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3A144609
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876874; cv=none; b=SFwMwrTSAHImGL1SoseWihzVK4MmhacKVQfv/bFnVV+pxcKNwI1BbENS3QW1d0clplnVG0zXtzEuwZPeKW/p48gQSGbQO42LWi/F2an/0MSb9nVvAtROtsSaIK4DJkcPAFdGLVaVlqHmZLz5ZYTeTulcOJ+9eIz3kLGv1qo0c2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876874; c=relaxed/simple;
	bh=wA8Lf3CZyMSyk/+YApk65f8FNwWV1iWFTXih4mLCFMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyMtcdmYevAHU41H8TKKI3ZlLW4QHu9azjmCC/AWa6zpli2uVVM8AemEYfw0JfdAkhgJrotbF5YzhdoRSgYj4iTUkYoYzdAiUuzlTpZBsKK2ElepRJb+iR8vbIGOIRQYCkQkDxGEKMy7TAfrSGL+Hr76pqV4/9qPX/otlHlvt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqV6Ilze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqV6Ilze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706876872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bSOagLCU9RA18uhSvbVE7xJJi/PABl/3SptPhadGyo=;
	b=DqV6IlzeLyuPaXNm4oUY8hVGIy4etlyAYmPz9CVBcLoRl7UpdRR4ma0VsYy2O7TYFYbIh6
	ovUdI2WfECejIOvt999VhtYOj0VolMg3FrlAXaNk6Dtd+Ym0VWMpRHtm09C6uytrUEMU7e
	hh5hmat3n9pexH0uVGUh9jDPxW2GwYU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-8e1Gs6XZMlipmOyOtRUz9Q-1; Fri, 02 Feb 2024 07:27:51 -0500
X-MC-Unique: 8e1Gs6XZMlipmOyOtRUz9Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2962ab5ddfbso1240490a91.3
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 04:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876869; x=1707481669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bSOagLCU9RA18uhSvbVE7xJJi/PABl/3SptPhadGyo=;
        b=e2PIbjcjFlCUENjEgZRB8bl6op2xtw8CALWsvFQC/aFxRzjznpGQqt9tbg8LCt1w7w
         cq1X9CqnER8lvNTImL4wRU8GP7pCby8tCfisVik/XOEbDtWHzVYBgVHv2iyusDsFduNw
         5VsKjgS8LToCdj88mD4JvR7PsjTDAgC6boJpvIWbWMsPL9wf4AD0rVF3/8NuXMhcdmwH
         Gq3dr2y4Sux6WbMUzzLk6EyS1MAdFmZPnOKQj3+3HLZ77OpSSNmC9VM+PZTtPigp7ZOK
         ksEpB/GDame9z/HrdV3bOYUhFCqX9ioP1h5/KEhN3PpuQ0myaoJghTsqPZeQeN5DH1ax
         Eiiw==
X-Gm-Message-State: AOJu0Yy6rS9t+kg6G1edNMxRAten/pFurAg2/rhvYPqeQGo0+vxlpAoY
	8kDBmYJQ3gq5Sw2Ryg61wpAIxUdPbyq5be1YRSXKNfwkhUlKoYrnLzcw+3PfiV8oNeBBLctLbeI
	RUeyOC4ckQ/fKTGz/QBWSFR0uipbOwJReKzWyGiQun5E3jG45X8n8huo=
X-Received: by 2002:a17:90a:b109:b0:296:3a8e:eee8 with SMTP id z9-20020a17090ab10900b002963a8eeee8mr1821276pjq.41.1706876869216;
        Fri, 02 Feb 2024 04:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhqMYloYVaa90BbAjZtT2EA4kNkQ2X2GfMp/4bupHtIhVjXyyclcgiK6YdCTsclPsISyq5QQ==
X-Received: by 2002:a17:90a:b109:b0:296:3a8e:eee8 with SMTP id z9-20020a17090ab10900b002963a8eeee8mr1821268pjq.41.1706876868926;
        Fri, 02 Feb 2024 04:27:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSxAZxruJWidru6j6sqHp3MCGb6P0oMvdXcakO87WfMF0/E91ccqCii0dveFflASqpY0gnMKQiY2srIt22FJj7Y80ewBM14D8fKvh/eYo50dRqf/8fp+Dti2zrCrk=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090ab89000b0029604b0b7d1sm3821293pjr.15.2024.02.02.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:27:48 -0800 (PST)
Date: Fri, 2 Feb 2024 20:27:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Message-ID: <20240202122744.ejfpfrfbt6gnrese@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230925201827.1703857-1-aahringo@redhat.com>
 <d9981b21da65517589150792e8511bf192dd2374.camel@kernel.org>
 <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAK-6q+iiSgZBne_C-o3iGz=+dzjVupGX6t04JbzB9DZU__q-0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+iiSgZBne_C-o3iGz=+dzjVupGX6t04JbzB9DZU__q-0w@mail.gmail.com>

On Fri, Feb 02, 2024 at 07:19:53AM -0500, Alexander Aring wrote:
> Hi Zorro,
> 
> On Fri, Feb 2, 2024 at 7:04 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 12:10:44PM -0500, Jeff Layton wrote:
> > > On Mon, 2023-09-25 at 16:18 -0400, Alexander Aring wrote:
> > > > This patch adds fcntl corner cases that was being used to confirm issues
> > > > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > > > implementation and in those corner cases issues was being found and
> > > > fixed.
> > > >
> > > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > > ---
> > > > changes since v2:
> > > > - move fcntl tests into one fcntl c file
> > > > - remove ofd and same owner tests, should be reflected by only one test
> > > > - simplify commit message (remove testname out of it)
> > > > - add error messages in fcntl.c to give more information if an error
> > > >   occur
> > > >
> > > >  src/Makefile          |   3 +-
> > > >  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/732     |  32 +++++
> > > >  tests/generic/732.out |   2 +
> > > >  4 files changed, 358 insertions(+), 1 deletion(-)
> > > >  create mode 100644 src/fcntl.c
> > > >  create mode 100755 tests/generic/732
> > > >  create mode 100644 tests/generic/732.out
> > > >
> > > > diff --git a/src/Makefile b/src/Makefile
> > > > index 2815f919..67f936d3 100644
> > > > --- a/src/Makefile
> > > > +++ b/src/Makefile
> > > > @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > > >     t_ofd_locks t_mmap_collision mmap-write-concurrent \
> > > >     t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > > >     t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > > > -   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> > > > +   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > > > +   fcntl
> > >
> > > I think this function needs a less-generic name than "fcntl". Other the
> > > lock tests themselves look like a nice addition though.
> >
> > Yeah, the "fcntl" name is too "big", please rename it to show what it trys
> > to test. Hi Alexander, you can tell me the new name you'd like to change,
> > if you don't want to send a V2. That might help to catch the fstests release
> > of this weekend :)
> >
> 
> I was thinking about "fcntl_corner_tests", if this is okay.

Good to me, I'm rename to that if no more objection :)

> 
> Thanks.
> 
> - Alex
> 

