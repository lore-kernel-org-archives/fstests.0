Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9019CC2A
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977548; cv=none; b=mua5FyOKaLpLJ9pTAuUjQZkKL29Rr9H6Q2msA7L89j+7LB4P7iNkiy3wI+ZJSFZZJfjrdBZoVi332UTL0AxIJQLsnSOlsn9i5ORcpdkBaw5WUMlVX0VMR/t+be2hqW5VHC8wdfjGcJwVqEKQFd1PI91YEJmj65lXgDO/N5BJGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977548; c=relaxed/simple;
	bh=4HOMjYPP2WmM0zp/bZGGKbunyitaqkj32HsKnCAbhGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUzHll2LK9+BGMgrE0i3l39ttypPIUyzlJ+BDnffkoik/9XUJkVzdv8mCqCNKFXOkeHYIaKkEAui7Ro/k+pzdcMpIGNWDvBnpIzuyRYIxhLKM/9joRTRIXTezq5n/0+h0ZgpdacRyNIC+OjOUOeD8NM8/FCWa6Yfu0SjmHQQIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc+81Jny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc+81Jny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0279C4CED1;
	Wed, 15 Jan 2025 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736977547;
	bh=4HOMjYPP2WmM0zp/bZGGKbunyitaqkj32HsKnCAbhGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qc+81JnyBzngtS0QD8ew3RQrBNytPybqSyx3OiG7eKWn4o747z4NXqz9WoF84vsqS
	 O1fm3gfwEHz31SXVltEb01cKsbWFIZt1W4QVqi0yk713dQYgXZod2zLg8yksBZxuGX
	 VBbw4w3w4wqAz5mCV7ygYMexAPhvrYbFPtm07DLM1yODUNayqg9o6BWMsVCulIKps1
	 Yr+8XbyE4ONfQJWEM0ko4J2SeXRAYaVmDf2QnUWbWGjP/tUhwZ00VAxR7jJxfFsAEh
	 oeTu5GoujWdi75um80ccmwaIYBbTT4FhMaLCqhclwpkmue0dGji7f5A4720/5BFxqi
	 roS8pD86k+LCg==
Date: Wed, 15 Jan 2025 13:45:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] include/builddefs.in: ignore unused-result warning
Message-ID: <20250115214547.GG3557695@frogsfrogsfrogs>
References: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
 <20250115153327.izjczrhtpd2yjfjc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115153327.izjczrhtpd2yjfjc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Wed, Jan 15, 2025 at 11:33:27PM +0800, Zorro Lang wrote:
> On Mon, Jan 06, 2025 at 05:59:06PM +0800, Shiyang Ruan wrote:
> > When build xfstests, a lot of "unused result" warning are reported:
> > 
> >     [CC] write_log.lo
> > write_log.c: In function 'wlog_record_write':
> > write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
> >   205 |             write(wfile->w_afd, wbuf, reclen);
> >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
> >   209 |             write(wfile->w_rfd, wbuf, reclen);
> >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     [CC] random.lo
> 
> Hi,
> 
> I never hit this build warning:
> 
> # make
> ...
> Building lib
>     [LTDEP]
>     [CC] write_log.lo
>     [LD]
> Building ltp
>     [CC]    doio
>     [CC]    fsstress
> ...
> 
> Besides that ...
> 
> > 
> > Mostly are calused by not using the return value of read()/write()/...
> > Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
> > won't cause other problem but make the log clean.
> > 
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  include/builddefs.in | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/builddefs.in b/include/builddefs.in
> > index 7274cde8d..edf87ff00 100644
> > --- a/include/builddefs.in
> > +++ b/include/builddefs.in
> > @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
> >  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
> >  HAVE_FICLONE = @have_ficlone@
> >  
> > -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> > +GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result
> 
> I'm not an expert of gcc. From the manual of gcc, it says:
> 
>        -Wno-unused-result
>            Do not warn if a caller of a function marked with attribute "warn_unused_result" does not use its return value. The default is -Wunused-result.
> 
> Looks like the "-Wno-unused-result" works for "a function marked with
> attribute warn_unused_result", e.g.
> 
>     int __attribute__((warn_unused_result)) foo(void)
> 
> I think fstests doesn't use that attribute.

No, but unistd.h does for write():

extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur
    __attr_access ((__read_only__, 2, 3));

where "__wur" is a macro wrapping __attribute__
((__warn_unused_result__)) if available and FORTIFY_SOURCE is nonzero.

But, uh, shouldn't we fix these programs either to fail the test because
some part of its execution failed, or declare that the return value is
irrelevant if that's the case?

--D

> Thanks,
> Zorro
> 
> 
> >  
> >  ifeq ($(PKG_PLATFORM),linux)
> >  PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
> > -- 
> > 2.43.0
> > 
> > 
> 
> 
