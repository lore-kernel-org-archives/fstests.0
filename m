Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511036BB49
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8aDm6d2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705066552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpJzkrmj08C5Xizjya0CoNsCINxaksJrnJLamVSYINQ=;
	b=L8aDm6d2bQtPwoG5Kry977fhd+/vqZhg7Fx0w+wov4wCxDfolpR7r4LxMntamxgCqQ+/0A
	VwQwg2ULc0iKOlZkRXhgyH5wJh0eU1+V5nEtXjxYSmpeAEYBbo7uFEHFW/vhyJ5aEEklPS
	PjUyO9b68nSQ7z2KIe/9MhDLIL0BJ2w=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-T-4I44KmNxqstPIN_ib-FQ-1; Fri, 12 Jan 2024 08:35:51 -0500
X-MC-Unique: T-4I44KmNxqstPIN_ib-FQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso2694480a12.1
        for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 05:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705066550; x=1705671350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpJzkrmj08C5Xizjya0CoNsCINxaksJrnJLamVSYINQ=;
        b=XbQa2JfYUpovlklLKDfE71YoQc+UYrUQT7CVdw0sNcgwmaEnwcU+EqtQ1+Z4Z/M37f
         beN5+qhswv2UKrPJve/GcDdooND5LOdy8kdKrxtS7y1G1waH/QdNse0zvFz4LSaMoCxO
         e/gven9P8XmtLwFvqhdiKYaj3OIWKSTKpv4aZqvrv1b8gnrXMH6KzQ/Brj1xM5IyeWSi
         x2BBk/4K95Wf1eqTXfiIZpF5GXnIBWxUZfIwr/PDfntASF7ZaNzegj5qqDDDHeaDOLfN
         OvP7maWzj2y0qTiPCEcIbomdJQMlIsvCbNeIELBQfH2M8qBcnb7yDGUL11iTFDB+kPua
         Ijkg==
X-Gm-Message-State: AOJu0Yw4OErEUwZCd6M817tGd8UhJLG3RZ4Xt/OVzrfhjJ9Gl3ug98xP
	3AVjbC31Yl1buKJI6iyXpSQiFnnwZvOu8FIs2j05RTWZor00KUhVrb0oOx96LQddGXOAJESteZU
	s7kmbfkoHtSLL/el2n91qLu+fl2h8AVY38Lck
X-Received: by 2002:a17:902:6847:b0:1d4:e31b:11a7 with SMTP id f7-20020a170902684700b001d4e31b11a7mr887470pln.24.1705066549737;
        Fri, 12 Jan 2024 05:35:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgWzRPRKwiTz4goDaZ0z0X4/uAZD3P4hSq8BnCtR5U+7+r0jvtluQxbe0gX7qcWDSpPNZSuA==
X-Received: by 2002:a17:902:6847:b0:1d4:e31b:11a7 with SMTP id f7-20020a170902684700b001d4e31b11a7mr887462pln.24.1705066549432;
        Fri, 12 Jan 2024 05:35:49 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id db11-20020a17090ad64b00b00286da7407f2sm6375046pjb.7.2024.01.12.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:35:49 -0800 (PST)
Date: Fri, 12 Jan 2024 21:35:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH fstests 2/2] generic/732: don't run it on NFS
Message-ID: <20240112133545.r7obtpchaetmodxv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
 <20240110-fixes-v1-2-69f5ddd95656@kernel.org>
 <20240111204931.oqbub6crymt2misb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <1a2ad4e0142c6a80a0930c9d4841facb75a8f93b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2ad4e0142c6a80a0930c9d4841facb75a8f93b.camel@kernel.org>

On Thu, Jan 11, 2024 at 04:13:11PM -0500, Jeff Layton wrote:
> On Fri, 2024-01-12 at 04:49 +0800, Zorro Lang wrote:
> > On Wed, Jan 10, 2024 at 01:27:28PM -0500, Jeff Layton wrote:
> > > This test sets up two independent superblocks with the same backend
> > > server, and then does RENAMES of the same files in the two servers. This
> > > is basically trying to simulate the case where two clients are competing
> > > to rename files in the same directory on the same server.
> > > 
> > > This test would usually pass vs. an NFSv4 server that doesn't have
> > > dfdd2630a7398 ("nfsd: fix change_info in NFSv4 RENAME replies"), because
> > > the client would end up improperly invalidating the dcache for the whole
> > > dir after most RENAMEs.
> > > 
> > > However, this test doesn't (and shouldn't) pass on NFS, because the
> > > client has no idea that a rename has happened on the second mount. The
> > > expected behavior for the NFS client is for it to use the cache timeouts
> > > in this case, which is what it now does with the above server bug fixed.
> > > 
> > > Exempt NFS from running this test, since we don't expect it to pass.
> > > 
> > > Cc: Yongcheng Yang <yoyang@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > This case is written for a nfs fix at first. If nfs would like to skip this
> > test, I don't know if it makes sense to keep it in fstests?
> > 
> > 
> 
> It might make sense to keep this test in place for stuff like cephfs,
> but if dropping it altogether is best, then that's fine with me.

OK, thanks for this feedback, if it still makes sense for any one fs,
we can keep it.

Thanks,
Zorro

> 
> > 
> > >  tests/generic/732 | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/tests/generic/732 b/tests/generic/732
> > > index 785aac58f361..5b5087d5accd 100755
> > > --- a/tests/generic/732
> > > +++ b/tests/generic/732
> > > @@ -22,9 +22,7 @@ _cleanup()
> > >  }
> > >  
> > >  # real QA test starts here
> > > -_supported_fs generic
> > > -[ "$FSTYP" = "nfs" ] && _fixed_by_kernel_commit fdd2630a739819 \
> > > -	"nfsd: fix change_info in NFSv4 RENAME replies"
> > > +_supported_fs ^nfs
> > >  
> > >  _require_test
> > >  _require_scratch
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

