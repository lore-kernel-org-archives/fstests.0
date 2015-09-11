Received: from sandeen.net ([63.231.237.45]:54423 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbbIKAOD (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 10 Sep 2015 20:14:03 -0400
Subject: Re: xfstests enospc tests not filling up file systems with
 transparent compression
References: <CADW=+3mX-aBuxFnTcshSOR4-q-uY4OucpbFmeoy0xzW49s6csQ@mail.gmail.com>
 <20150910234558.GC31723@thunk.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <55F21CC9.6050903@sandeen.net>
Date: Thu, 10 Sep 2015 19:14:01 -0500
MIME-Version: 1.0
In-Reply-To: <20150910234558.GC31723@thunk.org>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Theodore Ts'o <tytso@mit.edu>, =?UTF-8?B?RHXFoWFuIMSMb2xpxIc=?= <dusanc@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 9/10/15 6:45 PM, Theodore Ts'o wrote:
> On Thu, Sep 10, 2015 at 10:09:16PM +0200, Du=C5=A1an =C4=8Coli=C4=87 wr=
ote:
>>
>> There are various xfstests that try to fill up whole partition but
>> they give false positives on file systems with transparent compression
>> because they use compressible test files like input from /dev/zero.
>> Different tests use different ways to generate test file(s) so what
>> would be the preferred way to generate incompressible test files? Use
>> /dev/urandom instead /dev/zero?
>=20
> I would expect that most tests would use fallocate to allocate space
> for ENOSPC tests, since it's much faster than writing all zeros.

Several of those tests are generic ones, designed to work on filesystems
like ext3 which don't support fallocate...

-Eric
