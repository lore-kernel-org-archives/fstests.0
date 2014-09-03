Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:55497 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752112AbaICLmT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Sep 2014 07:42:19 -0400
Date: Wed, 3 Sep 2014 21:42:16 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 0/3] CIFS support for XFS test suite
Message-ID: <20140903114216.GP20518@dastard>
References: <1409341340-27031-1-git-send-email-pshilovsky@samba.org>
 <CAKywueRns+hehrZ3dQ8a8XnaHbd6tNh1BnZAwsTxNTV_w6V6SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKywueRns+hehrZ3dQ8a8XnaHbd6tNh1BnZAwsTxNTV_w6V6SQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Pavel Shilovsky <pshilovsky@samba.org>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-cifs <linux-cifs@vger.kernel.org>, "samba-technical@samba.org" <samba-technical@samba.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 03, 2014 at 10:23:47AM +0400, Pavel Shilovsky wrote:
> 2014-08-29 23:42 GMT+04:00 Pavel Shilovsky <pshilovsky@samba.org>:
> > These are patches that adds CIFS support to XFS tests.
> >
> > The first patch changes generic/013 test to use mount options provided for $TEST_DEV for remount. The second patch adds "-cifs" command line argument and CIFS specific variables. The third patch disables tests that need POSIX behavior from filesystem for unix cifs mounts.
> >
> > With these patches applied, most of generic/shared $TEST_DEV tests pass for the recent kernel cifs module.
> >
> > Changes since v2:
> > 1) patch #3 uses separate _require_test_{feature} functions rather than generic _require_test_posix_ext
> > 2) patch #2 adds UDF notes to README
> >
> > Pavel Shilovsky (3):
> >   generic/013: encapsulate remount during cleanup
> >   common: add cifs support
> >   cifs: skip tests that need POSIX support for nounix mounts
> >
> >  README            |  5 +++--
> >  check             |  2 ++
> >  common/config     | 31 +++++++++++++++++++++++++++----
> >  common/rc         | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/005 |  8 ++------
> >  tests/generic/013 |  2 +-
> >  tests/generic/023 |  1 +
> >  tests/generic/024 |  1 +
> >  tests/generic/025 |  1 +
> >  tests/generic/131 |  1 +
> >  10 files changed, 94 insertions(+), 13 deletions(-)
> >
> > --
> > 1.9.1
> >
> 
> Any comments on the series?

Patience. It will be friday before I get to it....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
