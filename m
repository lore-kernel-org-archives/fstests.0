Received: from mail-pg0-f41.google.com ([74.125.83.41]:35485 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755431AbdBQGsq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2017 01:48:46 -0500
Received: by mail-pg0-f41.google.com with SMTP id t188so13127039pgt.2
        for <fstests@vger.kernel.org>; Thu, 16 Feb 2017 22:48:46 -0800 (PST)
Date: Thu, 16 Feb 2017 22:48:08 -0800
From: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 2/2] btrfs: test decompression in the middle of large
 extents
Message-ID: <20170217064808.GA13656@vader>
References: <7e55bbd20c8e6515e0b76b1ee4c348fb6066c502.1487298611.git.osandov@fb.com>
 <300ecd5f733d77c68969818db0a4e4f53d951adc.1487298611.git.osandov@fb.com>
 <20170217055849.GB24562@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217055849.GB24562@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 17, 2017 at 01:58:49PM +0800, Eryu Guan wrote:
> On Thu, Feb 16, 2017 at 06:32:49PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This is a regression test for "Btrfs: fix btrfs_decompress_buf2page()".
> > It fails for zlib on v4.10-rc[1-7].
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> > This runs in <60 seconds on my test VM, which I think qualifies for the
> > quick group?
> 
> quick test usually takes <30s, so probably it's not quick enough :)
> (it takes ~80s on my test vm, which has 4vcpus and 8G memory)

Ok, I'll remove it from the quick group :)

> > 
> >  common/btrfs        |  8 +++++
> >  tests/btrfs/137     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/137.out |  2 ++
> >  tests/btrfs/group   |  1 +
> >  4 files changed, 107 insertions(+)
> >  create mode 100755 tests/btrfs/137
> >  create mode 100644 tests/btrfs/137.out
> > 
> > diff --git a/common/btrfs b/common/btrfs
> > index 96c3635b..015ce4d2 100644
> > --- a/common/btrfs
> > +++ b/common/btrfs
> > @@ -364,3 +364,11 @@ _reload_btrfs_ko()
> >  	modprobe -r btrfs || _fail "btrfs unload failed"
> >  	modprobe btrfs || _fail "btrfs load failed"
> >  }
> > +
> > +_btrfs_compression_algos()
> > +{
> > +	echo zlib
> > +	if [ -e /sys/fs/btrfs/features/compress_lzo ]; then
> > +		echo lzo
> 
> If new compression algorithms are added, are there going to be new
> features/compress_$algo entry added? If so I'd suggest that take a more
> generic way to query supported compression algos, rather than
> "hard-coded" zlib and lzo.

I think that's safe to assume. I'll adapt this.

> > +	fi
> > +}
> > diff --git a/tests/btrfs/137 b/tests/btrfs/137
> > new file mode 100755
> > index 00000000..c3f28cc0
> > --- /dev/null
> > +++ b/tests/btrfs/137
> > @@ -0,0 +1,96 @@
> > +#! /bin/bash
> > +# FS QA Test 137
> > +#
> > +# Test decompression in the middle of large extents. Regression test for Linux
> > +# kernel commit 6e78b3f7a193 ("Btrfs: fix btrfs_decompress_buf2page()").
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Facebook.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch
> 
> Better to have
> 
> _require_btrfs_command "property"
> 
> Not a big deal, but nice to have :)

Will fix. Thanks for the review.
