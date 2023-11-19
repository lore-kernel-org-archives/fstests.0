Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0cocOhp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD663C2
	for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 05:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700399894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cgYjmz8thehDy3Fre5EHYbt7FgUfi/125Vu4tA0P5A=;
	b=X0cocOhp3IaV2jIf8NSTiY/aGnjXaKSjkTtNPJoDP0tB8dd5gew/4S5vX2bjXj83uxJ1Ye
	xMH7JPh3nY00IRtGscOq+Q7IJddq5fNguY5QqB72F41/fTgsJ9gay1+v2YJOLR8WWxSAl8
	DJGnjNFEN+6KgCpOCgbFIRgpQWSShRw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Qgv0nazSOsuFhs_g-MF4tQ-1; Sun, 19 Nov 2023 08:18:12 -0500
X-MC-Unique: Qgv0nazSOsuFhs_g-MF4tQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b99999614bso3737996a12.0
        for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 05:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399891; x=1701004691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cgYjmz8thehDy3Fre5EHYbt7FgUfi/125Vu4tA0P5A=;
        b=Fczi9+jPbLGIjcMwV2Dxpj0ah5eikhzwRzpOrbJfXueNYBFgnNjPG2UiG/zIs/Gbsx
         UAyODUwPL2sRcLwDGmAOWnOK7cNr5+FEmEoclNMUqCAaJ+HlQs6cYKT8+6DOjgISBIHB
         oECzZEq4rRM3TAhYPQ2T2DnLVV/cyiVmSj4YTVx4hxuXGxWeeRugsTL3ip8cr74HOVwe
         o/ya2v4JloceCqwzqbjeJ0SMd2thVC8iEAoqhCbXaoUk9UeACyaqyfyIaAbRnjWxFYxe
         UkFE7renJU/M5xZyKNmTqN/3gL/2R2ucB8yqoFSHRA//sazpJjZDi6yZc52PyPYbWtNW
         9TzA==
X-Gm-Message-State: AOJu0YwZtWCl3KcziYp06OWRlR9hqjM/b+t66KjRRm1IBuWTtGrDY68I
	1dBk0MS4tnGwUn0B6GDWCurzRQGjxTyzCEeuHpBIQMwblv6+5XiIEvqh0npjLwSJ8Na4k3FawPR
	nAwRndpzMKvfHLltv0A==
X-Received: by 2002:a05:6a20:b797:b0:187:8eca:8dc6 with SMTP id fh23-20020a056a20b79700b001878eca8dc6mr2039444pzb.34.1700399891731;
        Sun, 19 Nov 2023 05:18:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmwZwi+DY1fKhxKkM7FmDFCgRgMcZmcpC5l2ydsxZeT/WyavgrNrOaZWm+olKK02vKsBC3MA==
X-Received: by 2002:a05:6a20:b797:b0:187:8eca:8dc6 with SMTP id fh23-20020a056a20b79700b001878eca8dc6mr2039435pzb.34.1700399891360;
        Sun, 19 Nov 2023 05:18:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b006cb8a8a4bbfsm697136pfu.186.2023.11.19.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:18:10 -0800 (PST)
Date: Sun, 19 Nov 2023 21:18:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/726,727: add missing _require_scratch_reflink
Message-ID: <20231119131807.rwpfigdiui3uoxqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231108152428.432995-1-hch@lst.de>
 <20231117145155.t7vvq3ksdrhyo5ff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231117220945.GH36175@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117220945.GH36175@frogsfrogsfrogs>

On Fri, Nov 17, 2023 at 02:09:45PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 17, 2023 at 10:51:55PM +0800, Zorro Lang wrote:
> > On Wed, Nov 08, 2023 at 04:24:28PM +0100, Christoph Hellwig wrote:
> > > These two tests require reflink functionality, add the correct
> > > statement to ensure that.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  tests/generic/726 | 2 ++
> > >  tests/generic/727 | 2 ++
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/tests/generic/726 b/tests/generic/726
> > > index f0d8df2e..77afe10c 100755
> > > --- a/tests/generic/726
> > > +++ b/tests/generic/726
> > > @@ -19,6 +19,7 @@ _begin_fstest auto fiexchange swapext quick
> > >  
> > >  # Import common functions.
> > >  . ./common/filter
> > > +. ./common/reflink
> > >  
> > >  # real QA test starts here
> > >  
> > > @@ -28,6 +29,7 @@ _require_user
> > >  _require_xfs_io_command swapext '-v vfs -a'
> > >  _require_xfs_io_command startupdate
> > >  _require_scratch
> > > +_require_scratch_reflink
> > 
> > Does the "startupdate" actually need reflink feature?
> 
> It does, but the -a switch to the _require_xfs_io_command swapext line
> above will fail _notrun the test.  Or at least it would had I not
> changed the CLI options when I gave up on getting FIEXCHANGE merged and
> reworked it as an xfs-only ioctl.
> 
> IOWs, the "privatize the FIEXCHANGE" series should fix all these
> problems for Christoph.

Thanks Darrick, I'll drop this patch temporarily (as I've merged your
"privatize the FIEXCHANGE" patch). Please reply to this patch again,
if this problem is still there after next release.

Thanks,
Zorro

> 
> --D
> 
> > >  
> > >  _scratch_mkfs >> $seqres.full
> > >  _scratch_mount
> > > diff --git a/tests/generic/727 b/tests/generic/727
> > > index 2cda49ea..1f9eebc5 100755
> > > --- a/tests/generic/727
> > > +++ b/tests/generic/727
> > > @@ -20,6 +20,7 @@ _begin_fstest auto fiexchange swapext quick
> > >  # Import common functions.
> > >  . ./common/filter
> > >  . ./common/attr
> > > +. ./common/reflink
> > >  
> > >  # real QA test starts here
> > >  
> > > @@ -31,6 +32,7 @@ _require_command "$SETCAP_PROG" setcap
> > >  _require_xfs_io_command swapext '-v vfs -a'
> > >  _require_xfs_io_command startupdate
> > >  _require_scratch
> > > +_require_scratch_reflink
> > >  _require_attrs security
> > >  
> > >  _scratch_mkfs >> $seqres.full
> > > -- 
> > > 2.39.2
> > > 
> > > 
> > 
> > 
> 

