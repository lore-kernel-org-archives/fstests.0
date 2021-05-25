Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEE9C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E796061420
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhEYQ0p (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEYQ0o (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:26:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0299C6141C;
        Tue, 25 May 2021 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621959915;
        bh=755aBwXZgOSFswSx4VChcNIw6VQ9AY+Li6SRFAQ5Fo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpgVLBhscqQKv2NkJ8vnkYYtOKsOGjPzjlHcRx2avR9nrDkO+zDfowyPEYFacrfj1
         Q7BjXsubtSxTzbs/rxJriaCCRdZIoY9AxpdbxyhVB9kWpqMFokym1gIJfqGH8/zKWd
         reuzo7wNMK2enDTN71E2bmaxSzgG2KSla9/LXRCrkXdS0mCxtu6op0JKd+kA6mEG7V
         cNSWJygK34XROpADM7f5ooQCQQ3M2N0XXV7QtWjYDlcf2FWVDnWVMo7v7zHMVn7kpo
         CKWosUhxDHRkNrmvj28LnolSFvnZpGYZFJ34UM8xcE0Ks8TunybjreJIm1BqtaHnTP
         VmgUTIxJijFig==
Date:   Tue, 25 May 2021 09:25:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 8/9] generic/465: Fix handling of DIO alignment <
 sizeof(long)
Message-ID: <20210525162514.GH202095@locust>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194968267.4011860.3593730881184557924.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162194968267.4011860.3593730881184557924.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 02:34:42PM +0100, David Howells wrote:
> generic/465 will fail if the minimun DIO alignment is less than the minimum
> size permitted by the posix_memalign() syscall calls made in
> aio-dio-append-write-read-race.  AFS has a DIO alignment of 1.
> 
> Fix this by setting the minimum alignment to sizeof(long).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

I wonder if you ought to just change the posix_memalign call to match
(somewhat more closely) what the other directio testers do:

	ret = posix_memalign((void **)&wbuf, sysconf(_SC_PAGESIZE), blksize);

Since the alignment of the memory buffer doesn't necessarily have
anything to do with the alignment of the read/write offset.

(Longer term it would be /really/ nice to hoist DIOINFO to all the
filesystems, and refactor fstests to use it consistently, but that's way
too big of a request for this patchset.)

--D

> ---
> 
>  .../aio-dio-append-write-read-race.c               |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> index 911f2723..8268fb4e 100644
> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> @@ -110,7 +110,7 @@ int main(int argc, char *argv[])
>  	int i, j, c;
>  	int use_aio = 1;
>  	int ret = 0;
> -	int io_align = 4096;
> +	int io_align = 4096, mem_align;
>  	char *prog;
>  	char *testfile;
>  
> @@ -146,14 +146,15 @@ int main(int argc, char *argv[])
>  		goto err;
>  	}
>  
> -	ret = posix_memalign((void **)&wbuf, io_align, blksize);
> +	mem_align = (io_align >= sizeof(long) ? io_align : sizeof(long));
> +	ret = posix_memalign((void **)&wbuf, mem_align, blksize);
>  	if (ret) {
>  		fail("failed to alloc memory: %s\n", strerror(ret));
>  		ret = 1;
>  		goto err;
>  	}
>  
> -	ret = posix_memalign((void **)&rbuf, io_align, blksize);
> +	ret = posix_memalign((void **)&rbuf, mem_align, blksize);
>  	if (ret) {
>  		fail("failed to alloc memory: %s\n", strerror(ret));
>  		ret = 1;
> 
> 
