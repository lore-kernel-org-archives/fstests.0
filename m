Received: from imap.thunk.org ([74.207.234.97]:45027 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbbIJXqA (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 10 Sep 2015 19:46:00 -0400
Date: Thu, 10 Sep 2015 19:45:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: xfstests enospc tests not filling up file systems with
 transparent compression
Message-ID: <20150910234558.GC31723@thunk.org>
References: <CADW=+3mX-aBuxFnTcshSOR4-q-uY4OucpbFmeoy0xzW49s6csQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADW=+3mX-aBuxFnTcshSOR4-q-uY4OucpbFmeoy0xzW49s6csQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?B?RHXFoWFuIMSMb2xpxIc=?= <dusanc@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 10, 2015 at 10:09:16PM +0200, Du=C5=A1an =C4=8Coli=C4=87 wrot=
e:
>=20
> There are various xfstests that try to fill up whole partition but
> they give false positives on file systems with transparent compression
> because they use compressible test files like input from /dev/zero.
> Different tests use different ways to generate test file(s) so what
> would be the preferred way to generate incompressible test files? Use
> /dev/urandom instead /dev/zero?

I would expect that most tests would use fallocate to allocate space
for ENOSPC tests, since it's much faster than writing all zeros.

If a file system with tansparent compression is treating space
allocated with fallocate as "all zeros" and hence infinitely
compressible, I'd argue that it's buggy, since one of the documented
uses of fallocate is to force the file system to allocate space so
that future writes are guaranteed to succeed, so that the application
doesn't have to deal with ENOSPC errors at some inconvenient time.
(For example, in the case of a DVR, you want to know that you've
allocated enough space for that all-so-critical recording of the
season finale of "The Big Bang Theory", or that episode of "Sex and
the City" which you had missed.  :-)

Cheers,

					- Ted
