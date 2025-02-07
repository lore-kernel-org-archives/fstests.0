Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726222619
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893697; cv=none; b=YiFvtFnvGDpyMpfmWLKSAxJ6SK+s5T2zOVguYbdUQU4oi/Sk9cJwo07MmGCa5d1aIdg/mF85BsgqR2MbOTnGL94S9ptla/xIGFC1s69UY6LBuhJPlCInKHZsEi+zgHJSbN3JufUMvQmuH3T9ZAWt1e1VBbkHbpy42jKteTu1as8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893697; c=relaxed/simple;
	bh=EcGdSzL/FTOvHi2+hX9Q5GfRCSV+8zHr+UzG4BGjRvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWCMi4TIV0vXmeijYyGb8RH4J+37esfT5Pu0E0igUp/HklTEfs12yvS7xmwmPVH0p02xH1uHoD+VtaTEQRpIbWBNi2sHb8DI/VIojCYdGvMhJGV/hyDlIqHvSGkXkfZlz1PVOInmghsJH1XmbTZOWr5oNG+GMOddUTJrIlGso2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjhiLPrg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjhiLPrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C188C4CEDD;
	Fri,  7 Feb 2025 02:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738893697;
	bh=EcGdSzL/FTOvHi2+hX9Q5GfRCSV+8zHr+UzG4BGjRvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjhiLPrgGyJUK7xa2eZm1MxQ6HNznBUJp5hOMpYoKQ6xHFBESsN7mTnc1STjztwwp
	 xcvcXWVRQDkIo8/wCpVV1ioiWbKDKzjo34ZMfEIbRvUTup3OHRtkxAK4nRMfOwIHK2
	 rT+nhh8qDT4LsoALvg7Io1nYAYO1sqkByKr8MpjMIkQwHSBMrB+boa2ztZTs2nBrLp
	 qvoRSp7O765oQmy3VtPLvrphyQmEjv83Rgm++3eqxyyL16ubEkKw2Hti36VkMnI0GZ
	 /EWE9SJfPQzYDBPTdNFP1LTLHdRuNDN1bKE5Q4Nn/8lL7o3iHfh52/Rs0RNPXnCcga
	 emrn9/xIQhWxw==
Date: Thu, 6 Feb 2025 18:01:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/7] builddefs: define linux
Message-ID: <20250207020136.GK21828@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-3-sandeen@redhat.com>
 <20250206223905.GO21799@frogsfrogsfrogs>
 <006e3012-c4e9-4672-a9bb-ccb726017b21@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006e3012-c4e9-4672-a9bb-ccb726017b21@sandeen.net>

On Thu, Feb 06, 2025 at 07:09:21PM -0600, Eric Sandeen wrote:
> On 2/6/25 4:39 PM, Darrick J. Wong wrote:
> > On Thu, Feb 06, 2025 at 03:19:57PM -0600, Eric Sandeen wrote:
> >> There are several #ifdef linux guards in the code, but nothing
> >> defined it. This caused several sparse warnings, so define it
> >> when building on linux.
> > 
> > cpp in gcc 12.2 defines this:
> > 
> > $ touch /tmp/moo.h ; cpp -dM /tmp/moo.h | grep define.linux
> > #define linux 1
> 
> Huh, on my test box too.
> And yet without this sparse coughs up lots of things for me:
> 
> tlibio.c:90:20: error: undefined identifier 'LIO_IO_TYPES'
> tlibio.c:90:33: error: undefined identifier 'LIO_WAIT_TYPES'
> tlibio.c:92:20: error: undefined identifier 'LIO_IO_TYPES'
> tlibio.c:92:33: error: undefined identifier 'LIO_WAIT_TYPES'
> tlibio.c:118:20: error: undefined identifier 'LIO_IO_TYPES'
> tlibio.c:118:33: error: undefined identifier 'LIO_WAIT_TYPES'
> 
> because i.e.:
> 
> #ifdef linux
> #define LIO_IO_TYPES            00021   /* all io types */
> #endif /* linux */
> 
> make V=1 shows:
> 
> /bin/sh ../libtool --quiet --tag=CC --mode=compile gcc -g -O2 -g -O2 -DDEBUG  -I../include -DVERSION=\"1.1.1\" -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -funsigned-char -fno-strict-aliasing -Wall   -c tlibio.c
> 
> so not sure what's going on here ?

sparse doesn't define linux by default:

$ cat > /tmp/a.c << ENDL
#ifdef linux
# warning not
#else
# warning me
#endif
ENDL
$ gcc -o /tmp/a.o /tmp/a.c
/tmp/a.c:2:3: warning: #warning not [-Wcpp]
    2 | # warning not
      |   ^~~~~~~
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/Scrt1.o: in function `_start':
(.text+0x17): undefined reference to `main'
collect2: error: ld returned 1 exit status
$ sparse /tmp/a.c
/tmp/a.c:4:3: warning: me
$ sparse /tmp/a.c -Dlinux
/tmp/a.c:2:3: warning: not

--D

> 
> > --D
> > 
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> >>  include/builddefs.in | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/builddefs.in b/include/builddefs.in
> >> index 7274cde8..00dec0ea 100644
> >> --- a/include/builddefs.in
> >> +++ b/include/builddefs.in
> >> @@ -78,7 +78,7 @@ HAVE_FICLONE = @have_ficlone@
> >>  GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> >>  
> >>  ifeq ($(PKG_PLATFORM),linux)
> >> -PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
> >> +PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -Dlinux $(GCCFLAGS)
> >>  endif
> >>  ifeq ($(PKG_PLATFORM),darwin)
> >>  PCFLAGS = -traditional-cpp $(GCCFLAGS)
> >> -- 
> >> 2.48.0
> >>
> >>
> > 
> 
