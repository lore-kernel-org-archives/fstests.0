Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607090;
	b=dDyDGTikvBwucyLeESyCQjYZoecxcN/U8RAhQH7+JHmZHW9j0+FTV7lhNThWNpSL4Zvw
	 cn2Nw7uzZ63FHSnHFKF++OLS5iwFmqMyXt5vMQT8bpwM8eL7cZfKgHPBY7BXcX1HR9D1x
	 hchI16gZwkrh/OJBxMe9oW5mTO4EoJtUyp5U7WIZLeFiOEFOqhIFhJ4YUV53nhnuvTDnT
	 9XAFftSGcA5nix1YUlwda7iQ/X+Kg8yzqUm6gfe82notpzcJ3GaopmWtC/pL+hnp06hDt
	 bdIvYavYOpvF/YQuS+2ZrYpOyAhIwNvwQDKLwDB67X8ztogv802qLMF4b7irHc7aUJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607090;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=oJwfyoVHf9YNG4FECGzY8kV1vFo5eAsdiKf9iBmFtGY=;
	b=n5cDK18xnAqtbKnsxUkm7VbEtjWSxJwTNyLT7wakrSJw62HHYC4EHo8A8ZD24Y8d/j1U
	 NSVDJ4+VKKofgD/7mfQIWbbo/vPuKeJrDG22nwj4H2xgxD2vYAJ+Dxd6xpwSoCrbXDopg
	 kZDQh95fg6qG3rRu6lwaecPLmeyAmKXykL4sl5T50MkaO98jBe2Ashu4Q2G+6cIG2q+IF
	 wwWkpuvtYOPzkWA0wuI549uckF99eUu6Ud+36y53Nmk7Y5mkQ32IpxbXt55BLJQ4wDkbV
	 WudnJVjegtHAWrAVRxdCAh3aplwB3/5yc/KGxW9dAeXR4eFQTg0U6D7e/cpSQX9bRJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/u4i0Qv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FD606A324
	for <fstests@vger.kernel.org>; Mon,  2 Nov 2026 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/u4i0Qv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F741F000C1;
	Mon,  2 Nov 2026 08:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607090;
	bh=oJwfyoVHf9YNG4FECGzY8kV1vFo5eAsdiKf9iBmFtGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A/u4i0QvLvJ85Ga0CHL8j3vhSk5q9NbNvwHOC9DOTbJ+tJsWyL7XWM1CoWGpmG+fe
	 AuipxnYzvrZ72I18H3S7hWfg3sFI+ISOW0qu6xXwDjxPnNuu80LE1/Q61a9XZLvkUX
	 zaNam/1zneFccs0ehWvu0BcnB/7GQxoWEP+5h6Cbp/P5Y0SeJfNHIdYp/tECwhvjOU
	 VJVU0P5WMQ6KUhZ9dztqviJftVFO60DRfASnXiZ6arRps/DpQ8ZkEn0ox6hPgh6Bye
	 UeKdGNwuFUXVWU5vO3elhTiRfy8KsiO2bt7iz0j/wYSorixOt+5dtDNcS6OMQBQJ2F
	 d4fx0+KXqfI8A==
Date: Mon, 2 Nov 2026 16:11:25 +0800
From: Zorro Lang <zlang@kernel.org>
To: Long An <lan@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: ignore EBUSY for job5 on NFS
Message-ID: <auhEHmqDz7jxmnhZ@zlang-mailbox>
Mail-Followup-To: Long An <lan@suse.com>, fstests@vger.kernel.org
References: <20261012025707.16720-1-lan@suse.com>
 <CAHLNDm2=h5t42jpdyJRKUekot46ZF17TOOF5jxprz0hnwCmKaQ@mail.gmail.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHLNDm2=h5t42jpdyJRKUekot46ZF17TOOF5jxprz0hnwCmKaQ@mail.gmail.com>

On Tue, Oct 27, 2026 at 05:55:08PM +0800, Long An wrote:
> Hi Zorro, Just a gentle ping on this patch. Any feedback or comments
> would be greatly appreciated.

Sorry for the delayed reply on this patch. Looking at the patch description,
it seems there is no conclusive evidence yet as to what actually causes this
test failure. Before having xfstests simply ignore an error, we should have
a solid justification. It might be better to bring this up on the linux-nfs
mailing list first to confirm whether this is a known issue on the NFS side.

Thanks,
Zorro

> Thanks,
> An Long
> 
> 
> 
> On Mon, Oct 12, 2026 at 10:57 AM <lan@suse.com> wrote:
> >
> > From: An Long <lan@suse.com>
> >
> > On NFS, the buffered read in job5 occasionally fails with EBUSY:
> >
> >   fio: io_u error on file <dir>/file2: Device or resource busy: read ...
> >
> > This most likely happens because the client has to invalidate its page
> > cache before reading a file that other jobs may have modified, and that
> > cannot complete while those jobs keep mixing direct, buffered and mmap
> > writes on the same files.
> >
> > Make this error ignorable for job5 reads only, and only when testing
> > NFS, so that unexpected errors from other jobs or other filesystems are
> > still reported. Since ignore_error given on the fio command line applies
> > to all jobs, move it into the job file, where it can be overridden per
> > job. Behaviour for other filesystems and jobs is unchanged.
> >
> > Signed-off-by: An Long <lan@suse.com>
> > ---
> >  tests/generic/095 | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/generic/095 b/tests/generic/095
> > index 828274fd..53afb1de 100755
> > --- a/tests/generic/095
> > +++ b/tests/generic/095
> > @@ -25,12 +25,25 @@ numjobs=$((5 * LOAD_FACTOR))
> >  fio_config=$tmp.fio
> >  fio_out=$tmp.fio.out
> >  blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> > +
> > +# There's a known EIO failure to report collisions between directio and buffered
> > +# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> > +# at here.
> > +#
> > +# On NFS, the buffered read in job5 may fail with EBUSY, most likely because
> > +# the client has to invalidate its page cache before reading a stale file, as
> > +# the file may have been modified by other jobs doing writes, and that cannot
> > +# complete while those jobs are mixing direct, buffered and mmap I/O on the same
> > +# files. Ignore EBUSY on reads for job5 on NFS.
> > +job5_ignore_error=",EIO"
> > +[ "$FSTYP" = "nfs" ] && job5_ignore_error="EBUSY,EIO"
> >  cat >$fio_config <<EOF
> >  [global]
> >  bs=8k
> >  iodepth=$iodepth
> >  iodepth_batch=$iodepth_batch
> >  randrepeat=1
> > +ignore_error=,EIO
> >  size=1m
> >  directory=$SCRATCH_MNT
> >  numjobs=$numjobs
> > @@ -57,6 +70,7 @@ direct=1
> >  rw=randwrite
> >  filename=file1:file2
> >  [job5]
> > +ignore_error=$job5_ignore_error
> >  bs=1k
> >  ioengine=sync
> >  rw=randread
> > @@ -86,10 +100,7 @@ echo 'bs=$pagesize' >> $fio_config
> >
> >  _require_fio $fio_config
> >
> > -# There's a known EIO failure to report collisions between directio and buffered
> > -# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> > -# at here.
> > -$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out
> > +$FIO_PROG $fio_config --output=$fio_out
> >  cat $fio_out >> $seqres.full
> >  echo "Silence is golden"
> >
> > --
> > 2.51.0
> >
