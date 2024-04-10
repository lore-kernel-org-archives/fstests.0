Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2116F0E2
	for <fstests@vger.kernel.org>; Wed, 10 Apr 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760184; cv=none; b=PpbkkRiDv81gWcSF5zk0bu6ocPW0u/YnK0u+klsWu8TeX0qtlwWGuv5yyH0cHn4sZ92tQ+WguyvzxxUgynb37+U3x6coCe0tcNbZ9TUcGNO0ksV2ecXWo5aYef3qpQenLvsGqwWNcmeNl0XJTtg7Fk4qH+XYPwRirngTBSoHTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760184; c=relaxed/simple;
	bh=mdE4AFJmcx7sG5k9QOUqN+TB2UORPIWb6tjUTU6OHzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+/+usTQToX19tj1pfBgrnAon8lHxFDIDP5PbtlhMUkrOjzXL/vLyVC+MLD/Gqdm2hZl8oBlTRjbg4ztZDvBATZdPquG9O6TpCaH3JNErTEN94IS0/npgrul1NKuoo7NwmD8E8cjYOO8gY2Uo/vF/ZZq3qVZGpXZnnNkDaU8SjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxkzcyBO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxkzcyBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712760181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNekNL5le48V0m1euDO7VRr7+CGqhPnB+TK2XGui12Q=;
	b=dxkzcyBO5jKgN2gmTyDbkrzbc2LHlmhNeOYE4M0HzLKQzwvwtws88JpCJPbKiT+19PoWe0
	ztC1b8UcnILA2/t9etE/PvJFTuCt/NUCe/gRlo/3AXKJHbNAYnXp9fOysanl9Ylk6+IC+L
	toLJPtKv1suqg349BBICWhBtjSIE+CU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-IN0AtUI2PxS9-0Fv5GmxQw-1; Wed, 10 Apr 2024 10:43:00 -0400
X-MC-Unique: IN0AtUI2PxS9-0Fv5GmxQw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so5534624a12.3
        for <fstests@vger.kernel.org>; Wed, 10 Apr 2024 07:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760179; x=1713364979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNekNL5le48V0m1euDO7VRr7+CGqhPnB+TK2XGui12Q=;
        b=MlLzkCPI/jm/5ozZAKSMmiMfJDe75s1PCte/ysnTRyXMnt6vX7naTxBmuCZ7n5ElUq
         cjkEDYGHcXhRqAtNsXqhA4UWd/8soRqWtesBgKsAzdNRnCFPAHgx5090IULatv8BEW02
         eJZC2EuzPe2/XzPi5mMksbBJGfwLP2rJ4hiLKI6r2Zm7gYsF8VJfRTlP6WyJ1ZVb1CBd
         vJf/LCXV6l7DW/I0REzFzQ/lj1wvCYNht9X/g9lXaD9qc+U9n2H0ntjBgN9Xfz/1H9Gp
         Q8k2aJW0AkKx5WBhBdKEnkii8AzIkpeXiCBhMZNEOZTIKiS2nomemqNF/DwTmSihO8hI
         V8zA==
X-Forwarded-Encrypted: i=1; AJvYcCWtOUnC2+hScvGvjXpSDIhA9hfLUp/3n5xzCk/KtdNze4UOxsqsjHzSrg6yYqef5HxN1A5uJL04MYo8Ye67URjlJ0dYt8rnOQ==
X-Gm-Message-State: AOJu0Yyi8jKAeWCL1TXksqT18oFActx5enJ+yMksehPmLP+DJnaSap/g
	v0oqNQnDeGrxS81Mq905atkWkRHAXPCi5SUCoNcpbhJdk3QQpoqDc4y15uy5RUBBSm1ZB6v/kHP
	mRt3eailpuSY+SMF0ZkW9sEuKEMMeX5Q9H8Igpqk/RJsth9HMSI5n3nQ=
X-Received: by 2002:a05:6a21:3994:b0:1a1:448f:d7b8 with SMTP id ad20-20020a056a21399400b001a1448fd7b8mr3039081pzc.62.1712760179045;
        Wed, 10 Apr 2024 07:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtkhT5FYYBjohIxZ49Riv7hmG+JtNcaD1nf+XQNDLmYfNGt6QTuhclJl99LfsmfPp+Mb3Y8Q==
X-Received: by 2002:a05:6a21:3994:b0:1a1:448f:d7b8 with SMTP id ad20-20020a056a21399400b001a1448fd7b8mr3039042pzc.62.1712760178433;
        Wed, 10 Apr 2024 07:42:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fx8-20020a056a00820800b006ed4c430acesm4964071pfb.40.2024.04.10.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:42:58 -0700 (PDT)
Date: Wed, 10 Apr 2024 22:42:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J . Wong " <djwong@kernel.org>,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: fix kernels without v5 support
Message-ID: <20240410144254.iiqrxlm64xc6mqa6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240408133243.694134-1-hch@lst.de>
 <20240408145554.ezvbgolzjppua4in@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240408145939.GA26949@lst.de>
 <20240408190043.oib4lmiri7ssw3ez@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408190043.oib4lmiri7ssw3ez@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Apr 09, 2024 at 03:00:43AM +0800, Zorro Lang wrote:
> On Mon, Apr 08, 2024 at 04:59:39PM +0200, Christoph Hellwig wrote:
> > On Mon, Apr 08, 2024 at 10:55:54PM +0800, Zorro Lang wrote:
> > > > this series ensures tests pass on kernels without v5 support.  As a side
> > > > effect it also removes support for historic kernels and xfsprogs without
> > > > any v5 support, and without mkfs input validation.
> > > 
> > > Thanks for doing this! I'm wondering if fstests should do this "removing"
> > > earlier than xfs? Hope to hear more opinions from xfs list and other fstests
> > > users (especially from some LTS distro) :)
> > 
> > What is being removed is support for kernels and xfsprogs that do not
> > support v5 file systems at all, not testing on v4 file system for the
> > test device and the large majority of tests using the scratch device
> > without specifying an explicit version.
> 
> Sure, I think most of systems testing doesn't need this, except some old
> LTS distros.
> 
> > 
> > The exception from the above are two sub-cases for v4 that are removed in
> > the this series - if we really care about them I could move them into
> > separate tests, but I doubt it's worth it.
> 
> Let me check and test this patchset more, before acking it. And give some
> time to get more review. Thanks for this patchset!

My testing done on some old and new distro/kernels with v4 and v5 xfs.
It looks good, doesn't bring in more issues. So I'd like to have this
change.

But as the review points from XFS list, looks like the patch 4/6 is better
to not be merged, and the patch 6/6 need further changes? So I'll look forward
the V2, to take more actions.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > 

