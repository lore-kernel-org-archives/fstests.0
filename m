Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9715D5CA
	for <fstests@vger.kernel.org>; Mon, 27 May 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810169; cv=none; b=oAGjoU47DDvYpi/VSvMTPko99Mmi7N7WM/ZGDy3FSeCx6EprXvBDNe5jETGPMa++A96ntw3NmyNyAtF0nxNJv/pvg3i+ldcdVJQFFNIOLh3gDR+msa/FSW4dEEE3ie6RRcuvfMQySSxTqmhsa4tDKjjVewOCMzDQ8HR+fR+r7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810169; c=relaxed/simple;
	bh=SPW0JHui8mjVFlpEjAEkwUHDs5a0BjGfnprADNpsrnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8amzfGZVxdR2jL+INWIQKtbdflb9kvFGKgnoKspXB4CE4FfQK+NJnLjtKvTR6M4yVsnnmd0dYlox1o7x/pfD1Rd7dhQ4u7JTWj7nBR2TNQDh3BEoEixprWU/AVwlQSlH158RTCQA3U7hlKTflynYJXGtXXZFtXFpf+50muL8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=1zVrnlCW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="1zVrnlCW"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Vntzx2SCxz9sHY;
	Mon, 27 May 2024 13:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716810157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N9/zIjKeW3q2yLRFedM8xKLfN5zg7xy/tQSB3Mk+QEA=;
	b=1zVrnlCWsYYj3Z2cc3BBUeRLFdqoe4JQ/dCXz4ACj8QqZX1TMS9p6jDXsYStFjgzYpzX9H
	sKCxhd9Wm3uyes7VShmozkQK8jKQ8wbfESinVNHbInnBg6UPhMcPs5un25xi843piQhPOR
	7i5lNpblg08q2ymRf3OLQWsRLlOr3LwlFJhlIk6UnqC7hZxzuXKDfwjO/9xrM32VnP1U/u
	Om7Ir/cfT4jOV8PyLagdxGNVN6ycu04rk9YGF9SwxMwCSVYuwxQfmPWgQUeBaGsljLJ4SE
	qymDzL7VpClAHmh+aXu75Ca4lpiFQf/orbh0jHdgXMWbvhQgLzw7K6DuqMBbRg==
Date: Mon, 27 May 2024 11:42:32 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	djwong@kernel.org, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/3] xfs/008: use block size instead of the pagesize
Message-ID: <20240527114232.fwvk3knm2np5vgfe@quentin>
References: <20240513131254.92412-1-kernel@pankajraghav.com>
 <20240513131254.92412-4-kernel@pankajraghav.com>
 <87v835rw7e.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v835rw7e.fsf@gmail.com>

On Thu, May 23, 2024 at 09:55:25AM +0530, Ritesh Harjani wrote:
> "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:
> 
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >
> > The testcase estimates to have ratio of 1:3/4 for holes:filesize. This
> > holds true where the blocksize is always less than or equal to pagesize
> > and the total size of the file is calculated based on the pagesize.
> > There is an implicit assumption that blocksize will always be less than
> > the pagesize.
> >
> > LBS support will enable bs > ps where a minimum IO size is one block,
> > which can be greater than a page. Adjust the size calculation to be
> > based on the blocksize and not the pagesize.
> >
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/008     | 19 ++++++++++---------
> >  tests/xfs/008.out |  8 ++++----
> >  2 files changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/tests/xfs/008 b/tests/xfs/008
> > index e7d6153b..e37e435a 100755
> > --- a/tests/xfs/008
> > +++ b/tests/xfs/008
> > @@ -11,7 +11,8 @@ _begin_fstest rw ioctl auto quick
> >  
> >  status=0	# success is the default!
> >  pgsize=`$here/src/feature -s`
> > -
> > +fileblksize=$(_get_file_block_size "$TEST_DIR")
> > +blksize=$((fileblksize > pgsize ? fileblksize : pgsize))
> 
> I assume when the test might be written it might have assumed blocksize =
> pagesize. Hence the dependency on pagesize in this test. 
> If that assumption is correct, then we might not need these two paths
> and can just make it blocksize.
> 
> Do you see any problem with blocksize for any of the paths
> (bs = ps, bs < ps and bs > ps)?
Thanks for the comments Ritesh. You are right about not needing to
fallback to pgsize.

I made your suggested changes and I will send a new version soon.
> 
> 
> >  # Override the default cleanup function.
> >  _cleanup()
> >  {
> > @@ -21,7 +22,7 @@ _cleanup()
> >  
> >  _filter()
> >  {
> > -    sed -e "s/-b $pgsize/-b PGSIZE/g" \
> > +    sed -e "s/-b $blksize/-b BLKSIZE/g" \
> >  	-e "s/-l .* -c/-l FSIZE -c/g"
> >  }
> >  
> > @@ -73,17 +74,17 @@ _require_test
> >  # We are trying to create roughly 50 or 100 holes in a file
> >  # using random writes. Assuming a good distribution of 50 writes
> >  # in a file, the file only needs to be 3-4x the size of the write
> > -# size muliplied by the number of writes. Hence we use 200 * pgsize
> > -# for files we want 50 holes in and 400 * pgsize for files we want
> > +# size muliplied by the number of writes. Hence we use 200 * blksize
> > +# for files we want 50 holes in and 400 * blksize for files we want
> >  # 100 holes in. This keeps the runtime down as low as possible.
> >  #
> > -_do_test 1 50 "-l `expr 200 \* $pgsize` -c 50 -b $pgsize"
> > -_do_test 2 100 "-l `expr 400 \* $pgsize` -c 100 -b $pgsize"
> > -_do_test 3 100 "-l `expr 400 \* $pgsize` -c 100 -b 512"   # test partial pages
> > +_do_test 1 50 "-l `expr 200 \* $blksize` -c 50 -b $blksize"
> > +_do_test 2 100 "-l `expr 400 \* $blksize` -c 100 -b $blksize"
> > +_do_test 3 100 "-l `expr 400 \* $blksize` -c 100 -b 512"   # test partial blocks
> >  
> >  # rinse, lather, repeat for direct IO
> > -_do_test 4 50 "-d -l `expr 200 \* $pgsize` -c 50 -b $pgsize"
> > -_do_test 5 100 "-d -l `expr 400 \* $pgsize` -c 100 -b $pgsize"
> > +_do_test 4 50 "-d -l `expr 200 \* $blksize` -c 50 -b $blksize"
> > +_do_test 5 100 "-d -l `expr 400 \* $blksize` -c 100 -b $blksize"
> >  # note: direct IO requires page aligned IO
> 
> ^^^ This last comment about direct-io alignment is not valid anymore since kernel
> 2.6. Maybe it's time to rip that comment off.
> 
> From man 2 open
> O_DIRECT
> <...>
>        If  none  of  the  above is available, then direct I/O support and alignment restrictions can only be assumed from known characteristics of the filesystem, the individual file, the underlying storage device(s), and the kernel
>        version.  In Linux 2.4, most filesystems based on block devices require that the file offset and the length and memory address of all I/O segments be multiples of the filesystem block size (typically 4096  bytes).   In  Linux
>        2.6.0, this was relaxed to the logical block size of the block device (typically 512 bytes).  A block device's logical block size can be determined using the ioctl(2) BLKSSZGET operation or from the shell using the command:
> 
> -ritesh
> 
> >  
> >  # todo: realtime.
> > diff --git a/tests/xfs/008.out b/tests/xfs/008.out
> > index 5e3ae8e3..0941e218 100644
> > --- a/tests/xfs/008.out
> > +++ b/tests/xfs/008.out
> > @@ -1,10 +1,10 @@
> >  QA output created by 008
> >  
> > -randholes.1 : -l FSIZE -c 50 -b PGSIZE
> > +randholes.1 : -l FSIZE -c 50 -b BLKSIZE
> >  ------------------------------------------
> >  holes is in range
> >  
> > -randholes.2 : -l FSIZE -c 100 -b PGSIZE
> > +randholes.2 : -l FSIZE -c 100 -b BLKSIZE
> >  ------------------------------------------
> >  holes is in range
> >  
> > @@ -12,10 +12,10 @@ randholes.3 : -l FSIZE -c 100 -b 512
> >  ------------------------------------------
> >  holes is in range
> >  
> > -randholes.4 : -d -l FSIZE -c 50 -b PGSIZE
> > +randholes.4 : -d -l FSIZE -c 50 -b BLKSIZE
> >  ------------------------------------------
> >  holes is in range
> >  
> > -randholes.5 : -d -l FSIZE -c 100 -b PGSIZE
> > +randholes.5 : -d -l FSIZE -c 100 -b BLKSIZE
> >  ------------------------------------------
> >  holes is in range
> > -- 
> > 2.34.1

-- 
Pankaj Raghav
