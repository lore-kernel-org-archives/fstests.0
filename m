Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EED221554
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047861; cv=none; b=KfBUfFhSAeTJ/4MRINMVIz7OBjqBUNUfgl6B0VMC5GqQ72hVbOJJ06uHh/hXVSg9FwcMBwxfztVJyDY6lpe8IGcckhloc2Zr1WLyf3qnYnaDgsdh2okTtVfSkInyOD4h8CnKJ20F0JrjA9XP48THpHlWNJmahsoumxpzUBXY+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047861; c=relaxed/simple;
	bh=kfDzeD7/zVb4/0FU4EQ5xJW48GYfBRynNi0nwif2T7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFIH3ok7i1CGDaWoFjChKi/8HIq5XL3SahsjrOHVyMej3z+/Qyfx+fq72riwChVXJ1WUfqEek/dS43QCwBBzG/TSlJWLUwTQRCD77zEs+leir/D7oYiq+8MTwbB3E/X6RF+vcISd6xrFBvoRLfCzqlF22Ot9z8JkVW7N0y6GQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdCsMKVi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdCsMKVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759047853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKciQSQWCcG+I3KbO2dQ+p5tZZ7NpAvrzeYros3oPeI=;
	b=PdCsMKVicEL+9GAJClyruiBDPycEI8agj4JvvRsr5B7Axkh8GB4K8u9GHnHc1gvi3AUGKr
	IL2TWIt9ZAg8HnRmtLIavS7d/IQUGg1h8l2hgKP8AGhQsiwKIKAXkmKlKcltmC3D58+e4t
	F4eHMKeaKXa64lR7H3RzAMT1ac6q8yU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-b9k8wNvaPbOFb8B8ftDkuw-1; Sun, 28 Sep 2025 04:17:39 -0400
X-MC-Unique: b9k8wNvaPbOFb8B8ftDkuw-1
X-Mimecast-MFC-AGG-ID: b9k8wNvaPbOFb8B8ftDkuw_1759047459
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e60221fso5074443b3a.0
        for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 01:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759047459; x=1759652259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKciQSQWCcG+I3KbO2dQ+p5tZZ7NpAvrzeYros3oPeI=;
        b=IYmNVMHSlmplE/ycwRJ+niyYDJ/5jgxG1h7qdjOVmKWUOP2qpvPQT8LqaFN3un+tJY
         5xjeBM1zJyyrDE2Mqogqj+QbpPRs1NjoPPEs2czVNwA3+zuPCD0CrNDpek2HQok/Ajlk
         aG+s7eg1oxFQ3O665lUVp7rreOCpAKZHkyqqfp8oPz3BYrKzqp9agW3f6vjmRxrNq5Gm
         ecUM/RJkrWQsURDpzMbNiePRkfvjPCQqSQjQ73u9MMXapH2rdMQKFmNWpTltvO/QifPY
         xeLTEhThwznnhfgE9zf/4ojnCTYX8aLA9BZucPqt9bXfacgpsHnlYBJ01TipBCNe/NzB
         e4mg==
X-Forwarded-Encrypted: i=1; AJvYcCU/I/Uuor9/DPwjjhe/XoBsO7dN/53he1zrVzZSaZ+wpifMjGbIzSuxObmE9CoA0eAqmahPfkPi@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoUladY6N2/yc72Rj9Gui8iGN8WmLYeuwXrQxwl28l65vFHfZ
	uZS3x8a97v4zExU3EWfopiTVOFndcr/blDwfk7OL2xmO+YJNhmjdMZcdyHPJ6dXM9p9PkSAuKG5
	owr0uUS5viMQHWOXoGrN5bEzt9/MV8gPsGpn59MHGGG0FyVY0dlYRmmNx+sc=
X-Gm-Gg: ASbGnctgdHWYxS5Av2HnVNAB3sGJwBKaoSs0SdP7C5ECUjtX1Kn1761iAU8SLyFgm1X
	998ul1ZSr3ZFMuyqyH1hvkgEtaWO4xkMedk1n5YDDyt1oZ4vNZfnBE62cqZlCIARM2uOmz7LDg2
	EWa8+8NJXsqbWPnbyz7/j2B5Or4Ap8kvjyB5h/El1tXEG8xGm5jEQNm+Gj8WJu3LG1JWPB+hZsK
	KPZ/OshgUSz3wMdfpZW/Q6jbHFsg/5thW9TF6WT17FulwCtbSPEFYL5oTirBsbTtGCe4cVv3WBX
	R5rErX9oMmlYus55phfJHr2b9H1+TOFT754LLITCgFGeGy7L0K//GE5ldbSdy/G4UZe368HMvm0
	d1l7o
X-Received: by 2002:a05:6a00:b96:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-780fce18886mr13976049b3a.8.1759047458506;
        Sun, 28 Sep 2025 01:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAsKE8yi3uLFhUcvRGX/APzqLEpGvxhqj2BPZf85viZDUKXvLRpcMnYHwU1epI0StqWlMCRA==
X-Received: by 2002:a05:6a00:b96:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-780fce18886mr13976029b3a.8.1759047457930;
        Sun, 28 Sep 2025 01:17:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78262c184d5sm2099194b3a.95.2025.09.28.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 01:17:37 -0700 (PDT)
Date: Sun, 28 Sep 2025 16:17:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs/022: do sanity check on footer of non inode
 dnode
Message-ID: <20250928081733.5peprevpxqyejvgo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250901020331.2171502-1-chao@kernel.org>
 <20250901020331.2171502-2-chao@kernel.org>
 <20250926192254.djrwx55itz422yft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <802f7ad9-11e8-4b91-81b5-7579b7e8a255@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802f7ad9-11e8-4b91-81b5-7579b7e8a255@kernel.org>

On Sun, Sep 28, 2025 at 02:48:23PM +0800, Chao Yu wrote:
> On 9/27/2025 3:22 AM, Zorro Lang wrote:
> > On Mon, Sep 01, 2025 at 10:03:31AM +0800, Chao Yu wrote:
> > > This is a regression test:
> > > 1. create foo & bar
> > > 2. write 8M data to foo
> > > 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
> > > 4. fpunch in foo w/ specified range
> > > 
> > > If we haven't applied kernel patch ("f2fs: fix to do sanity check on
> > > node footer for non inode dnode"), f2fs may missed to do sanity check
> > > on corrupted dnode, result in panic in step 4).
> > > 
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   tests/f2fs/022     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/f2fs/022.out |  2 ++
> > >   2 files changed, 54 insertions(+)
> > >   create mode 100755 tests/f2fs/022
> > >   create mode 100644 tests/f2fs/022.out
> > > 
> > > diff --git a/tests/f2fs/022 b/tests/f2fs/022
> > > new file mode 100755
> > > index 00000000..a5e19a71
> > > --- /dev/null
> > > +++ b/tests/f2fs/022
> > > @@ -0,0 +1,52 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. f2fs/022
> > > +#
> > > +# This is a regression test:
> > > +# 1. create foo & bar
> > > +# 2. write 8M data to foo
> > > +# 3. use inject.f2fs to inject i_nid[0] of foo w/ ino of bar
> > > +# 4. fpunch in foo w/ specified range
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick rw
> > > +
> > > +. ./common/attr
> > > +
> > > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +	"f2fs: fix to do sanity check on node footer for non inode dnode"
> > > +
> > > +_require_scratch_nocheck
> > > +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> > > +_require_xfs_io_command "fpunch"
> > > +_require_kernel_config CONFIG_F2FS_CHECK_FS
> > 
> > Looks like the CONFIG_F2FS_CHECK_FS is a necessary condition to reproduce
> > that bug, right? I'm wondering is there a better way to check if CONFIG_F2FS_CHECK_FS
> > is enabled, likes reading someone file in /sys or what ever else? Checking kernel config
> 
> No, I don't see any sysfs entry for checing if CONFIG_F2FS_CHECK_FS is
> enabled.
> 
> I checked the testcase w/ image which has CONFIG_F2FS_CHECK_FS=off, the
> testcase falls into a deadloop inside kernel, so it's fine to get rid of
> the CONFIG_F2FS_CHECK_FS requirement? Thoughts?

Sure, let's remove the unnecessary requirement :) And ...

> 
> Thanks,
> 
> > isn't always a recommended way, except no better idea :)
> > 
> > > +
> > > +# remove all mkfs options to avoid layout change of on-disk inode
> > > +export MKFS_OPTIONS=""
> > > +
> > > +foo_path=$SCRATCH_MNT/foo
> > > +bar_path=$SCRATCH_MNT/bar
> > > +
> > > +_scratch_mkfs >> $seqres.full
> > > +_scratch_mount
> > > +
> > > +touch $foo_path
> > > +touch $bar_path
> > > +$XFS_IO_PROG $foo_path -c "pwrite 0 8M" >> $seqres.full
> > > +sync
> > > +foo_ino=`stat -c '%i' $foo_path`
> > > +bar_ino=`stat -c '%i' $bar_path`
> > > +_scratch_unmount
> > > +
> > > +# inject foo inode to replace i_nid[0] w/ to bar ino
> > > +$F2FS_INJECT_PROG --node --mb i_nid --nid $foo_ino --idx 0 --val $bar_ino $SCRATCH_DEV >> $seqres.full || _fail "failed to inject"
> > > +
> > > +_scratch_mount
> > > +# expect to trigger panic
> > > +$XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"

... if you might be better to change this comment a bit :)

If you'd like to resend this patchset, please change the patch 1/2 by the way.
then I can merge your next version directly :)

Thanks,
Zorro

> > > +_scratch_unmount
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
> > > new file mode 100644
> > > index 00000000..5307e3d7
> > > --- /dev/null
> > > +++ b/tests/f2fs/022.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 022
> > > +fallocate: Structure needs cleaning
> > > -- 
> > > 2.49.0
> > > 
> > 
> 

