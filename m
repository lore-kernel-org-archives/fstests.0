Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D37634
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003152; cv=none; b=jMKGLvTy3g/YNfqoq2HsKCieymZqWRrdzqclItA58IfJPPentOy5P9tCWdATxi3oipGThdDh6/WLQvJ6kni9jOgpi59LBj7dHJemlPNsqsELIA411mgFIMP5lrFY+VD2A8feX1zRldxu7ayNxueoX1EdPAVcPaK86j19SpinqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003152; c=relaxed/simple;
	bh=yRtde/RriZXKUw2Him8yAnCB004ZdyBpntS5AvZIBF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qmufktukxhp8qxM7O+QUBGa8jKedIFrldDDnclPKxVmFpkfpM4q6uBLoN0EQ4fWY3Pg1sI9FZIOBRnobruY63gfwfOJViNe5m7VxZTnnUT8IaIxQW9jnTS/K3erFDiaItv39wsnbPSCHSDLcYPuRs5TGAqvdOgUzibsdk2uMPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IisT2df5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IisT2df5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709003148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AG/5YL3uORiyDcYskT43x0/4hpMJtYNXcQTgXTRH/Go=;
	b=IisT2df5wu1FWDd9Pq/Plrj1xBOXfe3Q00RGRxq8fRzS/UQ4Pn7FCehdjLGZE7HpuAcKVp
	khRTyb/Q9M7oKnLNLE84IfOIq6EOWvFSfsbFZdO2EE8NAmGz8KdlVEaMI6yHOg3+q2E0vW
	i3IWuQ1307Ur+TpP5q6MTWjuha7YZiM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-OtVIyDywMuKahpCCoWIjCA-1; Mon, 26 Feb 2024 22:05:45 -0500
X-MC-Unique: OtVIyDywMuKahpCCoWIjCA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c1a511830eso1205276b6e.3
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 19:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709003145; x=1709607945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AG/5YL3uORiyDcYskT43x0/4hpMJtYNXcQTgXTRH/Go=;
        b=kZyRhvHaVOAQ/KvmUAPNNofaBkPurXvOU2qD2Ws7bQ1dCzjaYndxeWvugDgh1JGmnU
         UDDD0xrS9s7uFGTxlTGdjMk19eVZjARbKc9LhV3qS6b4kZNerb6QNTkBFxeFcK3+u/sw
         JvZ9/F6thPGg5ufAbkJMfp30JnF9vc3su644tQq4/skekCToPswiXDPTa90utyWb1ojP
         kKbyH4zEYMfzXvv+oMyYmJPZUKgkX3OrleF4mhnjc1cCfPjj6EmaTVDtSIydkQUTV60h
         3RIgrG3KBQND1mw2G4yLWO+clfRCzuX+54CXiWoF1b/Ynt/g8CXTc/hhHtGh0XVCWxoM
         fV1g==
X-Gm-Message-State: AOJu0Yy/PxltibP9JiZ3WzvoLxxZjyqvm2iUBt+IEqK4gFJwVMdXpHjM
	cOOXUHTTzU5wYflLtqsfh5HOXDA2uJ5aw3yGxzZy2wM8bBb0fO4uG0diK/z/BbK7bVJ4hcmKpM/
	wvptbKuBMJHnQmKbUaR9bEv68VDC4CLjb87WcPNyNAdDclx7A994DCGo=
X-Received: by 2002:a05:6808:1184:b0:3c0:3f65:dc2f with SMTP id j4-20020a056808118400b003c03f65dc2fmr987782oil.50.1709003144765;
        Mon, 26 Feb 2024 19:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoUpxHchFIaVfSEDb1LFXDlDYeD3ejUtDkA5xPBmYKySPJyMAfSyBspvRa5iNDSpGVN9MdRw==
X-Received: by 2002:a05:6808:1184:b0:3c0:3f65:dc2f with SMTP id j4-20020a056808118400b003c03f65dc2fmr987764oil.50.1709003144364;
        Mon, 26 Feb 2024 19:05:44 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z2-20020aa78882000000b006e47ab9b2e5sm4720588pfe.215.2024.02.26.19.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:05:44 -0800 (PST)
Date: Tue, 27 Feb 2024 11:05:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] tests/*/Makefile: make sure group.list DIRT exists
 before install
Message-ID: <20240227030541.z7bweuyamwwubkmt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240208225241.644701-1-martin.jansa@gmail.com>
 <20240225163042.rrb6djrhbs6e2fk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CA+chaQdFJkmc540nzz0PKJLtXMGg4yCfHYkMZaxCooCZ6PdaLw@mail.gmail.com>
 <20240226165703.GQ6188@frogsfrogsfrogs>
 <CA+chaQfpUUBqP_ai_4UPWYBztGvdxAU+V0OfmTKG9t7_nrb1rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+chaQfpUUBqP_ai_4UPWYBztGvdxAU+V0OfmTKG9t7_nrb1rw@mail.gmail.com>

On Mon, Feb 26, 2024 at 06:31:04PM +0100, Martin Jansa wrote:
> On Mon, Feb 26, 2024 at 5:57 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sun, Feb 25, 2024 at 07:01:48PM +0100, Martin Jansa wrote:
> > > On Sun, Feb 25, 2024 at 5:35 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Thu, Feb 08, 2024 at 11:52:41PM +0100, Martin Jansa wrote:
> > > > > * sometimes make install was failing with:
> > > > >   cp: cannot stat 'group.list': No such file or directory
> > > > >   and bunch of non-fatal messages:
> > > > >   mv: failed to preserve ownership for 'group.list': Invalid argument
> > > >
> > > > I'm wondering ... isn't that expected?
> > > >
> > > > Why not let "make install" fail directly, if there's not a completed "make" ?
> > > > Isn't that more familiar?
> > >
> > > It might if it fails reliably, but in OpenEmbedded builds where I was
> > > seeing this in some CI builds it failed in about 1% of the builds, which is
> > > enough to make the failure annoying and if this is meant to be expected
> > > behavior than not failing reliably, for context see:
> > > https://git.openembedded.org/meta-openembedded/commit/?id=e8a1c9823b7e55dd2ca7f19a3fd3a05ae676bfe2
> >
> > Aha, that explains the weird language in the commit message about
> > "removing tests/*/group.list" and "adding some sleep" even though the
> > patch doesn't actually do that.
> 
> That's what I was using to reliably trigger the "make install" failure as in:
> https://git.openembedded.org/meta-openembedded-contrib/commit/?h=jansa/master-xfstests-debug&id=d3fecf856850645762a9dcad5160686b2445729d
> 
> > > so here it calls make in do_compile task (defined in autotools-brokensep),
> > > then make install in do_install task and do_install was failing
> > > _sometimes_, and I haven't seen single failure since this change was
> > > applied.
> > >
> > > I'm not very familiar with xfstests, I wasn't even building it
> > > intentionally (it's just part of one CI job which builds everything
> > > available), so I might be missing something.
> >
> > Huh, that looks like the result of make trying to run the 'default' and
> > 'install' targets in parallel because there's no "install: default"
> > clause in the Makefile.
> >
> > Soooo... are you folks using 'make -jXX default install' in your CI
> > system?
> 
> -jXX is used in 2 separate steps (bitbake tasks) which don't run in parallel.
> 
> do_compile tasks runs:
> do_compile() {
>     make -j 70 -l 140
> }
> 
> and only after do_compile is finished do_install task runs:
> do_install() {
>     # otherwise install-sh duplicates DESTDIR prefix
>     export DIST_ROOT="/" DIST_MANIFEST=""
> DESTDIR="/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/image"
>     make -j 70 -l 140 install
> 
>     unionmount_target_dir=/OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/image/usr/xfstests/unionmount-testsuite
>     install -d $unionmount_target_dir/tests
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/tests/*
> -t $unionmount_target_dir/tests
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/*.py
> -t $unionmount_target_dir
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/run
> -t $unionmount_target_dir
>     install /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/unionmount-testsuite/README
> -t $unionmount_target_dir
> }
> 
> And with this I see 15 calls to buildgrouplist in do_compile and then
> the 2 calls for each of these 15 group.list files again in do_install
> 
> grep GROUP temp/log.do_install temp/log.do_compile | sort | uniq -c
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/btrfs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ceph/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/cifs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ext4/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/f2fs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/generic/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/nfs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ocfs2/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/overlay/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/perf/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/selftest/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/shared/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/tmpfs/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/udf/group.list
>       1 temp/log.do_compile: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/xfs/group.list
> 
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/btrfs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ceph/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/cifs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ext4/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/f2fs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/generic/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/nfs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/ocfs2/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/overlay/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/perf/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/selftest/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/shared/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/tmpfs/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/udf/group.list
>       2 temp/log.do_install: [GROUP]
> /OE/build/oe-core/tmp-glibc/work/core2-64-oe-linux/xfstests/2024.01.14/git/tests/xfs/group.list
> 
> I guess for you it doesn't run buildgrouplist again if you run "make
> && make install"?

Thanks for this explanation, this example makes more sense for me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Regards,
> 

