Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181113C465
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171194; cv=none; b=UMKgSaRiqAZjSVjqer6JFklYMeDn3sDkcBeZPplvB9OwN00ErQViJTVvCniZblEviQTy6cPgs4GDQWb7r4LWKJceUg8sWD9zwnkIjwd/0hRpre/ScCUlpA2zLO7b4w32D9WKXBvx8CnuAXbvyLm2yTSRrfS6qmf522YcF8Olh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171194; c=relaxed/simple;
	bh=q7Dvx4CG0RnexWO91J4oJDH6lHiISM1Me3lDpSwX4SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STxuoxxf3OpUfKzTeGWgKUJVZbgnhNxamA0SQRglyJFEUkBZJ2kER3QBXRLMjq4DWCVUAO6XtKi17qtMdKejuV8ajSeD8gOlVde7wHI5wvLdRh51BZUk/rTjD0kwkOcmnB3L2zaV7tCtb/9nmZDZ6Op5PRXdRFd/UzK37pQb91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2D0oT7i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2D0oT7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749171192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsFQl8sr8n30OqS4v5DdSHOD+ukUcT8jWVTD0i0oygk=;
	b=R2D0oT7i63Hnjt/JHaF8jXxYE/pKwyBNaWZGZjTYwICuQnokBSb5wD+bp7gn3Tc0SgFtJu
	JZ4rfM5QDzqmc69ajg4yPkgKutFFDztnZLTXlLbIqCYP6claiKLPIEDCSxtRAFf8pw0b8W
	P3F97/UYRMp7BebhzRZKlykd1zr6jd8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-EQaiqHa3NHq8sla_TuGOng-1; Thu, 05 Jun 2025 20:53:10 -0400
X-MC-Unique: EQaiqHa3NHq8sla_TuGOng-1
X-Mimecast-MFC-AGG-ID: EQaiqHa3NHq8sla_TuGOng_1749171190
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7480d44e6f9so1492609b3a.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 17:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171190; x=1749775990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsFQl8sr8n30OqS4v5DdSHOD+ukUcT8jWVTD0i0oygk=;
        b=bYIjlHsJsCh2SVmYJMIKYYlgfWWO3TLXgELL2F0/896tNFKcLbGut0kf55zfPFuozD
         lULcPlGH5l3w0gNcAfNvA1hHcWzV+qnKEnBFE41KQMG9IRqbMcTkSl1ocb+eFgZKwwxx
         BKm726PmuSpggdYsHl6zyEk9tW34jltugjEnHiX22yG74GbqPn/8aqiWPfj4Fj5Z3OFr
         WTT65vI+GtaZBaloQio+Np4BgUNETTvBU67SVfMCrfvQkZ5glXeoUW3JiCFvzxNf0gUR
         l0pg/jc3Fnh0p52muAwGPytEh6Eh7xixkImDmyjv6LFYi4OCMW98ydbj4rNX5K/8d0yH
         ISTw==
X-Forwarded-Encrypted: i=1; AJvYcCWSgIirMkiz9q84dByhB3R+o52n/+BDhK4RbYRsdmkFJk+w5ygIWxskx6n4DPwUFYslylwEgQll@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJByj7WxXoc2T0rznt7oHFr4u+m+BB3Dk9Ey3bZ2iWPLy1aOk
	NOESho1N+7J2cVGiiJpawL+YCLMbE1t44V75LzN56PVVejHb9BEwhhbSjIQFu9C7P8OZirrSHtI
	uU0K9fvZNJTla9kHpjyY6GlFFHgls36nsjhZ5g0J6EwmTSc/kTFVdMlZR4Bs=
X-Gm-Gg: ASbGnctjTmnzg29ygQsgFZdy6vTPaGLKxPtdo4d5mKGr4yJd6hNqZZa2WPfFmAiGT3+
	0vBs0LRzQXJGWoxSCElKUpORRvvBh1GNKVwVCmkFS8Yicc/4MyOuYWePA82/nwDrTau6jNLQ31P
	6IEyUqfi2IhNj/Q6JEhc/0KhXQe53JG6hCLgyEE8SSmAtONH3hnUZSv5cARYACaRZ160tMKaBPA
	VYq1yYf9DB8o2+AufMRYHej9eC0yMoUI+rTPmN74vhQHMclWEz0DC5dPWpht6nqctBIZ3KWcUBy
	RqW1AYndixgaxa0rsclpPqnV8bf2Ls/M71ZkIWprmbm2UI9esyBDKyRoi+NGPTw=
X-Received: by 2002:a05:6a00:806:b0:737:9b:582a with SMTP id d2e1a72fcca58-74827f3dab7mr2316532b3a.24.1749171189606;
        Thu, 05 Jun 2025 17:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhuxf44JkfMsS77q5YopkK2jKVaIaGt4qLF9JgjzWMXCZwCKbi9NDscO6soj+5oZzAbA+TlQ==
X-Received: by 2002:a05:6a00:806:b0:737:9b:582a with SMTP id d2e1a72fcca58-74827f3dab7mr2316513b3a.24.1749171189202;
        Thu, 05 Jun 2025 17:53:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38386sm263376b3a.6.2025.06.05.17.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 17:53:08 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:53:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/032: fix failure due to attempt to wait for
 non-child process
Message-ID: <20250606005304.p36cjy23ekdlg53u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>
 <20250605165225.fajg7aj3btuejhnp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6h98w--8=-TUridEaOt03v70J3gvLA_g=72iL9hFYL1w@mail.gmail.com>

On Thu, Jun 05, 2025 at 08:37:35PM +0100, Filipe Manana wrote:
> On Thu, Jun 5, 2025 at 5:52 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, May 28, 2025 at 12:42:20PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Running generic/032 can sporadically fail like this:
> > >
> > >   generic/032 11s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad)
> > >       --- tests/generic/032.out   2023-03-02 21:47:53.884609618 +0000
> > >       +++ /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad    2025-05-28 10:39:34.549499493 +0100
> > >       @@ -1,5 +1,6 @@
> > >        QA output created by 032
> > >        100 iterations
> > >       +/home/fdmanana/git/hub/xfstests/tests/generic/032: line 90: wait: pid 3708239 is not a child of this shell
> > >        000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > >        *
> > >        100000
> > >       ...
> > >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/032.out /home/fdmanana/git/h
> > >
> > > This is because we are attempting to wait for a process that is not a
> > > child process of the test process and it's instead a child of a process
> > > spawned by the test.
> > >
> > > To make sure that after we kill the process running _syncloop() there
> > > isn't any xfs_io process still running syncfs, add instead a trap to
> > > to _syncloop() that waits for xfs_io to finish before the process running
> > > that function exits.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> >
> > Oh... I didn't remove the _pgrep when I reverted those "setsid" things.
> >
> > CC Darrick, what do you think if I remove the _pgrep from common/rc
> > and generic/032 :) On the other words, revert the:
> >
> >   commit 1bb15a27573eea1df493d4b7223ada2e6c04a07a
> >   Author: Darrick J. Wong <djwong@kernel.org>
> >   Date:   Mon Feb 3 14:00:29 2025 -0800
> >
> >       generic/032: fix pinned mount failure
> 
> Reverting that commit won't fix anything. One still needs a mechanism
> to ensure that we don't attempt to unmount the scratch device while
> xfs_io from sync_pid is still running. The mechanism implemented in
> that commit is buggy and the trap based one from this patch should
> always work (and we do this trap based approach on several other tests
> to solve this same problem).

Sure, don't worry, I didn't try to Nack your patch:) Just due to you remove
the _pgrep() in your patch, then I thought it can be removed from common/rc
totally, looks like nothing need that function. So I tried to confirm that
with Darrick (who brought in this function:)

Due to commit 1bb15a27573 does two things:
1) create a new function _pgrep
2) call _pgrep in g/032

You've removed the 2) in this patch, so I'm wondering how about removing
the 1) and 2) totally. As you can see, g/032 is the only one place uses
_pgrep:

$ grep -rsn _pgrep .
./common/rc:40:_pgrep()
./tests/generic/032:87:dead_syncfs_pid=$(_pgrep xfs_io)

Thanks,
Zorro


> 
> Thanks.
> 
> 
> >
> > Thanks,
> > Zorro
> >
> > >  tests/generic/032 | 13 ++++---------
> > >  1 file changed, 4 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tests/generic/032 b/tests/generic/032
> > > index 48d594fe..b04b84de 100755
> > > --- a/tests/generic/032
> > > +++ b/tests/generic/032
> > > @@ -28,6 +28,10 @@ _cleanup()
> > >
> > >  _syncloop()
> > >  {
> > > +     # Wait for any running xfs_io command running syncfs before we exit so
> > > +     # that unmount will not fail due to the mount being pinned by xfs_io.
> > > +     trap "wait; exit" SIGTERM
> > > +
> > >       while [ true ]; do
> > >               _scratch_sync
> > >       done
> > > @@ -81,15 +85,6 @@ echo $iters iterations
> > >  kill $syncpid
> > >  wait
> > >
> > > -# The xfs_io instance started by _scratch_sync could be stuck in D state when
> > > -# the subshell running _syncloop & is killed.  That xfs_io process pins the
> > > -# mount so we must kill it and wait for it to die before cycling the mount.
> > > -dead_syncfs_pid=$(_pgrep xfs_io)
> > > -if [ -n "$dead_syncfs_pid" ]; then
> > > -     _pkill xfs_io
> > > -     wait $dead_syncfs_pid
> > > -fi
> > > -
> > >  # clear page cache and dump the file
> > >  _scratch_cycle_mount
> > >  _hexdump $SCRATCH_MNT/file
> > > --
> > > 2.47.2
> > >
> > >
> >
> 

