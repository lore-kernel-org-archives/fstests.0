Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9C1E481
	for <fstests@vger.kernel.org>; Sat, 12 Oct 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728741963; cv=none; b=athyNp7XxgJ4KHGlqIB4PZxSVE2lZvhDrHmGZ5EpRZbPqwDqGnDv2pF5RTIN0ecO+7PQhXC/o3NePMMNdoLwJVv3mu6bZxTVCdqC2/tMZJshGa2lbJ+16hGx9jLI21y6B49ROKI0F0kD6/nTHJUhnuHOYty3108m7myz9e1sZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728741963; c=relaxed/simple;
	bh=NBksyTOGWe4Nt8KqI4uApjQlOLOGrnw160iwZF/dcKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLvTimAq33LreNW2K/MWTyCfDjBfANWLtw/MpxuwiI7RNdYfTmmVmaw3Zm4zdvSCrul0MUDtv34z7VAABrlcEysTQ4r/CPjCLaIaipARuwEjePtncDZFLWkw6HtT+KnT68p+l/LlwipvHy43zYnCl3JsORtIgdMVA7RR/LcsYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtmiAYLD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtmiAYLD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728741960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=waFDwgPr4QcJIxhWov0AkVYaGHbJ4W1aOqTw0mnlcSk=;
	b=WtmiAYLDfNxWExtJC8kyXILtqmYP0Pa6zf5EI9IUvBcISyG2jDceMUCJ82rLFb3eZF5SUi
	0QYVHFiNbCwUFoPm5yiBC1x2kqv3D7jkW2O0XkbrYarYJf55uN3awzBXhZwWTVwL8txXBE
	rNh7zcFZT78sdAhENuUezqoAnL21k80=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-Vfar0zc-NhmmchUR84PQ7A-1; Sat, 12 Oct 2024 10:05:59 -0400
X-MC-Unique: Vfar0zc-NhmmchUR84PQ7A-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e576a28c7so241220b3a.2
        for <fstests@vger.kernel.org>; Sat, 12 Oct 2024 07:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728741958; x=1729346758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waFDwgPr4QcJIxhWov0AkVYaGHbJ4W1aOqTw0mnlcSk=;
        b=u2gUfJTfTSr89J25sUCTqgK1eMvgiBhzW1xzHYVgu5DycdGdqcwuEyB4tad2LGXaSD
         +Uquvo330WX823lpaB9SQCjwneVq+RRtf25wJLwJgjtL99j261h/7NFKU4Xs0tM84wT9
         ELhcj+gquI2tot4ej4U4BtqX2fzAcbG5CevX+j0PfXamSKrL7q+qiJ07rKjm5jZ0MV9i
         pl85NnUyfWIP+ADfriS+nOPvIk5RdhpHXx9N7yGYqpC9O1tXMgx6ujAYGrqFLwue1d2m
         B6odQC4Bi3mZ3Xi+G5yRLxk4Vq2Q4NhCv75cIKUldTF8upnnGd/OfljiFZ8OduWrNTqW
         OcDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN3k9aWyajdhW9tDBupiwd0zUH6Tp3JgPINcHNKWHJo2c5FEi2PZ/2rErdQrI3xywTukt6qILl@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLAlHF1AUs0sN/cXZWa05bxeQMJJtsGogdXmpqF9yp0H8tsTK
	3ispai9yfQPZGgLTiIsjMrYU2T7jkPr4Zb0PVwUTUe4uyd3odtn5CP6MlBmUCZwNnM7ivB+NyIE
	0LuiprraEMr5ymfU9XHg4uiI931mmQ2vFFuv8QH2Pw7Qb0vIP25RZdwuGpt/tY2APwA==
X-Received: by 2002:a05:6a00:1252:b0:71e:659:f2dd with SMTP id d2e1a72fcca58-71e37f4edf2mr9636649b3a.20.1728741957682;
        Sat, 12 Oct 2024 07:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOcIar4YRVXK9mEh/hhK+NDFYUIxYOnGopKwwWU/UhwCmi5Oxf/aZxhd++QLkTL7P5kcpEfg==
X-Received: by 2002:a05:6a00:1252:b0:71e:659:f2dd with SMTP id d2e1a72fcca58-71e37f4edf2mr9636615b3a.20.1728741957349;
        Sat, 12 Oct 2024 07:05:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa937cesm4163289b3a.132.2024.10.12.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 07:05:56 -0700 (PDT)
Date: Sat, 12 Oct 2024 22:05:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs/122: add tests for commitrange structures
Message-ID: <20241012140553.hpgvmjfajdfdjtgh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <172780126017.3586479.18209378224774919872.stgit@frogsfrogsfrogs>
 <172780126049.3586479.7813790327650448381.stgit@frogsfrogsfrogs>
 <ZvzeDhbIUPEHCP2D@infradead.org>
 <20241002224700.GG21853@frogsfrogsfrogs>
 <20241011062858.p5tewpiewwgzpzbo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241011181920.GO21840@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011181920.GO21840@frogsfrogsfrogs>

On Fri, Oct 11, 2024 at 11:19:20AM -0700, Darrick J. Wong wrote:
> On Fri, Oct 11, 2024 at 02:28:58PM +0800, Zorro Lang wrote:
> > On Wed, Oct 02, 2024 at 03:47:00PM -0700, Darrick J. Wong wrote:
> > > On Tue, Oct 01, 2024 at 10:45:50PM -0700, Christoph Hellwig wrote:
> > > > On Tue, Oct 01, 2024 at 09:49:27AM -0700, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > Update this test to check the ioctl structure for XFS_IOC_COMMIT_RANGE.
> > > > 
> > > > Meh.  Can we please not add more to xfs/122, as that's alway just
> > > > a pain?  We can just static_assert the size in xfsprogs (or the
> > > > xfstests code using it) instead of this mess.
> > > 
> > > Oh right, we had a plan to autotranslate the xfs/122 stuff to
> > > xfs_ondisk.h didn't we... I'll put that back on my list.
> > 
> > Hi Darrick,
> > 
> > Do you want to have this patch at first, or just wait for your
> > next version which does the "autotranslate"?
> 
> Let's drop this for now, machine-converting xfs/122 to xfs_ondisk.h
> wasn't as hard as I thought it might be.  Would you be ok with merging
> the fiexchange.h patch and the fsstress funshare patch this week?

Sure, if you hope so :)

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > 
> > 
> 

