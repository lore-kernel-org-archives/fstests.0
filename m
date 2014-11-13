Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:39545 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554AbaKMERg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 12 Nov 2014 23:17:36 -0500
Message-ID: <546430DE.60205@sandeen.net>
Date: Wed, 12 Nov 2014 22:17:34 -0600
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: xfstest status on current kernels
References: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com> <20141113032626.GA28565@dastard> <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
In-Reply-To: <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 11/12/14 9:38 PM, Steve French wrote:
> On Wed, Nov 12, 2014 at 9:26 PM, Dave Chinner <david@fromorbit.com> wrote:
>> On Wed, Nov 12, 2014 at 05:31:20PM -0600, Steve French wrote:
> 
>>> I want to make sure that I don't accidentally ignore a test (e.g. test
>>> generic/003 doesn't run with a message " [not run] relatime not
>>> supported by the current kernel" and want to make sure I am not
>>> missing something).
>>
>> You need to such things yourself and determine if the test should
>> have run for your given test configuration.

out of curiosity, what fs/kernel fails a "-o relatime" mount?

> I have been going through these one at a time as I have time (to
> see if they are workable on cifs/smb3 etc) - but it can get
> tricky (e.g. in this case relatime may be default behavior for fs so
> lack of a mount option with this exact name may be unnecessarily
> disabling this one on some fs)
> 
>> or test tools weren't built due to missing libraries:
>>
>> generic/010      [not run] dbtest was not built for this platform

dbtest used to be fiddly to build, but it builds here.

#ifdef HAVE_GDBM_NDBM_H_
#include <gdbm/ndbm.h>
#elif HAVE_GDBM_NDBM_H
#include <gdbm-ndbm.h>
#elif HAVE_GDBM_H
#include <gdbm.h>
#elif HAVE_NDBM_H
#include <ndbm.h>
#else
bozo!
#endif

yeah ....

well, we should at least list devel package dependencies for the entire
suite, I think, so as many people as possible can get everything going
as painlessly as possible.


our qe has this in a specfile:

BuildRequires:	autoconf, libtool, e2fsprogs-devel, xfsprogs-devel
BuildRequires:	libacl-devel, libattr-devel, libaio-devel

but that won't build dbtest!

> This is a good example, and one run that I had run into a month or
> two ago (at first I had assumed at first
> that it was not runnable on Linux, and then eventually
> figured out the build dependencies for it to work on Ubuntu and Fedora)

Since you had the ... privilege of getting it built from scratch, if you
wanted to submit a patch to the docs to clearly describe dependencies, that'd
be great.  :)

> Not always clear to me which of these tests are never going to work on Linux.

unless it says:

xfs/114	 [not run] not suitable for this OS: Linux

it should run on Linux.

There are only a few:

# grep _supported_os tests/*/??? | grep -vi linux
tests/generic/093:_supported_os IRIX
tests/generic/097:_supported_os IRIX
tests/generic/099:_supported_os IRIX
tests/udf/098:_supported_os IRIX
tests/udf/101:_supported_os IRIX
tests/xfs/057:_supported_os IRIX
tests/xfs/058:_supported_os IRIX
tests/xfs/095:_supported_os IRIX
tests/xfs/114:_supported_os IRIX
tests/xfs/115:_supported_os IRIX

-Eric

